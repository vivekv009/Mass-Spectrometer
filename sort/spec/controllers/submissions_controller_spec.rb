require "spec_helper"

describe SubmissionsController do

  before { @submissions_controller = SubmissionsController.new }

  subject { @submissions_controller }

  it "should extract zip and return files" do
    zip_file = fixture_file_upload(Rails.root.join("features/uploads/valid_submissions.zip"), 'application/zip')
    unzipped_files = subject.unzip(zip_file)
    unzipped_files.length.should eq(5)
    first_file = unzipped_files[0].path
    File.extname(first_file).should == ".txt"
  end

  it "should merge files together" do
    file1 = File.new('features/uploads/valid_submission.txt')
    file2 = File.new('features/uploads/valid_submission_two.txt')
    file3 = File.new('features/uploads/valid_submission_three.txt')

    fileMerge = File.new('features/uploads/merged_submission.txt')

    fileList = [file1, file2, file3]

    mergedFile = subject.merge_files(fileList)#, fileMerge)

    mergedFile.read.should == File.new('features/uploads/correct_merged_submission.txt').read


  end

  it "should return free hard disk space" do
    free_space = subject.space_available_mb
    free_space.should be > 10

  end

end