class CreateSubmissionProteinMods < ActiveRecord::Migration
  def change
    create_table :submission_protein_mods do |t|
      t.references :submission
      t.references :protein_mod
      t.string :category
      t.timestamps
    end
    
  end
end
