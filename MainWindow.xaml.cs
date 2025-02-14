using System.Windows;
using System.Windows.Controls;
using ElectronicsStore.Models;

namespace ElectronicsStore;

/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void Window_Initialized(object sender, EventArgs e)
    {
        new Authorization().ShowDialog();
        if (!Data.IsUserLoggedIn) Close();

        Title = "Магазин электроники - Вы вошли как ";
        if (Data.IsGuest) // если пользователь вошел как гость
        {
            Title += "Гость";
            tabShoppingCart.IsEnabled = false;
            return;
        }

        // если пользователь вошел в учетную запись
        var user = Data.User;
        if (user is null) return;
        Title += $"{user.LastName} {user.FirstName[0]}.";
        if (user.RoleId == 1) // если пользователь - администратор
        {
            Title += $" (Администратор)";
            gbAdminPanel.Visibility = Visibility.Visible;
        }
    }

    private void Window_Loaded(object sender, RoutedEventArgs e)
    {
        LoadProductsInListView();
        LoadCategoriesInComboBox();
        LoadShoppingCartInListView();
    }

    private void LoadProductsInListView()
    {
        using var db = new ElectronicsStoreContext();

        int selectedIndex = lvProducts.SelectedIndex;
        lvProducts.ItemsSource = db.ProductsInfos.ToList();

        if (selectedIndex == -1) return;
        if (selectedIndex == lvProducts.Items.Count - 1)
            selectedIndex--;
        lvProducts.SelectedIndex = selectedIndex;
        lvProducts.ScrollIntoView(lvProducts.SelectedItem);
        lvProducts.Focus();
    }

    private void LoadCategoriesInComboBox()
    {
        using var db = new ElectronicsStoreContext();
        cbCategories.ItemsSource = db.Categories.ToList();
    }

    private void LoadShoppingCartInListView()
    {
        if (Data.User is null) return;
        using var db = new ElectronicsStoreContext();
        var shoppingCartContent = db.ShoppingCartContents.Where(c => c.UserId == Data.User.Id);
        lvShoppingCart.ItemsSource = shoppingCartContent.ToList();
    }

    private void cbCategories_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        using var db = new ElectronicsStoreContext();

        if (cbCategories.SelectedItem is not Category category)
        {
            lvProducts.ItemsSource = db.ProductsInfos.ToList();
            return;
        }

        var productsWithSelectedCategory = db.ProductsInfos.Where(p => p.Category == category.Name);
        lvProducts.ItemsSource = productsWithSelectedCategory.ToList();
    }

    private void btnClearCategory_Click(object sender, RoutedEventArgs e)
        => cbCategories.SelectedIndex = -1;

    private void btnAddProduct_Click(object sender, RoutedEventArgs e)
    {
        Data.NewProduct = null;
        var addProductWindow = new AddEditProductWindow
        {
            Owner = this
        };
        bool? addedProduct = addProductWindow.ShowDialog();
        if (!addedProduct.HasValue) return;
        if (addedProduct.Value)
        {
            LoadProductsInListView();
        }
    }

    private void btnEditProduct_Click(object sender, RoutedEventArgs e)
    {
        if (lvProducts.SelectedItem is null) return;

        var selectedProduct = lvProducts.SelectedItem as ProductsInfo;
        if (selectedProduct is null) return;
        Data.NewProduct = new Product
        {
            Id = selectedProduct.Id,
            Name = selectedProduct.Name,
            Description = selectedProduct.Description,
            Price = selectedProduct.Price,
            StockQuantity = selectedProduct.StockQuantity
        };

        var editProductWindow = new AddEditProductWindow
        {
            Owner = this
        };
        bool? editedProduct = editProductWindow.ShowDialog();
        if (!editedProduct.HasValue) return;
        if (editedProduct.Value)
        {
            LoadProductsInListView();
        }
    }

    private void lvProducts_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (lvProducts.SelectedItem is not ProductsInfo product) return;
        var viewProductWindow = new ViewProductWindow(product)
        {
            Owner = this
        };
        bool? isProductAddedToCart = viewProductWindow.ShowDialog();
        if (!isProductAddedToCart.HasValue) return;
        if (isProductAddedToCart.Value)
        {
            tabShoppingCart.Focus();
            LoadShoppingCartInListView();
        }
    }

    private void btnRemoveFromCart_Click(object sender, RoutedEventArgs e)
    {
        if (lvShoppingCart.SelectedItem is not ShoppingCartContent productInCartContent) return;
        var productInCart = new ShoppingCart
        {
            ProductId = productInCartContent.ProductId,
            UserId = productInCartContent.UserId,
            Quantity = productInCartContent.Quantity
        };

        using var db = new ElectronicsStoreContext();
        db.ShoppingCarts.Remove(productInCart);
        db.SaveChanges();

        LoadShoppingCartInListView();
    }

    private void btnOrder_Click(object sender, RoutedEventArgs e)
    {
        if (Data.User is null) return;
        var order = new Order
        {
            UserId = Data.User.Id,
            OrderDate = DateTime.Now
        };

        using var db = new ElectronicsStoreContext();
        db.Orders.Add(order);
        db.SaveChanges();

        LoadProductsInListView();
        LoadShoppingCartInListView();
    }

    private void lvShoppingCart_SelectionChanged(object sender, SelectionChangedEventArgs e)
        => btnRemoveFromCart.IsEnabled = lvShoppingCart.SelectedIndex != -1;

    private void miExit_Click(object sender, RoutedEventArgs e)
    {
        MessageBoxResult result = MessageBox.Show("Вы уверены, что хотите выйти?",
            "Выход?", MessageBoxButton.YesNo, MessageBoxImage.Question);
        if (result == MessageBoxResult.Yes) Close();
    }

    private void miInfo_Click(object sender, RoutedEventArgs e)
    {
        MessageBox.Show("Курсовая работа\nРазработчик: Антонишин Кирилл Сергеевич ИСП-41\nТема: Магазин электроники",
            "Справка", MessageBoxButton.OK, MessageBoxImage.Information);
    }
}
