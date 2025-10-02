# **Assignment 1**
#### COMP 360 ON1 - Group 3
#### Simran Dhillon (#300211810), Bhupinder Singh Gill (#300140363), Gursagar Chahal (#300192061), Gurashman Kaur Otaal (#300196154), Guneet Bakshi (#300196598), Nicholas Retel (#300196657)
#### October 2nd, 2025

### Planning & Logging of Work
For this project our group mainly used WhatsApp for quick communication, providing feedback, and keeping each other updated. Using WhatsApp, we also scheduled regular meeting times on Microsoft Teams to discuss progress in more detail and to make decisions as a group. We shared our files and other project resources using WhatsApp, Microsoft Teams, and Google Drive, ensuring everyone had access to all the latest project materials. When organizing tasks, we used the Planner App on Microsoft Teams to log our individual tasks, and a screenshot of our individual contributions is attached to the project PDF. Using WhatsApp allowed us to communicate with each other very quickly and benefited us immensely when other platforms were involved, allowing us to stay organized and keep the project moving forward efficiently.

Each group member individually developed and tested their own version of the terrain generation code. After sharing progress and discussing results during our weekly meetings, we compared the different approaches and collectively decided on the final version to move forward with.

### Written Summary of Individual Task Contributions
**Simran Dhillon**: My individual contribution was developing the final version of the terrain generation code in Godot, ensuring the implementation used FastNoiseLite to create a natural 3D landscape, and integrating a shader for height based coloring and surface detail. I also recorded the demo video to demonstrate how the project works, including how the terrain parameters can be adjusted in the Inspector and how the code was tested.

**Bhupinder Singh Gill**: First worked on creating image using FastNoiseLite. Next, worked on creating a single quad with surface tool, then created 2*2 quad with image as texture on it, and did correct UV mapping to make sure no seams between the quads, sampled red channel from the noise image and applied it to y-axis of the landscape for all vertices. Reviewed the code finalized by our group to submit.

**Gurashman Otaal**: I first developed and tested my own version of the assignment by generating a 2D heightmap image in Python using FastNoiseLite, and then creating a 3D terrain in Godot where the mesh heights and texture were driven by that image. After completing both parts, we shared progress in our group meeting, compared the different approaches, and collectively decided to move forward with my version as the base for the final submission.

**Gursagar Chalal**: Worked on creating a 2D noise image similar to greyscale satellite images as well as creating a 3D mesh. Researched and shared knowledge about how to implement the 2D image into the 3D mesh. Attended all team meetings and promptly responded to all messages. 
 
**Guneet Bakshi**: I created a Perlin noise generator which produces a heightmap of 4096x4096. These values of noise are stored in an array, transformed into grayscale pixels, and stored as a PNG file titled height_map.png. During our group meeting, we reviewed the progress, and discussed the various approaches, and decided to proceed with simrans project.

**Nicholas Retel**:

### References
https://docs.godotengine.org/en/4.4/tutorials/scripting/gdscript/gdscript_exports.html

https://docs.godotengine.org/en/4.4/classes/class_fastnoiselite.html

https://www.youtube.com/watch?v=wWFdDKYYiUQ

https://glusoft.com/godot-tutorials/make-procedural-terrain-FastNoiseLite/

https://forum.godotengine.org/t/heightmap-lightmap-and-textures/11269

https://docs.godotengine.org/en/2.1/community/tutorials/3d/mesh_generation_with_heightmap_and_shaders.html

https://www.youtube.com/watch?v=izsMr5Pyk2g

https://docs.godotengine.org/en/4.4/classes/class_heightmapshape3d.html

https://www.reddit.com/r/godot/comments/1n5asfp/godot_shader_help_regarding_specific_texture_to/

https://forum.godotengine.org/t/replicating-shader-texture-function/16918

https://godotshaders.com/shader/shader-3/

https://www.youtube.com/watch?v=E44-P0amUzI
