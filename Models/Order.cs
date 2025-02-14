using System;
using System.Collections.Generic;

namespace ElectronicsStore.Models;

public partial class Order
{
    public long Id { get; set; }

    public int UserId { get; set; }

    public DateTime OrderDate { get; set; }

    public virtual ICollection<OrderContent> OrderContents { get; set; } = new List<OrderContent>();

    public virtual User User { get; set; } = null!;
}
