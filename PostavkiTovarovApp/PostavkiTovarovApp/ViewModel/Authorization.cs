using PostavkiTovarovApp.Core;
using PostavkiTovarovApp.Model;
using PostavkiTovarovApp.Model.Entity;
using PostavkiTovarovApp.View.Window;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace PostavkiTovarovApp.ViewModel
{
    class Authorization:BaseViewModel
    {
        
        
        private string login, password;
        public string Login
        {
            get
            {
                return login;
            }
            set
            {
                login = value;
                OnPropertyChanged("Login");
            }
        }
        public string Password
        {
            get
            {
                return password;
            }
            set
            {
                password = value;
                OnPropertyChanged("Password");
            }
        }
        private  Icommand auth;
        public Icommand Auth
        {
            get
            {
               return auth ?? (
                    auth = new Icommand(obj => {
                        using (var db = new TraiderEntities())
                        {
                            foreach (User user in db.User)
                            {
                                if (user.Login == Login && user.Passwqord == Password)
                                {
                                    UserSingletone.setInstance(user.RoleID,user.Id);
                                    new MainWindow().Show();
                                    foreach (Window window in Application.Current.Windows)
                                    {
                                        if (window is AuthorizationWindwo)
                                        {
                                            window.Close();
                                            
                                        }
                                    }
                                    return;
                                }
                            }
                            MessageBox.Show("Неверный логин или пароль");
                        }
                    }));
            }
        }
    }
}
