# MyDataMood-survey 
[![Build Status](https://travis-ci.com/jupcan/mydatamood-survey.svg?branch=main)](https://travis-ci.com/jupcan/mydatamood-survey) [![Heroku](https://heroku-badge.herokuapp.com/?app=mydatamood-survey)](https://mydatamood-survey.herokuapp.com/)
> REST API to handle a survey system collecting user interests in certain products and categories and providing insights about the popularity of each of them to understand consumer trends and how they can monetize them.

## Usage
There are 4 different endpoints implemented:

**1. PUT /products** - loads the list of available products into the system and removes all previous data (products and interests). This method may be called more than once during the life cycle of the service. For each product we will store:
- **Id**: unique identifier of the product.
- **Name**: name of the product
- **Category**: textual symbol representing the type of business a product is enclosed in (i.e. "car_insurances"...)

**Body**: The list of products to load.
**Content Type**: application/json

Sample Request:
```json
[
    {
        "id": "1234abcd",
        "name": "Car Insurance for any damage",
        "category": "car_insurances"
    },
    {
        "id": "5678efgh",
        "name": "Internet Cable Connection, up to 600Mb",
        "category": "landline_internet"
    }
]
```

**2. POST /interest** - loads the list of available products into the system and removes all previous data (products and interests). This method may be called more than once during the life cycle of the service. For each product we will store:
- **Id**: unique identifier of the product.
- **Name**: name of the product
- **Category**: textual symbol representing the type of business a product is enclosed in (i.e. "car_insurances"...)

**Body**: The list of products to load.
**Content Type**: application/json

Sample Request:
```json
[
    {
        "id": "1234abcd",
        "name": "Car Insurance for any damage",
        "category": "car_insurances"
    },
    {
        "id": "5678efgh",
        "name": "Internet Cable Connection, up to 600Mb",
        "category": "landline_internet"
    }
]
```