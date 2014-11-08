$(function () {   
    if (!String.prototype.format) {
      String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) { 
          return typeof args[number] != 'undefined'
            ? args[number]
            : match
          ;
        });
      };
    }
  
    function getQueryResults(state) {
        var query = new ASNAHelpers.QueryInputArgs()
        query.url = "../services/jsonservice.ashx";
        query.Library = "examples";
        query.File = "cmastnewl2";
        query.FieldsList = "CMCUSTNO, CMNAME, CMADDR1, CMCITY, CMSTATE";
        query.Rows = -1;
        query.Query = "CMSTATE = '{CMSTATE}'";
        query.addQueryParm("CMSTATE",state);
        query.addOrderBy("CMCITY",0);     

        return query;
   }

   var doneCallBack = function(json) {
        // This link helped!
        // http://www.sitepoint.com/working-jquery-datatables/

        $("#json-data-table").DataTable( {            
            aaData: json.list,
            aoColumns: [
                { sWidth: "3%", mData: "CMCUSTNO", stitle: "Number"},
                { sWidth: "40%", mData: "CMNAME" , stitle: "Name"},
                { sWidth: "40%", mData: "CMADDR1" , stitle: "Address"},
                { sWidth: "14%", mData: "CMCITY" , stitle: "City"},
                { sWidth: "3%", mData: "CMSTATE", stitle: "State"}
            ],
            aaSorting: [[3,'asc']],
            bDestroy: true
        });

        var mask = "<span>Returned {0} records. Fetched in {1} milliseconds.</span>";
        $("#query-metrics").html(mask.format(json.rowCountPhrase, json.milliseconds));        
        $("#grid-container").show();
    };

    var alwaysCallBack = function() {
        $("#json-loading").hide();    
    }
       
    $("#grid-container").hide();
    
    $("#json-data-table")
        .removeClass( 'display' )
		.addClass('table table-striped table-bordered');

    $("#stateList").on('change',function() {
        console.log('change event');
        var state = $(this).val(); 
        var query = getQueryResults(state);
        $("#json-loading").show();
        ASNAHelpers.ajax.postJson(query.url,query.getJson(),doneCallBack,alwaysCallBack);    
    });
    
    $("#stateList").change();
});