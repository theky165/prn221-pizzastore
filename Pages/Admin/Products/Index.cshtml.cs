using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SignalRAssignment.Models;

namespace SignalRAssignment.Pages.Admin.Products
{
    public class IndexModel : PageModel
    {
        [BindProperty(SupportsGet = true)]
        public string search { get; set; }
        public List<Models.Product> Product { get; set; }
        public Models.Account Auth { get; set; }

        private readonly SignalRAssignment.Models.PizzaStoreContext _context;

        public IndexModel(SignalRAssignment.Models.PizzaStoreContext context)
        {
            _context = context;
        }
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

            if (_context.Products != null)
            {
                Product = await _context.Products
                .Include(p => p.Category)
                .Include(p => p.Supplier).ToListAsync();
            }

            return Page();
        }

        private List<Models.Product> getAllProducts()
        {
            Product = _context.Products
                .Include(p => p.Category)
                .Include(p => p.Supplier).ToList();

            List<Models.Product> products = new List<Models.Product>();

            if (!String.IsNullOrEmpty(search))
            {
                products = Product.Where(p => p.ProductName.ToLower().Contains(search.ToLower()))
                    .ToList();
            }
            return products;
        }
    }
}
