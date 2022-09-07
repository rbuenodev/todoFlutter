﻿using todoApi.src.Repositories.Todo.DTOs;
using todoApi.src.Repositories.Todo.Repository;

namespace todoApi.src.Services
{

    public class TodoService
    {
        private readonly ITodoRepository _todoRepository;
        public TodoService(ITodoRepository todorepository)
        {
            _todoRepository = todorepository;
        }
        public Models.Todo Create(CreateTodoDto todo)
        {
            var newTodo = new Models.Todo(todo.Description, todo.CreatedAt, todo.Status, todo.CompletionDate);
            newTodo.Validate();
            return _todoRepository.Create(newTodo);
        }

        public bool Delete(int id)
        {
            return _todoRepository.Delete(id);
        }

        public List<Models.Todo> FindAll()
        {
            return _todoRepository.FindAll();
        }

        public Models.Todo? FindById(int id)
        {
            return _todoRepository.FindById(id);
        }

        public Models.Todo? Update(UpdateTodoDto todo)
        {
            var updatedTodo = FindById(todo.Id);
            if (updatedTodo == null)
                return null;

            updatedTodo.Description = todo.Description;
            updatedTodo.CreatedAt = todo.CreatedAt;
            updatedTodo.Status = todo.Status;
            updatedTodo.CompletionDate = todo.CompletionDate;
            updatedTodo.Validate();

            return _todoRepository.Update(updatedTodo);
        }
    }
}
