﻿$(function () {   

    function getQueryResults(state) {
        var query = new ASNAHelpers.QueryInputArgs()
        query.url = "../services/jsonservice.ashx";
        query.Library = "examples";
        query.File = "cmastnewl2";
        query.FieldsList = "CMCUSTNO:Number, CMNAME:Name, CMADDR1:Address, CMCITY:City, CMSTATE:State";
        query.Rows = -1;
        query.Query = "CMSTATE = '{CMSTATE}'";
        query.addQueryParm("CMSTATE",state);
        query.addOrderBy("CMCITY",0);     

        return query;
    }
               
    $("#stateList").on('change',function() {
        $("#json-loading").show();

        var state = $(this).val(); 
        var query = getQueryResults(state);

        var jsonReadyToRender = function(json) {
            // Some good tips for working with the jquery datatables plugin.
            // http://www.sitepoint.com/working-jquery-datatables/

            // Use sTitle property to explicitly set the column heading.
            // Use aliases in the FieldsList you can assign them 
            $("#json-data-table").DataTable( {            
                aaData: json.list,
                aoColumns: [
                    { sWidth: "3%", mData: "Number"},
                    { sWidth: "40%", mData: "Name" },
                    { sWidth: "40%", mData: "Address"},
                    { sWidth: "14%", mData: "City"},
                    { sWidth: "3%", mData: "State"}
                ],
                aaSorting: [[3,'asc']],
                bDestroy: true
            });

            var mask = "<span>Returned {0} records. Fetched in {1} milliseconds.</span>";
            $("#query-metrics").html(mask.format(json.rowCountPhrase, json.milliseconds));        

            $("#json-data-table").addClass('table table-striped table-bordered');    
            $("#grid-container").removeClass("hide");
        };

        var jsonCallComplete = function() {
            $("#json-loading").hide();    
        };

        ASNAHelpers.ajax.postJson(query.url,query.getJson(),jsonReadyToRender,jsonCallComplete);
    });
});