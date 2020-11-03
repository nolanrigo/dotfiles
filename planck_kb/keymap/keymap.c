#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_ortho_4x12(
        KC_ESC,  KC_Q,  KC_W,  KC_E,  KC_R,    KC_T,  KC_Y,  KC_U,   KC_I,    KC_O,   KC_P,    KC_BSPC,
        KC_TAB,  KC_A,  KC_S,  KC_D,  KC_F,    KC_G,  KC_H,  KC_J,   KC_K,    KC_L,   KC_QUOT, KC_ENT,
        KC_LSFT, KC_Z,  KC_X,  KC_C,  KC_V,    KC_B,  KC_N,  KC_M,   KC_COMM, KC_DOT, KC_SLSH, KC_RSFT,
        KC_LCTL, KC_NO, KC_NO, MO(3), KC_LALT, MO(2), MO(1), KC_SPC, KC_COLN, KC_NO,  KC_NO,   KC_F13
    ),
    [1] = LAYOUT_ortho_4x12(
        KC_TRNS, KC_EXLM, KC_AT,   KC_HASH, KC_AMPR, KC_NO,   KC_NO,   KC_GRV,  KC_CIRC, KC_DLR,  KC_QUES, KC_TRNS,
        KC_TRNS, KC_BSLS, KC_PIPE, KC_LCBR, KC_RCBR, KC_EQL,  KC_PERC, KC_LPRN, KC_RPRN, KC_SCLN, KC_DQUO, KC_TRNS,
        KC_NO,   KC_TILD, KC_ASTR, KC_UNDS, KC_MINS, KC_PLUS, KC_NO,   KC_LBRC, KC_RBRC, KC_LT,   KC_GT,   KC_NO,
        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_TRNS, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO
    ),
    [2] = LAYOUT_ortho_4x12(
        KC_TRNS, KC_MUTE, KC_MPLY, KC_VOLD, KC_VOLU, KC_NO,   KC_NO, KC_7, KC_8,   KC_9,   KC_ASTR, KC_TRNS,
        KC_TRNS, KC_NO,   KC_LEFT, KC_UP,   KC_DOWN, KC_RGHT, KC_NO, KC_4, KC_5,   KC_6,   KC_SLSH, KC_TRNS,
        KC_NO,   KC_BRID, KC_BRIU, KC_MPRV, KC_MNXT, KC_NO,   KC_NO, KC_1, KC_2,   KC_3,   KC_PLUS, KC_NO,
        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_TRNS, KC_NO,   KC_NO, KC_0, KC_DOT, KC_EQL, KC_MINS, KC_NO
    ),
    [3] = LAYOUT_ortho_4x12(
        KC_TRNS, KC_P2, KC_P1, KC_P0,   KC_NO, KC_NO, KC_NO, KC_P6, KC_P8, KC_PEQL, KC_NO, KC_TRNS,
        KC_TRNS, KC_P4, KC_P5, KC_NO,   KC_NO, KC_NO, KC_NO, KC_P7, KC_P9, KC_NO,   KC_NO, KC_TRNS,
        KC_NO,   KC_NO, KC_NO, KC_P3,   KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO, KC_NO,
        KC_NO,   KC_NO, KC_NO, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO, KC_NO
    )
};

