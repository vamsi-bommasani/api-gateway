package terratests

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"os/exec"
	"path/filepath"
	"testing"
	"time"
)

// run runs a command in the repo root and returns stdout, stderr and error.
func run(ctx context.Context, dir string, name string, args ...string) (string, string, error) {
	cmd := exec.CommandContext(ctx, name, args...)
	cmd.Dir = dir
	var outb, errb bytes.Buffer
	cmd.Stdout = &outb
	cmd.Stderr = &errb
	err := cmd.Run()
	fmt.Printf("COMMAND: %s %v\nSTDOUT:\n%s\nSTDERR:\n%s\n", name, args, outb.String(), errb.String())
	return outb.String(), errb.String(), err
}

func TestTerraformAPIGateway(t *testing.T) {
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Minute)
	defer cancel()

	// repo root (one level up from terratests)
	repoRoot, err := filepath.Abs("..")
	if err != nil {
		t.Fatalf("failed to determine repo root: %v", err)
	}

	// Initialize
	if out, errOut, err := run(ctx, repoRoot, "terraform", "init", "-input=false"); err != nil {
		t.Fatalf("terraform init failed: %v\nstdout: %s\nstderr: %s", err, out, errOut)
	}

	// Apply (use the test tfvars file)
	if out, errOut, err := run(ctx, repoRoot, "terraform", "apply", "-auto-approve", "-var-file=terratests/test.tfvars"); err != nil {
		t.Fatalf("terraform apply failed: %v\nstdout: %s\nstderr: %s", err, out, errOut)
	}

	// Ensure we always attempt to destroy at the end
	defer func() {
		if out, errOut, err := run(ctx, repoRoot, "terraform", "destroy", "-auto-approve", "-var-file=terratests/test.tfvars"); err != nil {
			t.Logf("terraform destroy failed: %v\nstdout: %s\nstderr: %s", err, out, errOut)
		}
	}()

	// Get output (use -json to parse safely)
	out, errOut, err := run(ctx, repoRoot, "terraform", "output", "-json", "api_invoke_url")
	if err != nil {
		t.Fatalf("terraform output failed: %v\nstdout: %s\nstderr: %s", err, out, errOut)
	}

	// terraform output -json api_invoke_url returns a JSON string
	var apiURL string
	if err := json.Unmarshal([]byte(out), &apiURL); err != nil {
		t.Fatalf("failed to parse api_invoke_url output: %v\noutput: %s", err, out)
	}

	if apiURL == "" {
		t.Fatalf("expected API Gateway invoke URL output, got empty string")
	}

	// Log the created API Gateway invoke URL
	t.Logf("Created API Gateway URL: %s", apiURL)
}
