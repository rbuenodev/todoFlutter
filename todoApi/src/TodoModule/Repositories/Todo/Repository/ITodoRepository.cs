using todoApi.src.Repositories.Todo.DTOs;

namespace todoApi.src.Repositories.Todo.Repository
{
    public interface ITodoRepository
    {
        Models.Todo? FindById(int id);
        List<Models.Todo> FindAll();
        Models.Todo Create(Models.Todo todo);
        Models.Todo? Update(Models.Todo todo);
        bool Delete(int id);
    }
}
