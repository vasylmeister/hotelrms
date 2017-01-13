  // sets week days when select week view on dashboard. called from week_dashboard_container partial, setGridDays
  function setWeekDays(defaultday = moment()) {
    var weekDays = document.getElementsByClassName("week-day");
    weekDays[0].innerHTML = defaultday.subtract(1, 'd').format('Do');
    for (i = 1; i < 7; i++) { 
      weekDays[i].innerHTML = defaultday.add(1,'d').format('Do');
    };
  };
  
  // sets month days when select month view on dashboard. called from month_dashboard_container partial, serGridDays
  function setMonthDays(defaultday = moment()) {
    var monthDays = document.getElementsByClassName("month-day");
    defaultday.subtract(7, 'd');
    for (i = 0; i < 31; i++) { 
      monthDays[i].innerHTML =defaultday.add(1,'d').format('D');
    };
  };
  
  // sets year days when select year view on dashboard. called from year_dashboard_container partial, serGridDays
  function setYearDays(defaultday = moment()) {
    var startDate = defaultday.startOf('year')
    var yearDays = document.getElementsByClassName("year-day");
    yearDays[0].innerHTML = startDate.format('D')
    for (i = 1; i < yearDays.length; i++) { 
      yearDays[i].innerHTML = startDate.add(1,'d').format('D');
    };
  };
  
  // sets week or month days, called from queries on date select and on date navigations
  function setGridDays (date) {
    if ($("#week-container").length) {
      setWeekDays(date)
    } 
    else {
      try {
        setMonthDays(date);
      } catch(err){
        return
      }
    }
  }
  
  // default months grid has 30days, this functions adds 31st day. called from month_dashboard_container partial 
  function addLastDay(defaultday = moment()) {
    if (defaultday.daysInMonth() == 31) {
      $('.last-day').css("display", "inline");
    };
  };
  
  // weird functions to show or hide date navigation arrows for different views + show date-field and hide year-field. Using created functions hideV and showV for visibility settings
  function showArrows(show = "day") {
    if (show == "year") {
      $('#date-field, .date-arrows').hide();
      $('#year-field, .year-arrows').show();
    } else {
      $('#date-field, .date-arrows').show();
      $('#year-field, .year-arrows').hide();
      if (show == "day") {
        $("#double-date-right, #double-date-left").hideV();
        $("#date-right, #date-left").showV();      
      } else if (show == "week") {
        $("#double-date-right, #double-date-left, #date-right, #date-left").showV();
      } else {
        $("#date-right, #date-left").hideV();
        $("#double-date-right, #double-date-left").showV();
      }
    }
  }


  