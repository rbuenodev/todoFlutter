using todoApi.src.Repositories.Todo.Context;
using todoApi.src.Repositories.Todo.Repository;
using Microsoft.EntityFrameworkCore;
using todoApi.src.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<ITodoRepository, TodoRepository>();
builder.Services.AddScoped<TodoService>();
builder.Services.AddCors();

var connection = new todoApi.src.Env().DatabaseConnection;
builder.Services.AddDbContext<TodoContext>(options => options.UseNpgsql(connection));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    var devconnection = new todoApi.src.Env().DevDatabaseConnection;
    if (devconnection != null)
        todoApi.src.Migration.MigrateDatabase.Start(devconnection);
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
