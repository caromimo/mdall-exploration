# Notes

## GETTING DATA FROM THE COMMAND LINE:

### Device identifiers
```
curl "https://health-products.canada.ca/api/medical-devices/deviceidentifier/" > data/device_identifiers.json
```

### Devices
```
curl "https://health-products.canada.ca/api/medical-devices/device/" > data/devices.json
```

### Device licences
```
curl "https://health-products.canada.ca/api/medical-devices/licence/" > data/device_licences.json
```

### Companies
```
curl "https://health-products.canada.ca/api/medical-devices/company/?status=A" > data/companies.json
```

### Licence types
```
curl "https://health-products.canada.ca/api/medical-devices/licencetype" > data/licence_types.json
```

## CONVERTING JSON TO CSV AT THE COMMAND LINE:
## Because postgres cannot read JSON

## Create the companies csv
```
jq -r '.[] | [.company_id, .company_name, (.addr_line_1 + " " + .addr_line_2 + " " + .addr_line_3), .postal_code, .city, .country_cd, .region_cd, .company_status] | @csv' data/companies.json > companies.csv
```

## Create the devices csv
```
cat data/devices.json | jq -r '.[] | [.device_id, .original_licence_no, .first_licence_dt, .end_date, .trade_name] | @csv' > devices.csv
```

# Steps (all defined in the Makefile):
* Create a local instance of the database with Docker: `make db`
* Migrate the database with `make migrate`
* Connect to the database with `make connect`
* Import data from the csv with `\copy companies from 'companies.csv' delimiter ',' csv`

