class HelpController < ApplicationController
  # GET /help
  # GET /help.json
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
