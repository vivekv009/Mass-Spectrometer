class SubmissionProteinMod < ActiveRecord::Base
  belongs_to :submission
  belongs_to :protein_mod
end
