using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SignalRAssignment.Models;
using System.Text.Json;

namespace SignalRAssignment.Pages.Account
{
    public class ProfileModel : PageModel
    {
        private readonly PizzaStoreContext dbContext;

        [BindProperty]
        public Models.Account Auth { get; set; }

        public ProfileModel(PizzaStoreContext dbContext)
        {
            this.dbContext = dbContext;

        }
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
                Auth = await dbContext.Accounts.FirstOrDefaultAsync(a => a.AccountId == Auth.AccountId);
            }

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                Models.Account auth = JsonSerializer.Deserialize<Models.Account>(HttpContext.Session.GetString("User"));

                var acc = await dbContext.Accounts.FirstOrDefaultAsync(a => a.AccountId == auth.AccountId);

                if (acc.AccountId != null)
                {
                    acc = await dbContext.Accounts.FirstOrDefaultAsync(a => a.AccountId == acc.AccountId);
                }

                acc.UserName = Auth.UserName;
                acc.FullName = Auth.FullName;

                await dbContext.SaveChangesAsync();

                HttpContext.Session.Remove("User");
                HttpContext.Session.SetString("User", JsonSerializer.Serialize(auth));

                ViewData["success"] = "Update Successfull";
                return Page();

            }
            catch (Exception e)
            {
                ViewData["fail"] = e.Message;
                return Page();
            }

        }
    }
}
