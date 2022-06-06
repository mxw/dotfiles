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


///////////////////////////////////////////////////////////////////////////////
// Grid object.

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


///////////////////////////////////////////////////////////////////////////////
// Monitor object.

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

var mbp15   = new Monitor('1440x900');   // all layouts
var mbp19   = new Monitor('2880x1800');  // all layouts
var dell30  = new Monitor('2560x1600');  // 2-screen only
var dell30c = new Monitor(1); // 3-screen only
var dell30r = new Monitor(2); // 3-screen only


///////////////////////////////////////////////////////////////////////////////
// Layouts.

function make_chrome_layout(monitor) {
  return function() {
    let is_left = false;
    return function(w) {
      if (w.main()) {
        w.doop(monitor.grid(2, 2).snapto(xy(0, 0), xy(1, 2)));
        return;
      }
      if (is_left) {
        w.doop(monitor.grid(2, 2).snapto(xy(0, 0), xy(1, 2)));
      } else {
        w.doop(monitor.grid(2, 2).snapto(xy(1, 0), xy(1, 2)));
      }
      is_left = !is_left;
    };
  }();
}

S.layout('1-monitor', {
  'Google Chrome': {
    operations: [mbp15.full()],
    'ignore-fail': true,
    'repeat': true,
  },
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual IRC Client': {
    operations: [mbp15.full()],
  },
});

S.layout('2-monitor', {
  'iTerm2': {
    operations: [S.op('push', {
      screen: dell30.screen,
      direction: 'top',
      style: 'center'}
    )],
  },
  'Google Chrome': {
    operations: [dell30.full()],
    repeat: true,
  },
  'Messenger': {
    operations: [dell30.grid(2, 2).snapto(xy(0, 0), xy(1, 2))],
  },
  'Discord': {
    operations: [dell30.grid(2, 2).snapto(xy(1, 0), xy(1, 2))],
  },
  /*
  'Google Chrome': {
    operations: [make_chrome_layout(dell30)],
    'ignore-fail': true,
    'repeat': true,
  },
  */
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual IRC Client': {
    operations: [mbp15.full()],
  },
});

S.layout('3-monitor', {
  'iTerm2': {
    operations: [S.op('push', {
      screen: dell30c.screen,
      direction: 'top',
      style: 'center'}
    )],
  },
  'Google Chrome': {
    operations: [make_chrome_layout(dell30r)],
    'ignore-fail': true,
    'repeat': true,
  },
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual IRC Client': {
    operations: [mbp15.full()],
  },
});

S.layout('3-monitor-alt', {
  'iTerm2': {
    operations: [S.op('push', {
      screen: dell30r.screen,
      direction: 'top',
      style: 'center'}
    )],
  },
  'Google Chrome': {
    operations: [make_chrome_layout(dell30c)],
    'ignore-fail': true,
    'repeat': true,
  },
  'Microsoft Outlook': {
    operations: [mbp15.full()],
  },
  'Textual IRC Client': {
    operations: [mbp15.full()],
  },
});


///////////////////////////////////////////////////////////////////////////////
// Operations.

/*
 * Reset to default layout.
 */
function layout() {
  var count = S.screenCount();
  if (count <= 3) {
    S.op('layout', {name: count + '-monitor'}).run();
  }
}

var ntogs = (function() {
  var i = 0;
  return function() { return i++; };
})();

/*
 * Swap big monitors when there are two.
 */
function toggle() {
  if (S.screenCount() != 3) { return; }

  if (ntogs() % 2 == 0) {
    S.op('layout', {name: '3-monitor-alt'}).run();
  } else {
    S.op('layout', {name: '3-monitor'}).run();
  }
}

/*
 * Context-aware push.
 */
function pushy(dir) {
  return function() {
    if (dir != 'left' && dir != 'right') { return; }

    const scr = S.screen().rect();
    const win = S.window().rect();

    const pushed =
      (dir === 'left'  && scr.x === win.x) ||
      (dir === 'right' && scr.x !== win.x);

    // dumb logic that lets us cycle 1/2 -> 1/3 -> 2/3 -> 1/2
    const ratio = Math.round(scr.width / (win.width + 1));
    const div = pushed ? (ratio % 3) + 1 : 2;

    S.op('push', {
      screen: S.screen(),
      direction: dir,
      style: "bar-resize:screenSizeX/" + (div > 1 ? div : '3*2'),
    }).run();
  };
}


///////////////////////////////////////////////////////////////////////////////
// Defaults and bindings.

S.def([mbp15.screen], '1-monitor');
S.def([mbp15.screen, dell30.screen], '2-monitor');
S.def([mbp15.screen, dell30.screen, dell30.screen], '3-monitor');

S.def([mbp19.screen], '1-monitor');
S.def([mbp19.screen, dell30.screen], '2-monitor');
S.def([mbp19.screen, dell30.screen, dell30.screen], '3-monitor');

S.bindAll({
  'space:ctrl':       layout,
  'space:ctrl,shift': toggle,
  'return:ctrl':      S.op('relaunch'),

  'left:ctrl,shift,alt':  pushy('left'),
  'right:ctrl,shift,alt': pushy('right'),
  'down:ctrl,shift,alt':    S.op('move', {
    x: 'screenOriginX',
    y: 'screenOriginY',
    width: 'screenSizeX',
    height: 'screenSizeY',
  }),
});
