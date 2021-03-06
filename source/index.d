Ddoc
<p>
$(LINK2 https://github.com/p0nce/gfm, GFM) is a feature-rich library to ease the creation of video games / multimedia applications with the D programming language. Pick what you need.
</p>

<h3>Overview:</h3>

$(UL
    <p>$(LI gfm.core sub-package:
        $(UL
            $(LI $(D log.d): logging interface + implementations (HTML file, colored console output...).)
            $(LI $(D queue.d): a dead simple queue/fifo/stack/ring-buffer, with a range interface.)
            $(LI $(D lockedqueue.d): synchronized queue for thread communication.)
            $(LI $(D memory.d): aligned malloc/free/realloc.)
            $(LI $(D alignedbuffer.d): aligned array-like container.)
            $(LI $(D text.d): string utilities.)
         )
    )</p>
    <p>$(LI gfm.math sub-package:
        $(UL
            $(LI $(D vector.d): small vectors for 2D and 3D.)
            $(LI $(D matrix.d): small matrices for 2D and 3D.)
            $(LI $(D quaternion.d): quaternions.)
            $(LI $(D half.d): 16-bit floating point type.)
            $(LI $(D wideint.d): 2^N bits integers (recursive implementation, covers cent/ucent).)
            $(LI $(D box.d): half-open intervals (for eg. AABB).)
            $(LI $(D fixedpoint.d): fixed-point numbers.)
            $(LI $(D fraction.d): rational numbers.)
            $(LI $(D statistics.d): statistical functions.)
            $(LI $(D solver.d): polynomial solvers up to quadratic.)
            $(LI $(D simplerng.d): random distributions: a port of SimpleRNG from John D. Cook.)
            $(LI $(D shapes.d): segment, triangle, sphere, ray...)
            $(LI $(D frustum.d): 3D frustum and 3D plane.)
            $(LI $(D funcs.d): useful math functions.)
            $(LI $(D simplexnoise.d): Simplex noise implementation.)
         )
    )</p>
    <p>$(LI gfm.opengl sub-package:
        $(UL
            $(LI OpenGL wrapper based on package derelict-gl3.)
            $(LI makes easier to use the OpenGL API correctly.)
            $(LI including a matrix stack to replace fixed pipeline.)
            $(LI including compilation of a single source for multiple shaders.)
            $(LI practical shader uniforms support: set them at any time, with id caching, and support pruned uniforms.)
            $(LI legacy multi-texture support which is needed for a low-spec game.)
            $(LI FBO support with GL_EXT_framebuffer_object fallback.)
            $(LI built-in OpenGL debug output forwarding.)
         )
    )</p>

    <p>$(LI gfm.net sub-package:
        $(UL
            $(LI $(D uri.d): URI parsing (RFC 3986).)
            $(LI $(D httpclient.d): HTTP client (RFC 2616).)
            $(LI $(D cbor.d): CBOR serialization/deserialization (RFC 7049).)
         )
    )</p>
    <p>$(LI gfm.sdl2 sub-package:
        $(UL
            $(LI SDL 2.0 wrapper based on package derelict-sdl2.)
            $(LI including SDL_image and SDL_ttf wrappers.)
            $(LI built-in SDL logging forwarding.)
            $(LI framerate statistics.)
         )
    )</p>

    <p>$(LI gfm.image sub-package:
        $(UL
            $(LI $(D image.d): generic abstract image and software rendering routines.)
            $(LI $(D bitmap.d): planar and tile-based concrete images.)
            $(LI $(D cie.d): physical color computations.)
            $(LI $(D hsv.d): RGB <-> HSV conversions.)
         )
    )</p>

    <p>$(LI gfm.freeimage sub-package:
        $(UL
            $(LI FreeImage wrapper based on package derelict-fi.)
            $(LI FIBITMAP wrapper.)
         )
    )</p>
    
    <p>$(LI gfm.assimp sub-package:
        $(UL
            $(LI Assimp wrapper based on package derelict-assimp3.)
            $(LI scene wrapper.)
         )
    )</p>

) 


<h3>Dealing with resources in D.</h3>

<p>
Resource management in D needs more care than it seems at first ; more so than in C++ and as much as in C#.
</p>

<p>
The crux of the matter is that <b>you cannot rely on a class destructor being called by the 
GC or even class destruction order</b>.</p>

<p>A notable consequence is that <b>when a class instance destructor is 
called, its members might have been destroyed already (unlike in C++).</b></p>

<p>
You can verify this fact here: $(WEB dlang.org/class.html#destructors).
</p>

<p>
To simplify, the <i>resource-ness</i> of a class leaks on anything that owns it. 
This is an unavoidable fact of a GC with cycles and you have to deal with it, ie. 
you have to call close() methods manually before it's too late.
</p>

<h4>How to deal with it:</h4>

$(UL
  $(LI Call close() manually on resource classes.)
  $(LI A class with a close() method should have it called automatically by its destructor.)
  $(LI Use such friendly resource classes with $(D scoped!), $(D RefCounted), $(D scope(exit)), 
    $(D Unique!), or any other deterministic destruction mechanisms.)
  $(LI For maximum usefulness, a close() method should support being called several times.)
)

