﻿using System;
using System.Collections.Generic;

namespace ElectronicsStore.Models;

public partial class OrderContent
{
    public long OrderId { get; set; }

    public int ProductId { get; set; }

    public int Quantity { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
