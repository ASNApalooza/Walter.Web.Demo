<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="ExportToExcel.aspx.vr" Inherits="views_ExportToExcel" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">
<div class="col-md-3">
    <h3>Excel export</h3>
    <p>This page shows how you might use Walter to provide a datatable to an ASP.NET 
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
    <div id="content-page-main">
        <div>
            <div class="panel panel-default">
              <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div>

<%-- 
                                <input type="text" name="library"        id="library" required="required" value="examples" /><br />
                                <input type="text" name="file"           id="file" required="required"  value="CMastNewL2" /><br />
                                <input type="text" name="fieldsList"     id="fieldsList" required="required"  value="CMCUSTNO:Number,CMNAME:Name,CMADDR1:Address,CMCITY:City" /><br />
                                <input type="text" name="rows"           id="rows" required="required"  value="1000" /><br />
                                <input type="text" name="queryType"      id="queryType" required="required"  value="paged" /><br />
                                <input type="text" name="qryFld0"        required="required"  value="@cmcustno:i'0'" /><br />
--%>
                                <img src="../public/images/excel.jpg" />
                                <asp:LinkButton ID="linkbuttonExportToExcel" runat="server" ClientIDMode="Static">Export customer list Excel</asp:LinkButton>
                            </div>    
                        </div>    
                    </div>
              </div>
            </div>
        </div>
    </div>
</div> 

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Source code on this page to generate the Excel spreadsheet</h4>
      </div>
      <div class="modal-body">

<p>This is the entire source it takes to generate a an Excel spreadsheet. The namespace ASNA.Helpers.ASPNET provides several ASP.NET-specific 
capabilities for Walter. Its ExcelExport class does all the work to render a Walter-created Excel spreadsheet over HTTP.</p>  

<pre class="prettyprint linenums">
BegSr linkbuttonExportToExcel_Click Access(*Private) Event(*This.linkbuttonExportToExcel.Click)
    DclSrParm sender Type(*Object)
    DclSrParm e Type(System.EventArgs)

    DclFld Inputs Type(ASNA.Helpers.DataServices.QueryFileInstanceArgs.InputArgs) New()
    DclFLd ex     Type(ASNA.Helpers.ASPNET.ExcelExport) New()
    DclFld Result Type(*Boolean)

    Inputs.Library      = "examples"
    Inputs.File         = "cmastnewl2"
    Inputs.FieldsList   = "CMCUSTNO:Number,CMNAME:Name,CMADDR1:Address,CMCITY:City"
    Inputs.Rows         = -1
    Inputs.Query        = "CMCUSTNO > 0"
    Inputs.QueryParms.Add(*New ASNA.Helpers.DataServices.QueryField("CMCustNo",0))
    Inputs.OrderBy.Add(*New ASNA.Helpers.DataServices.QueryOrderByField("CMNAME",0))
    Inputs.Options.Add("heading","Customer Listing  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss"))
    Inputs.Options.Add("worksheet_name","Customers")

    Result = ex.CreateSpreadsheet(HttpContext.Current,Inputs) 
    If (Result) 
        // Spreadsheet creation was successful.
    Else 
        ClientScript.RegisterStartupScript( *This.GetType(),"ShowGrowler", "showExcelError()", *True)
    EndIf        
EndSr
</pre>
        
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
    <script src="../public/js/ExportToExcel.aspx.js"></script>
    <%
    Else
    %>
    <script src="../public/js/ExportToExcel.aspx.min.js"></script>
    <%
    EndIf 
    %>

</asp:Content>

