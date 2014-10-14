

OPENSCAD=openscad
SLIC3R=slic3r

gname = ${patsubst %.scad,%.gcode,$(1)}
stlname = ${patsubst %.stl,%.gcode,$(1)}

SOURCEFILES = 3DR-Simple-Corner-Bottom-Reenforced.scad 3DR-Simple-Corner-Top-Reenforced.scad 3DR-Simple-LCD-Mount.scad 3DR-Simple-Magnetic-Car.scad  3DR-Simple-RUMBA-Mount.scad 3DR-Simple-Rod-Extender.scad 3DR-Simple-Traxxas-Car.scad 3DR-Simple-Traxxas-Effector.scad Blower-Fan-Duct.scad Car-Optical-Trigger.scad Effector-Blower-Mount.scad Effector-E3D-Fan-Mount.scad Effector-Slotted-Hotend-Mount.scad Effector-Z-Sensor-Mount.scad Filament-Feed-Holder.scad

STLFILES = ${addprefix ,${call stlname, $(SOURCEFILES)}}

GCODEFILES = ${addprefix PLA-,${call gname, $(SOURCEFILES)}}
GCODEFILES += ${addprefix ABS-,${call gname, $(SOURCEFILES)}}

default: $(GCODEFILES)
	echo $(GCODEFILES)

stl: $(STLFILES)

gcode: $(GCODEFILES)

%.stl: %.scad
	$(OPENSCAD) -o $@ $<

PLA-%.gcode: %.stl
	$(SLIC3R) $< --load slic3r_pla_full.ini --output $@

ABS-%.gcode: %.stl
	$(SLIC3R) $< --load slic3r_abs_full.ini --output $@

clean:
	$(RM) $(GCODEFILES)
	$(RM) $(STLFILES)