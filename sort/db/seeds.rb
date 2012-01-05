# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'fileutils'

def copy_with_path(src, dst)
  FileUtils.mkdir_p(File.dirname(dst))
  FileUtils.cp(src, dst)
end



ProteinMod.create(external_id: 23, name: '2-amino-3-oxo-butanoic acid T')
ProteinMod.create(external_id: 182, name: 'Asparagine HexNAc')
ProteinMod.create(external_id: 183, name: 'Asparagine dHexHexNAc')
ProteinMod.create(external_id: 131, name: 'CAMthiopropanoyl K')
ProteinMod.create(external_id: 130, name: 'ICAT heavy')
ProteinMod.create(external_id: 129, name: 'ICAT light')
ProteinMod.create(external_id: 9, name: 'M cleavage from protein n-term')
ProteinMod.create(external_id: 179, name: 'MMTS on C')
ProteinMod.create(external_id: 83, name: 'NEM C')
ProteinMod.create(external_id: 84, name: 'NIPCAM')
ProteinMod.create(external_id: 87, name: 'O18 on peptide n-term')
ProteinMod.create(external_id: 139, name: 'PNGasF in O18 water')
ProteinMod.create(external_id: 113, name: 'SeMet')
ProteinMod.create(external_id: 184, name: 'Serine HexNAc')
ProteinMod.create(external_id: 185, name: 'Threonine HexNAc')
ProteinMod.create(external_id: 24, name: 'acetylation of K')
ProteinMod.create(external_id: 10, name: 'acetylation of protein n-term')
ProteinMod.create(external_id: 25, name: 'amidation of peptide c-term')
ProteinMod.create(external_id: 163, name: 'arginine to ornithine')
ProteinMod.create(external_id: 140, name: 'beta elimination of S')
ProteinMod.create(external_id: 141, name: 'beta elimination of T')
ProteinMod.create(external_id: 13, name: 'beta methythiolation of D')
ProteinMod.create(external_id: 47, name: 'beta-carboxylation of D')
ProteinMod.create(external_id: 26, name: 'beta-methylthiolation of D (duplicate of 13)')
ProteinMod.create(external_id: 3, name: 'carbamidomethyl C')
ProteinMod.create(external_id: 31, name: 'carbamylation of K')
ProteinMod.create(external_id: 32, name: 'carbamylation of n-term peptide')
ProteinMod.create(external_id: 29, name: 'carboxyamidomethylation of D')
ProteinMod.create(external_id: 30, name: 'carboxyamidomethylation of E')
ProteinMod.create(external_id: 28, name: 'carboxyamidomethylation of H')
ProteinMod.create(external_id: 27, name: 'carboxyamidomethylation of K')
ProteinMod.create(external_id: 165, name: 'carboxykynurenin of W')
ProteinMod.create(external_id: 2, name: 'carboxymethyl C')
ProteinMod.create(external_id: 33, name: 'citrullination of R')
ProteinMod.create(external_id: 4, name: 'deamidation of N and Q')
ProteinMod.create(external_id: 164, name: 'dehydro of S and T')
ProteinMod.create(external_id: 88, name: 'di-O18 on peptide n-term')
ProteinMod.create(external_id: 35, name: 'di-iodination of Y')
ProteinMod.create(external_id: 36, name: 'di-methylation of K')
ProteinMod.create(external_id: 37, name: 'di-methylation of R')
ProteinMod.create(external_id: 38, name: 'di-methylation of peptide n-term')
ProteinMod.create(external_id: 42, name: 'farnesylation of C')
ProteinMod.create(external_id: 46, name: 'fluorophenylalanine')
ProteinMod.create(external_id: 43, name: 'formylation of K')
ProteinMod.create(external_id: 44, name: 'formylation of peptide n-term')
ProteinMod.create(external_id: 82, name: 'formylation of protein n-term')
ProteinMod.create(external_id: 48, name: 'gamma-carboxylation of E')
ProteinMod.create(external_id: 40, name: 'gammathiopropionylation of K')
ProteinMod.create(external_id: 41, name: 'gammathiopropionylation of peptide n-term')
ProteinMod.create(external_id: 49, name: 'geranyl-geranyl')
ProteinMod.create(external_id: 50, name: 'glucuronylation of protein n-term')
ProteinMod.create(external_id: 51, name: 'glutathione disulfide')
ProteinMod.create(external_id: 53, name: 'guanidination of K')
ProteinMod.create(external_id: 136, name: 'heavy arginine-13C6')
ProteinMod.create(external_id: 137, name: 'heavy arginine-13C6-15N4')
ProteinMod.create(external_id: 181, name: 'heavy lysine - 13C6 15N2')
ProteinMod.create(external_id: 180, name: 'heavy lysine - 2H4')
ProteinMod.create(external_id: 138, name: 'heavy lysine-13C6')
ProteinMod.create(external_id: 56, name: 'homoserine')
ProteinMod.create(external_id: 57, name: 'homoserine lactone')
ProteinMod.create(external_id: 64, name: 'hydroxylation of  Y')
ProteinMod.create(external_id: 59, name: 'hydroxylation of D')
ProteinMod.create(external_id: 63, name: 'hydroxylation of F')
ProteinMod.create(external_id: 60, name: 'hydroxylation of K')
ProteinMod.create(external_id: 61, name: 'hydroxylation of N')
ProteinMod.create(external_id: 62, name: 'hydroxylation of P')
ProteinMod.create(external_id: 168, name: 'iTRAQ114 on K')
ProteinMod.create(external_id: 169, name: 'iTRAQ114 on Y')
ProteinMod.create(external_id: 167, name: 'iTRAQ114 on nterm')
ProteinMod.create(external_id: 171, name: 'iTRAQ115 on K')
ProteinMod.create(external_id: 172, name: 'iTRAQ115 on Y')
ProteinMod.create(external_id: 170, name: 'iTRAQ115 on nterm')
ProteinMod.create(external_id: 174, name: 'iTRAQ116 on K')
ProteinMod.create(external_id: 175, name: 'iTRAQ116 on Y')
ProteinMod.create(external_id: 173, name: 'iTRAQ116 on nterm')
ProteinMod.create(external_id: 177, name: 'iTRAQ117 on K')
ProteinMod.create(external_id: 178, name: 'iTRAQ117 on Y')
ProteinMod.create(external_id: 176, name: 'iTRAQ117 on nterm')
ProteinMod.create(external_id: 65, name: 'iodination of Y')
ProteinMod.create(external_id: 67, name: 'lipoyl K')
ProteinMod.create(external_id: 73, name: 'methyl C')
ProteinMod.create(external_id: 74, name: 'methyl H')
ProteinMod.create(external_id: 75, name: 'methyl N')
ProteinMod.create(external_id: 77, name: 'methyl R')
ProteinMod.create(external_id: 69, name: 'methyl ester of D')
ProteinMod.create(external_id: 70, name: 'methyl ester of E (duplicate of 17)')
ProteinMod.create(external_id: 71, name: 'methyl ester of S')
ProteinMod.create(external_id: 72, name: 'methyl ester of Y')
ProteinMod.create(external_id: 68, name: 'methyl ester of peptide c-term (duplicate of 18)')
ProteinMod.create(external_id: 16, name: 'methylation of D')
ProteinMod.create(external_id: 17, name: 'methylation of E')
ProteinMod.create(external_id: 0, name: 'methylation of K')
ProteinMod.create(external_id: 14, name: 'methylation of Q')
ProteinMod.create(external_id: 18, name: 'methylation of peptide c-term')
ProteinMod.create(external_id: 76, name: 'methylation of peptide n-term')
ProteinMod.create(external_id: 11, name: 'methylation of protein n-term')
ProteinMod.create(external_id: 78, name: 'myristoleylation of G')
ProteinMod.create(external_id: 79, name: 'myristoyl-4H of G')
ProteinMod.create(external_id: 81, name: 'myristoylation of K')
ProteinMod.create(external_id: 80, name: 'myristoylation of peptide n-term G')
ProteinMod.create(external_id: 118, name: 'n-acyl diglyceride cysteine')
ProteinMod.create(external_id: 22, name: 'n-formyl met addition')
ProteinMod.create(external_id: 34, name: 'oxidation of C to cysteic acid')
ProteinMod.create(external_id: 162, name: 'oxidation of C to sulfinic acid')
ProteinMod.create(external_id: 39, name: 'oxidation of F to dihydroxyphenylalanine')
ProteinMod.create(external_id: 89, name: 'oxidation of H')
ProteinMod.create(external_id: 55, name: 'oxidation of H to D')
ProteinMod.create(external_id: 54, name: 'oxidation of H to N')
ProteinMod.create(external_id: 1, name: 'oxidation of M')
ProteinMod.create(external_id: 111, name: 'oxidation of P to pyroglutamic acid')
ProteinMod.create(external_id: 90, name: 'oxidation of W')
ProteinMod.create(external_id: 45, name: 'oxidation of W to formylkynurenin')
ProteinMod.create(external_id: 58, name: 'oxidation of W to hydroxykynurenin')
ProteinMod.create(external_id: 66, name: 'oxidation of W to kynurenin')
ProteinMod.create(external_id: 85, name: 'oxidation of W to nitro')
ProteinMod.create(external_id: 86, name: 'oxidation of Y to nitro')
ProteinMod.create(external_id: 186, name: 'palmitoleyl of S')
ProteinMod.create(external_id: 92, name: 'palmitoylation of C')
ProteinMod.create(external_id: 93, name: 'palmitoylation of K')
ProteinMod.create(external_id: 94, name: 'palmitoylation of S')
ProteinMod.create(external_id: 95, name: 'palmitoylation of T')
ProteinMod.create(external_id: 91, name: 'phosphopantetheine S')
ProteinMod.create(external_id: 6, name: 'phosphorylation of S')
ProteinMod.create(external_id: 134, name: 'phosphorylation of S with ETD loss')
ProteinMod.create(external_id: 96, name: 'phosphorylation of S with prompt loss')
ProteinMod.create(external_id: 7, name: 'phosphorylation of T')
ProteinMod.create(external_id: 135, name: 'phosphorylation of T with ETD loss')
ProteinMod.create(external_id: 97, name: 'phosphorylation of T with prompt loss')
ProteinMod.create(external_id: 8, name: 'phosphorylation of Y')
ProteinMod.create(external_id: 99, name: 'phosphorylation with neutral loss on C')
ProteinMod.create(external_id: 100, name: 'phosphorylation with neutral loss on D')
ProteinMod.create(external_id: 101, name: 'phosphorylation with neutral loss on H')
ProteinMod.create(external_id: 132, name: 'phosphorylation with neutral loss on S')
ProteinMod.create(external_id: 133, name: 'phosphorylation with neutral loss on T')
ProteinMod.create(external_id: 98, name: 'phosphorylation with prompt loss on Y')
ProteinMod.create(external_id: 5, name: 'propionamide C')
ProteinMod.create(external_id: 104, name: 'propionyl heavy K')
ProteinMod.create(external_id: 105, name: 'propionyl heavy peptide n-term')
ProteinMod.create(external_id: 102, name: 'propionyl light K')
ProteinMod.create(external_id: 103, name: 'propionyl light on peptide n-term')
ProteinMod.create(external_id: 106, name: 'pyridyl K')
ProteinMod.create(external_id: 107, name: 'pyridyl peptide n-term')
ProteinMod.create(external_id: 108, name: 'pyro-cmC')
ProteinMod.create(external_id: 109, name: 'pyro-glu from n-term E')
ProteinMod.create(external_id: 110, name: 'pyro-glu from n-term Q')
ProteinMod.create(external_id: 112, name: 's-pyridylethylation of C')
ProteinMod.create(external_id: 114, name: 'sulfation of Y')
ProteinMod.create(external_id: 115, name: 'sulphone of M')
ProteinMod.create(external_id: 166, name: 'sumoylation of K')
ProteinMod.create(external_id: 19, name: 'tri-deuteromethylation of D')
ProteinMod.create(external_id: 20, name: 'tri-deuteromethylation of E')
ProteinMod.create(external_id: 21, name: 'tri-deuteromethylation of peptide c-term')
ProteinMod.create(external_id: 116, name: 'tri-iodination of Y')
ProteinMod.create(external_id: 15, name: 'tri-methylation of K')
ProteinMod.create(external_id: 117, name: 'tri-methylation of R')
ProteinMod.create(external_id: 12, name: 'tri-methylation of protein n-term')
proa = ProteinMod.create(external_id: 52, name: 'ubiquitinylation residue')

