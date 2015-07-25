(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var CodeEditor, config, myLayout, panels, resize;

CodeEditor = require('./CodeEditor/CodeEditor');

panels = [];

config = {
  content: [
    {
      type: 'column',
      content: [
        {
          type: 'component',
          componentName: 'example',
          componentState: {
            text: 'Component 1'
          }
        }, {
          type: 'component',
          componentName: 'example',
          componentState: {
            text: 'Component 1'
          }
        }, {
          type: 'component',
          componentName: 'example',
          componentState: {
            text: 'Component 1'
          }
        }
      ]
    }
  ]
};

myLayout = new GoldenLayout(config, $('#main'));

myLayout.registerComponent('example', function(container, state) {
  var panel;
  console.log('new container');
  panel = new CodeEditor({
    el: container.getElement(),
    container: container,
    state: state
  });
  panel.getPanels = function() {
    return panels;
  };
  panels.push(panel);
  return container.on('destroy', function() {
    panel.remove();
    return panels = _.without(panels, panel);
  });
});

resize = function() {
  var height, main, width;
  height = $(window).height();
  width = $(window).width();
  main = $('#main');
  return main.css({
    width: width,
    height: height - 62
  });
};

resize();

myLayout.init();

$(window).resize(function() {
  resize();
  return setTimeout(function() {
    myLayout.updateSize();
    return console.log('resizing layout');
  }, 10);
});



},{"./CodeEditor/CodeEditor":2}],2:[function(require,module,exports){
var CodeEditor, TabPanel, Toolbar, TreePanel,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

TabPanel = require('./TabPanel');

TreePanel = require('./TreePanel');

Toolbar = require('./Toolbar');

module.exports = CodeEditor = (function(superClass) {
  extend(CodeEditor, superClass);

  function CodeEditor() {
    return CodeEditor.__super__.constructor.apply(this, arguments);
  }

  CodeEditor.prototype.initialize = function(opts) {
    this.state = opts.state;
    this.container = opts.container;
    _.bindAll(this, 'render');
    return this.render();
  };

  CodeEditor.prototype.render = function() {
    var html, zzz;
    zzz = _.uniqueId();
    html = "<div class=\"panel panel-default\">\n    <div class=\"panel-heading\">\n\n    </div>\n    <div class=\"splitter\">\n        <div class=\"splitter-left\">\n\n\n        </div>\n        <div class=\"splitter-right\">\n\n        </div>\n    </div>\n</div>";
    $(this.el).html(html);
    return setTimeout((function(_this) {
      return function() {
        var height, splitter, width;
        height = $(_this.el).height() - 45;
        width = $(_this.el).width();
        $('.panel', _this.el).css({
          height: height,
          width: width
        });
        splitter = $('.splitter', _this.el).jqxSplitter({
          orientation: 'vertical',
          width: '100%',
          height: '100%',
          panels: [
            {
              size: '200px'
            }
          ]
        });
        splitter.on('resize', function() {
          if (_this.tabpanel) {
            return _this.tabpanel.resize();
          }
        });
        _this.container.on('resize', function() {
          height = $(_this.el).height() - 45;
          width = $(_this.el).width();
          $('.panel', _this.el).css({
            height: height,
            width: width
          });
          $('.splitter', _this.el).jqxSplitter('render');
          if (_this.tabpanel) {
            _this.tabpanel.resize();
          }
          if (_this.toolbar) {
            return _this.toolbar.resize();
          }
        });
        _this.toolbar = new Toolbar({
          el: $('.panel-heading', _this.el)
        });
        _this.toolbar.parent = function() {
          return _this;
        };
        _this.tabpanel = new TabPanel({
          el: $('.splitter-right', _this.el)
        });
        _this.tabpanel.parent = function() {
          return _this;
        };
        _this.treepanel = new TreePanel({
          el: $('.splitter-left', _this.el)
        });
        _this.treepanel.parent = function() {
          return _this;
        };
        return _this.tabpanel.newTab();
      };
    })(this), 10);
  };

  return CodeEditor;

})(Backbone.View);



},{"./TabPanel":4,"./Toolbar":5,"./TreePanel":6}],3:[function(require,module,exports){
var EditorTab,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

module.exports = EditorTab = (function(superClass) {
  extend(EditorTab, superClass);

  function EditorTab() {
    return EditorTab.__super__.constructor.apply(this, arguments);
  }

  EditorTab.prototype.initialize = function(opts) {
    this.navtab = opts.navtab;
    _.bindAll(this, 'render');
    return this.render();
  };

  EditorTab.prototype.render = function() {
    this.editor = ace.edit(this.el);
    this.editor.setTheme('ace/theme/monokai');
    this.editor.getSession().setMode('ace/mode/javascript');
    return this.editor.setOptions({
      fontSize: "14px"
    });
  };

  return EditorTab;

})(Backbone.View);



},{}],4:[function(require,module,exports){
var EditorTab, TabPanel,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

EditorTab = require('./EditorTab');

module.exports = TabPanel = (function(superClass) {
  extend(TabPanel, superClass);

  function TabPanel() {
    return TabPanel.__super__.constructor.apply(this, arguments);
  }

  TabPanel.prototype.initialize = function(opts) {
    _.bindAll(this, 'render', 'receiveFn');
    this.render();
    return this.tabs = [];
  };

  TabPanel.prototype.render = function() {
    var html;
    html = "<div role=\"tabpanel\" style=\"height: 100%; width: 100%\">\n    <!-- Nav tabs -->\n    <ul class=\"nav nav-tabs\" role=\"tablist\" style=\"min-height: 30px;\">\n\n    </ul>\n\n    <!-- Tab panes -->\n    <div class=\"tab-content\">\n\n    </div>\n</div>";
    $(this.el).html(html);
    return setTimeout((function(_this) {
      return function() {
        var height, width;
        height = $(_this.el).height() - 30;
        width = $(_this.el).width() - 5;
        $('.tab-content', _this.el).css({
          height: height,
          width: width
        });
        return $('.nav-tabs', _this.el).sortable({
          delay: 150,
          helper: 'clone',
          appendTo: 'body',
          zIndex: 1000,
          connectWith: '.nav-tabs',
          receive: _this.receiveFn
        });
      };
    })(this), 10);
  };

  TabPanel.prototype.receiveFn = function(e, ui) {
    var codeeditor, i, len, ref, tab, tabId;
    console.log('received!');
    tabId = ui.item.find('a').attr('href').substr(1);
    console.log(tabId);
    ref = this.parent().getPanels();
    for (i = 0, len = ref.length; i < len; i++) {
      codeeditor = ref[i];
      tab = codeeditor.tabpanel.hasTab(tabId);
      if (tab) {
        codeeditor.tabpanel.tabs = _.without(codeeditor.tabpanel.tabs, tab);
        this.tabs.push(tab);
        tab.$el.detach().appendTo(this.$('.tab-content'));
        this.$('.nav-tabs li').removeClass('active');
        tab.navtab.tab('show');
        console.log(codeeditor.tabpanel.tabs);
        return;
      }
    }
  };

  TabPanel.prototype.hasTab = function(id) {
    var i, len, ref, tab;
    ref = this.tabs;
    for (i = 0, len = ref.length; i < len; i++) {
      tab = ref[i];
      if (tab.$el.attr('id') === id) {
        return tab;
      }
    }
  };

  TabPanel.prototype.resize = function() {
    var height, width;
    height = $(this.el).height() - 30;
    width = $(this.el).width();
    $('.tab-content', this.el).css({
      height: height,
      width: width
    });
    return this.tabs.forEach(function(tab) {
      return tab.editor.resize(true);
    });
  };

  TabPanel.prototype.newTab = function() {
    var closebtn, editorTab, liNav, navTabContainer, navTabTemplate, navtab, tab, tabContainer, tabContentTemplate, tabId;
    tabId = _.uniqueId('tab');
    navTabContainer = this.$('.nav-tabs');
    tabContainer = this.$('.tab-content');
    navTabTemplate = "<li role=\"presentation\">\n<a href=\"#" + tabId + "\" aria-controls=\"" + tabId + "\" role=\"tab\" data-toggle=\"tab\">" + tabId + ".js\n</a>\n</li>";
    tabContentTemplate = "<div role=\"tabpanel\" class=\"tab-pane\" id=\"" + tabId + "\" style=\"height: 100%; width: 100%\"></div>";
    navTabContainer.append(navTabTemplate);
    tabContainer.append(tabContentTemplate);
    navtab = this.$('.nav-tabs a:last');
    navtab.css({
      'padding-right': '25px'
    });
    tab = this.$('#' + tabId);
    navtab.tab('show');
    editorTab = new EditorTab({
      el: tab,
      navtab: navtab
    });
    this.tabs.push(editorTab);
    liNav = navtab.parent();
    closebtn = $('<span class="glyphicon glyphicon-remove-circle close-tab" aria-hidden="true"></span>').appendTo(liNav);
    return closebtn.click((function(_this) {
      return function() {
        liNav.remove();
        editorTab.editor.destroy();
        tab.remove();
        return _this.$('.nav-tabs a:last').tab('show');
      };
    })(this));
  };

  return TabPanel;

})(Backbone.View);



},{"./EditorTab":3}],5:[function(require,module,exports){
var Toolbar,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

module.exports = Toolbar = (function(superClass) {
  extend(Toolbar, superClass);

  function Toolbar() {
    return Toolbar.__super__.constructor.apply(this, arguments);
  }

  Toolbar.prototype.initialize = function(opts) {
    _.bindAll(this, 'render');
    this.items = [
      [
        {
          name: 'Save',
          icon: 'floppy-disk'
        }, {
          name: 'Save All',
          icon: 'floppy-saved'
        }
      ], [
        {
          name: 'New File',
          icon: 'file',
          cls: 'new-file'
        }
      ], [
        {
          name: 'Undo',
          icon: 'arrow-left'
        }, {
          name: 'Redo',
          icon: 'arrow-right'
        }
      ], [
        {
          name: 'Toggle Comment',
          icon: 'object-align-left'
        }
      ], [
        {
          name: 'Toggle Autocomplete',
          icon: 'tasks'
        }
      ], [
        {
          name: 'Cut',
          icon: 'scissors'
        }, {
          name: 'Copy',
          icon: 'duplicate'
        }, {
          name: 'Paste',
          icon: 'paste'
        }
      ], [
        {
          name: 'Revert',
          icon: 'refresh'
        }, {
          name: 'Close',
          icon: 'remove-circle'
        }
      ]
    ];
    return this.render();
  };

  Toolbar.prototype.events = {
    'click .new-file': 'newFile'
  };

  Toolbar.prototype.render = function() {
    var button, buttonGroup, html, i, j, k, l, len, len1, len2, len3, ref, ref1;
    html = "<div class=\"btn-toolbar\" role=\"toolbar\">";
    ref = this.items;
    for (i = 0, len = ref.length; i < len; i++) {
      buttonGroup = ref[i];
      html += "<div class=\"btn-group toolbar-button\" role=\"group\">";
      for (j = 0, len1 = buttonGroup.length; j < len1; j++) {
        button = buttonGroup[j];
        button.id = _.uniqueId('btn');
        html += "<button type=\"button\" id=\"" + button.id + "\" title=\"" + button.name + "\"class=\"btn btn-default btn-sm " + (button.cls || '') + "\" aria-label=\"Left Align\">\n  <span class=\"glyphicon glyphicon-" + button.icon + "\" aria-hidden=\"true\"></span>\n</button>";
      }
      html += "</div>";
    }
    html += "<div class=\"btn-group toolbar-list\" role=\"group\">\n  <button type=\"button\" class=\"btn btn-default btn-sm dropdown-toggle\" data-toggle=\"dropdown\" aria-expanded=\"false\">\n    <span class=\"glyphicon glyphicon-menu-hamburger\" aria-hidden=\"true\"></span>\n  </button>\n    <ul class=\"dropdown-menu\" role=\"menu\">";
    ref1 = this.items;
    for (k = 0, len2 = ref1.length; k < len2; k++) {
      buttonGroup = ref1[k];
      for (l = 0, len3 = buttonGroup.length; l < len3; l++) {
        button = buttonGroup[l];
        html += "<li><a href=\"#\"><span class=\"glyphicon glyphicon-" + button.icon + "\" aria-hidden=\"true\">\n</span>&nbsp;&nbsp;" + button.name + "</a></li>";
      }
      html += "<li class=\"divider\"></li>";
    }
    html += "</ul>";
    html += "</div>";
    html += "</div>";
    $(this.el).html(html);
    return setTimeout((function(_this) {
      return function() {
        return _this.resize();
      };
    })(this), 10);
  };

  Toolbar.prototype.resize = function() {
    var width;
    width = this.$el.width();
    if (width < 400 && width !== 0) {
      this.$('.toolbar-list').show();
      return this.$('.toolbar-button').hide();
    } else {
      this.$('.toolbar-list').hide();
      return this.$('.toolbar-button').show();
    }
  };

  Toolbar.prototype.newFile = function() {
    return this.parent().tabpanel.newTab();
  };

  return Toolbar;

})(Backbone.View);



},{}],6:[function(require,module,exports){
var TreePanel,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

module.exports = TreePanel = (function(superClass) {
  extend(TreePanel, superClass);

  function TreePanel() {
    return TreePanel.__super__.constructor.apply(this, arguments);
  }

  TreePanel.prototype.initialize = function(opts) {
    _.bindAll(this, 'render');
    return this.render();
  };

  TreePanel.prototype.render = function() {
    var html, zzz;
    zzz = _.uniqueId();
    html = "<nav class=\"navbar navbar-default\">\n    <div class=\"container-fluid\">\n        <ul class=\"nav navbar-nav\">\n\n            <li class=\"dropdown\">\n                <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">Public <span class=\"caret\"></span></a>\n                <ul class=\"dropdown-menu\" role=\"menu\">\n                    <li><a href=\"#\">CODEMONSTER</a></li>\n                    <li><a href=\"#\">CODEZILLA</a></li>\n                    <li><a href=\"#\">GraphIDE</a></li>\n                </ul>\n            </li>\n        </ul>\n        <ul class=\"nav navbar-nav navbar-right\">\n            <li>\n                <button type=\"button\" class=\"navbar-btn btn btn-xs\"><span class=\"glyphicon glyphicon-chevron-left\" aria-hidden=\"true\"></span></button>\n            </li>\n        </ul>\n    </div>\n</nav>\n<div class=\"jstree\">\n  <ul>\n    <li>Root node\n      <ul>\n        <li>Child node 1</li>\n        <li>Child node 2</li>\n      </ul>\n    </li>\n  </ul>\n</div>";
    $(this.el).html(html);
    return $('.jstree', this.el).jstree({
      core: {
        themes: {
          name: 'default-dark',
          dots: true,
          icons: true
        }
      }
    });
  };

  return TreePanel;

})(Backbone.View);



},{}]},{},[1]);
