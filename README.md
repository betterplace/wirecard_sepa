# Wirecard SEPA
[![Build Status](https://api.travis-ci.org/betterplace/wirecard_sepa.svg?branch=master)](http://travis-ci.org/betterplace/wirecard_sepa)
[![Code Climate](https://codeclimate.com/repos/55494936e30ba04e91005d6e/badges/cd0d22df220babab1b66/gpa.svg)](https://codeclimate.com/repos/55494936e30ba04e91005d6e/feed)
[![Dependency Status](https://gemnasium.com/betterplace/wirecard_sepa.svg)](https://gemnasium.com/betterplace/wirecard_sepa)

Implements the client for creating payments in the Wircard Elastic Engine gateway.
More info [here](doc/wirecard-payment-processing-api-1.13.pdf).

## Usage
```ruby
config = WirecardSepa::Config.new({
  api_url: 'https://api-test.wirecard.com/engine/rest/paymentmethods/',
  http_auth_username: '70000-APITEST-AP',
  http_auth_password: 'xxxxxxxxx',
  merchant_account_id: '4c901196-eff7-411e-82a3-5ef6b6860d64',
  creditor_id: 'DE98ZZZ09999999999'
})
gateway = WirecardSepa::Gateway.new(config)
response = gateway.debit({
  requested_amount: '12.12',
  account_holder_first_name: 'John',
  account_holder_last_name: 'Doe',
  bank_account_iban: 'DE42512308000000060004',
  bank_account_bic: 'WIREDEMMXXX',
  mandate_id: '1235678',
  mandate_signed_date: '2015-06-02'
})
response.success?
=> true
```


### Feature: Custom Fields
Beginning with version 0.0.5 the WirecardSepa::Gateway#debit method
accepts a `custom_fields` param which forwards custom key-value pairs
to the wirecard payment back end.

Usage example:
```
response = gateway.debit({
  requested_amount: '12.12',
  account_holder_first_name: 'John',
  account_holder_last_name: 'Doe',
  bank_account_iban: 'DE42512308000000060004',
  bank_account_bic: 'WIREDEMMXXX',
  mandate_id: '1235678',
  mandate_signed_date: '2015-06-02',
  custom_fields: {
    'Banana' => 'tree',
    'Department' => 'IT',
  }
})
```

## TODOS
- [x] Simple error handling
- [x] Docs for usage in README.md

## Contributing
1. Fork it ( https://github.com/betterplace/wirecard_sepa/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
