using System;
using System.Collections.Generic;

namespace ElectronicsStore.Models;

public partial class Product
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public short CategoryId { get; set; }

    public decimal Price { get; set; }

    public int StockQuantity { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<OrderContent> OrderContents { get; set; } = new List<OrderContent>();

    public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; } = new List<ShoppingCart>();
}
