     # Register and Load TF Extensions
     require 'sketchup.rb'
     require 'extensions.rb'

     tf_extensions = SketchupExtension.new "Rotate 90", "CB_Rot90/rot90.rb"
     tf_extensions.version = '1.1.1'
     tf_extensions.description = "Rotate selected groups and/or components by 90 degrees"
     tf_extensions.copyright = "Copyright (c) 2013, Clark Bremer"
     tf_extensions.creator = "Clark Bremer"
     Sketchup.register_extension tf_extensions, true