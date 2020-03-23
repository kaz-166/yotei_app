module EventsHelper
    #googleマップから位置情報を取得
    def location_info(location)
        url = URI.encode("https://www.google.com/maps/place/" + location)
        doc = Nokogiri::HTML(open(url))
    end
end
