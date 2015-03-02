<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="TraditionalGridView.aspx.vr" Inherits="views_TraditionalGridView" Title="Untitled Page" %>


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
<h3>Populate the GridView traditionally with AVR and a DclDiskFile</h3>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">

<div class="col-md-3">
    <h3>Using Walter in a traditional ASP.NET page</h3>
    <p>This page shows traditional use of AVR's DclDisk file to populate a DataGrid. RPG limits processing 
    provides "paging" through the customer list. 
    </p>
    <p>
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
                        <asp:Panel ID="Panel1" runat="server" CssClass="col-md-4"  DefaultButton="linkbuttonPosition">


                            <div class="input-group">
                                <asp:TextBox ID="textboxPosition" cssclass="form-control" runat="server" placeholder="Find customer" ClientIDMode="Static"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:LinkButton ID="linkbuttonPosition" runat="server" CssClass="btn btn-default"><span class="sr-only">Position to</span><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </span>
                            </div>

                        </asp:Panel>
                        <div class="col-md-8">

                            <div class="pull-right">

<%--

                                <div class="btn-group">
                                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"><asp:Label ClientIDMode="Static" ID="labelSortBy" runat="server" Text="By name"></asp:Label> <span class="caret"></span></button>

                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                        <li role="presentation"><asp:LinkButton ID="linkbuttonByName" runat="server" role="menuitem">By name</asp:LinkButton></li>
                                        <li role="presentation"><asp:LinkButton ID="linkbuttonByNumber" runat="server" role="menuitem">By number</asp:LinkButton></li>
                                    </ul>

                                </div>                                
                                <asp:LinkButton ID="linkbuttonFirst" runat="server" CssClass="btn btn-default"><span class="glyphicon glyphicon-fast-backward"></span> First</asp:LinkButton>
--%>

                                <asp:LinkButton ID="linkbuttonNext" runat="server" CssClass="btn btn-default">Next <span class="glyphicon glyphicon-play"></span></asp:LinkButton>
                            </div>    
                        </div>    
                    </div>
              </div>
            </div>
            <asp:GridView ID="gridviewCustomers" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-condensed">
                <Columns>
                    <asp:BoundField DataField="Customer_CMCUSTNO" HeaderText="Number" >
                    <HeaderStyle Width="15%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Customer_CMNAME" HeaderText="Name" />
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
        <h4 class="modal-title" id="H1">Traditional AVR code to to populate the GridView on this page</h4>
      </div>
      <div class="modal-body">

<pre class="prettyprint linenums">DclFld DBNAME Type(*String) 
DclDB pgmDB DBName( "*PUBLIC/DG Net Local" )

DclDiskFile  CustomerByName +
      Type( *Input  ) +
      Org( *Indexed ) +
      Prefix( Customer_ ) +
      File( "Examples/CMastNewL2" ) +
      DB( pgmDB ) +
      ImpOpen( *No )

DclMemoryFile CustomerByNameMF ImpOpen( *Yes ) 
    DclRecordFormat Customers 
    DclRecordFld    Customer_CMCustNo  Type( *Packed ) Len( 9,0 )
    DclRecordFld    Customer_CMName    Type( *Char ) Len( 40 )     
    
BegSr Page_Load Access(*Private) Event(*This.Load)
    DclSrParm sender Type(*Object)
    DclSrParm e Type(System.EventArgs)

    DBNAME = (*This.Master *As Home).DBName

    pgmDB.DBName = DBNAME
    Connect pgmDB 
    Open CustomerByName

    If (NOT Page.IsPostBack)
        LoadGrid()
    Else
    EndIf
EndSr

BegSr Page_Unload Access(*Private) Event(*This.Unload)
    DclSrParm sender Type(*Object)
    DclSrParm e Type(System.EventArgs)

    Close *ALL
    Disconnect pgmDB
EndSr

BegSr LoadGrid
    Do FromVal( 1 ) ToVal( 12 )
        Read CustomerByName 
        If ( CustomerByName.IsEof ) 
            Leave
        EndIf

        Write CustomerByNameMF 
    EndDo

    Viewstate["custno"] = Customer_CMCustNo
    Viewstate["name"] = Customer_CMName 

    gridviewCustomers.DataSource = CustomerByNameMF.DataSet
    gridViewCustomers.DataBind()  
EndSr 

BegSr linkbuttonNext_Click Access(*Private) Event(*This.linkbuttonNext.Click)
    DclSrParm sender Type(*Object)
    DclSrParm e Type(System.EventArgs)

    Customer_CMName = Viewstate["name"].ToString()
    Customer_CMCustNo = Viewstate["custno"].ToString()

    SetGT CustomerByName Key(Customer_CMName, Customer_CMCustNo) 
    LoadGrid()      
EndSr

BegSr linkbuttonPosition_Click Access(*Private) Event(*This.linkbuttonPosition.Click)
    DclSrParm sender Type(*Object)
    DclSrParm e Type(System.EventArgs)

    Customer_CMName = textboxPosition.Text.Trim()
    Customer_CMCustNo = 0

    SetLL CustomerByName Key(Customer_CMName, Customer_CMCustNo) 
    LoadGrid()              
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




