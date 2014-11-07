<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="JsonDataTable.aspx.vr" Inherits="views_JsonDataTable" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">

<div>
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
                    <select id="customer-state">
                        <option value="AL">Alabama</option>
                        <option value="CA">California</option>
                        <option value="IN">Indiana</option>
                        <option value="MI">Michigan</option>
                        <option value="OH">Ohio</option>
                        <option value="TX">Texas</option>
                    </select>
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
    <%
    Else
    %>
    <script src="../public/js/JsonDataTable.aspx.min.js"></script>    
    <%
    EndIf 
    %>


</asp:Content>

