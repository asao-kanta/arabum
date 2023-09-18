class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: %i[:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /urls or /urls.json
  def index
    @urls = Url.all
    # logger.debug(@urls)
    # @girls_time = []
    # @girls_name = []
    # for i in 0..@urls.length-1
    #   logger.debug(@urls[i])
    #   agent = Mechanize.new
    #   agent.user_agent = "ACME-Examplebot/1.0"
    #   page = agent.get(@urls[i][:link])
    #   elements = page.search('div#girlprofile_sukkin ul li dl')
    #   if i==0
    #     @girls_day = elements.search("dt").inner_text.split
    #   end
    #   # date = elements.search("dd .go2").inner_text.split
    #   date = []
    #   elements.search("dd").each do |dd|
    #     date.push(dd.search(".go2").inner_text.split)
    #   end
    #   new_date = []
    #   flag = 0
    #   for j in 0..date.length-1
    #     if flag == 1
    #       flag = 0
    #       next
    #     end
    #     if date[j].include?("-")
    #       new_date.push(date[j]+date[j+1])
    #       flag = 1
    #     elsif date[j]==""
    #       new_date.push(" ")
    #     else
    #       new_date.push(date[j])
    #     end
    #   end
    #   @girls_time.push(new_date)
    #   @girls_name.push(@urls[i][:name])
    # end
    # logger.debug(@girls_day)
    # logger.debug(@girls_time)
  end

  # GET /urls/1 or /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
  end

  # POST /urls or /urls.json
  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to url_url(@url), notice: "Url was successfully created." }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1 or /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to url_url(@url), notice: "Url was successfully updated." }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1 or /urls/1.json
  def destroy
    @url.destroy

    respond_to do |format|
      format.html { redirect_to urls_url, notice: "Url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.require(:url).permit(:name, :link)
    end
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
end
