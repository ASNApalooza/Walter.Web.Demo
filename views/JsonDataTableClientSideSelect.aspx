<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="JsonDataTableClientSideSelect.aspx.vr" Inherits="views_JsonDataTableClientSideSelect" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">

<div>

    <div class="col-md-3">
        <h3>Populate a grid with Json</h3>
        <p>This page shows how you can use Walter to fetch Json from the client side. There isn't <em>any</em> server
        side code used on this page. The state list dropdown (in the 'Filter customers' panel) and the customer 
        grid are both populated with JavaScript and Ajax using Walter queries. 
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