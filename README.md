# Godot 4 light mask tutorial

This project is an example of how to have partially visible lit areas, based on the location of the player.

It uses 2 SubViewports, one for the main rendered image, and one for the mask.  Each viewport has it's own copy of the TileMap we're displaying.

We then set up a sprite that displays the rendered image viewport as a VieportTexture, and use a ShaderMaterial to mask what isn't visible.

The VisibilityMask viewport has a copy of the tilemap that uses a ShaderMaterial to turn all of the pixel colors white, and then it has a light (synced to the players position) that is in Subtract mode, to have black areas where the player can see, and white where they can't.

This VisibilityMask is passed in to the masking shader's parameters, and we set the alpha of the masked texture to 0 whenever there is a light spot in the mask.
