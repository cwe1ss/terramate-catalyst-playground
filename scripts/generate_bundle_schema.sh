#!/bin/bash
#
# Generate the JSON schema for a bundle

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JQ_SCRIPT="$SCRIPT_DIR/generate_bundle_schema.jq"

# Check if jq script exists
if [[ ! -f "$JQ_SCRIPT" ]]; then
    echo "Error: JQ script not found at $JQ_SCRIPT"
    exit 1
fi

# Single bundle argument required
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <bundle-full-path>"
    echo "Example: $0 /path/to/bundles/subscription"
    exit 1
fi

BUNDLE_PATH="$1"

if [[ ! "$BUNDLE_PATH" = /* ]]; then
    echo "Error: BUNDLE_PATH must be an absolute path"
    exit 1
fi

if [[ ! -d "$BUNDLE_PATH" ]]; then
    echo "Error: Bundle directory not found at $BUNDLE_PATH"
    exit 1
fi

echo "Generating schema for bundle: $BUNDLE_PATH"

bundle_name=$(basename "$BUNDLE_PATH")
inputs_file="$BUNDLE_PATH/inputs.tm.hcl"
schema_file="$BUNDLE_PATH/schema.json"

if [[ -f "$inputs_file" ]]; then
    # Convert and generate schema
    yq -o json "$inputs_file" | jq -f "$JQ_SCRIPT" > "$schema_file"
else
    echo "Skipping: $bundle_name (no inputs.tm.hcl found)"
fi

echo "Complete!"
