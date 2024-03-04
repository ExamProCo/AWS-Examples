class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :things do |t|
      t.string :name
      t.timestamps
    end

    Thing.create!(name: "Hello")
    Thing.create!(name: "World")
    Thing.create!(name: "Goodbye")
    Thing.create!(name: "Moon")
  end
end
