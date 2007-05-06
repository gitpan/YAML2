use Test::YAML skip_all => 'File just contains test data';;
__DATA__
=== Parse a list
+++ yaml
---
- one
- two
- three
+++ canon
[
"one",
"two",
"three"
]
