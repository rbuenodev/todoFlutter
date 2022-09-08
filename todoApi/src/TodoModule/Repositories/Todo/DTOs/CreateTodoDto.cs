namespace todoApi.src.Repositories.Todo.DTOs
{
    public class CreateTodoDto
    {
        public string Description { get; set; }
        public string CreatedAt { get; set; }
        public string CompletionDate { get; set; }
        public int Status { get; set; }

        public CreateTodoDto() { }
    }
}
