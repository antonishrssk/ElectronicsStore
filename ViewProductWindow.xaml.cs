using System.Windows;
using System.Windows.Controls;
using ElectronicsStore.Models;

namespace ElectronicsStore;

/// <summary>
/// Логика взаимодействия для ViewProductWindow.xaml
/// </summary>
public partial class ViewProductWindow : Window
{
    private readonly ProductsInfo _product;

    public ViewProductWindow(ProductsInfo product)
    {
        InitializeComponent();

        _product = product;
        Title = _product.Name;
    }

    private void Window_Loaded(object sender, RoutedEventArgs e)
    {
        stpProductInfo.DataContext = _product;
        stpAddProductsToCart.IsEnabled = !Data.IsGuest;
    }

    private void btnProductsExcrement_Click(object sender, RoutedEventArgs e)
    {
        if (int.TryParse(tbQuantity.Text, out int amount))
        {
            if (amount > 1)
                tbQuantity.Text = $"{--amount}";
        }
        else tbQuantity.Text = "1";
    }

    private void btnProductsIncrement_Click(object sender, RoutedEventArgs e)
    {
        if (int.TryParse(tbQuantity.Text, out int amount))
        {
            if (amount < 999_999_999)
                tbQuantity.Text = $"{++amount}";
        }
        else tbQuantity.Text = "1";
    }

    private void tbQuantity_TextChanged(object sender, TextChangedEventArgs e)
    {
        if (int.TryParse(tbQuantity.Text, out int amount))
        {
            if (amount < 1 || amount > 999_999_999)
                tbQuantity.Text = "1";
        }
        else tbQuantity.Text = "1";
    }

    private void btnAddToCart_Click(object sender, RoutedEventArgs e)
    {
        var productForShoppingCart = new ShoppingCart
        {
            ProductId = _product.Id,
            UserId = Data.User!.Id,
            Quantity = int.Parse(tbQuantity.Text)
        };

        if (productForShoppingCart.Quantity > _product.StockQuantity)
        {
            MessageBox.Show("На складе нет столько таких товаров", "Ошибка добавления", MessageBoxButton.OK, MessageBoxImage.Error);
            return;
        }

        try
        {
            using var db = new ElectronicsStoreContext();
            db.ShoppingCarts.Add(productForShoppingCart);
            db.SaveChanges();
            DialogResult = true;
        }
        catch
        {
            MessageBox.Show("Ошибка добавления.\nВозможно, этот товар уже есть в Вашей корзине.", "Ошибка добавления",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }

        Close();
    }
}
