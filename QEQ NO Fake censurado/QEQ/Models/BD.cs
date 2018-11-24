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


        //public static string connectionString = "Server=10.128.8.16;User=QEQA03;Password=QEQA03;Database=QEQA03"; //Ort
        public static string connectionString = @"Server=DESKTOP-5P28OS5;Database=QEQA03;Trusted_Connection=True;"; //Anush
        //public static string connectionString = @"Server=DESKTOP-P6PCH8N\SQLEXPRESS;Database=QEQA03;Trusted_Connection=True;"; //Chino

        public static Usuario usuario =new Usuario(0,"invitado","Guest","","","","",false);
        public static string msg;
        public static List<Preg> Preguntas;//sp Traer Preguntas
        public static List<Personaje> Personajes;//Sp traer personajes
        //public static List<string> Categorias;//sp Traer Cats
        //public static List<string> Grupos;//sp Traer grupos
        public static List<Cat> Categorias;//sp Traer Cats
        public static List<Cat> Grupos;//sp Traer grupos
        public static List<Rta> Respuestas;//sp traer Ras
        public static Dictionary<string, List<Preg>> PregsXGrupos;
        public static Partida laPartida;
        public static List<Partida> Ranking;
        public static List<Usuario> Usuarios;
        public static List<Partida> Partidas; 

        //Funciones de utilidad================
        public static Preg BuscarPregunta(int id)
        {
            Preg pregunta = null;
            int i = 0;
            while (i < Preguntas.Count && pregunta == null)
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
            while (i < Personajes.Count && personaje == null)
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
        public static Cat BuscarCat(int id, List<Cat> Cats)
        {
            Cat grupo = null;
            int i = 0;
            while (i < Cats.Count && grupo == null)
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

        public static Usuario BuscarUsuario(int id)
        {
            Usuario user = null;
            int i = 0;
            while (i < Usuarios.Count && user == null)
            {
                if (Usuarios[i].Id == id)
                {
                    user = Usuarios[i];
                }

                else
                {
                    i++;
                }
            }
            return user;
        }

        public static bool CompararPreg(Preg pregunta, List<Preg> pregs) {
            bool found = false;
            int i = 0;
            while (!found && i < pregs.Count())
            {
                if (pregs[i].Id == pregunta.Id) { found = true; }
                else { i++; }
            }

            return found;
        }

        public static Partida BuscarPartida(int id) {
            Partida partida = new Partida();
            int i = 0;
            while (i < Partidas.Count && partida == new Partida())
            {
                if (Partidas[i].Id == id)
                {
                    partida = Partidas[i];
                }

                else
                {
                    i++;
                }
            }
            return partida;
        }
        //Funciones para la bd=====================================================================================
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
        //Stores de ABM==============================================================================================
        public static void CrearRta(Personaje Per, Preg pregunta)
        {
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spCargarRespuestas";
            laConsulta.Parameters.AddWithValue("@idPersonaje", Per.Id);
            laConsulta.Parameters.AddWithValue("@idPregunta", pregunta.Id);
            laConsulta.ExecuteNonQuery();
            Desconectar(unaConexion);
        }
        //Trae una nueva persona, y una lista de preguntas, las cuales fueron marcadas como Sí
        public static string AgregarP(Personaje Per)
        {
            string msg = "";
            int id = -1;
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
                id = Convert.ToInt32(elLector["idPersona"]);
            }
            Desconectar(unaConexion);
            if (msg == "")
            {

                Per.Id = id;
                foreach (Preg pregunta in Per.Preguntas)
                {
                    if (pregunta.Id != -1) { CrearRta(Per, pregunta); }
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
            if (msg != "La id no Corresponde a ningun personaje")
            {
                foreach (Preg pregunta in Per.Preguntas)
                {
                    if (pregunta.Id != -1) { CrearRta(Per, pregunta); }
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
            laConsulta.Parameters.AddWithValue("@Puntos", Pre.Puntos);
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
            laConsulta.Parameters.AddWithValue("@Puntos", Car.Puntos);
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

        //Stores de cargado=================================================================================================================================
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
                Categorias.Add(new Cat(Convert.ToInt32(elLector["idCategoria"]), Convert.ToString(elLector["Categoria"])));
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
            { try
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

        public static List<Preg> CargarRxP(int idP) {
            List<Preg> pregs = new List<Preg>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerRxP";
            laConsulta.Parameters.AddWithValue("@idPersona", idP);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                pregs.Add(new Preg(Convert.ToInt32(elLector["idPregunta"]), elLector["Texto"].ToString(), Convert.ToInt32(elLector["idGrupo"]), Convert.ToInt32(elLector["Puntos"])));
            }
            return pregs;
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
                Preg Pregunta = new Preg(Convert.ToInt32(elLector["idPregunta"]), Convert.ToString(elLector["Texto"]), Convert.ToInt32(elLector["idGrupo"]),Convert.ToInt32(elLector["Puntos"]));
                Preguntas.Add(Pregunta);
                PregsXGrupos[BuscarCat(Pregunta.idGrupo, Grupos).Nombre].Add(Pregunta);
            }
            Desconectar(unaConexion);
        }

        public static void CargarUsuarios() {
            Usuarios = new List<Usuario>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerUsuarios";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Usuarios.Add(new Usuario(Convert.ToInt32(elLector["idUsuarios"]),elLector["Username"].ToString(),elLector["Nombre"].ToString()));
            }
            Desconectar(unaConexion);
        }

        //Manipulacion de Usuarios=====================================================================================
        public static Usuario Login(string User, string Pass, string Ip, string mac)
        {
            string Nombre = "", email = "", pass = "", username = "", Mac = "", IpPublica = "";
            int id = 0;
            int regs;
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
                    id = Convert.ToInt32(elLector["idUsuarios"]);
                    Nombre = (elLector["Nombre"].ToString());
                    msg = (elLector["msg"].ToString());
                    email = (elLector["Mail"].ToString());
                    pass = (elLector["Pass"].ToString());

                    username = (elLector["Username"].ToString());
                    Admin = Convert.ToBoolean(elLector["Administrador"]);


                }
                else if (elLector["msg"].ToString() != "OK")

                {
                    msg = (elLector["msg"].ToString());
                }
            }
            elLector.Close();
            regs = laConsulta.ExecuteNonQuery();
            Usuario Usu = new Usuario(id, Nombre, username, pass, IpPublica, email, Mac, Admin);


            Desconectar(unaConexion);
            return Usu;

        }

        public static int ModificarUsu(Usuario usu, string usuviejo, string PassVieja)
        {
            int regs;
            Usuario usuViejo = BD.Login(usuviejo, PassVieja, usu.Ip, usu.Mac);
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
            int regs = laConsulta.ExecuteNonQuery();
            Desconectar(unaConexion);
            return regs;
        }

        //Ranking
        public static void Rank() {
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spRanking";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            Ranking = new List<Partida>();
            while (elLector.Read())
            {
                Ranking.Add(new Partida(Convert.ToInt32(elLector["idPartida"]), Convert.ToInt32(elLector["idUsuario1"]),"", Convert.ToInt32(elLector["idPer1"]), Convert.ToInt32(elLector["Puntos"]), Convert.ToInt32(elLector["Preguntas"]), Convert.ToBoolean(elLector["Ganador"]), Convert.ToDateTime(elLector["Fecha"])));
                int tinter = Convert.ToInt32(elLector["idPer1"]);
            } 
            Desconectar(unaConexion);
        }
    
        //Fin del ranking
        //Game1=============================================================================================================================

        public static void GuardarPartida1(Partida partida) {
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spGuardarPartida1";
            laConsulta.Parameters.AddWithValue("@Usuario", partida.Usuario1);
            laConsulta.Parameters.AddWithValue("@cantPregunta", partida.CantPreguntas);
            laConsulta.Parameters.AddWithValue("@fecha", partida.Fecha);
            laConsulta.Parameters.AddWithValue("@ip", partida.Ip1);
            laConsulta.Parameters.AddWithValue("@Ganador", partida.Ganador);
            laConsulta.Parameters.AddWithValue("@idPersonaje", partida.Personaje1.Id);
            laConsulta.Parameters.AddWithValue("@Puntos", partida.Puntos);
            int regs = laConsulta.ExecuteNonQuery();
            Desconectar(unaConexion);
        }
        public static void CargarRtas(int idCat)
        {
            Respuestas = new List<Rta>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spTraerRespuestas";
            laConsulta.Parameters.AddWithValue("@idCategoria", idCat);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Respuestas.Add(new Rta(Convert.ToInt32(elLector["idRespuestas"]), Convert.ToInt32(elLector["idPregunta"]), Convert.ToInt32(elLector["idPersona"])));

            }
            Desconectar(unaConexion);
        }

        //Game 2===============================================================================================================================
        public static void CargarPartidas()
        {
            Partidas = new List<Partida>();
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spBuscarPartidas";
            SqlDataReader elLector = laConsulta.ExecuteReader();
            while (elLector.Read())
            {
                Partidas.Add(new Partida(Convert.ToInt32(elLector["idPartida"]), Convert.ToInt32(elLector["idUsuario1"]), elLector["idPersona"].ToString(),Convert.ToInt32(elLector["idCategoria"])));
            }
            Desconectar(unaConexion);
        }

        public static void CrearPartida(Partida partida)
        {
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spCrearPartida";
            laConsulta.Parameters.AddWithValue("@IdUsuarioHost", partida.Usuario1);
            laConsulta.Parameters.AddWithValue("@IpHost", partida.Ip1);
            laConsulta.Parameters.AddWithValue("@idCat", partida.IdCat);
            laConsulta.ExecuteNonQuery();
            Desconectar(unaConexion);
        }

        public static void Unirse(int idPartida)
        {
            bool exito = false;
            SqlConnection unaConexion = Conectar();
            SqlCommand laConsulta = unaConexion.CreateCommand();
            laConsulta.CommandType = System.Data.CommandType.StoredProcedure;
            laConsulta.CommandText = "spUnirse";
            laConsulta.Parameters.AddWithValue("@IdPartida", idPartida);
            laConsulta.Parameters.AddWithValue("@IdUsuario2", usuario.Id);
            laConsulta.Parameters.AddWithValue("@Ip2", usuario.Ip);
            SqlDataReader elLector = laConsulta.ExecuteReader();
            if (elLector.Read())
            {
                exito = Convert.ToBoolean(elLector["exito"]);
            }
            Desconectar(unaConexion);
            if (exito) {
                BD.CargarPartidas();
                BD.laPartida = BuscarPartida(idPartida);
            }
        }
    }



}