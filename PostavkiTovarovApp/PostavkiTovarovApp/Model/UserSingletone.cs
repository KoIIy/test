using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostavkiTovarovApp.Model
{
    class UserSingletone
    {
        private static UserSingletone instance;
        public int Role
        {
            get;
            private set;
        }
        public int UserId
        {
            get;
            private set;
        }
        protected UserSingletone(int role,int userid)
        {
            this.Role = role;
            this.UserId = userid;
        }
        public static UserSingletone setInstance(int role,int userid)
        {
            if (instance == null)
            {
                instance = new UserSingletone(role,userid);
            }
            return instance;
        }
        public static UserSingletone getInstance()
        {
            return instance;
        }
        public static UserSingletone clearInstance()
        {
            instance = null;
            return null;
        }
    }
}
