SVGTest
=======

Make it easier to test other SVG Libraries out there.

Currently none of the SVG Libraries fulfill even the most basic functionality.
SVGKit is the closest one, but even this fails a simple test like loading an SVG file, and resizing the 
SVGView.

I shall update this project to work with other libraries when I come across them.
The dream is to one day find an SVG Library that has the following syntax:

  SVGImage *img = [SVGImage imageNamed:@"test.svg"];
  SVGImageView *imgView = [[SVGImageView alloc] initWithFrame:self.view.bounds];
  imgView.autoResizingMask = UIViewAutoResizingMaskFlexibleHeight | UIViewAutoResizingMaskFlexibleWidth;
  imgView.image = img;
  [self.view addSubview:imgView];
  
  
