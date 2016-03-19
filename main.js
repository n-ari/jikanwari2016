// Generated by CoffeeScript 1.10.0
var Q, add, list, main, rev, update, vm;

rev = {
  "Mon": 1,
  "Tue": 2,
  "Wed": 3,
  "Thu": 4,
  "Fri": 5,
  "Other": 6,
  "1": 1,
  "2": 2,
  "3": 3,
  "4": 4,
  "5": 5,
  "6": 6,
  "12": 1,
  "34": 2,
  "56": 3,
  "78": 4,
  "910": 5
};

Q = 2;

add = function(sch, items) {
  var color, i, item, k, r, ref, results, x;
  color = sch.color;
  results = [];
  for (x = k = 0, ref = Q; 0 <= ref ? k < ref : k > ref; x = 0 <= ref ? ++k : --k) {
    r = sch.data[x];
    results.push((function() {
      var l, ref1, results1;
      results1 = [];
      for (i = l = 0, ref1 = r.length; 0 <= ref1 ? l < ref1 : l > ref1; i = 0 <= ref1 ? ++l : --l) {
        item = r[i].split(',');
        results1.push(items[x][rev[item[1]]][rev[item[0]]].push([color, item[2]]));
      }
      return results1;
    })());
  }
  return results;
};

vm = {};

list = ["情報工学科200E", "情報工学科200O", "情報工学科200EO", "情報工学科300E", "情報工学科300O", "情報工学科300EO", "情報工学系200", "情報工学系300", "文系", "第二外国語"];

update = function() {
  var col, i, item, items, j, k, l, len, len1, len2, m, n, o, p, q, ref, ref1, ref2, ref3, ref4, ref5, ref6, row, sch, x;
  row = ",1～2,3～4,5～6,7～8,9～10,その他".split(',');
  col = ",月,火,水,木,金,その他".split(',');
  items = [];
  ref = [0, 1];
  for (k = 0, len = ref.length; k < len; k++) {
    x = ref[k];
    items[x] = [];
    for (i = l = 0, ref1 = row.length; 0 <= ref1 ? l < ref1 : l > ref1; i = 0 <= ref1 ? ++l : --l) {
      for (j = m = 0, ref2 = col.length; 0 <= ref2 ? m < ref2 : m > ref2; j = 0 <= ref2 ? ++m : --m) {
        if (j === 0) {
          items[x][i] = [];
          items[x][i][j] = row[i];
        } else if (i === 0) {
          items[x][i][j] = col[j];
        } else {
          items[x][i][j] = [];
        }
      }
    }
  }
  ref3 = vm.list;
  for (n = 0, len1 = ref3.length; n < len1; n++) {
    item = ref3[n];
    sch = schedule[item];
    add(sch, items);
  }
  ref4 = [0, 1];
  for (o = 0, len2 = ref4.length; o < len2; o++) {
    x = ref4[o];
    for (i = p = 1, ref5 = row.length; 1 <= ref5 ? p < ref5 : p > ref5; i = 1 <= ref5 ? ++p : --p) {
      for (j = q = 1, ref6 = col.length; 1 <= ref6 ? q < ref6 : q > ref6; j = 1 <= ref6 ? ++q : --q) {
        if (items[x][i][j].length === 0) {
          items[x][i][j] = [["#fff", ":sobaya:"]];
        }
      }
    }
  }
  return vm.items = items;
};

main = function() {
  vm = new Vue({
    el: "#app",
    methods: {
      JKE: function() {
        this.list = ["情報工学科200E", "情報工学科300E", "情報工学系200", "情報工学系300", "文系", "第二外国語"];
        return update();
      },
      JKO: function() {
        this.list = ["情報工学科200O", "情報工学科300O", "情報工学系200", "情報工学系300", "文系", "第二外国語"];
        return update();
      },
      JKEO: function() {
        this.list = ["情報工学科200EO", "情報工学科300EO", "情報工学系200", "情報工学系300", "文系", "第二外国語"];
        return update();
      },
      update: function() {
        return update();
      }
    },
    data: {
      items: [],
      list: [],
      subjectList: list
    }
  });
  return update();
};

window.onload = main;
