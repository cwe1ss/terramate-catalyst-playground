terramate {
  config {
    disable_safeguards = ["git"]
  }
}

import {
  source = "imports/mixins/*.tm.hcl"
}
