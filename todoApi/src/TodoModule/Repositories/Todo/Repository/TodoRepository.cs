using todoApi.src.Repositories.Todo.Context;
using todoApi.src.Repositories.Todo.DTOs;

namespace todoApi.src.Repositories.Todo.Repository
{
    public class TodoRepository : ITodoRepository
    {
        private readonly TodoContext _todoContext;
        public TodoRepository(TodoContext todoContext)
        {
            _todoContext = todoContext;
        }
        public Models.Todo Create(Models.Todo todo)
        {
            var newTodo = new Entity.TodoEntity(todo.Description, todo.CreatedAt, todo.Status, todo.CompletionDate);
            try
            {
                _todoContext.Add(newTodo);
                _todoContext.SaveChanges();
            }
            catch (Exception)
            {
                throw;
            }
            todo.Id = newTodo.Id;
            return todo;
        }

        public bool Delete(int id)
        {
            var todo = _todoContext.Todos.Where((id) => id.Equals(id)).FirstOrDefault();
            if (todo == null)
                return false;
            try
            {
                _todoContext.Remove(todo);
                _todoContext.SaveChanges();
            }
            catch (Exception)
            {

                throw;
            }
            return true;
        }

        public List<Models.Todo> FindAll()
        {
            var list = _todoContext.Todos.Select(t => new Models.Todo { Id = t.Id, Description = t.Description, CreatedAt = t.CreatedAt, CompletionDate = t.CompletionDate, Status = t.Status }).ToList();
            return list;
        }

        public Models.Todo? FindById(int id)
        {
            var todo = _todoContext.Todos.Where(t => t.Id == id).Select(t => new Models.Todo { Id = t.Id, Description = t.Description, CreatedAt = t.CreatedAt, CompletionDate = t.CompletionDate, Status = t.Status }).SingleOrDefault();
            return todo;
        }

        public Models.Todo? Update(Models.Todo todo)
        {
            var updateEntity = _todoContext.Todos.Where(t => t.Id == todo.Id).SingleOrDefault();
            if (updateEntity == null) return null;
            try
            {
                updateEntity.Description = todo.Description;
                updateEntity.CreatedAt = todo.CreatedAt;
                updateEntity.CompletionDate = todo.CompletionDate;
                updateEntity.Status = todo.Status;
                _todoContext.SaveChanges();
            }
            catch (Exception)
            {
                throw;
            }

            return todo;
        }
    }
}
