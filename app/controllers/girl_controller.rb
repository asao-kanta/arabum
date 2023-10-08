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
      agent.request_headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
        "Cookie": "xgsn=3a63a907a3145f3b9f95dcdca6ec4637; xgsnt=3a63a907a3145f3b9f95dcdca6ec4637; xgss=19024fe6a4e509439535d07200828356; X-Sc-R-T-M=10X100X100X13Y1695545968.341Y641706313; Apache=s.yoyaku.request3.cityheaven.net.18571695545968864; xgrn=17a0e47f782d1b326b267f36de5ec641; xgrh=14.128.1.87",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
      }
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
