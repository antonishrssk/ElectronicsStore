using System.Text;
using System.Windows;
using ElectronicsStore.Models;
using Microsoft.EntityFrameworkCore;

namespace ElectronicsStore;

/// <summary>
/// Логика взаимодействия для AddEditProductWindow.xaml
/// </summary>
public partial class AddEditProductWindow : Window
{
    private Product? _product;

    public AddEditProductWindow()
    {
        InitializeComponent();
    }

    private void Window_Loaded(object sender, RoutedEventArgs e)
    {
        using var db = new ElectronicsStoreContext();

        cbCategories.ItemsSource = db.Categories.ToList();
        if (Data.NewProduct is null)
        {
            Title = "Добавление товара";
            btnAddEditProduct.Content = "Добавить товар";
            _product = new Product();
        }
        else
        {
            Title = "Редактирование товара";
            btnAddEditProduct.Content = "Редактировать товар";
            _product = db.Products.Find(Data.NewProduct.Id);
        }

        DataContext = _product;
    }

    private void btnAddEditProduct_Click(object sender, RoutedEventArgs e)
    {
        var errors = new StringBuilder();
        if (tbName.Text.Length == 0) errors.AppendLine("Введите название");
        if (tbDescription.Text.Length == 0) errors.AppendLine("Введите описание");
        if (cbCategories.SelectedItem is null) errors.AppendLine("Выберите категорию");
        if (tbPrice.Text.Length == 0) errors.AppendLine("Введите цену");
        if (tbStockQuantity.Text.Length == 0) errors.AppendLine("Введите количество товаров на складе");
        if (errors.Length > 0)
        {
            MessageBox.Show(errors.ToString());
            return;
        }

        if (_product is null) return;
        try
        {
            using var db = new ElectronicsStoreContext();
            if (Data.NewProduct is null)
            {
                db.Products.Add(_product);
            }

            db.SaveChanges();
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
        }

        DialogResult = true;
        Close();
    }

    private void btnCancel_Click(object sender, RoutedEventArgs e)
        => Close();
}
