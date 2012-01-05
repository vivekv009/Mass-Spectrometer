class AddExternalIdToProteinMods < ActiveRecord::Migration
  def change
    add_column :protein_mods, :external_id, :integer
    add_column :ions, :external_id, :integer
    add_column :enzymes, :external_id, :integer
  end
end
