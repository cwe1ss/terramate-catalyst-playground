script "build" {
  name = "Build Terramate bundles"

  job {
    commands = [
      # Generate a JSON schema for the bundle
      ["bash", "-ce", <<-EOT
        ${terramate.root.path.fs.absolute}/scripts/generate_bundle_schema.sh "${terramate.root.path.fs.absolute}${terramate.stack.path.absolute}"
      EOT
      ],
    ]
  }
}
