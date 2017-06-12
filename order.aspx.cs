﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class order : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void saveCustomerData(object sender, EventArgs e)
    {
        SDS_Customer.Insert();
    }

    protected void insertIntoCustomer(object sender, SqlDataSourceStatusEventArgs e)
    {
        Response.Write("customer資料新增成功");
    }

    protected void addToOrderForm(object sender, EventArgs e)
    {
        SDS_OrderForm.Insert();
        SqlConnection connect = new SqlConnection("Data Source=.;Initial Catalog=onlinestore;User ID=ad;Password=ad");
        connect.Open();

        SqlCommand command = null;
        SqlCommand cc = null;
        cc = new SqlCommand("Update Product Set 數量=數量-@number Where 商品名稱=@name", connect);
        cc.Parameters.Add("@name", DropDownList1.Text);
        cc.Parameters.Add("@number", DropDownList2.Text);

        command = new SqlCommand("Select * From Product Where 商品名稱=@name", connect);
        command.Parameters.Add("@name", DropDownList1.Text);
        cc.ExecuteNonQuery();//important
        SqlDataReader drr = command.ExecuteReader();
        if (drr.HasRows)
        {
            GridView1.Visible = true;
            GridView2.DataSource = drr;
            GridView2.DataBind();
        }


        drr.Dispose();
        command.Dispose();
        connect.Close();
        command.Dispose();
       
    }
    protected void insertIntoOrderForm(object sender, SqlDataSourceStatusEventArgs e)
    {
        Response.Write("訂單已送出");
    }


    protected void stocknumber(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("Data Source=.;Initial Catalog=onlinestore;User ID=ad;Password=ad");
        con.Open();

    }
    
protected void  btn_search(object sender, EventArgs e)
{
    SqlConnection con = new SqlConnection("Data Source=.;Initial Catalog=onlinestore;User ID=ad;Password=ad");
    con.Open();
    SqlCommand cmd = new SqlCommand("Select * From OrderForm Where 訂購者=@paraName", con);
    cmd.Parameters.Add("@paraName", TextBox1.Text);
    SqlDataReader dr = cmd.ExecuteReader();
    if (dr.HasRows)
    {
        GridView1.Visible = true;
        GridView1.DataSource = dr;
        GridView1.DataBind();
    }
   

    dr.Dispose();
    cmd.Dispose();
    con.Close();
    con.Dispose();

}


protected void btn_delete(object sender, EventArgs e)
{
    int? rows = null;
    SqlConnection n = new SqlConnection("Data Source=.;Initial Catalog=onlinestore;User ID=ad;Password=ad");
    n.Open();
    SqlCommand s = new SqlCommand("Delete From OrderForm Where 訂單編號=@number", n);
    s.Parameters.Add("@number", TextBox4.Text);
    GridView1.Visible = false;

    rows = s.ExecuteNonQuery();
    if (rows >= 0)
        txtMsg.Text = string.Format("成功刪除{0}", rows);
    else
        txtMsg.Text = string.Format("刪除失敗");
    

    /*SqlCommand cdd = new SqlCommand("Select * From OrderForm Where 訂購者=@paraName", n);
    cdd.Parameters.Add("@paraName", TextBox1.Text);
    SqlDataReader drd = cdd.ExecuteReader();
    if (drd.HasRows)
    {
        GridView3.Visible = true;
        GridView3.DataSource = drd;
        GridView3.DataBind();
    }*/
    s.Dispose();
    n.Close();
    n.Dispose();
   
}


protected void btn_view(object sender, EventArgs e)
{
    SqlConnection nn = new SqlConnection("Data Source=.;Initial Catalog=onlinestore;User ID=ad;Password=ad");
    nn.Open();

    SqlCommand cdd = new SqlCommand("Select * From OrderForm Where 訂購者=@paraName", nn);
    cdd.Parameters.Add("@paraName", TextBox1.Text);
    SqlDataReader drd = cdd.ExecuteReader();
    if (drd.HasRows)
    {
        GridView3.Visible = true;
        GridView3.DataSource = drd;
        GridView3.DataBind();
    }
    else
    {
        GridView3.Visible = false;
        check.Text = string.Format("無任何訂單");
    }

    cdd.Dispose();
    nn.Close();
    nn.Dispose();

}
}