Ion.create(external_id: 0, name: 'a')
Ion.create(external_id: 1, name: 'b')
Ion.create(external_id: 2, name: 'c')
Ion.create(external_id: 3, name: 'x')
Ion.create(external_id: 5, name: 'zdot')
#Ion.create(external_id: , name: 'p')
#Ion.create(external_id: , name: 'n')
#Ion.create(external_id: , name: 'i')
#Ion.create(external_id: , name: 'u')
Ion.create(external_id: 10, name: 'adot')
Ion.create(external_id: 11, name: 'X-CO2')
Ion.create(external_id: 12, name: 'adot-CO2')

MassSearchType.create(name: 'monoisotopic')
MassSearchType.create(name: 'average')
MassSearchType.create(name: 'monoisotopic N15')
MassSearchType.create(name: 'exact')

Enzyme.create(external_id: 0, name: 'Trypsin')
Enzyme.create(external_id: 1, name: 'Arg-C')
Enzyme.create(external_id: 2, name: 'CNBr')
Enzyme.create(external_id: 3, name: 'Chymotrypsin (FYWL)')
Enzyme.create(external_id: 4, name: 'Formic Acid')
Enzyme.create(external_id: 5, name: 'Lys-C')
Enzyme.create(external_id: 6, name: 'Lys-C, no P rule')
Enzyme.create(external_id: 7, name: 'Pepsin A')
Enzyme.create(external_id: 8, name: 'Trypsin+CNBr')
Enzyme.create(external_id: 9, name: 'Trypsin+Chymotrypsin (FYWLKR)')
Enzyme.create(external_id: 10, name: 'Trypsin, no P rule')
Enzyme.create(external_id: 11, name: 'Whole protein')
Enzyme.create(external_id: 12, name: 'Asp-N')
Enzyme.create(external_id: 13, name: 'Glu-C')
Enzyme.create(external_id: 14, name: 'Asp-N+Glu-C')
Enzyme.create(external_id: 15, name: 'Top-Down')
Enzyme.create(external_id: 16, name: 'Semi-Tryptic')
Enzyme.create(external_id: 17, name: 'No Enzyme')
Enzyme.create(external_id: 18, name: 'Chymotrypsin, no P rule (FYWL)')
Enzyme.create(external_id: 19, name: 'Asp-N (DE)')
Enzyme.create(external_id: 20, name: 'Glu-C (DE)')
Enzyme.create(external_id: 21, name: 'Lys-N (K)')
Enzyme.create(external_id: 22, name: 'Thermolysin, no P rule')
Enzyme.create(external_id: 23, name: 'Semi-Chymotrypsin (FYWL)')
Enzyme.create(external_id: 24, name: 'Semi-Glu-C')

