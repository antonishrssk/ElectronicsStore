using System.Text;
using System.Windows;
using ElectronicsStore.Models;

namespace ElectronicsStore;

/// <summary>
/// Логика взаимодействия для Authorization.xaml
/// </summary>
public partial class Authorization : Window
{
    private bool _isUserLoggingIn = true;

    public Authorization()
    {
        InitializeComponent();
    }

    private void UpdateLoginFormUI()
    {
        txtLoginRegister.Text = _isUserLoggingIn ? "Войдите, чтобы продолжить" : "Создайте учётную запись";
        stpFio.Visibility = _isUserLoggingIn ? Visibility.Collapsed : Visibility.Visible;
        btnLoginRegister.Content = _isUserLoggingIn ? "Войти" : "Зарегистрироваться";
        btnHasAccount.Content = _isUserLoggingIn ? "Нет учётной записи?" : "Уже есть учётная запись?";

        if (_isUserLoggingIn) tbEmail.Focus();
        else tbLastName.Focus();
    }

    private void Window_Loaded(object sender, RoutedEventArgs e)
    {
        UpdateLoginFormUI();
    }

    private void btnLoginRegister_Click(object sender, RoutedEventArgs e)
    {
        using var db = new ElectronicsStoreContext();

        if (_isUserLoggingIn) // вход
        {
            var user = db.Users.Where(u => u.Email == tbEmail.Text && u.Password == pbPassword.Password);
            if (user.Count() == 1) // успешный вход
            {
                Data.User = user.First();
                Data.IsUserLoggedIn = true;
                Close();
            }
            else // ошибка входа
            {
                MessageBox.Show("Логин и/или пароль неверны. Повторите ввод.", "Данные неверны", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        else // регистрация
        {
            var user = db.Users.Where(u => u.Email == tbEmail.Text);
            if (!user.Any()) // если пользователя с введенной почтой нет
            {
                var errors = new StringBuilder();
                if (tbLastName.Text.Length == 0) errors.AppendLine("Введите фамилию");
                if (tbFirstName.Text.Length == 0) errors.AppendLine("Введите имя");
                if (tbEmail.Text.Length == 0) errors.AppendLine("Введите электронную почту");
                if (pbPassword.Password.Length == 0) errors.AppendLine("Введите пароль");

                try
                {
                    var newUser = new User
                    {
                        LastName = tbLastName.Text,
                        FirstName = tbFirstName.Text,
                        Patronymic = tbPatronymic.Text,
                        Email = tbEmail.Text,
                        Password = pbPassword.Password,
                        RoleId = 2
                    };
                    db.Users.Add(newUser);
                    db.SaveChanges();

                    Data.User = newUser;
                    Data.IsUserLoggedIn = true;
                    Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(errors.ToString() + ex.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else // если пользователь с введенной почтой уже существует
            {
                MessageBox.Show("Пользователь с этой электронной почтой уже зарегистрирован. Повторите ввод.",
                    "Пользователь уже существует", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }

    private void btnLoginAsGuest_Click(object sender, RoutedEventArgs e)
    {
        Data.IsUserLoggedIn = true;
        Data.IsGuest = true;
        Close();
    }

    private void btnHasAccount_Click(object sender, RoutedEventArgs e)
    {
        _isUserLoggingIn = !_isUserLoggingIn;
        UpdateLoginFormUI();
    }
}
