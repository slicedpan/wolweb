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

  function updateMachine(id, serviceStatuses) {
    var machineElement = $(`.machine-container[machine-id=${id}]`);
    var wakeupButtonDisabled = false;
    for (const [service, up] of Object.entries(serviceStatuses)) {
      if (up) {
        wakeupButtonDisabled = true;
        machineElement.find(`.service-${service}`).addClass("service-up").removeClass("service-down");
      } else {
        machineElement.find(`.service-${service}`).addClass("service-down").removeClass("service-up")
      }
    }
    machineElement.find(".wakeup-button").prop("disabled", wakeupButtonDisabled);
  }

  window.setInterval(function() {
    $.ajax("/machines").done(function(response) { 
      response.machines.forEach(machine => {
        updateMachine(machine.id, machine.service_statuses)
      });  
    }).fail(function() {
      console.error("Request to /machines failed!");
    })
  }, 10000)
});