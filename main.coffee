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
  # 共通
  "文系"
  "英語第一第二"
  "英語第五第六"
  "第二外国語"
  # 5類
  "情報工学科200E"
  "情報工学科200O"
  "情報工学科200EO"
  "情報工学科300E"
  "情報工学科300O"
  "情報工学科300EO"
  "情報工学系200"
  "情報工学系300"
  "電気電子工学科"
  "電気電子系200"
  "電気電子系300"
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
  for item in vm.list
    sch = schedule[item]
    add sch, items
  # 時間割追加ここまで
  for x in [0,1]
    for i in [1...row.length]
      for j in [1...col.length]
        if items[x][i][j].length == 0
          items[x][i][j] = [["#fff",":sobaya:"]]
  vm.items = items

gradeStandard =
  second : ["文系","英語第五第六","第二外国語"]
  third : ["文系","英語第五第六","第二外国語"]

main = ->
  vm = new Vue
    el : "#app"
    methods :
      JKE: ->
        @list = []
        @list.push "情報工学科200E"
        @list.push "情報工学科300E"
        @list.push "情報工学系200"
        @list.push "情報工学系300"
        @list = @list.concat gradeStandard.second;
        do update
      JKO: ->
        @list = []
        @list.push "情報工学科200O"
        @list.push "情報工学科300O"
        @list.push "情報工学系200"
        @list.push "情報工学系300"
        @list = @list.concat gradeStandard.second;
        do update
      JKEO: ->
        @list = []
        @list.push "情報工学科200EO"
        @list.push "情報工学科300EO"
        @list.push "情報工学系200"
        @list.push "情報工学系300"
        @list = @list.concat gradeStandard.second;
        do update
      DD: ->
        @list = []
        @list.push "電気電子系200"
        @list.push "電気電子系300"
        @list.push "電気電子工学科"
        @list = @list.concat gradeStandard.second;
        do update
      update: ->
        do update
      reset: ->
        @list = []
        do update
    data :
      items : []
      list : []
      subjectList : list
  do update

window.onload = main
