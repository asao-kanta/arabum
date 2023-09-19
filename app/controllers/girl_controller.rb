class GirlController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    @urls = Url.all
    logger.debug(@urls)
    @girls_time = []
    @girls_name = []
    for i in 0..@urls.length-1
      logger.debug(@urls[i])
      agent = Mechanize.new
      agent.user_agent = "ACME-Examplebot/1.0"
      page = agent.get(@urls[i][:link])
      logger.debug(page)
      puts page
      elements = page.search('div#girlprofile_sukkin ul li dl')
      if i==0
        @girls_day = elements.search("dt").inner_text.split
      end
      # date = elements.search("dd .go2").inner_text.split
      date = []
      elements.search("dd").each do |dd|
        date.push(dd.search(".go2").inner_text.split)
      end
      new_date = []
      flag = 0
      for j in 0..date.length-1
        if flag == 1
          flag = 0
          next
        end
        if date[j].include?("-")
          new_date.push(date[j]+date[j+1])
          flag = 1
        elsif date[j]==""
          new_date.push(" ")
        else
          new_date.push(date[j])
        end
      end
      @girls_time.push(new_date)
      @girls_name.push(@urls[i][:name])
    end
    logger.debug(@girls_day)
    logger.debug(@girls_time)
  end
  
  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
end
