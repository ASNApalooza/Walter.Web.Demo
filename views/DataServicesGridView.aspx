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

