$(function () {
    
    function getQueryResults(state) {
        var query = new ASNAHelpers.QueryInputArgs();
        query.url = "../services/jsonservice.ashx";
        query.Library = "examples";
        query.File = "cmastnewl2";
        query.FieldsList = "CMCUSTNO, CMNAME, CMADDR1, CMCITY, CMSTATE";
        query.Rows = 400;
        //query.Query = "CMSTATE = '{CMSTATE}'";
        query.Query = "CMNAME >= '{CMNAME}'";
        query.addQueryParm("CMNAME",state);
        query.addOrderBy("CMCITY",0);     

        return query;
   }

   var query = getQueryResults("S");
    
    $("#grid-container").hide();
    
    $("#json-data-table")
        .removeClass( 'display' )
		.addClass('table table-striped table-bordered');
    
    function doneCallBack(json) {
        // This link helped!
        // http://www.sitepoint.com/working-jquery-datatables/

        $("#json-data-table").DataTable( {            
            aaData: json.list,
            aoColumns: [
                { sWidth: "5%", mData: "CMCUSTNO", stitle: "Number"},
                { sWidth: "35%", mData: "CMNAME" , stitle: "Name"},
                { sWidth: "35%", mData: "CMADDR1" , stitle: "Address"},
                { sWidth: "20%", mData: "CMCITY" , stitle: "City"},
                { sWidth: "5%", mData: "CMSTATE", stitle: "State"}
            ]
        });

        $("#json-data-table_length").after("<span> &nbsp;&nbsp;&nbsp;Showing " + json.rowCountPhrase + " records.</span>");
        
        $("#json-loading").hide();
        $("#grid-container").show();

    }

    function alwaysCallBack() {
        $("#json-loading").hide();    
    }

    ASNAHelpers.ajax.postJson(query.url, query.getJson(), doneCallBack,alwaysCallBack);     

});