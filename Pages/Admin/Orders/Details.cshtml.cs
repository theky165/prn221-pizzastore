using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SignalRAssignment.Models;

namespace SignalRAssignment.Pages.Admin.Orders
{
    public class DetailsModel : PageModel
    {
        private readonly SignalRAssignment.Models.PizzaStoreContext _context;
        public Models.Account Auth { get; set; }

        public DetailsModel(SignalRAssignment.Models.PizzaStoreContext context)
        {
            _context = context;
        }

      public Order Order { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (HttpContext.Session.GetString("Staff") == null)
            {
                return Redirect("/Account/Login");
            }

            Auth = JsonSerializer.Deserialize<Models.Account>(HttpContext.Session.GetString("Staff"));

            if (Auth == null)
            {
                return Forbid();
            }
            else
            {
                Auth = await _context.Accounts.FirstOrDefaultAsync(a => a.AccountId == Auth.AccountId);
            }

            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders.FirstOrDefaultAsync(m => m.OrderId == id);
            if (order == null)
            {
                return NotFound();
            }
            else 
            {
                Order = order;
            }
            return Page();
        }
    }
}
