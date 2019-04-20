vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 texturecolor = Texel(texture, texture_coords);
    vec4 final = texturecolor * color;

    if (final.rgb == vec3(0.0, 0.0, 0.0))
    {
        final.a = 0.0;
    }

    return final;
}
