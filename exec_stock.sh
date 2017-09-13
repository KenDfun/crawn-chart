#!/bin/sh

ruby /home/kabuchk/src/crawn-chart/stock.rb < /home/kabuchk/src/crawn-chart/ticker.txt
ruby /home/kabuchk/src/crawn-chart/upload_sftp.rb < /home/kabuchk/src/crawn-chart/ticker.txt
