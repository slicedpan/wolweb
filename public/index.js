$(document).ready(function() {
  $(".machine-container").each(function(index, element) {
    var id = Number($(element).attr("machine-id"));
    $(element).find(".wakeup-button").click(function(event) {
      $.ajax(`/machines/${id}/wakeup`, {
        method: "POST"
      }).done(function() {
        console.log("request succeeded");
      }).fail(function() {
        console.log("request failed");
      })
    })
  });
});