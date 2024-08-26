class AddSearchQuantityToCepStat < ActiveRecord::Migration[7.1]
  def change
    add_column :cep_stats, :search_quantity, :integer, default: 1
  end
end
