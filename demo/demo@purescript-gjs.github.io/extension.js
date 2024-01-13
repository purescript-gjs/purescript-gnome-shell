// output/Data.Unit/foreign.js
var unit = void 0;

// output/Control.Apply/index.js
var apply = function(dict) {
  return dict.apply;
};

// output/Control.Applicative/index.js
var pure = function(dict) {
  return dict.pure;
};
var liftA1 = function(dictApplicative) {
  var apply2 = apply(dictApplicative.Apply0());
  var pure1 = pure(dictApplicative);
  return function(f) {
    return function(a) {
      return apply2(pure1(f))(a);
    };
  };
};

// output/Effect/foreign.js
var pureE = function(a) {
  return function() {
    return a;
  };
};
var bindE = function(a) {
  return function(f) {
    return function() {
      return f(a())();
    };
  };
};

// output/Control.Bind/index.js
var bind = function(dict) {
  return dict.bind;
};

// output/Control.Monad/index.js
var ap = function(dictMonad) {
  var bind2 = bind(dictMonad.Bind1());
  var pure3 = pure(dictMonad.Applicative0());
  return function(f) {
    return function(a) {
      return bind2(f)(function(f$prime) {
        return bind2(a)(function(a$prime) {
          return pure3(f$prime(a$prime));
        });
      });
    };
  };
};

// output/Effect/index.js
var $runtime_lazy = function(name, moduleName, init) {
  var state = 0;
  var val;
  return function(lineNumber) {
    if (state === 2)
      return val;
    if (state === 1)
      throw new ReferenceError(name + " was needed before it finished initializing (module " + moduleName + ", line " + lineNumber + ")", moduleName, lineNumber);
    state = 1;
    val = init();
    state = 2;
    return val;
  };
};
var monadEffect = {
  Applicative0: function() {
    return applicativeEffect;
  },
  Bind1: function() {
    return bindEffect;
  }
};
var bindEffect = {
  bind: bindE,
  Apply0: function() {
    return $lazy_applyEffect(0);
  }
};
var applicativeEffect = {
  pure: pureE,
  Apply0: function() {
    return $lazy_applyEffect(0);
  }
};
var $lazy_functorEffect = /* @__PURE__ */ $runtime_lazy("functorEffect", "Effect", function() {
  return {
    map: liftA1(applicativeEffect)
  };
});
var $lazy_applyEffect = /* @__PURE__ */ $runtime_lazy("applyEffect", "Effect", function() {
  return {
    apply: ap(monadEffect),
    Functor0: function() {
      return $lazy_functorEffect(0);
    }
  };
});

// output/GJS/foreign.js
var argv = ARGV;
var log = (msg) => () => console.log(msg);

// output/Data.Bounded/foreign.js
var topChar = String.fromCharCode(65535);
var bottomChar = String.fromCharCode(0);
var topNumber = Number.POSITIVE_INFINITY;
var bottomNumber = Number.NEGATIVE_INFINITY;

// output/Demo/index.js
var pure2 = /* @__PURE__ */ pure(applicativeEffect);
var main = /* @__PURE__ */ pure2(unit);
var extension = /* @__PURE__ */ function() {
  var extension_init = function(v) {
    return function __do() {
      log("init called")();
      return unit;
    };
  };
  var extension_enable = function(_settings) {
    return function __do() {
      log("enable called")();
      return unit;
    };
  };
  var extension_disable = function(_env) {
    return function __do() {
      log("disable called")();
      return unit;
    };
  };
  return {
    extension_init,
    extension_enable,
    extension_disable
  };
}();

// necessary footer to transform a spago build into a valid gnome extension
let DemoEnv = null;
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
let DemoSettings = null;
export default class Demo extends Extension {
  constructor(metadata) {
    super(metadata);
    DemoSettings = extension.extension_init(metadata)();
  }
  enable() { DemoEnv = extension.extension_enable(DemoSettings)(); }
  disable() { extension.extension_disable(DemoEnv)(); }
}
