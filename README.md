# Exploring Medical Devices Active Licences Listing (MDALL) data

This is a personal project to explore the data available from the [Medical Devices Active Licences Listing (MDALL) API](https://health-products.canada.ca/api/documentation/mdall-documentation-en.html). Please note that I am using [pdm scripts](https://pdm-project.org/latest/usage/scripts/) (detailed in the pyproject.toml file) instead of a Makefile.

## GETTING DATA FROM THE COMMAND LINE:

First download the data at the command line: 

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

## Steps (all defined in pyproject.toml file):
* Create a local instance of the database with Docker: `pdm create`
* Migrate the database with `pdm up`
* Connect to the database with `pdm connect`


## Notes

The [pg8000](https://pypi.org/project/pg8000/) is a native Python library for connecting to postgres databases. The [ijson](https://pypi.org/project/ijson/) is Python library for reading json data from large files. Here is an [example](https://pythonspeed.com/articles/json-memory-streaming/). This is a good option for large files as it is reading the json file line by line.