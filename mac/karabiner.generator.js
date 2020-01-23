const fs = require('fs');

const LEVEL_3_MODIFIER_KEYS = ['close_bracket', 'tab'];

function parseKeybindings(file) {
  return file.toString().split('\n').map(line => line.split(' '))
}

const level1 = fs.readFileSync('./level1');
const level1KeyTuples = parseKeybindings(level1);
const level3 = fs.readFileSync('./level3');
const level3KeyTuples = parseKeybindings(level3);
const level4 = fs.readFileSync('./level4');
const level4KeyTuples = parseKeybindings(level4);

const simple_modifications = level1KeyTuples.map(([from, to]) => {
  return {
    "from": {
      "key_code": from,
    },
    "to": {
      "key_code": to,
    }
  };
});

const LEVEL_3_MODIFIER_NAME = 'virtual_mod_0';
const virtualModManipulators = LEVEL_3_MODIFIER_KEYS.map(key => {
  return {
    "type": "basic",
    "from": {
      "key_code": key,
      "modifiers": {
        "mandatory": [],
        "optional": [
          "any"
        ]
      }
    },
    "to": [
      {
        "set_variable": {
          "name": LEVEL_3_MODIFIER_NAME,
          "value": 1
        }
      }
    ],
    "to_after_key_up": [
      {
        "set_variable": {
          "name": LEVEL_3_MODIFIER_NAME,
          "value": 0
        }
      }
    ]
  };
});

const virtualModRule = {
  description: "Virtual Modifier on Close Bracket",
  manipulators: virtualModManipulators,
};

function keyTuplesToMani(keyTuples, level4Flag) {
  return keyTuples.map(([from, to, shift]) => {
    const mani = {
      "type": "basic",
      "from": {
        "key_code": from,
      },
      "to": [
        {
          "key_code": to
        }
      ],
      "conditions": [
        {
          "type": "variable_if",
          "name": LEVEL_3_MODIFIER_NAME,
          "value": 1
        }
      ]
    };

    if (level4Flag) {
      mani.from.modifiers = {
        "mandatory": [
          'left_shift'
        ],
        "optional": [
          "any"
        ]
      };
    }

    if (shift === 'shift') {
      mani.to[0].modifiers = ['left_shift'];
    }
    return mani;
  });
}

// We could map right shift to be a duplicate left shift, and then map stuff onto right shift so there's no conflict.
const level3Rules = {
  description: "Level 3 keybindings",
  manipulators: keyTuplesToMani(level3KeyTuples)
};

const level4Rules = {
  description: "Level 4 keybindings",
  manipulators: keyTuplesToMani(level4KeyTuples, true)
};

const complex_modifications = {
  "parameters": {
    "basic.simultaneous_threshold_milliseconds": 50,
    "basic.to_delayed_action_delay_milliseconds": 500,
    "basic.to_if_alone_timeout_milliseconds": 1000,
    "basic.to_if_held_down_threshold_milliseconds": 500,
    "mouse_motion_to_scroll.speed": 100
  },
  "rules": [
    virtualModRule, level3Rules, level4Rules
  ]
};

const guomakProfile = {
  name: "Guomak",
  simple_modifications,
  complex_modifications,
  devices: [],
  "fn_function_keys": [
    {
      "from": {
        "key_code": "f1"
      },
      "to": {
        "consumer_key_code": "display_brightness_decrement"
      }
    },
    {
      "from": {
        "key_code": "f2"
      },
      "to": {
        "consumer_key_code": "display_brightness_increment"
      }
    },
    {
      "from": {
        "key_code": "f3"
      },
      "to": {
        "key_code": "mission_control"
      }
    },
    {
      "from": {
        "key_code": "f4"
      },
      "to": {
        "key_code": "launchpad"
      }
    },
    {
      "from": {
        "key_code": "f5"
      },
      "to": {
        "key_code": "illumination_decrement"
      }
    },
    {
      "from": {
        "key_code": "f6"
      },
      "to": {
        "key_code": "illumination_increment"
      }
    },
    {
      "from": {
        "key_code": "f7"
      },
      "to": {
        "consumer_key_code": "rewind"
      }
    },
    {
      "from": {
        "key_code": "f8"
      },
      "to": {
        "consumer_key_code": "play_or_pause"
      }
    },
    {
      "from": {
        "key_code": "f9"
      },
      "to": {
        "consumer_key_code": "fastforward"
      }
    },
    {
      "from": {
        "key_code": "f10"
      },
      "to": {
        "consumer_key_code": "mute"
      }
    },
    {
      "from": {
        "key_code": "f11"
      },
      "to": {
        "consumer_key_code": "volume_decrement"
      }
    },
    {
      "from": {
        "key_code": "f12"
      },
      "to": {
        "consumer_key_code": "volume_increment"
      }
    }
  ],
  parameters: {
    "delay_milliseconds_before_open_device": 1000
  },
  selected: true,
  virtual_hid_keyboard: {
    "country_code": 0,
    "mouse_key_xy_scale": 100
  }
};

// add misc constants
const cfg = {
  "global": {
    "check_for_updates_on_startup": true,
    "show_in_menu_bar": true,
    "show_profile_name_in_menu_bar": false
  },
  "profiles": [guomakProfile]
};

// export JSON
fs.writeFileSync('./karabiner.json', JSON.stringify(cfg));