admin = User.create(name: 'Admin Name', username: 'admin', email: 'admin@test.com', password: 'foobar', password_confirmation: 'foobar', approved: true, enabled: true, admin: true)
user = User.create(name: 'Test User', username: 'user', email: 'user@test.com', password: 'foobar', password_confirmation: 'foobar', approved: true, enabled: true,admin: false)
disabled_user = User.create(name: 'Disabled User', username: 'disabled_user', email: 'disabled_user@test.com', password: 'foobar', password_confirmation: 'foobar', approved: true, enabled: false,admin: false)
inactive_user = User.create(name: 'Inactive User', username: 'inactive_user', email: 'inactive_user@test.com', password: 'foobar', password_confirmation: 'foobar', approved: false, enabled: false, admin: false)

database1 = Database.create(title: 'Database Name', user: user)
database2 = Database.create(title: 'Database Name 2', user: admin)

database_1_version_1 = DatabaseVersion.create(
  file: File.open(Rails.root.join("features/sequence_library/valid_database.fasta")),
  database: database1,
  database_title: 'valid_database.fasta',
  processed: true
)

database_1_version_2 = DatabaseVersion.create(
  file: File.open(Rails.root.join("features/sequence_library/valid_database.fasta")),
  database: database1,
  database_title: 'valid_database.fasta',
  processed: true
)

