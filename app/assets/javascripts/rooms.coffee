

$(document).on "turbolinks:load",  ->
  $(".container").on('click', '#delete-field', ((event) ->
    selectBox = $(".bed-type-select-container").children().last().remove()
  ));
  
  $(".container").on('click', '#add-field', ((event) ->
    selectBox = $(".bed-type-select-container")
    count = selectBox.children().size()
    selectBox.children().last().clone().appendTo(selectBox)
    selectBox.children().last().attr({ id: "room_bed_types_attributes_#{count}_id", name: "room[bed_types_attributes][#{count}][id]"})
  ));