

$(document).on "turbolinks:load",  ->
  $(".container").on('click', '#delete-field-new', ((event) ->
    $(".bed-type-select-container").children().last().remove()
  ));
  
  $(".container").on('click', '#add-field-new', ((event) ->
    selectBox = $(".bed-type-select-container")
    count = selectBox.children().size()
    selectBox.children().last().clone().appendTo(selectBox)
    selectBox.children().last().attr({ id: "room_bed_types_attributes_#{count}_id", name: "room[bed_types_attributes][#{count}][id]"})
  ));
  
  
  $(".container").on('click', '#delete-field-edit', ((event) ->
    selectBox = $(".bed-type-select-container select")
    selectBox.last().hide()
    count = selectBox.size()-1
    $("input[name='room[room_bed_types_attributes][2][_destroy]']").val(1)
    # $("input:hidden").last().val(3)
  ));
  
  #add create new select box if none exists
  $(".container").on('click', '#add-field-edit', ((event) ->
    selectBox = $(".bed-type-select-container select")
    count = selectBox.size()
    $(".bed-type-select-container").append(selectBox.last().clone())
    $(".bed-type-select-container select").last().attr({ id: "room_room_bed_types_attributes_#{count}_bed_type_id", name: "room[room_bed_types_attributes][#{count}][bed_type_id]"})
  ));