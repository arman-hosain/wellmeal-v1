# frozen_string_literal: true

class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.string :ingredients, null: false

      t.timestamps
    end
  end
end
