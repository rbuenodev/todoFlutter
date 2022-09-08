namespace todoApi.src.Models
{
    public class Todo
    {
        public int? Id { get; set; }
        public string Description { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime CompletionDate { get; set; }
        public int Status { get; set; }

        public Todo() { }

        public Todo(string description, DateTime createdAt, int status, DateTime completionDate)
        {
            Description = description;
            CreatedAt = createdAt;
            Status = status;
            CompletionDate = completionDate;
        }

        public void Validate()
        {
            if (CreatedAt > CompletionDate)
            {
                throw new Exception("Creation date can't be bigger than completion date");
            }

            if (CompletionDate < CreatedAt)
            {
                throw new Exception("Completion date can't be bigger than creation date");
            }
        }
    }
}
