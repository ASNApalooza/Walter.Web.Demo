$(function () {
    var sortBy = $("#labelSortBy").html();
    var textboxPosition = $("#textboxPosition");
    if (sortBy === "By number") {
        textboxPosition.attr("type", "number");
        textboxPosition.attr("placeholder", "Customer number");
    }
    else  {
        textboxPosition.attr("placeholder", "Customer name");
    }
});
