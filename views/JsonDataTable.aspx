<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="JsonDataTable.aspx.vr" Inherits="views_JsonDataTable" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
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
        <div id="grid-container">
            <div>
                <div class="panel-group" id="accordion">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                          <i class="fa fa-filter"></i>&nbsp;Filter customers
                        </a>
                      </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse">
                      <div class="panel-body">
                        Select customer state
                        <asp:DropDownList ID="stateList" ClientIDMode="Static" runat="server" CssClass="customer-state-list"></asp:DropDownList>
                        
                        <%--<select id="customer-state">--%>
                        <!--
                            <option value="AL">Alabama</option>
                            <option value="CA">California</option>
                            <option value="IN">Indiana</option>
                            <option value="MI">Michigan</option>
                            <option value="OH">Ohio</option>
                            <option value="TX">Texas</option>
                            -->
                        <%--</select>--%>
                        <div id="query-metrics"></div>
                      </div>
                    </div>
                  </div>
                </div>
            </div>
            <table id="json-data-table" cellspacing="0" width="100%" class="jsonTable">
                <thead>
                    <tr>
                        <th>Number</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>City</th>
                        <th>State</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
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
    <script src="../public/js/JsonDataTable.aspx.js"></script>
    <script src="../public/js/stopwatch.js"></script>
    <%
    Else
    %>
    <script src="../public/js/JsonDataTable.aspx.min.js"></script>    
    <%
    EndIf 
    %>


</asp:Content>

