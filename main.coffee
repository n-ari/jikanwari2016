# index.html でロードした js ファイルが schedule を埋めている

rev = {
  "Mon":1
  "Tue":2
  "Wed":3
  "Thu":4
  "Fri":5
  "Other":6
  "1":1
  "2":2
  "3":3
  "4":4
  "5":5
  "6":6
  "12":1
  "34":2
  "56":3
  "78":4
  "910":5
}

Q = 2

add = (sch,items)->
  color = sch.color
  for x in [0...Q]
    r = sch.data[x]
    for i in [0...r.length]
      item = r[i].split ','
      items[x][rev[item[1]]][rev[item[0]]].push [color,item[2]]

vm = {}

list = [
  "情報工学科200E"
  "情報工学系200"
  "文系"
  "第二外国語"
  "情報工学科300E"
  "情報工学系300"
]

update = ->
  row = ",1～2,3～4,5～6,7～8,9～10,その他".split ','
  col = ",月,火,水,木,金,その他".split ','
  items = []
  for x in [0,1]
    items[x] = []
    for i in [0...row.length]
      for j in [0...col.length]
        if j is 0
          items[x][i] = []
          items[x][i][j] = row[i]
        else if i is 0
          items[x][i][j] = col[j]
        else
          items[x][i][j] = []
  # 時間割追加
  for item in list
    sch = schedule[item]
    add sch, items
  # 時間割追加ここまで
  for x in [0,1]
    for i in [1...row.length]
      for j in [1...col.length]
        if items[x][i][j].length == 0
          items[x][i][j] = [["#fff",":sobaya:"]]
  vm.items = items

main = ->
  vm = new Vue
    el : "#app"
    methods :
      switchToE: ->
        for i in [0...list.length]
          if list[i] is "情報工学科200O" or list[i] is "情報工学科200EO"
            list[i] = "情報工学科200E"
          if list[i] is "情報工学科300O" or list[i] is "情報工学科300EO"
            list[i] = "情報工学科300E"
        do update
      switchToO: ->
        for i in [0...list.length]
          if list[i] is "情報工学科200E" or list[i] is "情報工学科200EO"
            list[i] = "情報工学科200O"
          if list[i] is "情報工学科300E" or list[i] is "情報工学科300EO"
            list[i] = "情報工学科300O"
        do update
      switchToEO: ->
        for i in [0...list.length]
          if list[i] is "情報工学科200E" or list[i] is "情報工学科200O"
            list[i] = "情報工学科200EO"
          if list[i] is "情報工学科300E" or list[i] is "情報工学科300O"
            list[i] = "情報工学科300EO"
        do update
    data :
      items : []
  do update

window.onload = main
