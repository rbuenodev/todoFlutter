using Microsoft.EntityFrameworkCore;
using todoApi.src.Repositories.Todo.Entity;

namespace todoApi.src.Repositories.Todo.Context
{
    public class TodoContext : DbContext
    {
        public TodoContext() { }

        public TodoContext(DbContextOptions<TodoContext> options) : base(options) { }
        public DbSet<TodoEntity> Todos { get; set; }
    }
}
