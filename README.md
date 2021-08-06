## About
A RESTful Rails API for a Tea Subscription Service.  
![Image](https://media.giphy.com/media/WPO1IoXaFIVuE/giphy.gif)    
[via GIPHY](https://giphy.com/embed/WPO1IoXaFIVuE)

## Table of contents
[**Built Using**](#built-using) |
[**Database Schema**](#database-schema) |
[**Setup**](#setup) |
[**File Structure**](#file-structure) |
[**Endpoints**](#endpoints) |
[**Error Handling**](#error-handling) |
[**Testing**](#testing) |
[**Developer**](#developer)

## Built Using
- Ruby 2.5.3
- Rails 5.2.6

## Database Schema
![Screen Shot 2021-08-04 at 6 16 31 PM](https://user-images.githubusercontent.com/57960885/128267451-184ff5ca-6a78-4fa8-bd0a-e0a06dab0285.png)

## Setup
- Fork and clone this repository
- change directories into `tea_subscription` and run the command `bundle install` in your terminal
- To set up the database and seed it, run `rails db:{create,mirgrate,seed}` or `rails db:setup`
- Start your server with the `rails s` command
- Now you're ready to consume the endpoints below

## File Structure
- Routes located in `config/routes.rb`
- Customer subscriptions controller located in `app/controllers/api/v1/customers/subscriptions_controller.rb`
- Request tests located at `spec/requests/api/v1/customers/subscriptions/`. Here you'll find happy and sad path tests for current endpoints/controller actions.

## Endpoints
All endpoints run off base URL http://localhost:3000 on a local machine.

#### Subscribe a customer to a tea subscription
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `POST` | `/api/v1/customers/:customer_id/subscriptions`| Joins a customer and a tea to a subscription |

Example Request:
Needs following information in the request body
```
body:
{
  "tea_id": 1,
  "title": "Subscription for delicious tea",
  "price": 12.05,
  "frequency": 0
}
```
Example Response:
```
{
  "data": {
      "id": "9",
      "type": "subscription",
      "attributes": {
          "customer_id": 1,
          "tea_id": 5,
          "title": "Subscription for delicious tea",
          "price": 12.05,
          "status": "active",
          "frequency": "monthly"
      }
  }
}
```
#### Cancel a customers tea subscription
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `PATCH` | `/api/v1/customers/:customer_id/subscriptions/:id`| Updates the customer's subscription status to inactive |

Example Request:
Needs to include status in the request body.  
Status is an enum so it can either be sent as 1 or "inactive". Inversely, to activate an inactive subscription the status could be sent as 0 or "active".  
Note: If you wish to update any other attributes, they can also be sent in the request body.
```
body:
{
  "status": 1,
}
```
Example Response:
```
{
  "data": {
      "id": "3",
      "type": "subscription",
      "attributes": {
          "customer_id": 1,
          "tea_id": 3,
          "title": "Ut praesentium magni.",
          "price": 12.44,
          "status": "inactive",
          "frequency": "monthly"
      }
  }
}
```

#### See all of a customers tea subscriptions (active and cancelled)
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET` | `/api/v1/customers/:customer_id/subscriptions`| Retrives all subscriptions for customer |



Example Request:
URL: `http://localhost:3000/api/v1/customers/1/subscriptions`

Example Response:
```
{
    "data": [
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 3,
                "title": "Ut praesentium magni.",
                "price": 12.44,
                "status": "inactive",
                "frequency": "monthly"
            }
        },
        {
            "id": "6",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 1,
                "title": "Subscription for delicious tea",
                "price": 12.05,
                "status": "active",
                "frequency": "monthly"
            }
        }
    ]
}
```
## Error Handling
Examples of errors and how they're formatted:
- If customer does not exist
`GET /api/v1/customers/<id of non-existent customer>/subscriptions`
```
{
  "errors": "Cannot find customer"
}
```
- If customer has no subscriptions (active or inactive)
`GET /api/v1/customers/<id of customer with no subscriptions>/subscriptions`
```
{
  "errors": "No subscriptions found"
}
```
- Field is missing from request body
`POST /api/v1/customers/:customer_id/subscriptions`
```
{
  "errors": "Frequency can't be blank
}
```
- Customer already has a subscription for tea
`POST /api/v1/customers/:customer_id/subscriptions`
```
{
  "errors": "Tea subscription already exists for this tea & customer"
}
```
- Customer tries to subscribe to a tea that doesn't exist
`POST /api/v1/customers/:customer_id/subscriptions`
```
{
  "errors": "Cannot find tea"
}
```
- Update is sent with invalid status enum
`PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id`
```
{
  "errors": "'10' is not a valid status"
}
```


## Testing
- Tested with Rspec
- Model and request tests
- 100% coverage
- To run tests, use the command `bundle exec rspec`
- Te see coverage, use the command `open coverage/index.html`

## Developer
##### Gaelyn Cooper • [GitHub](https://github.com/gaelyn) • [LinkedIn](https://www.linkedin.com/in/gaelyn-cooper/)
