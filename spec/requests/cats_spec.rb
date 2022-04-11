

require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create(
        name: 'Felina',
        age: 12,
        enjoys: 'Being a cat',
        image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'
      )

      get '/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

  describe "POST /create" do
    it "creates a cat" do

      cat_params = {
        cat: {
          name: 'Felina',
          age: 12,
          enjoys: 'Being a cat',
          image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'
        }
      }

      
      post '/cats', params: cat_params

      
      expect(response).to have_http_status(200)

      
      cat = Cat.first

     
      expect(cat.name).to eq 'Felina'
      expect(cat.age).to eq 12
      expect(cat.enjoys).to eq 'Being a cat'
      expect(cat.image).to eq 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'
    end
  end
  describe 'PATCH /update' do
    it 'updates a cat' do
      Cat.create name: 'Felina', age: 12, enjoys: 'Being a cat', image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'

      cat_felina = Cat.first

      cat_params = {
        cat: {
          name: 'Alisha',
          age: 24,
          enjoys: 'Being a cat',
          image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'
          }
        }
        patch "/cats/#{cat_felina.id}", params: cat_params
        cat_mystery = Cat.find(cat_felina.id)

        expect(response).to have_http_status(200)
        expect(cat_mystery.name).to eq 'Alisha'
    end
  end
  describe 'DELETE /destriy' do
    it 'deletes a cat from the DB' do
      Cat.create name: 'Felina', age: 12, enjoys: 'Being a cat', image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'
      cat_felina = Cat.first
      delete "/cats/#{cat_felina.id}"
      expect(response).to have_http_status(200)

      cats = Cat.all
      expect(cats).to be_empty
    end
  end
  describe 'cannot create a cat without a valid attributes' do
    it 'cannot create a cat without an age' do
      cat_params = {
        cat: {
          name: 'Alisha',
          enjoys: 'Being a cat',
          image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/why-cats-are-best-pets-1559241235.jpg?crop=0.586xw:0.880xh;0.0684xw,0.0611xh&resize=640:*'
          }
      }
      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['age']).to include "can't be blank"
    end
  end
end