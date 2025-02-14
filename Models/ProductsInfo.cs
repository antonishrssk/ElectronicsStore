using System;
using System.Collections.Generic;

namespace ElectronicsStore.Models;

public partial class ProductsInfo
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public string Category { get; set; } = null!;

    public decimal Price { get; set; }

    public int StockQuantity { get; set; }
}
