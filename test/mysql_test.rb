require 'mysql2'

client = Mysql2::Client.new(:host => 'mysql.design-fun.com', :username => ENV['mysqluser'], :password => ENV['mysqlpass'], :database => 'kabu_chart')
query = %q{select * from stock_data}
results = client.query(query)
results.each do |row|
  puts "--------------------"
  p row
  row.each do |id, ticker, name, c_detail|
    puts "#{id} #{ticker} #{name} #{c_detail}"
  end
end
