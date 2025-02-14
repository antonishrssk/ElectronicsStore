using ElectronicsStore.Models;

namespace ElectronicsStore;

public static class Data
{
    public static User? User;
    public static bool IsUserLoggedIn = false;
    public static bool IsGuest = false;

    public static Product? NewProduct;
}
