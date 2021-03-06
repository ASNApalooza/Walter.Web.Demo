﻿$(function () {   
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

    function populateSelectTag(query) {
        query.url = "../services/jsonservice.ashx";
        query.cacheList = query.cacheList || true;
        query.raiseChangeEvent = query.raiseChangeEvent || false;

        var options = $("#" + query.targetSelectId);
        var cacheKey = query.targetSelectId + "_cache";

        var doneCallBack = function(json) {
            _.each(json.list, function(element,index,list) {
                options.append($("<option />").val(element.value).text(element.text));
            });

            if (query.cacheList) {
                sessionStorage.setItem(cacheKey,JSON.stringify(json));    
            }

            if (! _.isUndefined(query.selectedValue)) {
                options.val(query.selectedValue);
            }
            else {
                options.val(json.list[0].value);
            }

            if (query.raiseChangeEvent) {
                options.change();
            }
        };

        var alwaysCallBack = function() {            
        };

        if (query.cacheList && sessionStorage.getItem(cacheKey)) {
            var json = JSON.parse(sessionStorage.getItem(cacheKey));        
            doneCallBack(json);
        }
        else {
            ASNAHelpers.ajax.postJson(query.url,query.getJson(),doneCallBack,alwaysCallBack);    
        }
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
    
    var populateStateList = function() {
        var stateQuery = new ASNAHelpers.QueryInputArgs();
        stateQuery.Library = "examples";
        stateQuery.File = "states";
        stateQuery.FieldsList = "State:text, Abbrev:value";
        stateQuery.Rows = -1;
        stateQuery.addQueryParm("State");
        stateQuery.targetSelectId = "stateList";
        
        stateQuery.cacheList = true;
        //stateQuery.selectedValue = "IN";
        stateQuery.raiseChangeEvent = true;

        populateSelectTag(stateQuery);
    }();
});