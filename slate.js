/**
 * .slate.js - Slate window manager configuration.
 */

S.configAll({
  defaultToCurrentScreen: true,
  checkDefaultsOnLoad: true,
  orderScreensLeftToRight: true,

  nudgePercentOf: 'screenSize',
  resizePercentOf: 'screenSize',
  focusCheckWidthMax: 3000,

  windowHintsIgnoreHiddenWindows: false,
  windowHintsShowIcons: true,
  windowHintsSpread: true,
});

/**
 * Dimensions object factory.  So fancy!
 */
function xy(x, y) {
  return {x: x, y: y};
}

/**
 * Slate, y u only have strings?
 */
var scr = {
  pos:  xy('screenOriginX', 'screenOriginY'),
  size: xy('screenSizeX', 'screenSizeY'),
};
var win = {
  pos:  xy('windowTopLeftX', 'windowTopLeftY'),
  size: xy('windowSizeX', 'windowSizeY'),
};


//////////////////////////////////////////
//
//  Grid object.
//

function Grid(screen, dims) {
  this.screen = screen;
  this.x = dims.x;
  this.y = dims.y;
}
_.extend(Grid.prototype, {
  /**
   * Returns a position object corresponding to cell (x, y) in the grid.
   */
  pos: function(x, y) {
    return {
      x: scr.pos.x + '+' + x + '*' + scr.size.x + '/' + this.x,
      y: scr.pos.y + '+' + y + '*' + scr.size.y + '/' + this.y
    };
  },

  /**
   * Returns a size object corresponding to (x, y) cells in the grid.
   */
  size: function(x, y) {
    return {
      width:  x + '*' + scr.size.x + '/' + this.x,
      height: y + '*' + scr.size.y + '/' + this.y,
    };
  },

  /**
   * Returns an operation for snapping a window to `cell', spanning `span'.
   */
  snapto: function(cell, span) {
    // Default to noresize.
    span = span || xy(this.x, this.y);

    var screen = this.screen;

    return S.op('move', _.extend(
      {screen: screen},
      this.pos(cell.x, cell.y),
      this.size(span.x, span.y)
    ));
  },

  /**
   * Returns an operation for centering a window on a cell's vertex.
   */
  center: function(cell) {
    var screen = this.screen;
    var pos = this.pos(cell.x, cell.y);

    return S.op('move', {
      screen: screen,
      x: pos.x + '-' + win.size.x + '/' + 2,
      y: pos.y + '-' + win.size.y + '/' + 2,
      width: win.size.x,
      height: win.size.y,
    });
  },
});


//////////////////////////////////////////
//
//  Monitor object.
//

function Monitor(screen) {
  this.screen = screen;
  this._grids = {};
}
_.extend(Monitor.prototype, {
  grid: function(x, y) {
    var dims = x + 'x' + y;
    this._grids[dims] = this._grids[dims] || new Grid(this.screen, xy(x, y));

    return this._grids[dims];
  },

  center: function() {
    return this.grid(2, 2).center(xy(1, 1));
  },

  full: function() {
    return this.grid(1, 1).snapto(xy(0, 0));
  },
});

var mbp15  = new Monitor('1440x900');   // all layouts
var dell30 = new Monitor('2560x1600');  // 2-screen only
var dell30c = new Monitor(1); // 3-screen only
var dell30r = new Monitor(2); // 3-screen only


//////////////////////////////////////////
//
//  Layouts.
//

S.layout('1-monitor', {
  'Google Chrome': {
    operations: [mbp15.full()],
    'ignore-fail': true,
    'repeat': true,
  },
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual': {
    operations: [mbp15.full()],
  },
});

S.layout('2-monitor', {
  'iTerm': {
    operations: [S.op('push', {
      screen: dell30.screen,
      direction: 'top',
      style: 'center'}
    )],
  },
  'Google Chrome': {
    operations: [function(w) {
      if (w.main()) {
        w.doop(dell30.grid(2, 2).snapto(xy(0, 0), xy(1, 2)));
      } else {
        w.doop(dell30.grid(2, 2).snapto(xy(1, 0), xy(1, 2)));
      }
    }],
    'ignore-fail': true,
    'repeat': true,
  },
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual': {
    operations: [mbp15.full()],
  },
});

S.layout('3-monitor', {
  'iTerm': {
    operations: [S.op('push', {
      screen: dell30c.screen,
      direction: 'top',
      style: 'center'}
    )],
  },
  'Google Chrome': {
    operations: [function(w) {
      if (w.main()) {
        w.doop(dell30r.grid(2, 2).snapto(xy(0, 0), xy(1, 2)));
      } else {
        w.doop(dell30r.grid(2, 2).snapto(xy(1, 0), xy(1, 2)));
      }
    }],
    'ignore-fail': true,
    'repeat': true,
  },
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual': {
    operations: [mbp15.full()],
  },
});

function layout() {
  var count = S.screenCount();
  if (count <= 3) {
    S.op('layout', {name: count + '-monitor'}).run();
  }
}

S.def([mbp15.screen], '1-monitor');
S.def([mbp15.screen, dell30.screen], '2-monitor');
S.def([mbp15.screen, dell30.screen, dell30.screen], '3-monitor');


//////////////////////////////////////////
//
//  Bindings.
//

S.bindAll({
  'space:ctrl':   layout,
  'return:ctrl':  S.op('relaunch'),
});
