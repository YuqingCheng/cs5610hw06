// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

function update_buttons() {
  $('.timeblock-button').each( (_, bb) => {
    let started = $(bb).data('started');
    if (started) {
      $(bb).text("Stop Working");
    } else {
      $(bb).text("Start Working");
    }
  });
}

function set_button(assignment_id, value) {
  $('.timeblock-button').each( (_, bb) => {
    if (assignment_id == $(bb).data('assignment-id')) {
      $(bb).data('started', value);
    }
  });
  update_buttons();
}

function start_task(assignment_id) {
  let text = JSON.stringify({
    action: {
      assignment_id: assignment_id,
      flag: 'start',
    }
  });

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(assignment_id, resp.data); },
  });
}

function stop_task(assignment_id) {
  let text = JSON.stringify({
    action: {
      assignment_id: assignment_id,
      flag: 'stop',
    }
  });
  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: () => { 
      set_button(assignment_id, null);
    },
  });
}

function button_click(e) {
  let btn = $(e.target);
  let started = btn.data('started');
  let assignment_id = btn.data('assignment-id');

  if (started) {
    stop_task(assignment_id);
    location.reload();
  } else {
    start_task(assignment_id);
  }
}

function init_timeblock() {
  if(!$('.timeblock-button')) {
    return;
  }
  $('.timeblock-button').click(button_click);
  update_buttons();
}

$(init_timeblock);

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