database_2_version_1 = DatabaseVersion.create(
  file: File.open(Rails.root.join("features/sequence_library/valid_database.fasta")),
  database: database2,
  database_title: 'valid_database.fasta',
  processed: true
)


copy_with_path(Rails.root.join("features/results/valid_result.omx"), Rails.root.join("public/files/submission/1/result/valid_result.omx").to_s())
copy_with_path(Rails.root.join("features/results/invalid_result.omx"), Rails.root.join("public/files/submission/2/result/invalid_result.omx").to_s())

Submission.create(
	title: 'Test Submission 1', 
	file: File.open(Rails.root.join("features/uploads/valid_submission.txt")),
	results_file: File.open(Rails.root.join("features/results/valid_result.omx")),
	file_extension: 'txt',
	precursor_mass_tolerance: 2.3,
  l_bound_precursor: 2,
  u_bound_precursor: 5,
  min_charge: 6,
  max_missed_cleavages: 3,
  hitlist_max_length: 4,
  e_value_cutoff: 11,
  product_mass_tolerance: 5.2,
  fract_prod_peaks: 3.5,
  peak_cutoff: 18.4,
  status: 'c',
  created_at: '2011-10-25 21:28:31 UTC',
  updated_at: '2011-10-25 21:28:31 UTC',
  user: admin,
  database_version: database_1_version_1
)

