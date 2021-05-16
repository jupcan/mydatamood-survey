# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'mydatamood-survey',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'test server',
        },
        {
          url: 'https://mydatamood-survey.herokuapp.com/',
          description: 'production server',
        }
      ],
      definitions: {
        category: {
          type: 'object',
          properties: {
            category: { type: :string },
            score: { type: :number }
          }, required: ['category']
        },
        product: {
          type: 'object',
          properties: {
            id: { type: :string, example: '1234abcd' },
            name: { type: :string, example: 'Car Insurance for any damage'},
            category: { type: :string, example: 'car_insurances' },
          }, required: ['name', 'category']
        },
        user: {
          type: 'object',
          properties: {
            id: { type: :string },
            name: { type: :string },
            email: { type: :string }
          }, required: ['id']
        },
        interest: {
          type: 'object',
          properties: {
            user_id: { type: :string, example: 'asdfasdf123' },
            product_id: { type: :string, example: '1234abcd' },
            score: { type: :number, example: 7 }
          }, required: ['user_id', 'product_id', 'score']
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
