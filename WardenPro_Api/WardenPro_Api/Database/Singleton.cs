using System.Data.Entity;

namespace WardenPro_Api.Database
{
    public partial class WardenProEntities : DbContext
    {

        public static WardenProEntities _instance;

        public static WardenProEntities GetInstance()
        {
            if ( _instance == null )
                _instance = new WardenProEntities();
            return _instance;
        }

    }
}