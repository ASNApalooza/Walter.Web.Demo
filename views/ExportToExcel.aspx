<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="ExportToExcel.aspx.vr" Inherits="views_ExportToExcel" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">
<div class="col-md-3">
    <h3>Using Walter in a traditional ASP.NET page</h3>
    <p>This page shows how you might use Walter to provide a datatable to an ASP.NET 
       ASPX page for use with the GridView (or any other data-aware control).</p>
    <p>One of the things the DataList does very well is let you easily change access paths at runtime. As
       the user selects how to display and position the list, different logical files are being used 
       to creating the underlying DataTable. While this example uses two position types, you could easily
       snap in others.       
    </p>
    <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
</div>
<div class="col-md-9">
    <div id="content-page-main">
        <div>
            <div class="panel panel-default">
              <div class="panel-body">
                    <div class="row">
                        <asp:Panel ID="Panel1" runat="server" CssClass="col-md-4">
                        </asp:Panel>
                        <div class="col-md-8">
                            <div class="pull-right">
                                <input type="text" name="library"        id="library" required="required" value="examples" /><br />
                                <input type="text" name="file"           id="file" required="required"  value="CMastNewL2" /><br />
                                <input type="text" name="fieldsList"     id="fieldsList" required="required"  value="CMCUSTNO:Number,CMNAME:Name,CMADDR1:Address,CMCITY:City" /><br />
                                <input type="text" name="rows"           id="rows" required="required"  value="1000" /><br />
                                <input type="text" name="queryType"      id="queryType" required="required"  value="paged" /><br />
                                <input type="text" name="qryFld0"        required="required"  value="@cmcustno:i'0'" /><br />
                                <asp:LinkButton ID="linkbuttonExportToExcel" runat="server" PostBackUrl="~/services/ExcelService.ashx" ClientIDMode="Static">Export to Excel</asp:LinkButton>
                            </div>    
                        </div>    
                    </div>
              </div>
            </div>
        </div>
    </div>
</div> 

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderPageBottom" Runat="Server">
    <script src="../public/js/ExportToExcel.aspx.js"></script>


</asp:Content>

