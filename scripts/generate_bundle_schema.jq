# Convert bundle inputs (parsed as JSON by yq) to a JSON Schema
#
# Usage: yq -o json inputs.tm.hcl | jq -f generate_bundle_schema.jq

# Helper function to convert HCL type to JSON Schema type(s)
def hcl_type_to_json_schema:
  if . == "string" then "string"
  elif . == "number" then "number"
  elif . == "bool" then "boolean"
  elif startswith("list(") or startswith("set(") then "array"
  elif startswith("map(") or startswith("object") then "object"
  else "string"
  end;

# Helper function to extract items type from container types
def get_items_type:
  if test("list\\(|set\\(") then
    capture("(?:list|set)\\((?<type>[^)]+)\\)") | .type | hcl_type_to_json_schema
  else
    "string"
  end;

# Helper function to convert a single input definition to JSON Schema property
def input_to_property:
  . as $input
  | {
    "type": ($input.type | hcl_type_to_json_schema),
    "title": ($input.prompt // ""),
    "description": ($input.description // "")
  }
  | if .type == "array" then
      . + { "items": { "type": ($input.type | get_items_type) } }
    else . end
  | if $input.default != null then
      . + { "default": $input.default }
    else . end;

# Helper function to build properties object from input definitions
def build_input_properties:
  reduce .[] as $input_entry (
    {};
    . + {
      ($input_entry.key): ($input_entry.value | input_to_property)
    }
  );

# Main conversion logic
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "object",
  "properties": {
    "apiVersion": {
        "const": "terramate.io/cli/v1"
      },
      "kind": {
        "const": "BundleInstance"
      },
      "metadata": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "name": {
            "type": "string"
          },
          "uuid": {
            "type": "string"
          }
        },
        "required": [
          "name",
          "uuid"
        ]
      },
      "spec": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "source": {
            "type": "string"
          },
          "inputs": {
            "$ref": "#/definitions/inputs"
          }
        },
        "required": [
          "source",
          "inputs"
        ]
      },
      "environments": {
        "type": "object",
        "additionalProperties": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "inputs": {
              "$ref": "#/definitions/inputs"
            }
          }
        }
      },
  },
  "definitions": {
    "inputs": {
      "type": "object",
      "additionalProperties": false,
      "properties": (
        . as $root
        | ($root.define.bundle.input | to_entries)
        | build_input_properties
      )
    }
  }
}
