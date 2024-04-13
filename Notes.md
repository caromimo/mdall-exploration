# Notes

## Getting data from the command line: 
```
curl "https://health-products.canada.ca/api/medical-devices/licence/?state=active&type=json&lang=en" > data/active_licences.json
```

## Converting json to csv at the command line:
```
jq -r '.[] | [.company_id, .company_name, (.addr_line_1 + " " + .addr_line_2 + " " + .addr_line_3), .postal_code, .city, .country_cd, .region_cd, .company_status] | @csv' data/companies.json > companies.csv
```
