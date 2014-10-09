<%@ Page Language="AVR" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="jqueryAutoComplete.aspx.vr" Inherits="views_jqueryAutoComplete" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftColumn" Runat="Server">
<div class="col-md-3">
    <h3>jQuery AutoComplete</h3>
    <p>This page shows how you might use the DataList object to provide a datatable to an ASP.NET 
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
                        <asp:Panel ID="Panel1" runat="server" CssClass="col-md-8">
                            <div class="input-group">
                                <asp:TextBox ID="textboxCustomerName" cssclass="form-control" runat="server" placeholder="Find customer" EnableViewState="False" ClientIDMode="Static"></asp:TextBox>
                                <br/>
                                <asp:TextBox ID="textboxCustomerNumber" cssclass="form-control" runat="server" EnableViewState="False" ClientIDMode="Static"></asp:TextBox>

                            </div>
                        </asp:Panel>
                        <div class="col-md-4">
                        </div>    
                    </div>
              </div>
            </div>
        </div>
    </div>
</div> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderPageBottom" Runat="Server">
    <script src="../public/js/ASNAHelpers.QueryInputArgs.js"></script>
    <script src="../public/js/jQueryAutoComplete.aspx.js"></script>
</asp:Content>

