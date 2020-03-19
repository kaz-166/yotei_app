class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show]
  def index
  end

  def show
    @followers = twitter.friends(current_user).take(3)
  end

  private
    def twitter
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = "Quk3tKWVBQO9WpFYzkKapByk7"
        config.consumer_secret = "UmihME0PcC4xMy9nfobjOMOZzLlsyemYubJoy5v5scXcVEPdRw"
        config.access_token = "731809789659877376-cC4GZHbgbRv3cMyXCghNyVG6GfuzD5k"
        config.access_token_secret ="iZllloyKwDU3morSt670oCJ2LZ4vp5NiRlOBgFSrvOLuu"
      end
    end
end
