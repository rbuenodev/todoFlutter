namespace todoApi.src
{
    public class Env
    {
        public string DatabaseConnection { get; set; }
        public string DevDatabaseConnection { get; set; }

        public Env()
        {
            DatabaseConnection = Environment.GetEnvironmentVariable("DATABASE_CONNECTION");
            DevDatabaseConnection = Environment.GetEnvironmentVariable("DEV_DATABASE_CONNECTION");
        }
    }
}
