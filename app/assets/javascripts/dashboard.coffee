$(document).on "turbolinks:load",  ->
  
  #set todays date
  $('#date-field').html(moment().format('Do MMMM YYYY')); 
  
  #show callendar upon click on date
  $('#date-field').pikaday({ 
    field: document.getElementById('datepicker'),
    firstDay: 1,
    minDate: new Date(2000, 0, 1),
    maxDate: new Date(2020, 12, 31),
    yearRange: [2000,2020],
    onSelect: ->
      $('#date-field').html(this.getMoment().format('Do MMMM YYYY'));
    });
  
  #move one day before or after the displayed date.
  $('.date-container').on('click', '#date-left', ((event) ->
    event.preventDefault()
    dateField = $('#date-field')
    displayedDate = dateField.text()
    dateField.html(moment(displayedDate, "Do MMMM YYYY").subtract(1, 'd').format('Do MMMM YYYY'))
    ));
  $('#date-right').click (event)->
    event.preventDefault();
    dateField = $('#date-field')
    displayedDate = dateField.text()
    dateField.html(moment(displayedDate, "Do MMMM YYYY").add(1, 'd').format('Do MMMM YYYY'))  
