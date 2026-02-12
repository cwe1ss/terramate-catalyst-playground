#!/bin/bash

# Generate JSON schemas for all bundles
# This script loops through all bundle directories and generates schema.json
# for each one that contains an inputs.tm.hcl file

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUNDLES_DIR="$PROJECT_ROOT/bundles"
JQ_SCRIPT="$SCRIPT_DIR/generate_bundle_schema.jq"

# Check if jq script exists
if [[ ! -f "$JQ_SCRIPT" ]]; then
    echo "Error: JQ script not found at $JQ_SCRIPT"
    exit 1
fi

# Check if bundles directory exists
if [[ ! -d "$BUNDLES_DIR" ]]; then
    echo "Error: Bundles directory not found at $BUNDLES_DIR"
    exit 1
fi

echo "Generating schemas for all bundles..."
echo "Bundles directory: $BUNDLES_DIR"
echo ""

# Counter for processed bundles
processed=0
skipped=0

# Loop through all directories in bundles
for bundle_path in "$BUNDLES_DIR"/*; do
    if [[ ! -d "$bundle_path" ]]; then
        continue
    fi

    bundle_name=$(basename "$bundle_path")
    inputs_file="$bundle_path/inputs.tm.hcl"
    schema_file="$bundle_path/schema.json"

    if [[ -f "$inputs_file" ]]; then
        echo "Processing: $bundle_name"

        # Convert and generate schema
        if yq -o json "$inputs_file" | jq -f "$JQ_SCRIPT" > "$schema_file"; then
            echo "  ✓ Generated: $schema_file"
            processed=$((processed + 1))
        else
            echo "  ✗ Error generating schema for $bundle_name"
        fi
    else
        echo "Skipping: $bundle_name (no inputs.tm.hcl found)"
        skipped=$((skipped + 1))
    fi
done

echo ""
echo "Complete! Processed: $processed bundle(s), Skipped: $skipped"
