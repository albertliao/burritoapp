class Ingredient
  include Mongoid::Document
  field :name, type: String

  has_many :burrito_ingredients
end
