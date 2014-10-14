

OPENSCAD=openscad
SLIC3R=slic3r

gname = ${patsubst %.scad,%.gcode,$(1)}
stlname = ${patsubst %.scad,%.stl,$(1)}

SOURCEFILES = 3DR-Simple-Wing-Top-Parts.scad 3DR-Simple-Wing-Bottom-Parts.scad 3DR-Simple-Corner-Bottom-Reenforced.scad 3DR-Simple-Corner-Top-Reenforced.scad 3DR-Simple-LCD-Mount.scad 3DR-Simple-Magnetic-Car.scad  3DR-Simple-RUMBA-Mount.scad 3DR-Simple-Rod-Extender.scad 3DR-Simple-Traxxas-Car.scad 3DR-Simple-Traxxas-Effector.scad Blower-Fan-Duct.scad Car-Optical-Trigger.scad Effector-Blower-Mount.scad Effector-E3D-Fan-Mount.scad Effector-Slotted-Hotend-Mount.scad Effector-Z-Sensor-Mount.scad Filament-Feed-Holder.scad

STLFILES = ${addprefix ,${call stlname, $(SOURCEFILES)}}

GCODEFILES = ${addprefix PLA-,${call gname, $(SOURCEFILES)}}
GCODEFILES += ${addprefix ABS-,${call gname, $(SOURCEFILES)}}

default: gcode stl

stl: $(STLFILES)

gcode: $(GCODEFILES)

%.stl: %.scad
	$(OPENSCAD) -o $@ $<

PLA-%.gcode: %.stl slic3r_pla_full.ini
	$(SLIC3R) $< --load slic3r_pla_full.ini --output $@

ABS-%.gcode: %.stl slic3r_abs_full.ini
	$(SLIC3R) $< --load slic3r_abs_full.ini --output $@

clean:
	$(RM) $(GCODEFILES)
	$(RM) $(STLFILES)
