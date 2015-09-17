## [0.1.3] - 2015-09-17
### Fixed
- Treat response body according to their given charset, normally UTF-8

## [0.1.2] - 2015-09-09
### Fixed
- Params for a debit return may now contain special chars without leading to a malformed XML doc.
  E.g. having "&" or "<" in a param lead to a malformed XML doc.

## [0.1.1] - 2015-09-08
### Changed
- All response objects implement `to_s` which returns the actual response xml string

## [0.1.0] - 2015-08-05
### Changed
- order_number is now a required parameter for recurring requests

## [0.0.5] - 2015-07-28
### Changed
- Adds custom_fields feature for sepa payments. Have a look at the README.md for more details.

## [0.0.4] - 2015-06-11
### Changed
- ?

## [0.0.3] - 2015-06-15
### Changed
- Added Changelog
- Added Specs for init/processing recurring payments

