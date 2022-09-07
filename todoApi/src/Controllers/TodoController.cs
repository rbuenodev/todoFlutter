using Microsoft.AspNetCore.Mvc;
using todoApi.src.Repositories.Todo.DTOs;
using todoApi.src.Services;

namespace todoApi.src.Controllers
{
    [ApiController]
    [Route("api/todo")]
    public class TodoController : ControllerBase
    {
        private readonly TodoService _todoService;

        public TodoController(TodoService todoService)
        {
            _todoService = todoService;
        }


        [HttpGet]
        [ProducesResponseType((200), Type = typeof(List<Models.Todo>))]
        [ProducesResponseType(404)]
        public IActionResult GetAll()
        {
            return Ok(_todoService.FindAll());
        }

        [HttpGet("{id}")]
        [ProducesResponseType((200), Type = typeof(Models.Todo))]
        [ProducesResponseType(404)]
        public IActionResult Get([FromRoute] int id)
        {
            var todo = _todoService.FindById(id);
            if (todo == null) return NotFound();

            return Ok(todo);
        }

        [HttpPost]
        [ProducesResponseType((200), Type = typeof(Models.Todo))]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult Post([FromBody] CreateTodoDto todo)
        {
            if (todo == null)
            {
                return BadRequest();
            }
            return Ok(_todoService.Create(todo));
        }

        [HttpPut]
        [ProducesResponseType((200), Type = typeof(Models.Todo))]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult Put([FromBody] UpdateTodoDto todo)
        {
            if (todo == null)
            {
                return BadRequest();
            }

            var updatedTodo = _todoService.Update(todo);
            if (updatedTodo == null)
                return NotFound();

            return Ok(updatedTodo);
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult Delete([FromRoute] int id)
        {
            return Ok(_todoService.Delete(id));
        }
    }
}
