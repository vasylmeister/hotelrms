$(document).on "turbolinks:load",  ->
  

  # set content on page load
  
  # -set todays date in main date-field
  $('#date-field').html(moment().format('Do MMMM YYYY'));
  
  # -set 3 years in dropdown
  $("#yv-last-year").html(moment().subtract(1,"years").format('YYYY'))
  $("#yv-current-year").html(moment().format('YYYY'))
  $("#yv-next-year").html(moment().add(1,"years").format('YYYY'))
  
  # dashboard menu events
  # -invoke calendar upon click on date-field
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
  
  # -toggle dropdown and hide on click
  $(".year-dropdown-toggle").click ->
    $(".year-dropdown-menu").toggle()
    $(".active").attr("class", "")
    $('#year-view').parent().attr("class", "active")
  $(document).click ->
    $(".year-dropdown-menu").hide()
 
  # -navigation arrows events
  # --move one day before or after the displayed date.
  $('.date-container').on('click', '#date-left', ((event) ->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").subtract(1, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
    ));

  $('#date-right').click (event)->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").add(1, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
    
  # --move 7 days before or after the displayed date.
  $('.date-container').on('click', '#double-date-left', ((event) ->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").subtract(7, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
    ))

  $('#double-date-right').click (event)->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    newDate = moment(displayedDate, "Do MMMM YYYY").add(7, 'd')
    dateField.html(newDate.format('Do MMMM YYYY'))
    setGridDays(newDate)
  
  # --move 1 year before or after the displayed year
  $('#double-year-left').click (event) ->
    event.preventDefault()
    yearField = $('#year-field')
    displayedYear = yearField.text()
    newYear = moment().set('year', (parseInt(displayedYear) - 1))
    yearField.html(newYear.format('YYYY'))
    $("#dashboard-container").load("/reload_container?view=year&year=#{newYear.format("YYYY")}")
  
  $('#double-year-right').click (event) ->
    event.preventDefault()
    yearField = $('#year-field')
    displayedYear = yearField.text()
    newYear = moment().set('year', (parseInt(displayedYear) + 1))
    yearField.html(newYear.format('YYYY'))
    $("#dashboard-container").load("/reload_container?view=year&year=#{newYear.format("YYYY")}")
  

  # -load selected view  
  # --load DAY view
  $('#day-view').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=day")
    $(".active").attr("class", "")
    $('#day-view').parent().attr("class", "active")
    showArrows()

  
  # --load WEEK view  
  $('#week-view').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=week")
    $(".active").attr("class", "")
    $('#week-view').parent().attr("class", "active")
    showArrows("week")

  
  # --load MONTH view  
  $('#month-view').click (event)->
    event.preventDefault()
    $("#dashboard-container").load("/reload_container?view=month")
    $(".active").attr("class", "")
    $('#month-view').parent().attr("class", "active")
    showArrows("month")

  # --load YEAR view  
  # ---make year active in view navigation menu  
  $('#year-view').click (event)->
    event.preventDefault()
    $(".active").attr("class", "")
    $('#year-view').parent().attr("class", "active")

  # ---load view for a selected year
  $(".yv-year-select").click (event)->
    event.preventDefault()
    selectedYear = moment(this.text, "YYYY")
    showArrows("year")
    $('#year-field').html(selectedYear.format("YYYY"));
    $("#dashboard-container").load("/reload_container?view=year&year=#{selectedYear.format("YYYY")}")
    
  # -refresh current view ADD animation while loading the page and a quick confirmation that container was reloaded
  $('.refresh-button').click (event)->
    event.preventDefault()
    view = /^\w*/.exec $("li.active").children().attr("id")
    year = if view == "year" then $('#year-field').text() else ""
    $("#dashboard-container").load("/reload_container?view=#{view}&year=#{year}")



# my own functions
jQuery.fn.showV = ->
  this.css('visibility', 'visible')

jQuery.fn.hideV = ->
  this.css('visibility', 'hidden')

  