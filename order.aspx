<%@ Page Language="C#" AutoEventWireup="true" CodeFile="order.aspx.cs" Inherits="order" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="訂購者:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="連絡電話:"></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="備註:"></asp:Label>
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" onclick="saveCustomerData" 
            Text="開始訂購" />
        <asp:Label ID="訂購編號" runat="server" BorderStyle="None" Text="label_order_id" 
            Visible="False"></asp:Label>
        <br />
        <asp:SqlDataSource ID="SDS_Customer" runat="server" 
            ConnectionString="<%$ ConnectionStrings:onlinestoreConnectionString %>" 
            DeleteCommand="DELETE FROM [customer] WHERE [訂購者編號] = @訂購者編號" 
            InsertCommand="INSERT INTO [customer] ([訂購者名稱], [電話], [memo]) VALUES (@訂購者名稱, @電話, @memo)" 
            oninserted="insertIntoCustomer" SelectCommand="SELECT * FROM [customer]" 
            UpdateCommand="UPDATE [customer] SET [訂購者名稱] = @訂購者名稱, [電話] = @電話, [memo] = @memo WHERE [訂購者編號] = @訂購者編號">
            <DeleteParameters>
                <asp:Parameter Name="訂購者編號" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="訂購者名稱" PropertyName="Text" 
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox2" Name="電話" PropertyName="Text" 
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox3" Name="memo" PropertyName="Text" 
                    Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="訂購者名稱" Type="String" />
                <asp:Parameter Name="電話" Type="String" />
                <asp:Parameter Name="memo" Type="String" />
                <asp:Parameter Name="訂購者編號" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="Label4" runat="server" Text="商品:"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="SqlDataSource_Product" DataTextField="商品名稱" DataValueField="商品名稱">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource_Product" runat="server" 
            ConnectionString="<%$ ConnectionStrings:onlinestoreConnectionString %>" 
            SelectCommand="SELECT [商品名稱] FROM [Product]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_product" runat="server"></asp:SqlDataSource>
        <br />
        <asp:Label ID="商品名稱" runat="server" Text="label_product_name" Visible="False"></asp:Label>
&nbsp;<asp:DropDownList ID="DropDownList2" runat="server">
            <asp:ListItem Selected="True">==請選擇數量==</asp:ListItem>
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
        </asp:DropDownList>
&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" onclick="addToOrderForm" Text="加入訂單" />
        <asp:SqlDataSource ID="SDS_OrderForm" runat="server" 
            ConnectionString="<%$ ConnectionStrings:onlinestoreConnectionString %>" 
            DeleteCommand="DELETE FROM [OrderForm] WHERE [訂單編號] = @訂單編號" 
            InsertCommand="INSERT INTO [OrderForm] ([product], [amount], [訂購者]) VALUES (@product, @amount, @訂購者)" 
            oninserted="insertIntoOrderForm" SelectCommand="SELECT * FROM [OrderForm]" 
            
            
            UpdateCommand="UPDATE [OrderForm] SET [product] = @product, [amount] = @amount, [訂購者] = @訂購者 WHERE [訂單編號] = @訂單編號">
            <DeleteParameters>
                <asp:Parameter Name="訂單編號" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="product" 
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="DropDownList2" Name="amount" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" Name="訂購者" PropertyName="Text" 
                    Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="product" Type="String" />
                <asp:Parameter Name="amount" Type="Int32" />
                <asp:Parameter Name="訂購者" Type="String" />
                <asp:Parameter Name="訂單編號" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server">
        </asp:GridView>
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" onclick="btn_search" Text="查詢訂單" />
    
        <br />
        <asp:GridView ID="GridView1" runat="server" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>

        <br />
    
    </div>
    <asp:Label ID="Label5" runat="server" Text="請輸入訂單編號:"></asp:Label>
    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    <asp:Button ID="Button4" runat="server" onclick="btn_delete" Text="刪除並更新訂單資訊" />
    <br />
    <asp:Label ID="txtMsg" runat="server" Text="labe_show"></asp:Label>
    <br />
    <br />
    <asp:Button ID="Button5" runat="server" onclick="btn_view" Text="檢視訂單" />
    <asp:GridView ID="GridView3" runat="server" Visible="False">
    </asp:GridView>
    <br />
    <asp:Label ID="check" runat="server" Text="check"></asp:Label>
    </form>
</body>
</html>
