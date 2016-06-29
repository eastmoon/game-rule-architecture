◎ Game Rule Architecture

Game Rule Architecture for C#
本程式在呈現面會以Unity為運作工具，其中會包含部分Unity使用的檢測命令。

◎ Structure

Library
    ├ PureMVC
    └ GameRuleArchitecture
           ├ Core
           │     └ Kernel
           ├ Model
           ├ View
           └ Controller
Framework
    ├ Model
    ├ View
    ├ Controller
    └ Core

● Library

主要兩個函式庫，PureMVC、GameRuleArchitecture；若有引用其他外部函式庫則位於同層。
GameRuleArchitecture是繼承PureMVC架構，並將其改善為對應遊戲規則設計所需要的呈現架構。

○ Framework

GameRuleArchitecture模組實踐皆放置於此，在實際運作上，Unity或外部軟體會直接呼叫Framework內包含的主要物件，是直接引用或繼承改寫皆可；除非特殊需求，盡可能不要直接繼承Library.GameRuleArchitecture內容；若要繼承，則物件應放置於此。

◎ 啟動程序

1. 宣告啟動程序並執行

{
	// Retrieve application facade instance.
	ApplicationFacade facade = ApplicationFacade.getInstance();
	// Register startup command. 
	facade.RegisterCommand(ApplicationFacade.EVENT_STARTUP, typeof(StartupCommand));
	// Startup application facade, it will execute StartupCommand.
	facade.Startup(null);
}

2. 執行順序

‧ApplicationFacade.Startup
‧ApplicationFacade.InitializeFacade
‧ApplicationFacade.InitializeModel
‧GRAModel.InitializeModel
‧ApplicationFacade.InitializeView
‧GRAView.InitializeView
‧ApplicationFacade.InitializeController
‧GRAController.InitializeController
‧StartupCommand

※ 相關文章參考：
---------------------------
PureMVC Moves to GitHub
http://puremvc.org/
---------------------------

