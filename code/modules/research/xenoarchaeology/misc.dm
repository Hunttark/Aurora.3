
//---- Noticeboard

/obj/structure/noticeboard/anomaly
	notices = 5
	icon_state = "nboard05"

/obj/structure/noticeboard/anomaly/New()
	//add some memos
	var/obj/item/paper/P = new()
	P.name = "Memo RE: proper analysis procedure"
	P.info = "<br>We keep test dummies in pens here for a reason, so standard procedure should be to activate newfound alien artifacts and place the two in close proximity. Promising items I might even approve monkey testing on."
	P.stamped = list(/obj/item/stamp/rd)
	P.overlays = list("paper_stamped_rd")
	src.contents += P

	P = new()
	P.name = "Memo RE: materials gathering"
	P.info = "Corasang,<br>the hands-on approach to gathering our samples may very well be slow at times, but it's safer than allowing the blundering miners to roll willy-nilly over our dig sites in their mechs, destroying everything in the process. And don't forget the escavation tools on your way out there!<br>- R.W"
	P.stamped = list(/obj/item/stamp/rd)
	P.overlays = list("paper_stamped_rd")
	src.contents += P

	P = new()
	P.name = "Memo RE: ethical quandaries"
	P.info = "Darion-<br><br>I don't care what his rank is, our business is that of science and knowledge - questions of moral application do not come into this. Sure, so there are those who would employ the energy-wave particles my modified device has managed to abscond for their own personal gain, but I can hardly see the practical benefits of some of these artifacts our benefactors left behind. Ward--"
	P.stamped = list(/obj/item/stamp/rd)
	P.overlays = list("paper_stamped_rd")
	src.contents += P

	P = new()
	P.name = "READ ME! Before you people destroy any more samples"
	P.info = "how many times do i have to tell you people, these xeno-arch samples are del-i-cate, and should be handled so! careful application of a focussed, concentrated heat or some corrosive liquids should clear away the extraneous carbon matter, while application of an energy beam will most decidedly destroy it entirely - like someone did to the chemical dispenser! W, <b>the one who signs your paychecks</b>"
	P.stamped = list(/obj/item/stamp/rd)
	P.overlays = list("paper_stamped_rd")
	src.contents += P

	P = new()
	P.name = "Reminder regarding the anomalous material suits"
	P.info = "Do you people think the anomaly suits are cheap to come by? I'm about a hair trigger away from instituting a log book for the damn things. Only wear them if you're going out for a dig, and for god's sake don't go tramping around in them unless you're field testing something, R"
	P.stamped = list(/obj/item/stamp/rd)
	P.overlays = list("paper_stamped_rd")
	src.contents += P

//---- Bookcase

/obj/structure/bookcase/manuals/xenoarchaeology
	name = "Xenoarchaeology Manuals bookcase"

	New()
		..()
		new /obj/item/book/manual/excavation(src)
		new /obj/item/book/manual/mass_spectrometry(src)
		new /obj/item/book/manual/materials_chemistry_analysis(src)
		new /obj/item/book/manual/anomaly_testing(src)
		new /obj/item/book/manual/anomaly_spectroscopy(src)
		new /obj/item/book/manual/stasis(src)
		update_icon()

//---- Lockers and closets

/obj/structure/closet/secure_closet/xenoarchaeologist
	name = "xenoarchaeologist's locker"
	req_access = list(access_xenoarch)
	icon_state = "science"

/obj/structure/closet/secure_closet/xenoarchaeologist/fill()
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat(src)
	new /obj/item/clothing/shoes/science(src)
	new /obj/item/clothing/glasses/science(src)
	new /obj/item/device/radio/headset/headset_sci(src)
	new /obj/item/storage/belt/archaeology(src)
	new /obj/item/storage/box/excavation(src)
	new /obj/item/taperoll/science(src)
	new /obj/item/clothing/head/hardhat(src)

/obj/structure/closet/excavation
	name = "excavation tools"
	icon_state = "eng"
	icon_door = "eng_tool"

/obj/structure/closet/excavation/fill()
	new /obj/item/storage/belt/archaeology(src)
	new /obj/item/storage/box/excavation(src)
	new /obj/item/device/flashlight/lantern(src)
	new /obj/item/device/ano_scanner(src)
	new /obj/item/device/depth_scanner(src)
	new /obj/item/device/core_sampler(src)
	new /obj/item/device/gps/science(src)
	new /obj/item/device/beacon_locator(src)
	new /obj/item/device/radio/beacon(src)
	new /obj/item/pickaxe(src)
	new /obj/item/material/hatchet/machete/steel(src)
	new /obj/item/clothing/accessory/holster/utility/machete(src)
	new /obj/item/device/measuring_tape(src)
	new /obj/item/pickaxe/hand(src)
	new /obj/item/storage/bag/fossils(src)
	new /obj/item/device/hand_labeler(src)
	new /obj/item/ore_detector(src)

	// 2 Drills
	new /obj/item/pickaxe/drill(src)
	new /obj/item/pickaxe/drill(src)

//---- Isolation room air alarms

/obj/machinery/alarm/isolation
	req_one_access = list(access_research, access_atmospherics, access_engine_equip)

/obj/machinery/alarm/monitor/isolation
	req_one_access = list(access_research, access_atmospherics, access_engine_equip)
	locked = 0
	remote_control = 1
