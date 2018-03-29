using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Web;

namespace TLC
{      
    public class DB
    {
        static string Conn = @"Provider=Microsoft.ACE.OLEDB.12.0; Data Source=" + HttpContext.Current.Request.PhysicalApplicationPath + @"\OutRecord.mdb";

        /// <summary>
        /// 取得新的DataTable
        /// </summary>
        /// <param name="dtOld">舊的DataTable</param>
        /// <param name="sFilter">篩選</param>
        /// <param name="sSort">排序</param>
        /// <returns>新的DataTable</returns>
        public static DataTable DTFilter(DataTable dtOld, string sFilter, string sSort)
        {
            return (new DataView(dtOld, sFilter, sSort, DataViewRowState.CurrentRows)).ToTable();
        }        
        /// <summary> 取得DataTable(OleDB連線) </summary>
        /// <param name="sSql">SQL子句</param>
        /// <param name="sConn">OleDB連線字串</param>
        /// <param name="sTableName">Table名稱(可不輸入)</param>
        /// <returns>DataTable</returns>
        public static DataTable GetDt(string sSql, string sTableName = "TABLE")
        {
            OleDbConnection conn = new OleDbConnection(Conn);
            DataTable dt = new DataTable();
            try
            {
                conn.Open();
                OleDbDataAdapter da = new OleDbDataAdapter(sSql, Conn);
                da.Fill(dt);

                //sTableName!=TABLE 表示有設定TableName
                if (sTableName != "TABLE")
                {
                    dt.TableName = sTableName;
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return dt;
        }        
        public static int ExecuteSQL(string sSQL)
        {
            OleDbConnection oldConn = new OleDbConnection(Conn);
            try
            {
                oldConn.Open();
                OleDbCommand oldCmd = new OleDbCommand(sSQL, oldConn);
                return oldCmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                oldConn.Close();
            }
        }
    }
}
