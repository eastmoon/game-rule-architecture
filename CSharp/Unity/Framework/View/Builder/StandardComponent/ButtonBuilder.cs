using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;
using UnityEngine.UI;

namespace Game.Framework.View.Builder.StandardComponent
{
    class ButtonBuilder : ViewComponentsBuilder
    {
        // Static Enum
        public static String ID = "";
        // Member variable
        private ViewComponentsBuilder mBuilder;
        // Constructor
        public ButtonBuilder()
        {
            ButtonBuilder.ID = this.GetType().Namespace + "." + this.GetType().Name;
            this.SetComponentID(ButtonBuilder.ID);

            this.mBuilder = new ViewComponentsBuilder();
            this.mBuilder.SetBuilder(new TextBuilder());
        }
        // Build component
        public override GameObject Build(object[] _args)
        {
            String name = "";
            String text = "";
            if(_args.Length > 0)
                name = _args[0] as String;
            if (_args.Length > 1)
                text = _args[1] as String;

            GameObject obj = this.GetTarget();
            // Defined size
            RectTransform rect = obj.AddComponent<RectTransform>();
            rect.anchorMin = new Vector2(0, 1);
            rect.anchorMax = new Vector2(0, 1);
            rect.pivot = new Vector2(0, 1);
            rect.sizeDelta = new Vector2(160, 30);
            // Defined background
            Image img = obj.AddComponent<Image>();
            // Retrieve UISprite in database within Editor
            Sprite sprite = null;
#if UNITY_EDITOR
            sprite = UnityEditor.AssetDatabase.GetBuiltinExtraResource<Sprite>("UI/Skin/UISprite.psd");
#endif
            img.sprite = sprite;
            img.type = Image.Type.Sliced;
            // Defined button UI system
            obj.AddComponent<Button>();
            // Defined text in button
            this.mBuilder.SetStage(obj).Build(TextBuilder.ID, "Text", text).GetComponent<RectTransform>().anchoredPosition = new Vector2();
            //
            obj.name = name;
            //
            if (this.GetStage() != null && this.GetStage() != obj)
                obj.transform.SetParent(this.GetStage().transform);
            return obj;
        }
    }
}
