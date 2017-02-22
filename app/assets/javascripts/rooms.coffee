

$(document).on "turbolinks:load",  ->

  $(".container").on('change', '#room_beds', ((event) ->
    setBedTypeFields()
  ));
    
  # this fuctions are called when user changes the number of beds
  setBedTypeFields = () ->
    bedcount = $("#room_beds").val()
    bed_type_fields = $(".bed-type-field-container select")
    fields_to_add = bedcount-bed_type_fields.length
    if fields_to_add > 0
      addBedTypeField() for [1..fields_to_add]
    else
      removeBedTypeField() for [fields_to_add..-1] unless fields_to_add == 0
      
    
  addBedTypeField = () ->
    selectContainer = $(".bed-type-select-container")
    count = $(".bed-type-select-container select").size()
    selectContainer.append($(".bed-type-field-container").first().clone())
    selectFields = $(".bed-type-field-container select")
    if $(".page-header h1").text() == "Create new room"
      selectFields.last().attr({ id: "room_bed_types_attributes_#{count}_id", name: "room[bed_types_attributes][#{count}][id]"})
    else
      selectFields.last().attr({ id: "room_room_bed_types_attributes_#{count}_bed_type_id", name: "room[room_bed_types_attributes][#{count}][bed_type_id]"})
  
  removeBedTypeField = () ->
    if $(".page-header h1").text() == "Create new room"
      $(".bed-type-field-container").last().remove() 
    else
      selectBox = $(".bed-type-select-container select:visible")
      selectBox.last().remove()
      $("input[type=checkbox]:visible").last().hide()
      count = $(".bed-type-select-container select").size()
      $("input[name='room[room_bed_types_attributes][#{count}][_destroy]']").val(1)
  
  # old funtions for add and remove buttons    
  # $(".container").on('click', '#delete-field-new', ((event) ->
  #   $(".bed-type-select-container").children().last().remove()
  # ));
  
  # $(".container").on('click', '#add-field-new', ((event) ->

  # ));
  
  
  # $(".container").on('click', '#delete-field-edit', ((event) ->
  #   selectBox = $(".bed-type-select-container select")
  #   selectBox.last().hide()
  #   count = selectBox.size()-1
  #   $("input[name='room[room_bed_types_attributes][#{count}][_destroy]']").val(1)
  #   # $("input:hidden").last().val(3)
  # ));
  
  # #add create new select box if none exists
  
  # $(".container").on('click', '#add-field-edit', ((event) ->
  #   selectBox = $(".bed-type-select-container select")
  #   count = selectBox.size()
  #   $(".bed-type-select-container").append($(".bed-type-field-container").last().clone())
  #   $(".bed-type-select-container select").last().attr({ id: "room_room_bed_types_attributes_#{count}_bed_type_id", name: "room[room_bed_types_attributes][#{count}][bed_type_id]"})
  # ));