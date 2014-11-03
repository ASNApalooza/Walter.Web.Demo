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
              <div class="panel-body" role="form">
                    <div class="row">
                        
                        <asp:Panel ID="Panel1" runat="server" CssClass="col-md-8">
                            <div class="input-group">
                                <asp:TextBox ID="textboxCustomerName" cssclass="form-control" runat="server" placeholder="Customer name" EnableViewState="False" ClientIDMode="Static"></asp:TextBox>
                                <br/>
                                <asp:TextBox ID="textboxCustomerNumber" cssclass="form-control" runat="server" placeholder="Customer number" EnableViewState="False" ClientIDMode="Static"></asp:TextBox>
                            </div>

                            <div class="form-horizontal">

                                <div class="form-group">
                                   <label for="form-Name" class="col-sm-2 control-label">Name</label>
                                   <div class="col-sm-10">
                                      <input type="text" class="form-control" id="form-Name" />
                                   </div>
                                </div>

                                <div class="form-group">
                                   <label for="form-Address" class="col-sm-2 control-label">Address</label>
                                   <div class="col-sm-10">
                                      <input type="text" class="form-control" id="form-Address" />
                                   </div>
                                </div>



                                <div class="form-group">
                                   <label for="form-City" class="col-sm-2 control-label">City</label>
                                   <div class="col-sm-6">
                                      <input type="text" class="form-control" id="form-City" />
                                   </div>
                                   <label for="form-State" class="col-sm-2 control-label">State</label>
                                   <div class="col-sm-2">
                                      <input type="text" class="form-control" id="form-State" />
                                   </div>
                                </div>

                                <div class="form-group">
                                   <label for="form-PostalCode" class="col-sm-2 control-label">Zip code</label>
                                   <div class="col-sm-4">
                                      <input type="text" class="form-control" id="form-PostalCode" />
                                   </div>
                                </div>

                                <div class="form-group">
                                  <div class="col-sm-2 control-label">
                                      <label>Active</label>
                                  </div>
                                  <div class="checkbox col-sm-10" style="">
                                    <input type="checkbox" style="margin-left:2px;">
                                 </div>
                               </div>

                                <div class="form-group">
                                   <label for="form-Email" class="col-sm-2 control-label">Email</label>
                                   <div class="col-sm-10">
                                      <input type="email" class="form-control" id="form-Email" />
                                   </div>
                                </div>

                                <div class="form-group">
                                   <label for="form-Fax" class="col-sm-2 control-label">Fax</label>
                                   <div class="col-sm-6">
                                      <input type="text" class="form-control" id="form-Fax" />
                                   </div>
                                </div>

                                <div class="form-group">
                                   <label for="form-Phone" class="col-sm-2 control-label">Phone</label>
                                   <div class="col-sm-6">
                                      <input type="text" class="form-control" id="form-Phone" />
                                   </div>
                                </div>



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

    <%
    If (HttpContext.Current.IsDebuggingEnabled)     
    %>
        <script src="../public/js/jQueryAutoComplete.aspx.js"></script>
    <%
    Else
    %>
        <script src="../public/js/jQueryAutoComplete.aspx.min.js"></script>
    <%
    EndIf 
    %>

</asp:Content>

