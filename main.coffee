# index.html でロードした js ファイルが schedule を埋めている
# index.html でロードした js ファイルが subjects を埋めている

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

addsubj = (subj,items)->
  color = subjects[subj][0]
  for i in [1...subjects[subj].length]
    query = subjects[subj][i].split ','
    qu = query[0][0]^0
    items[qu-1][rev[query[2]]][rev[query[1]]].push [color,subj]

vm = {}

update = ->
  row = ",1～2,3～4,5～6,7～8,9～10,その他".split ','
  col = ",月,火,水,木,金,その他".split ','
  items = []
  for x in [0...Q]
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
  for subj in vm.picked_subj
    addsubj subj,items
  # 時間割追加ここまで
  for x in [0...Q]
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
        @list.push "情報通信系200"
        @list = @list.concat gradeStandard.second;
        do update
      JKO: ->
        @list = []
        @list.push "情報工学科200O"
        @list.push "情報工学科300O"
        @list.push "情報工学系200"
        @list.push "情報工学系300"
        @list.push "情報通信系200"
        @list = @list.concat gradeStandard.second;
        do update
      JKEO: ->
        @list = []
        @list.push "情報工学科200EO"
        @list.push "情報工学科300EO"
        @list.push "情報工学系200"
        @list.push "情報工学系300"
        @list.push "情報通信系200"
        @list = @list.concat gradeStandard.second;
        do update
      DD: ->
        @list = []
        @list.push "電気電子系200"
        @list.push "電気電子系300"
        @list.push "電気電子工学科"
        @list = @list.concat gradeStandard.second;
        do update
      use_preset: (ps)->
        console.log ps
        for subj in presets[ps]
          if @picked_subj.indexOf(subj) is -1
            @picked_subj.push subj
        do update
      update: ->
        do update
      reset: ->
        @picked_subj = []
        do update
    data :
      items : []
      list : []
      subjectList : []
      picked_subj : []
      all_subj : subjects
      presets : presets
  do update

window.onload = main
