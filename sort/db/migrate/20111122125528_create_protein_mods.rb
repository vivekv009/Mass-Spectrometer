class CreateProteinMods < ActiveRecord::Migration
  def change
    create_table :protein_mods do |t|
      t.string :name

      t.timestamps
    end
  end
end
