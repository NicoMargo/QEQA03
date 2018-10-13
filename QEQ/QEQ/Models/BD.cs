using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace QEQ.Models
{
    public static class BD
    {
        public static string connectionString = "Server=10.128.8.16;User=QEQA03;Password=QEQA03;Database=QEQA03";
        //public static List<Preguntas> ListaPreg = new List<Preguntas>();
       // public static List<Respuestas> ListaResp = new List<Respuestas>();
  




        public static SqlConnection Conectar()
        {
            SqlConnection laConexion = new SqlConnection(connectionString);
            laConexion.Open();
            return laConexion;
        }

        public static void Desconectar(SqlConnection laConexion)
        {
            laConexion.Close();
        }

        public static bool ModificarP(Personaje P)
        {
            bool reg = true;
            
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "sp_Respuesta2";

           /* laConsulta.Parameters.AddWithValue("@Categoria", CategInt);

            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                ID = Convert.ToInt32(elLector["IDResp"]);
                TextoResp = (elLector["texto"].ToString());
                CategInt = Convert.ToInt32(elLector["Categoria"]);
                Numero = Convert.ToInt32(elLector["Numero"]);
                Correcta = Convert.ToBoolean(elLector["TF"]);
                NumerosubCat = Convert.ToInt32(elLector["NumerosubCategoria"]);
                Respuestas unaResp = new Respuestas(ID, Numero, TextoResp, Correcta, CategInt, NumerosubCat);
                ListaResp.Add(unaResp);
            }*/
            Desconectar(unaConexion);
            return reg;
        }

        public static Usuario Login(string User, string Pass)
        {
            
           
            string Nombre ="", email = "", pass = "", username = "", Mac = "", IP = "";
            int Puntos = -1;
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spLogin";

            laConsulta.Parameters.AddWithValue("@Username", User);
            laConsulta.Parameters.AddWithValue("@Password", Pass);
            

            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Nombre = (elLector["Nombre"].ToString());
                email = (elLector["Mail"].ToString());
                pass = (elLector["Pass"].ToString());
                Mac = (elLector["Mac"].ToString());
                IP = (elLector["Ip"].ToString());
                username = (elLector["Username"].ToString());
                Puntos = Convert.ToInt32(elLector["Puntos"]);
                
                
            }
            Usuario Usu = new Usuario(Nombre, username, pass, Puntos, IP, Mac, email);
            Desconectar(unaConexion);
            return Usu;
        }
     
    }
}