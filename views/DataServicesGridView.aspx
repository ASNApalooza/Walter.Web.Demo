<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="DataServicesGridView.aspx.vr" Inherits="views_DataServicesGridView" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">

    <%
    If (HttpContext.Current.IsDebuggingEnabled)     
    %>
    <link rel="stylesheet" href="../public/css/DataServicesGridView.aspx.css">
    <%
    Else
    %>
    <link rel="stylesheet" href="../public/css/DataServicesGridView.aspx.min.css">
    <%
    EndIf 
    %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="PageHeadingPlaceHolder" Runat="Server">
<h3>Populate the GridView with server-side Walter queries </h3>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">

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
    <div id="content-page-main">
        <div>
            <div class="panel panel-default">
              <div class="panel-body">
                    <div class="row">
                        <asp:Panel ID="Panel1" runat="server" CssClass="col-md-4" DefaultButton="linkbuttonPosition">
                            <div class="input-group">
                                <asp:TextBox ID="textboxPosition" cssclass="form-control" runat="server" placeholder="Find customer" ClientIDMode="Static"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:LinkButton ID="linkbuttonPosition" runat="server" CssClass="btn btn-default"><span class="sr-only">Position to</span><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </span>
                            </div>
                        </asp:Panel>
                        <div class="col-md-8">
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"><asp:Label ClientIDMode="Static" ID="labelSortBy" runat="server" Text="By name"></asp:Label> <span class="caret"></span></button>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                    <li role="presentation"><asp:LinkButton ID="linkbuttonByName" runat="server" role="menuitem">By name</asp:LinkButton></li>
                                    <li role="presentation"><asp:LinkButton ID="linkbuttonByNumber" runat="server" role="menuitem">By number</asp:LinkButton></li>
                                    </ul>
                                </div>
                                <asp:LinkButton ID="linkbuttonFirst" runat="server" CssClass="btn btn-default"><span class="glyphicon glyphicon-fast-backward"></span> First</asp:LinkButton>
                                <asp:LinkButton ID="linkbuttonNext" runat="server" CssClass="btn btn-default">Next <span class="glyphicon glyphicon-play"></span></asp:LinkButton>
                            </div>    
                        </div>    
                    </div>
              </div>
            </div>
            <asp:GridView ID="gridviewCustomers" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-condensed">
                <Columns>
                    <asp:BoundField DataField="CMCUSTNO" HeaderText="Number" >
                    <HeaderStyle Width="15%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CMNAME" HeaderText="Name" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</div> 


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Some of the Walter-centric code that populates the GridView on this page</h4>
      </div>
      <div class="modal-body">

<p>The code below shows most of the Walter-centric code to populate the GridView. A variabled named CurrentOrderBy (persisted in Viewstate)
keeps track of the current order-by selection (name or number in this case). In the ConfigureDataList subroutine its value is used to determine
what file and query parameters to load at runtime. Unlike static Visual RPG, where you need to hardcode DclDiskFiles, Walter's use of data
files is quite dynamic and easy to swap out at runtime. 
</p>

<p>The LoadGrid() routine is responsible for setting the GridView's datasource. It gets passed a string variable called QueryState. This variable
contains the serialized value of the Walter query object. The first time LoadGrid is called this value is null, so line 35 uses Walter's 
Exec() method to get the first page of query results. Line 41 ensures that Walter's query state is saved in Viewstate. On subsequent calls to 
LoadGrid() that saved query state value is passed in and used in line 37 as the only argument to Walter's NextPage() method. Internally, Walter
brings himself back to life with this serialized value and then returns the next page of query results. 
</p>  
<p>You'll notice that when using Walter in most stateful apps (ie, Windows apps) NextPage() doesn't need to be passed the query state--because 
the query object in a stateful doesn't go out of scope. However, if circumstances required it, you could save and restore the Walter query 
object in a stateful app just as we're doing here in this stateless app.
</p>


<pre class="prettyprint linenums">
Using ASNA.Helpers.DataServices

...

BegSr ConfigureDataList
    DclSrParm Query     Type(ASNA.Helpers.DataServices.QueryDriver)

    Query.Args.Inputs.Library      = "examples"
    Query.Args.Inputs.FieldsList   = "CMCUSTNO,CMNAME"
    Query.Args.Inputs.Rows         = 12

    If (CurrentOrderBy = OrderBy.Name) 
        Query.Args.Inputs.File      = "CmastNewL2"
        Query.Args.Inputs.QueryParms.Add(*New QueryField("CMNAME",*This.CMNameValue))
        Query.Args.Inputs.QueryParms.Add(*New QueryField("CMCUSTNO",*This.CMCustNoValue))
    ElseIf (CurrentOrderBy = OrderBy.Number)
        Query.Args.Inputs.File      = "CmastNewL1"        
        Query.Args.Inputs.QueryParms.Add(*New QueryField("CMCUSTNO",*This.CMCustNoValue))   
    EndIf             
EndSr 

...

BegSr LoadGrid
    DclSrParm QueryState Type(*String) 

    DclFld DGDB       Type(AdgConnection) 
    DclFld Query      Type(ASNA.Helpers.DataServices.QueryDriver) 

    DGDB = *New AdgConnection(*This.DBName)
    DGDB.Open()
    Query = *New ASNA.Helpers.DataServices.QueryDriver(DGDB) 
    If (String.IsNullOrEmpty(QueryState)) 
        ConfigureDataList(Query)
        gridviewCustomers.DataSource = Query.Exec() *As DataTable 
    Else 
        gridviewCustomers.DataSource = Query.NextPage(QueryState) *As DataTable  
    EndIf 

    If (Query.Args.Error.ErrorException = *Nothing)
        Viewstate["queryState"] = Query.Args.Outputs.QueryState
        gridviewCustomers.DataBind()
    EndIf

    DGDB.Close()
EndSr</pre>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderPageBottom" Runat="Server">
    <script src="../public/js/DataServicesGridView.aspx.js"></script>

    <%
    If (HttpContext.Current.IsDebuggingEnabled)     
    %>
    <script src="../public/js/DataServicesGridView.aspx.js"></script>
    <%
    Else
    %>
    <script src="../public/js/DataServicesGridView.aspx.min.js"></script>
    <%
    EndIf 
    %>

</asp:Content>

