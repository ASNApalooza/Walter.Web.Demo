<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="JsonDataTable.aspx.vr" Inherits="views_JsonDataTable" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
    <link rel="stylesheet" href="../public/vendor/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css">

    <style>
        table > thead > tr > th {
            color: black;
            background-color: white;
        }
    </style>
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
                      Customer selection criteria
                    </a>
                  </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse">
                  <div class="panel-body">
                   Query criteria here. 


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
    <script src="../public/js/ASNAHelpers.QueryInputArgs.js"></script>
    <script src="../public/vendor/datatables/media/js/jquery.dataTables.js"></script>
    <script src="../public/vendor/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.js"></script>                
    <script src="../public/js/JsonDataTable.aspx.js"></script>
</asp:Content>

