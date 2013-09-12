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
    span = span || win.size;

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

function Monitor(resolution) {
  this.res = resolution;
  this._grids = {};
}
_.extend(Monitor.prototype, {
  grid: function(x, y) {
    var dims = x + 'x' + y;
    this._grids[dims] = this._grids[dims] || new Grid(this.res, xy(x, y));

    return this._grids[dims];
  },

  center: function() {
    return this.grid(2, 2).center(xy(1, 1));
  },

  full: function() {
    return this.grid(1, 1).snapto(xy(0, 0));
  },
});

var mbp15  = new Monitor('1440x900');
var dell30 = new Monitor('2560x1600');


//////////////////////////////////////////
//
//  Layouts.
//

var layouts = [
  S.layout('1-monitor', {
    'Google Chrome': {
      operations: [mbp15.full()],
      'ignore-fail': true,
    },
    'Microsoft Outlook': {
      operations: [mbp15.full()],
    },
    'Textual': {
      operations: [
        S.op('push', {direction: 'left', style: 'center'})
      ],
    },
    'Pandora': {
      operations: [
        S.op('push', {direction: 'right', style: 'center'})
      ],
    },
  }),

  S.layout('2-monitor', {
    'iTerm': {
      operations: [dell30.center()],
    },
    'Google Chrome': {
      operations: [function(w) {
        if (w.main()) {
          w.doop(dell30.grid(2, 2).snapto(xy(0, 0), xy(1, 2)));
        } else {
          w.doop(dell30.grid(2, 2).snapto(xy(1, 0), xy(1, 1)));
        }
      }],
      'ignore-fail': true,
      'repeat': true,
    },
    'Microsoft Outlook': {
      operations: [mbp15.full()],
    },
    'Textual': {
      operations: [dell30.grid(3, 3).center(xy(2, 2))],
    },
    'Pandora': {
      operations: [dell30.grid(16, 16).snapto(xy(14, 9))],
    }
  }),
];

function layout() {
  var count = S.screenCount();
  if (n <= 2) {
    layouts[n-1].run();
  }
}

S.def([mbp15.res], '1-monitor');
S.def([mbp15.res, dell30.res], '2-monitor');


//////////////////////////////////////////
//
//  Bindings.
//

S.bindAll({
  'space:ctrl':   layout,
  'return:ctrl':  S.op('relaunch'),
  'delete:cmd':   S.op('hint', {characters: 'HJKL;GFDSAYUIOPTREWQ'}),
});
