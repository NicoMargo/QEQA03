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
        public static string msg;
        public static List<Preg> Preguntas;//sp Traer Preguntas
        public static List<Personaje> Personajes;//Sp traer personajes
        public static List<string> Categorias;//sp Traer Cats
        public static List<string> Grupos;//sp Traer grupos
        public static List<Rta> Respuestas;//sp traer Ras
        public static Dictionary<string, List<Preg>> PregsXGrupos;

        public static Preg BuscarPregunta(string texto)
        {
            Preg pregunta = null;
            int i = 0;
            while (i < Preguntas.Count() && pregunta == null)
            {
                if (Preguntas[i].Texto == texto)
                {
                    pregunta = Preguntas[i];
                }
            }
            return pregunta;
        }


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
        public static void CargarRta(Personaje Per, Preg pregunta)
        {
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spCargarRespuestas";
            laConsulta.Parameters.AddWithValue("@idPersona", Per.Id);
            laConsulta.Parameters.AddWithValue("@idPregunta", pregunta.Id);
            laConsulta.ExecuteNonQuery();
            Desconectar(unaConexion);
        }
        //Trae una nueva persona, y una lista de preguntas, las cuales fueron marcadas como Sí
        public static string AgregarP(string Nombre, Personaje Per)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spAgregarPersonaje";
            laConsulta.Parameters.AddWithValue("@Nombre", Nombre);
            laConsulta.Parameters.AddWithValue("@Categoria", Per.Categoria);
            //laConsulta.Parameters.AddWithValue("@Imagen", Per.Imagen);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                msg = Convert.ToString(elLector["@msg"]);
            }
            Desconectar(unaConexion);

            foreach (Preg pregunta in Per.Preguntas)
            {
                //      CargarRta(Per, pregunta);
            }
            return msg;
        }
        //Trae la persona rehecha, y una lista de preguntas, las cuales fueron marcadas como Sí
        public static string ModificarP(string Nombre, Personaje Per)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spModificarPersonaje";
            laConsulta.Parameters.AddWithValue("@Nombre", Nombre);
            laConsulta.Parameters.AddWithValue("@Categoria", Per.Categoria);
            laConsulta.Parameters.AddWithValue("@nuevoNombre", Per.Nombre);
            //laConsulta.Parameters.AddWithValue("@Imagen", Per.Imagen);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);

            foreach (Preg pregunta in Per.Preguntas)
            {
                CargarRta(Per, pregunta);
            }
            return msg;
        }

        public static void CargarCats()
        {
            Categorias = new List<string>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerCats";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Categorias.Add(Convert.ToString(elLector["Categoria"]));
            }
            Desconectar(unaConexion);
        }
        public static void CargarGrupos()
        {
            Grupos = new List<string>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerGrupos";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Grupos.Add(Convert.ToString(elLector["Nombre"]));
                PregsXGrupos.Add(Convert.ToString(elLector["Nombre"]),new List<Preg>());
            }
            Desconectar(unaConexion);
        }
        public static void CargarPersonajes()
        {
            Personajes = new List<Personaje>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerPersonajes";
            laConsulta.Parameters.AddWithValue("@Categoria", "Todos");
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Personajes.Add(new Personaje(Convert.ToInt32(elLector["idPersona"]), Convert.ToString(elLector["Nombre"]), "", Convert.ToString(elLector["Categoria"])));
            }
            Desconectar(unaConexion);
        }
        public static void CargarPersonajes(string Categoria)
        {
            Personajes = new List<Personaje>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerPersonajes";
            laConsulta.Parameters.AddWithValue("@Categoria", Categoria);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Personajes.Add(new Personaje(Convert.ToInt32(elLector["Id"]), Convert.ToString(elLector["Nombre"]), "", Convert.ToString(elLector["Categoria"])));
            }
            Desconectar(unaConexion);
        }
        public static void CargarPreguntas()
        {
            Preguntas = new List<Preg>();
            PregsXGrupos = new Dictionary<string, List<Preg>>();
            CargarGrupos();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerPreguntas";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Preg Pregunta = new Preg(Convert.ToInt32(elLector["idPregunta"]), Convert.ToString(elLector["Texto"]), Convert.ToString(elLector["Nombre"]));
                Preguntas.Add(Pregunta);
                PregsXGrupos[Pregunta.Grupo].Add(Pregunta);
            }
            Desconectar(unaConexion);
        }

        public static Usuario Login(string User, string Pass)
        {
            string Nombre = "", email = "", pass = "", username = "", Mac = "", IpPublica = "";
            int Puntos = 0;
            bool Admin = false;
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spLogin";

            laConsulta.Parameters.AddWithValue("@Username", User);
            laConsulta.Parameters.AddWithValue("@Password", Pass);


            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                if (elLector["msg"].ToString() == "OK")
                {
                    Nombre = (elLector["Nombre"].ToString());
                    msg = (elLector["msg"].ToString());
                    email = (elLector["Mail"].ToString());
                    pass = (elLector["Pass"].ToString());
                    Mac = (elLector["mac"].ToString());
                    IpPublica = (elLector["Ip1"].ToString());
                    username = (elLector["Username"].ToString());
                    Admin = Convert.ToBoolean(elLector["Administrador"]);
                    Puntos = Convert.ToInt32(elLector["Puntos"]);
                }
                else if (elLector["msg"].ToString() != "OK")

                {
                    msg = (elLector["msg"].ToString());
                }



            }
            Usuario Usu = new Usuario(Nombre, username, pass, Puntos, IpPublica, email, Mac,Admin);


            Desconectar(unaConexion);
            return Usu;

        }

     /*   public static Usuario Register(Usuario usu)
        {      
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spRegister";

            laConsulta.Parameters.AddWithValue("@Username", User);
            laConsulta.Parameters.AddWithValue("@Password", Pass);


            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                if (elLector["msg"].ToString() == "OK")
                {
                    Nombre = (elLector["Nombre"].ToString());
                    msg = (elLector["msg"].ToString());
                    email = (elLector["Mail"].ToString());
                    pass = (elLector["Pass"].ToString());
                    Mac = (elLector["mac"].ToString());
                    IpPublica = (elLector["Ip1"].ToString());
                    username = (elLector["Username"].ToString());
                    Puntos = Convert.ToInt32(elLector["Puntos"]);
                }
                else if (elLector["msg"].ToString() != "OK")

                {
                    msg = (elLector["msg"].ToString());
                }



            }
            Usuario Usu = new Usuario(Nombre, username, pass, Puntos, IpPublica, email, Mac);


            Desconectar(unaConexion);
            return Usu;

        }*/
    }

         
    
}