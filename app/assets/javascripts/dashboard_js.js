  // set week days when select week view on dashboard. called from week_dashboard_container partial, setGridDays
  function setWeekDays(defaultday = moment()) {
    var weekDays = document.getElementsByClassName("week-day");
    weekDays[0].innerHTML = defaultday.subtract(1, 'd').format('Do');
    for (i = 1; i < 7; i++) { 
      weekDays[i].innerHTML = defaultday.add(1,'d').format('Do');
    };
  };
  
  // set week days when select week view on dashboard. called from month_dashboard_container partial, serGridDays
  function setMonthDays(defaultday = moment()) {
    var monthDays = document.getElementsByClassName("month-day");
    defaultday.subtract(7, 'd');
    for (i = 0; i < 31; i++) { 
      monthDays[i].innerHTML =defaultday.add(1,'d').format('D');
    };
  };
  
  // called from queries on date select and on date navigations
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
  
  // default grid has 30days, this functions ads 31st day. called from month_dashboard_container partial 
  function addLastDay(defaultday = moment()) {
    if (defaultday.daysInMonth() == 31) {
      $('.last-day').css("display", "inline");
    };
  };
  
  // weird functions to show or hide date navigation arrows for different views
  function showArrows(show = "day") {
    if (show == "day") {
      $("#double-date-right, #double-date-left").css("visibility", "hidden");
      $("#date-right, #date-left").css("visibility", "visible");      
    } else if (show == "week") {
      $("#double-date-right, #double-date-left").css("visibility", "visible");
      $("#date-right, #date-left").css("visibility", "visible");
    } else {
      $("#date-right, #date-left").css("visibility", "hidden");
      $("#double-date-right, #double-date-left").css("visibility", "visible");
    }
  }
  