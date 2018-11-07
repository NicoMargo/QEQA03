using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Text;

namespace QEQ.Models
{
    public static class BD
    {


        public static string connectionString = "Server=10.128.8.16;User=QEQA03;Password=QEQA03;Database=QEQA03"; //Ort

       // public static string connectionString = @"Server=DESKTOP-5P28OS5\SQLEXPRESS;Database=QEQA03;Trusted_Connection=True;"; //Anush
       // public static string connectionString = @"Server=DESKTOP-P6PCH8N\SQLEXPRESS;Database=QEQA03;Trusted_Connection=True;"; //Chino


       
    

        public static string msg;
        public static List<Preg> Preguntas;//sp Traer Preguntas
        public static List<Personaje> Personajes;//Sp traer personajes
        //public static List<string> Categorias;//sp Traer Cats
        //public static List<string> Grupos;//sp Traer grupos
        public static List<Cat> Categorias;//sp Traer Cats
        public static List<Cat> Grupos;//sp Traer grupos
        public static List<Rta> Respuestas;//sp traer Ras
        public static Dictionary<string, List<Preg>> PregsXGrupos;
       

        
        public static Preg BuscarPregunta(int id)
        {
            Preg pregunta = null;
            int i = 0;
            while (i < Preguntas.Count() && pregunta == null)
            {
                if (Preguntas[i].Id == id)
                {
                    pregunta = Preguntas[i];
                }
                else
                {
                    i++;
                }
            }
            return pregunta;
        }
        public static Personaje BuscarPersonaje(string Nombre)
        {
            Personaje personaje = null;
            int i = 0;
            while (i < Personajes.Count() && personaje == null)
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

        public static Personaje BuscarPersonaje(int id)
        {
            Personaje personaje = null;
            int i = 0;
            while (i < Personajes.Count() && personaje == null)
            {
                if (Personajes[i].Id == id)
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
        public static Cat BuscarCat(int id,List<Cat> Cats)
        {
            Cat grupo = null;
            int i = 0;
            while (i < Cats.Count() && grupo == null)
            {
                if (Cats[i].Id == id)
                {
                    grupo = Cats[i];
                }

                else
                {
                    i++;
                }
            }
            return grupo;
        }




        //Action REsults------------------------------------------------------------------------------------------------------------------------------------
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
            laConsulta.Parameters.AddWithValue("@idCategoria", Per.idCategoria);
            laConsulta.Parameters.AddWithValue("@Foto", Per.FotoByte);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
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
        //Trae la persona rehecha, y una lista de preguntas, las cuales fueron marcadas como Sí
        public static string ModificarP(Personaje Per)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spModificarPersonaje";
            laConsulta.Parameters.AddWithValue("@Id", Per.Id);
            laConsulta.Parameters.AddWithValue("@idCategoria", Per.idCategoria);
            laConsulta.Parameters.AddWithValue("@nuevoNombre", Per.Nombre);
            laConsulta.Parameters.AddWithValue("@Foto", Per.FotoByte);
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

        public static string BorrarP(int id)
        {
            string msg = "";
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spEliminarPersonaje";
            laConsulta.Parameters.AddWithValue("@Id", id);
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
            if (tipo) { sp = "spCrearCat"; }
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
        public static string ModificarCat(Cat cat, bool tipo)
        {

            string msg = "";
            string pCat;
            string pNewCat;
            string sp;
            //tipo true es cat, false es grupo
            if (tipo)
            {//p significa parametro
                pCat = "@idCategoria";
                pNewCat = "@newCategoria";
                sp = "spModificarCategoria";
            }
            else
            {
                pCat = "@idGrupo";
                pNewCat = "@newGrupo";
                sp = "spModificarGrupo";
            }
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = sp;
            laConsulta.Parameters.AddWithValue(pCat, cat.Id);
            laConsulta.Parameters.AddWithValue(pNewCat, cat.Nombre);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }

        public static string BorrarCat(Cat cat, bool tipo)
        {
            string msg = "";
            string sp;
            //tipo true es cat, false es grupo
            if (tipo) { sp = "spEliminarCat"; }
            else { sp = "spEliminarGrupo"; }
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = sp;
            laConsulta.Parameters.AddWithValue("@id", cat.Id);
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
            laConsulta.Parameters.AddWithValue("@idGrupo", Pre.idGrupo);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }
        //Trae la persona rehecha, y una lista de preguntas, las cuales fueron marcadas como Sí
        public static string ModificarCar(Preg Car)
        {
            string msg = "";

            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spModificarPregunta";
            laConsulta.Parameters.AddWithValue("@idPregunta", Car.Id);
            laConsulta.Parameters.AddWithValue("@idGrupo", Car.idGrupo);
            laConsulta.Parameters.AddWithValue("@nuevoTexto", Car.Texto);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                msg = Convert.ToString(elLector["msg"]);
            }
            Desconectar(unaConexion);
            return msg;
        }

        public static string BorrarCar(Preg preg)
        {
            string msg = "";
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spEliminarPregunta";
            laConsulta.Parameters.AddWithValue("@idPregunta", preg.Id);
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
            Categorias = new List<Cat>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerCats";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Categorias.Add(new Cat(Convert.ToInt32(elLector["idCategoria"]),Convert.ToString(elLector["Categoria"])));
            }
            Desconectar(unaConexion);
        }
        public static void CargarGrupos()
        {
            Grupos = new List<Cat>();
            PregsXGrupos = new Dictionary<string, List<Preg>>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerGrupos";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Grupos.Add(new Cat(Convert.ToInt32(elLector["idGrupo"]), Convert.ToString(elLector["Nombre"])));
                PregsXGrupos.Add(Convert.ToString(elLector["Nombre"]), new List<Preg>());
            }
            Desconectar(unaConexion);
        }
        public static void CargarPersonajes()
        {
            byte[] foto;
            string Direccion;
            Personajes = new List<Personaje>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerPersonajes";
            laConsulta.Parameters.AddWithValue("@idCategoria",0);
         
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {      try
                {
                    foto = (byte[])elLector["Foto"];
                    Direccion = "data:Image/png;base64," + Convert.ToBase64String(foto);
                }  catch(NullReferenceException)
                {
                    foto = null;
                    Direccion = "";
                }
               
                Personajes.Add(new Personaje(Convert.ToInt32(elLector["idPersona"]), Convert.ToString(elLector["Nombre"]), null, Convert.ToInt32(elLector["idCategoria"]),Direccion, (byte[])elLector["Foto"]));

            }

            Desconectar(unaConexion);
        }
        public static void CargarPersonajes(int idCategoria)
        {
            Personajes = new List<Personaje>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerPersonajes";
            laConsulta.Parameters.AddWithValue("@idCategoria", idCategoria);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            byte[] bfoto;
            string sfoto;
            while (elLector.Read())
            {
                try
                {
                    bfoto = (byte[])elLector["Foto"];
                    sfoto = "data:Image/png;base64," + Convert.ToBase64String(bfoto);
                }
                catch (NullReferenceException)
                {
                    bfoto = null;
                    sfoto = "";
                }
                Personajes.Add(new Personaje(Convert.ToInt32(elLector["idPersona"]), Convert.ToString(elLector["Nombre"]), null, Convert.ToInt32(elLector["idCategoria"]), sfoto, (byte[])elLector["Foto"]));
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
                Preg Pregunta = new Preg(Convert.ToInt32(elLector["idPregunta"]), Convert.ToString(elLector["Texto"]), Convert.ToInt32(elLector["idGrupo"]));
                Preguntas.Add(Pregunta);
                PregsXGrupos[BuscarCat(Pregunta.idGrupo,Grupos).Nombre].Add(Pregunta);
            }
            Desconectar(unaConexion);
        }

        public static Usuario Login(string User, string Pass, string Ip, string mac)
        {
            string Nombre = "", email = "", pass = "", username = "", Mac = "", IpPublica = "";
            int Puntos = 0, regs;
            bool Admin = false;
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spLogin";
            laConsulta.Parameters.AddWithValue("@Username", User);
            laConsulta.Parameters.AddWithValue("@Password", Pass);
            laConsulta.Parameters.AddWithValue("@Mac", mac);
            laConsulta.Parameters.AddWithValue("@Ip", Ip);


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
            elLector.Close();
            regs = laConsulta.ExecuteNonQuery();
            Usuario Usu = new Usuario(Nombre, username, pass, Puntos, IpPublica, email, Mac, Admin);


            Desconectar(unaConexion);
            return Usu;

        }

        public static int ModificarUsu(Usuario usu, string usuviejo, string PassVieja)
        {
            int regs;
            Usuario usuViejo = BD.Login(usuviejo, PassVieja,usu.Ip, usu.Mac);
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
                    laConsulta.Parameters.AddWithValue("@NuevaPass", "a");
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
                regs = -2;
            }  
                      
            return regs;
        }


           public static int Register(Usuario usu)
           {           
               SqlConnection unaConexion = Conectar();
               SqlCommand laConsulta = unaConexion.CreateCommand();
               laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
               laConsulta.CommandText = "spRegister";
            laConsulta.Parameters.AddWithValue("@Username", usu.Username);
            laConsulta.Parameters.AddWithValue("@Password", usu.Pass);
            laConsulta.Parameters.AddWithValue("@Nomb", usu.Nombre);
            laConsulta.Parameters.AddWithValue("@Mail", usu.Email);
            laConsulta.Parameters.AddWithValue("@Admin", usu.Admin);
            laConsulta.Parameters.AddWithValue("@mac", usu.Mac);
            laConsulta.Parameters.AddWithValue("@Ip1", usu.Ip);
            int  regs = laConsulta.ExecuteNonQuery();                   
               Desconectar(unaConexion);
               return regs;
           }
    }



}