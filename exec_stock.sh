#!/bin/sh

ruby /home/kabuchk/src/crawn-chart/stock_18.rb < /home/kabuchk/src/crawn-chart/ticker.txt
ruby /home/kabuchk/src/crawn-chart/upload_sftp.rb < /home/kabuchk/src/crawn-chart/ticker.txt
