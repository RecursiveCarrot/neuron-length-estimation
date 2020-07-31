# Growth alignment of neurons on a nanopillar grid

We have images of 'immuno-strained' neurons on a background of diamond nanopillars. The neurons are expected to grow in alignment with the grid of pillars, we want to assess how well they align with the grid.

The following is a raw example of an image:


![Immuno-stain image]('./sample/neuron-example.jpg')

The green, red and blue channels approximately correspond to the neurons, glia and nuclei, respectively. We also know the orientation of the diamond pillar with respect to this image. 

![Immuno-stain image]('./sample/pillar-array.jpg')

![Immuno-stain image]('./sample/overlay-example.jpg')

Our aim is to trace out the neuron tendrils algorithmically and then measure how similar these traces align with the grid. For example, you can approximate this by looking at the integrated cosine similarity between the grid axes and neuron tendril paths.

Research Log:
- Preprocessed the images, cleaning up noise where possible.
- Conducted exploratory data analysis to identify any useful features. Note: Identified color transformation required to maximally separate the neuron/glia/nuclei signals.
- Extracted the of the neuron signal.
- Skeletonised the neuron pathways (Image to binary mask of tendril centers).
- Identified and parametrised a path for each visible neuron tendril.
- Calculated the similarity between the neuron path and the grid.
