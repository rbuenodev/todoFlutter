using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace todoApi.src.Repositories.Todo.Entity
{
    [Table("todos")]
    public class TodoEntity
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }
        [Column("description"), MaxLength(255)]
        public string Description { get; set; }
        [Column("created_at")]
        public DateTime CreatedAt { get; set; }
        [Column("completion_date")]
        public DateTime CompletionDate { get; set; }
        [Column("status")]
        public int Status { get; set; }

        public TodoEntity(string description, DateTime createdAt, int status, DateTime completionDate)
        {
            Description = description;
            CreatedAt = createdAt;
            Status = status;
            CompletionDate = completionDate;
        }
    }
}
