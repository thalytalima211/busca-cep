class CreateCepStats < ActiveRecord::Migration[7.1]
  def change
    create_table :cep_stats do |t|
      t.string :cep
      t.string :address
      t.string :state
      t.string :district
      t.string :latitude
      t.string :longitude
      t.integer :ddd
      t.string :city

      t.timestamps
    end
  end
end
