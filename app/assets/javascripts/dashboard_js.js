  // set week days when select week view on dashboard. called from week_dashboard_container partial
  function setWeekDays(defaultday = moment()) {
    var weekDays = document.getElementsByClassName("week-day");
    weekDays[0].innerHTML = defaultday.subtract(1, 'd').format('Do');
    for (i = 1; i < 7; i++) { 
      weekDays[i].innerHTML = defaultday.add(1,'d').format('Do');
    };
  };
  
  function setMonthDays(defaultday = moment()) {
    var monthDays = document.getElementsByClassName("month-day");
    defaultday.subtract(7, 'd');
    for (i = 0; i < 31; i++) { 
      monthDays[i].innerHTML =defaultday.add(1,'d').format('D');
    };
  };
  
  function addLastDay(defaultday = moment()) {
    if (defaultday.daysInMonth() == 31) {
      $('.last-day').css("display", "inline");
    };
  };
  
  function visibleArrows(show = "day") {
    if (show == "week") {
      $("#double-date-right, #double-date-left").css("visibility", "visible");
      $("#date-right, #date-left").css("visibility", "visible");
    } else if (show == "month") {
      $("#date-right, #date-left").css("visibility", "hidden");
      $("#double-date-right, #double-date-left").css("visibility", "visible");
    } else {
      $("#double-date-right, #double-date-left").css("visibility", "hidden");
      $("#date-right, #date-left").css("visibility", "visible");
    }
  }
  
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
  