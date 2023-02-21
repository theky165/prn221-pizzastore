using System;
using System.Collections.Generic;

namespace SignalRAssignment.Models;

public partial class Customer
{
    public int CustomerId { get; set; }

    public string Password { get; set; } = null!;

    public string? ContactName { get; set; }

    public byte[]? Address { get; set; }

    public string? Phone { get; set; }

    public virtual ICollection<Order> Orders { get; } = new List<Order>();
}
