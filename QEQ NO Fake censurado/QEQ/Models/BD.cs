using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace QEQ.Models
{
    public static class BD
    {
        //public static string connectionString = "Server=10.128.8.16;User=QEQA03;Password=QEQA03;Database=QEQA03"; //Ort
        public static string connectionString = @"Server=DESKTOP-5P28OS5\SQLEXPRESS;Database=QEQA03;Trusted_Connection=True;"; //Anush
                                                                                                                               // public static string connectionString = "Server=.;Database=QEQ;Trusted_Connection=True;"; //chino
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

        public static Personaje BuscarPersonaje(string Nombre)
        {
            Personaje personaje = null;
            int i = 0;
            while (i < Preguntas.Count() && personaje == null)
            {
                if (Personajes[i].Nombre == Nombre)
                {
                    personaje = Personajes[i];
                }

                else
                {
                    i++;
                }
            }
            return personaje;
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
        public static string AgregarP(Personaje Per)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spCrearPersonaje";
            laConsulta.Parameters.AddWithValue("@Nombre", Per.Nombre);
            laConsulta.Parameters.AddWithValue("@Categoria", Per.Categoria);
            laConsulta.Parameters.AddWithValue("@Imagen", "" /*Per.Imagen*/);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                msg = Convert.ToString(elLector["@msg"]);
            }
            Desconectar(unaConexion);
            if (msg == "")
            {
                foreach (Preg pregunta in Per.Preguntas)
                {
                    //      CargarRta(Per, pregunta);
                }
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
            laConsulta.Parameters.AddWithValue("@Imagen", ""/*Per.Imagen*/);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            if (msg == "")
            {
                foreach (Preg pregunta in Per.Preguntas)
                {
                    CargarRta(Per, pregunta);
                }
            }
            return msg;
        }

        public static string BorrarP(string Nombre)
        {
            string msg = "";
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spEliminarPersonaje";
            laConsulta.Parameters.AddWithValue("@Nombre", Nombre);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }

        public static string AgregarCat(string Cat, bool tipo)
        {
            string msg = "";
            string sp;
            //tipo true es cat, false es grupo
            if (tipo) { sp = "spCrearCategoria"; }
            else { sp = "spCrearGrupo"; }
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = sp;
            laConsulta.Parameters.AddWithValue("@Nombre", Cat);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }
        public static string ModificarCat(string Cat, string newCat, bool tipo)
        {

            string msg = "";
            string pCat;
            string pNewCat;
            string sp;
            //tipo true es cat, false es grupo
            if (tipo)
            {//p significa parametro
                pCat = "@Categoria";
                pNewCat = "@newCategoria";
                sp = "spModificarCategoria";
            }
            else
            {
                pCat = "@Grupo";
                pNewCat = "@newGrupo";
                sp = "spModificarGrupo";
            }
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = sp;
            laConsulta.Parameters.AddWithValue(pCat, Cat);
            laConsulta.Parameters.AddWithValue(pNewCat, newCat);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }

        public static string BorrarCat(string Cat, bool tipo)
        {
            string msg = "";
            string sp;
            //tipo true es cat, false es grupo
            if (tipo) { sp = "spEliminarCategoria"; }
            else { sp = "spEliminarGrupo"; }
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = sp;
            laConsulta.Parameters.AddWithValue("@Nombre", Cat);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }

        public static string AgregarCar(Preg Pre)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spCrearPregunta";
            laConsulta.Parameters.AddWithValue("@Texto", Pre.Texto);
            laConsulta.Parameters.AddWithValue("@Grupo", Pre.Grupo);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["@msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }
        //Trae la persona rehecha, y una lista de preguntas, las cuales fueron marcadas como Sí
        public static string ModificarCar(string texto, Preg Car)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spModificarPreg";
            laConsulta.Parameters.AddWithValue("@idPregunta", BuscarPregunta(texto).Id);
            laConsulta.Parameters.AddWithValue("@Grupo", Car.Grupo);
            laConsulta.Parameters.AddWithValue("@nuevoTexto", Car.Texto);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }

        public static string BorrarCar(string texto)
        {
            string msg = "";
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spEliminarPregunta";
            laConsulta.Parameters.AddWithValue("@idPregunta", BuscarPregunta(texto).Id);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
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
            PregsXGrupos = new Dictionary<string, List<Preg>>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerGrupos";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Grupos.Add(Convert.ToString(elLector["Nombre"]));
                PregsXGrupos.Add(Convert.ToString(elLector["Nombre"]), new List<Preg>());
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

                    username = (elLector["Username"].ToString());
                    Admin = Convert.ToBoolean(elLector["Administrador"]);
                    Puntos = Convert.ToInt32(elLector["Puntos"]);
                }
                else if (elLector["msg"].ToString() != "OK")

                {
                    msg = (elLector["msg"].ToString());
                }



            }
            Usuario Usu = new Usuario(Nombre, username, pass, Puntos, IpPublica, email, Mac, Admin);


            Desconectar(unaConexion);
            return Usu;

        }

        public static int ModificarUsu(Usuario usu, string usuviejo, string PassVieja)
        {
            int regs;
            Usuario usuViejo = BD.Login(usuviejo, PassVieja);
            if (usuViejo.Username != "")
            {
                SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spModificarUsuario";
            laConsulta.Parameters.AddWithValue("@Username", usuviejo);
            
            
                if (usu.Username == null)
                {
                    laConsulta.Parameters.AddWithValue("@nuevoUsername", usuViejo.Username);
                }
                else
                {
                    laConsulta.Parameters.AddWithValue("@nuevoUsername", usu.Username);
                }

                if (usu.Pass == null)
                {
                    laConsulta.Parameters.AddWithValue("@NuevaPass", 1);
                }
                else
                {
                    laConsulta.Parameters.AddWithValue("@NuevaPass", usu.Pass);
                }

                if (usu.Nombre == null)
                {
                    laConsulta.Parameters.AddWithValue("@nuevoNombre", usuViejo.Nombre);
                }
                else
                {
                    laConsulta.Parameters.AddWithValue("@nuevoNombre", usu.Nombre);
                }

                if (usu.Email == null)
                {
                    laConsulta.Parameters.AddWithValue("@nuevoMail", usuViejo.Email);
                }
                else
                {
                    laConsulta.Parameters.AddWithValue("@nuevoMail", usu.Email);
                }
                regs = laConsulta.ExecuteNonQuery();
                Desconectar(unaConexion);
            } else
            {
                regs = 0;
            }  
                      
            return regs;
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