class BurritoIngredient
  include Mongoid::Document
  belongs_to :burrito
  belongs_to :ingredient
end
