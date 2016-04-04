// Generated by CoffeeScript 1.10.0
var Q, addsubj, gradeStandard, main, rev, update, vm;

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

addsubj = function(subj, items) {
  var color, i, k, qu, query, ref, results;
  console.log(subj);
  color = subjects[subj][0];
  results = [];
  for (i = k = 1, ref = subjects[subj].length; 1 <= ref ? k < ref : k > ref; i = 1 <= ref ? ++k : --k) {
    query = subjects[subj][i].split(',');
    qu = query[0][0] ^ 0;
    results.push(items[qu - 1][rev[query[2]]][rev[query[1]]].push([color, subj]));
  }
  return results;
};

vm = {};

update = function() {
  var col, i, items, j, k, l, len, m, n, o, p, q, ref, ref1, ref2, ref3, ref4, ref5, ref6, row, subj, x;
  row = ",1～2,3～4,5～6,7～8,9～10,その他".split(',');
  col = ",月,火,水,木,金,その他".split(',');
  items = [];
  for (x = k = 0, ref = Q; 0 <= ref ? k < ref : k > ref; x = 0 <= ref ? ++k : --k) {
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
  ref3 = vm.picked_subj;
  for (n = 0, len = ref3.length; n < len; n++) {
    subj = ref3[n];
    addsubj(subj, items);
  }
  for (x = o = 0, ref4 = Q; 0 <= ref4 ? o < ref4 : o > ref4; x = 0 <= ref4 ? ++o : --o) {
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

gradeStandard = {
  second: ["文系", "英語第五第六", "第二外国語"],
  third: ["文系", "英語第五第六", "第二外国語"]
};

main = function() {
  vm = new Vue({
    el: "#app",
    methods: {
      use_preset: function(ps) {
        var k, len, ref, subj;
        this.picked_subj = [];
        ref = presets[ps];
        for (k = 0, len = ref.length; k < len; k++) {
          subj = ref[k];
          if (this.picked_subj.indexOf(subj) === -1) {
            this.picked_subj.push(subj);
          }
        }
        return update();
      },
      update: function() {
        return update();
      },
      reset: function() {
        this.picked_subj = [];
        return update();
      }
    },
    data: {
      items: [],
      list: [],
      subjectList: [],
      picked_subj: [],
      all_subj: subjects,
      presets: presets
    }
  });
  return update();
};

window.onload = main;
