using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SignalRAssignment.Models;
using System.Text.Json;

namespace SignalRAssignment.Pages.Account
{
    public class OrderModel : PageModel
    {
        private readonly SignalRAssignment.Models.PizzaStoreContext _context;
        [BindProperty]
        public Models.Account Auth { get; set; }
        public OrderModel(SignalRAssignment.Models.PizzaStoreContext context)
        {
            _context = context;
        }
        public IList<Order> Order { get; set; } = default!;
        public async Task<IActionResult> OnGetAsync()
        {
            if (HttpContext.Session.GetString("User") == null)
            {
                return Redirect("/Account/Login");
            }

            Auth = JsonSerializer.Deserialize<Models.Account>(HttpContext.Session.GetString("User"));

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
                Order = await _context.Orders.Where(o => o.CustomerId == Auth.AccountId)
                .Include(o => o.Customer).ToListAsync();
                //Order = await _context.Orders.Where(o => o.CustomerId == Auth.AccountId).ToListAsync();
            }

            return Page();
        }
    }
}
