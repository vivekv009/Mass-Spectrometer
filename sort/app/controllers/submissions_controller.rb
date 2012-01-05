require 'tempfile'

class SubmissionsController < ApplicationController
  # Modules
  include FileManager

  # Devise authentication
  before_filter :authenticate_user!

  # GET /submissions
  # GET /submissions.json
  def index

    flash.keep
    redirect_to :action => "queue"
  end
  
  # GET /submissions
  # GET /submissions.json
  def results
    # set topbar highlight

    @pars = {'time'=>'', 'user'=>'', 'status'=>'cfs'}
    @pars = params[:filterParams] if not params[:filterParams].nil?
    @highlight_results = true
    puts @pars
    
    @submissions = Submission.result_filter (params[:filterParams] or {})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end
  
  # GET /submissions
  # GET /submissions.json
  def queue




    # set topbar highlight
    @highlight_queue = true
    
    @submissions = Submission.queue_list

    respond_to do |format|
      flash.keep
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])

    # `call omssa`


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @submission }
    end
  end

  #def test
  #  "test"
  #end

  # GET /submissions/new
  # GET /submissions/new.json
  def new
    #myvar = test

    @database_verisons = DatabaseVersion.processed.all  
    @databases = Database.find(:all) 
    @users = User.where(:approved => true, :enabled => true)
    @users = [current_user] | @users
    
     


    
        

    # set topbar highlight
    @highlight_new_submission = true
  
    @submission = Submission.new
    
    respond_to do |format|
      if low_space?
        flash[:warning] = "Low disk space!"
      end
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/1/edit
 # def edit
 #   @submission = Submission.find(params[:id])
 # end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(params[:submission])
    @submission.user = @user
    file = params[:submission][:file]


    # if params.include? :receive_email
    #   @submission.send_confirmation = true
    # else
    #   @submission.send_confirmation = false
    # end

    if (file && file.original_filename.end_with?(".zip"))
      create_multiple
      return
    end

		@submission.file = file

    respond_to do |format|
      if @submission.save

        Delayed::Job.enqueue @submission
        # @submission.perform
         #@submission.delay.make_commandline()

        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.html { render action: "new" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_multiple
    zip_file = params[:submission][:file]
    unzipped_files = unzip(zip_file)

    submissions = []

#   =begin
# if params.include? :merge_files and !unzipped_files.empty?
#
#      submissionFileUploader = SubmissionFileUploader.new()
#      invalid_files = false
#      unzipped_files.each do |curr_file|
#        if submissionFileUploader.extension_white_list.include? File.extname(curr_file).to_s
#          invalid_files = true
#        end
#      end
#
#      if !invalid_files
#        @submission = Submission.new(params[:submission])
#        @submission.file = mergeFiles(unzipped_files, File.new('tmp/' + Time.new.to_s + '.' + File.extname(unzipped_files[0]).to_s, 'w'))
#        @submission.user = @user
#        submissions << @submission
#      end
#    else
#=end
      unzipped_files.each  do |curr_file|
        @submission = Submission.new(params[:submission])
  		  @submission.file = curr_file
        @submission.user = @user
        submissions << @submission
        if (not @submission.valid?)
          break
        end
      end
   # end

   # if submissions.empty?
   #   @submission.file = nil
   # end

    respond_to do |format|
      if (@submission.valid?)
        if params.include? :merge_files
          @submission.file = merge_files(unzipped_files)
          submissions = [@submission]
        end
        submissions.each do |submission|
          submission.save!
          Delayed::Job.enqueue submission
        end
        format.html { redirect_to submissions_url, notice: 'Submissions were successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  # PUT /submissions/1
  # PUT /submissions/1.json
  #def update
  #  @submission = Submission.find(params[:id])

  #  respond_to do |format|
  #    if @submission.update_attributes(params[:submission])
  #      format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
  #      format.json { head :ok }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @submission.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      flash[:success] = "Successfully deleted submission"
      format.html { redirect_to submission_results_url }
      format.json { head :ok }
    end
  end

  def cancel
    @submission = Submission.find(params[:id])
    @submission.complete_job("s")

    respond_to do |format|
      flash[:success] = "Successfully cancelled submission"
      format.html { redirect_to submissions_url }
      format.json { head :ok }
    end
  end

  def download_results
    @submission = Submission.find(params[:id])
    if @submission.status == 'c'
      begin
        result_file = @submission.results_file.file.path
        send_file result_file
      rescue => ex
        puts ex 
        #puts "Could not find file"
        flash[:error] = "Could not download results file"
        redirect_to submission_path
      end
    end
  end
end
