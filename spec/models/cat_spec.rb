require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe 'Create cat' do
    it 'wont create a cat in the database without a name' do
      cat = Cat.create age: 11, enjoys: 'hissy fits and playing air guitar with missing leg', image: 'https://imgur.com/a/RDO07c2'
      p cat.errors[:name]
      expect(cat.errors[:name]).to_not be_empty
    end
    it 'wont create a cat in the database without an age' do
      cat = Cat.create name: 'Hieronymus', enjoys: 'meowing at 3 AM', image: 'https://imgur.com/a/RDO07c2'
      p cat.errors[:age]
      expect(cat.errors[:age]).to_not be_empty
    end
    it 'wont create a cat in the database without an enjoys' do
      cat = Cat.create name: 'Hieronymus', age: 11, image: 'https://imgur.com/a/RDO07c2'
      p cat.errors[:enjoys]
      expect(cat.errors[:enjoys]).to_not be_empty
    end
    it 'wont create a cat in the database without an enjoys that is ten characters long' do
      cat = Cat.create name: 'Hieronymus', age: 11, enjoys: 'duh', image: 'https://imgur.com/a/RDO07c2'
      p cat.errors[:enjoys]
      expect(cat.errors[:enjoys]).to_not be_empty
    end
  end
end