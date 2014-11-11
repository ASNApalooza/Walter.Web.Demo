$(function () {    
    document.title = "Walter • Client side";

    (function() {
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
    }());
});