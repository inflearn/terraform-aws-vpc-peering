package main

import (
	"github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
)

func TestVpcPeering(t *testing.T) {
	t.Parallel()

	peeringTfDir := "../examples/complete"

	defer test_structure.RunTestStage(t, "teardown", func() { teardown(t, peeringTfDir) })
	test_structure.RunTestStage(t, "deploy", func() { deploy(t, peeringTfDir, map[string]interface{}{}) })
}
