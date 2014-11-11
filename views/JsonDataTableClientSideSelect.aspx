<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="JsonDataTableClientSideSelect.aspx.vr" Inherits="views_JsonDataTableClientSideSelect" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageHeadingPlaceHolder" Runat="Server">
<h3>Populate the states list and the customer grid with JavaScript</h3>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">
<div>
    <div class="col-md-3">
        <h3>Populate a grid with Json</h3>
        <p>This page shows how you can use Walter to fetch Json from the client side. There isn't <em>any</em> server
        side code used on this page. The state list dropdown (in the 'Filter customers' panel) and the customer 
        grid are both with Walter's JavaScript interface. 
        </p>
        <p>For this example, the superb <a href="http://www.datatables.net/">jQuery DataTables</a> plug-in is used to render the grid. In addition to many 
        great features, this plug-in also provides great Bootstrap support. 
        </p>
        <p><!-- Button trigger modal -->
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                Show source code
                </button>
        </p>

    </div>
    <div class="col-md-9">
        <div id="json-loading">
            Loading customers... <img src="../public/images/concentric-spinner.gif" />
        </div>
        <div id="grid-container">
            <div>
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title"><a data-parent="#accordion" data-toggle="collapse" href="#collapseOne"><i class="fa fa-filter"></i>&nbsp;Filter customers</a></h4> </div>
                        <div class="panel-collapse collapse" id="collapseOne">
                            <div class="panel-body"> Select customer state
                                <select id="stateList"> </select>
                                <div id="query-metrics"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <table cellspacing="0" class="jsonTable" id="json-data-table" width="100%">
                <thead>
                    <tr>
                        <th>Number</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>City</th>
                        <th>State</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <!-- #grid-container-->
    </div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">The JavaScript that populates this page.</h4>
      </div>
      <div class="modal-body">

<p>The code below is most of the JavaScript this page uses. See the file asnaMiscellaneous.js for the JavaScript 
to add the format() method to JavaScript's String object and the general-purpose populateSelectTag() method. 
</p>
<br />
<h4>JsonDataTableCommon.js</h4>
<p>This file is shared by the JsonDataTableClientSideSelect.aspx and the
JsonDataTableServerSideSelect.aspx pages. It provides the query that populates the grid 
and provides the change event handler. This handler fires when the selected value of 
the states dropdown changes--causing the grid to be reloaded with customers from the 
selected state. 
</p>
<pre class="prettyprint linenums">$(function () {  
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

            var mask = "&lt;span>Returned {0} records. Fetched in {1} milliseconds.&lt;/span>";
            $("#query-metrics").html(mask.format(json.rowCountPhrase, json.milliseconds));        

            $("#json-data-table").addClass('table table-striped table-bordered');    
            $("#grid-container").removeClass("hide");
            $("#json-loading").hide();    
        };

        ASNAHelpers.ajax.postJson(query.url,query.getJson(),jsonReadyToRender);
    });
});</pre>

<br />
<h4>JsonDataTableClientSideSelect.aspx.js</h4>
<p>This is the page-specific JavaScript that drives this page. The immediately 
invoked function expression calls populateSelectTag() to populate the states select 
tag (the states dropdown) and fire its change event. The code to populate the jQuery 
DataTable is called when the states dropdown change fires.

</p>

<pre class="prettyprint linenums">$(function () {   
    
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
});</pre>


        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderPageBottom" Runat="Server">
    <%
    If (HttpContext.Current.IsDebuggingEnabled)     
    %>
    <!--
    <script src="../public/vendor/datatables/media/js/jquery.dataTables.js"></script>
    <script src="../public/vendor/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.js"></script>                
    <script src="../public/js/ASNAHelpers.QueryInputArgs.js"></script>
    -->
    <script src="../public/js/JsonDataTableCommon.js"></script>
    <script src="../public/js/JsonDataTableClientSideSelect.aspx.js"></script>
    <script src="../public/js/stopwatch.js"></script>
    <%
    Else
    %>
    <script src="../public/js/JsonDataTable.aspx.min.js"></script>    
    <%
    EndIf 
    %>
</asp:Content>