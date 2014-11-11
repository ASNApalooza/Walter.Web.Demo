<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="JsonDataTableServerSideSelect.aspx.vr" Inherits="views_JsonDataTableServerSideSelect" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="PageHeadingPlaceHolder" Runat="Server">
<h3>Populate the states list server side and the customer grid with JavaScript</h3>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">
<div>
    <div class="col-md-3">
        <h3>Using Walter in a traditional ASP.NET page</h3>
        <p>This page shows how you can use Walter to provide a DataTable to an ASP.NET 
           ASPX page for use with the GridView (or any other data-aware control).</p>
        <p>One of the things the DataList does very well is let you easily change access paths at runtime. As
           the user selects how to display and position the list, different logical files are being used 
           to creating the underlying DataTable. While this example uses two position types, you could easily
           snap in others.       
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
        <div id="grid-container" class="hide">
            <div>
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title"><a data-parent="#accordion" data-toggle="collapse" href="#collapseOne"><i class="fa fa-filter"></i>&nbsp;Filter customers</a></h4> </div>
                        <div class="panel-collapse collapse" id="collapseOne">
                            <div class="panel-body"> Select customer state
                                <asp:DropDownList ID="stateList" ClientIDMode="Static" runat="server"></asp:DropDownList>
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
    <script src="../public/js/JsonDataTableServerSideSelect.aspx.js"></script>
    <script src="../public/js/stopwatch.js"></script>
    <%
    Else
    %>
    <script src="../public/js/JsonDataTableServerSideSelect.aspx.min.js"></script>    
    <%
    EndIf 
    %>
</asp:Content>