$(document).on "turbolinks:load",  ->
  
  # set todays date
  $('#date-field').html(moment().format('Do MMMM YYYY'));
  
  # calendar
  $('#date-field').pikaday({ 
    field: document.getElementById('datepicker'),
    firstDay: 1,
    minDate: new Date(2000, 0, 1),
    maxDate: new Date(2020, 12, 31),
    yearRange: [2000,2020],
    onSelect: ->
      selectedDate = this.getMoment()
      $('#date-field').html(selectedDate.format('Do MMMM YYYY'));
      setGridDays(selectedDate);
    });
  
  # move one day before or after the displayed date.
  $('.date-container').on('click', '#date-left', ((event) ->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").subtract(1, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
    ));

  $('#date-right').click (event)->
    event.preventDefault();
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").add(1, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
    
  # move 7 days before or after the displayed date.
  $('.date-container').on('click', '#double-date-left', ((event) ->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").subtract(7, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
    ));

  $('#double-date-right').click (event)->
    event.preventDefault();
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").add(7, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
  
  
  # refresh current view  
  $('.refresh-button').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=day");
  
  # view navigation  
  $('#day-view').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=day")
    $("li.active").attr("class", "")
    $('#day-view').parent().attr("class", "active")
    showArrows()
    
  $('#week-view').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=week")
    $("li.active").attr("class", "")
    $('#week-view').parent().attr("class", "active")
    showArrows("week")
    
  $('#month-view').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=month")
    $("li.active").attr("class", "")
    $('#month-view').parent().attr("class", "active")
    showArrows("month")