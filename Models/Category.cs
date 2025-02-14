using System;
using System.Collections.Generic;

namespace ElectronicsStore.Models;

public partial class Category
{
    public short Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
