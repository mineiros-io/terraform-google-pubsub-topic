# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0]

### Added

- Use terraform-google-pubsub-subscription module v1.1.0

## [1.1.0]

### Added

- Add support for cloud_storage_config in subscriptions

## [1.0.1]

### Fixed

- Ternary logic in subscriptions breaks some edge cases

## [0.2.1]

### Fixed

- Ternary logic in subscriptions breaks some edge cases

## [1.0.0]

### Breaking changes

- Drop support for Google provider v4

## [0.2.0]

### Added

- Add support for Google provider v5

## [0.1.2]

### Fixed

- Fix handling of subscriptions with different config structures

## [0.1.1]

### Fixed

- Fix support for schema definitions

## [0.1.0]

### Added

- Add support for `bigquery_config` attribute in subscriptions

### Changed

- Require Terraform Google Provider v4.32+

## [0.0.4]

### Added

- Add support for `computed_members_map` variable in IAM

## [0.0.3]

### Fixed

- Fix subscription `retry_policy` attribute

## [0.0.2]

### Fixed

- Fix `iam` input variable validation

## [0.0.1]

### Added

- Add support for [`google_pubsub_topic` Terraform resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic)
- Add support for [`google_pubsub_schema` Terraform resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema)
- Add support for [`mineiros-io/terraform-google-pubsub-topic-iam` Terraform Module](https://github.com/mineiros-io/terraform-google-pubsub-topic-iam)
- Add support for [`mineiros-io/terraform-google-pubsub-subscription` Terraform Module](https://github.com/mineiros-io/terraform-google-pubsub-subscription)

[unreleased]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.1.2...HEAD
[0.1.2]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.0.4...v0.1.0
[0.0.4]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mineiros-io/terraform-google-pubsub-topic/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-google-pubsub-topic/releases/tag/v0.0.1
