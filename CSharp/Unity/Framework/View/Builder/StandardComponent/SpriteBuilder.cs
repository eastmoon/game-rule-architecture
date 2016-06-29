using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;
using UnityEngine.UI;

namespace Game.Framework.View.Builder.StandardComponent
{
    class SpriteBuilder : ViewComponentsBuilder
    {
        // Static Enum
        public static String ID = "";
        // Constructor
        public SpriteBuilder()
        {
            SpriteBuilder.ID = this.GetType().Namespace + "." + this.GetType().Name;
            this.SetComponentID(SpriteBuilder.ID);
        }
        // Build component
        public override GameObject Build(object[] _args)
        {
            String name = "";
            String textureName = "";
            if (_args.Length > 0)
                name = _args[0] as String;
            if(_args.Length > 1)
                textureName = _args[1] as String;

            // Declare variable
            GameObject obj = this.GetTarget();
            // Create texture
            Texture2D texture = Resources.Load<Texture2D>(textureName);
            if (texture != null)
            {
                // Using texture to create sprite object.
                Sprite sp = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(0.5f, 0.5f), 1);
                sp.name = texture.name;
                // Create game object and setting sprite component.
                obj.AddComponent<SpriteRenderer>().sprite = sp;
            }
            else
            {
                // Create non-texture sprite object.
                obj.AddComponent<SpriteRenderer>();
            }
            obj.name = name;
            if (this.GetStage() != null && this.GetStage() != obj)
                obj.transform.SetParent(this.GetStage().transform);
            return obj;
        }
    }
}