Submission.create(
	title: 'Test Submission 2', 
	file: File.open(Rails.root.join("features/uploads/valid_submission_two.txt")),
	result: 'public/files/submission/2/result/invalid_result.omx',
	file_extension: 'txt',
	precursor_mass_tolerance: 2.3,
  l_bound_precursor: 2,
  u_bound_precursor: 5,
  min_charge: 6,
  max_missed_cleavages: 3,
  hitlist_max_length: 4,
  e_value_cutoff: 11,
  product_mass_tolerance: 5.2,
  fract_prod_peaks: 3.5,
  peak_cutoff: 18.4,
  status: 'f',
  created_at: '2011-11-15 21:28:31 UTC',
  updated_at: '2011-11-15 21:28:31 UTC',
  user: user,
  database_version: database_1_version_1
)

Submission.create(
	title: 'Test Submission 3', 
	file: File.open(Rails.root.join("features/uploads/valid_submission_three.txt")),
	file_extension: 'txt',
	precursor_mass_tolerance: 2.3,
  l_bound_precursor: 2,
  u_bound_precursor: 5,
  min_charge: 6,
  max_missed_cleavages: 3,
  hitlist_max_length: 4,
  e_value_cutoff: 11,
  product_mass_tolerance: 5.2,
  fract_prod_peaks: 3.5,
  peak_cutoff: 18.4,
  created_at: '2011-11-25 21:28:31 UTC',
  updated_at: '2011-11-25 21:28:31 UTC',
  user: disabled_user,
  database_version: database_2_version_1
)

Submission.create(
	title: 'Test Submission 4', 
	file: File.open(Rails.root.join("features/uploads/valid_submission_four.txt")),
	file_extension: 'txt',
	precursor_mass_tolerance: 2.3,
  l_bound_precursor: 2,
  u_bound_precursor: 5,
  min_charge: 6,
  max_missed_cleavages: 3,
  hitlist_max_length: 4,
  e_value_cutoff: 11,
  product_mass_tolerance: 5.2,
  fract_prod_peaks: 3.5,
  peak_cutoff: 18.4,
  created_at: '2011-11-26 21:28:31 UTC',
  updated_at: '2011-11-26 21:28:31 UTC',
  user: user,
  database_version: database_2_version_1
)

Submission.create(
	title: 'Test Submission 5', 
	file: File.open(Rails.root.join("features/uploads/valid_submission_five.txt")),
	file_extension: 'txt',
	precursor_mass_tolerance: 2.3,
  l_bound_precursor: 2,
  u_bound_precursor: 5,
  min_charge: 6,
  max_missed_cleavages: 3,
  hitlist_max_length: 4,
  e_value_cutoff: 11,
  product_mass_tolerance: 5.2,
  fract_prod_peaks: 3.5,
  peak_cutoff: 18.4,
  created_at: '2011-11-28 21:28:31 UTC',
  updated_at: '2011-11-28 21:28:31 UTC',
  user: user,
  database_version: database_1_version_2
)


