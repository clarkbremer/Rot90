require 'sketchup.rb'
##
## Rotate selected component instance 90 degrees around Z axis
##
##  Copyright (c) 2013 Clark Bremer
##  clarkbremer@gmail.com
##
## 5/5/2013:	1.1.1: RePackage for Extension Warehouse
## 9/10/2010:	Multiple Groups/Comps
## 5/17/08:  	All 3 axes.  (with Input from Matt666)
## 4/24/08: 	Use center as rotation point instead of CI origin.  Also works on groups now.
##

module CB_R90

def CB_R90.selected_comps_and_groups
    mm = Sketchup.active_model
    ss = mm.selection
	return nil if ss.empty?
	ss.each do |cc|
		return nil if not ((cc.instance_of? Sketchup::ComponentInstance) or (cc.instance_of? Sketchup::Group))
	end
    ss
end

def CB_R90.rotate90(sel, axis)
	rv = Geom::Vector3d.new(0,0,1) if axis == "z"
	rv = Geom::Vector3d.new(0,1,0) if axis == "y"
	rv = Geom::Vector3d.new(1,0,0) if axis == "x"
	ra = 90.degrees
	#rt = Geom::Transformation.rotation(rp, rv, ra)
	sel.each do |ent|
		ctr = ent.bounds.center
#		ctr = Geom::Point3d.new(0,0,0)
#		ctr.transform!(ent.transformation)
		rp = Geom::Point3d.new(ctr) 		#rotation point
		ent.transform!(Geom::Transformation.rotation(rp, rv, ra))
	end
end
end # module

if( not file_loaded?("rot90.rb") )
    UI.add_context_menu_handler do |menu|
		if menu == nil then
			UI.messagebox("Error setting context menu handler")
		else
			if (sel = CB_R90.selected_comps_and_groups)
				sbm = menu.add_submenu("Rotate 90")
				sbm.add_item("Around Red") {CB_R90.rotate90 sel, "x"}
				sbm.add_item("Around Green") {CB_R90.rotate90 sel, "y"}
				sbm.add_item("Around Blue") {CB_R90.rotate90 sel, "z"}
			end
		end

	end
end

file_loaded("rot90.rb")
