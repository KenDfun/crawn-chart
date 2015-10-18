# キーバインド

### atom
* * *
`ctrl-shift-M : Markdown-preview`  
`ctrl-shift-H : atom-html-preview`  

`ctrl-l :  行を選択`  
`ctrl-shift-k  : 行を削除`  
`ctrl-e: 行最後へ移動`  
`ctrl-enter:  現在の行の下に行を追加`  


### ruby
* * *
**  ファイル読み込み & ERB bind **
```
  File.open(fileName,'r:utf-8'){|f|
    ERB.new(f.read).result(binding)
  }
```

```
# 以下のような、ハッシュの配列があるとして                                                                                                                                                        
users = [
  {   
    :id => '00002',
    :name => 'hoge'
  },
  {
    :id => '00003',
    :name => 'fuge'
  },
  {
    :id => '00001',
    :name => 'hage'
  }
]

# こうすれば、配列内の各ハッシュのキーidでソートできる
users.sort! do |a, b|
  a[:id] <=> b[:id]
end

# 結果表示
# [{:id=>"00001", :name=>"hage"}, {:id=>"00002", :name=>"hoge"}, {:id=>"00003", :name=>"fuge"}]
p users

```
