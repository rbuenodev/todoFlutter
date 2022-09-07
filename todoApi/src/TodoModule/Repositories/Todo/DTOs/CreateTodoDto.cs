namespace todoApi.src.Repositories.Todo.DTOs
{
    public class CreateTodoDto
    {
        public string Description { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime CompletionDate { get; set; }
        public int Status { get; set; }

        public CreateTodoDto() { }
    }
}
