using UnityEngine;
using GameRuleArchitecture.Core;

namespace Game.Framework
{
    public class ApplicationCore
    {
        // Static instance
        private static ApplicationCore mInstance;
        // Static method
        public static ApplicationCore getInstance() {
            if (mInstance == null)
                mInstance = new ApplicationCore();
            return mInstance; }
        // Singletion pattern :
        // Constructor
        private ApplicationCore()
        {
            Debug.Log("Application instance startup.");
        }
        // Facade pattern :
        // System statup method
        public ApplicationCore SystemStartup()
        {
            Debug.Log("Application system startup.");
            
            // Startup game rule application
            ApplicationFacade facade = ApplicationFacade.getInstance();
            facade.RegisterCommand(ApplicationFacade.EVENT_STARTUP, typeof(Game.Framework.Controller.StartupCommand));
            facade.Startup(null);

            return this;
        }
        // Module startup method
        public ApplicationCore ModuleStatrup()
        {
            Debug.Log("Application module startup.");
            return this;
        }
    }
}