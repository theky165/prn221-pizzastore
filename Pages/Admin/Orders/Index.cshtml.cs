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
    public class IndexModel : PageModel
    {
        private readonly SignalRAssignment.Models.PizzaStoreContext _context;
        public Models.Account Auth { get; set; }

        public IndexModel(SignalRAssignment.Models.PizzaStoreContext context)
        {
            _context = context;
        }

        public IList<Order> Order { get;set; } = default!;

        public async Task<IActionResult> OnGetAsync()
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

            if (_context.Orders != null)
            {
                Order = await _context.Orders
                .Include(o => o.Customer).ToListAsync();
            }

            return Page();
        }
    }
}
