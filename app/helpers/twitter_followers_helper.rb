module TwitterFollowersHelper
    def followers(max)
      #twitter.friends(current_user).take(max)
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
