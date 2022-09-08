namespace todoApi.src.Migration
{
    public static class MigrateDatabase
    {

        public static void Start(string connection)
        {
            try
            {
                var evolveConnection = new Npgsql.NpgsqlConnection(connection);
                var evolve = new Evolve.Evolve(evolveConnection, msg => Console.WriteLine(msg))
                {
                    Locations = new List<string> { "db/migrations", "/db/dataset" },
                    IsEraseDisabled = true,
                };
                evolve.Migrate();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
    }
}
