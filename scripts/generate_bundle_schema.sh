#!/bin/bash
#
# Generate the JSON schema for a bundle

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JQ_SCRIPT="$SCRIPT_DIR/generate_bundle_schema.jq"

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

schema_file="$BUNDLE_PATH/schema.json"

# Use yq to extract define.bundle.input from all *.tm.hcl files,
# then jq to collect into array and filter non-null, then pass to jq script
yq -o json '.define.bundle.input' "$BUNDLE_PATH"/*.tm.hcl \
  | jq -s 'map(select(. != null))' \
  | jq -f "$JQ_SCRIPT" > "$schema_file"

echo "Complete!"
