using PostavkiTovarovApp.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace PostavkiTovarovApp.View.Window
{
    /// <summary>
    /// Логика взаимодействия для AuthorizationWindwo.xaml
    /// </summary>
    public partial class AuthorizationWindwo 
    {
        Authorization Auth = new Authorization();
        public AuthorizationWindwo()
        {
            InitializeComponent();
            DataContext = Auth;
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            Auth.Password = PasswordBox.Password;
        }
    }
}
