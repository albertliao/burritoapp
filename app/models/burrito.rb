class Burrito
  include Mongoid::Document
  field :name, type: String

  has_many :burrito_ingredients

  # Fakes out a has_many :through

  # First the objects
  def ingredients
    BurritoIngredient.where(burrito_id: id).map do |bi|
      bi.ingredient
    end
  end

  # Show all related ingredient IDs
  def ingredient_ids
    ingredients.map(&:id)
  end

  # Add and remove ingredients as necessary
  def ingredient_ids=(vals)
    my_bi = BurritoIngredient.where(burrito_id: self.id).map(&:ingredient_id)
    vals.each do |s|
      next if s.blank?
      s_id = BSON::ObjectId.from_string(s)
      if my_bi.include?(s_id)
        my_bi.delete(s_id)
      else
        BurritoIngredient.create(burrito_id: self.id, ingredient_id: s_id)
      end
    end
    my_bi.each do |r|
      BurritoIngredient.find_by(burrito_id: self.id, ingredient_id: r).destroy
    end
  end
end
