# -*- coding: utf-8 -*-

require "net/sftp"

$HTML_HOME = "/home/kabuchk/kabu-chart.dreamhosters.com"


class UploadToWebsite
  def initialize
    @sftp = Net::SFTP.start('kabu-chart.dreamhosters.com',"kabuchk",{:password => "dreamakari3"})
  end

  def upload(fileName)
    @sftp.upload!(fileName,"/home/kabuchk/kabu-chart.dreamhosters.com/#{fileName}")
    puts "upload: " + fileName
  end
end

webSession = UploadToWebsite.new
webSession.upload("index.html")

for std_ticker in STDIN
  webSession.upload("#{$HTML_HOME}/jpeg/chart_#{std_ticker.chomp}.jpg")
end
