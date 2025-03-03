var/list/admin_datums = list()

/datum/admins
	var/rank			= "Temporary Admin"
	var/client/owner	= null
	var/rights = 0
	var/fakekey			= null
	var/aooc_mute = FALSE
	var/datum/marked_datum

	var/mob/living/original_mob = null

	var/admincaster_screen = 0	//See newscaster.dm under machinery for a full description
	var/datum/feed_message/admincaster_feed_message = new /datum/feed_message   //These two will act as holders.
	var/datum/feed_channel/admincaster_feed_channel = new /datum/feed_channel
	var/datum/feed_message/admincaster_viewing_message = null
	var/admincaster_signature	//What you'll sign the newsfeeds as

	var/list/watched_processes	// Processes marked to be shown in Status instead of just Processes.

/datum/admins/New(initial_rank = "Temporary Admin", initial_rights = 0, ckey)
	if(!ckey)
		log_error("Admin datum created without a ckey argument. Datum has been deleted")
		qdel(src)
		return

	if (!current_map)
		SSatlas.OnMapload(CALLBACK(src, PROC_REF(update_newscaster_sig)))
	else
		update_newscaster_sig()

	rank = initial_rank
	rights = initial_rights
	admin_datums[ckey] = src

	if (rights & R_DEBUG)
		world.SetConfig("APP/admin", ckey, "role=admin")

/datum/admins/proc/associate(client/C)
	if(istype(C))
		owner = C
		owner.holder = src
		owner.add_admin_verbs()	//TODO
		staff |= C

/datum/admins/proc/disassociate()
	if(owner)
		staff -= owner
		owner.remove_admin_verbs()
		owner.deadmin_holder = owner.holder
		owner.holder = null

/datum/admins/proc/reassociate()
	if(owner)
		staff += owner
		owner.holder = src
		owner.deadmin_holder = null
		owner.add_admin_verbs()

/datum/admins/proc/update_newscaster_sig()
	if (!admincaster_signature)
		admincaster_signature = "[current_map.company_name] Officer #[rand(0,9)][rand(0,9)][rand(0,9)]"

/datum/admins/proc/toggle_aooc_mute_check()
	aooc_mute = !aooc_mute
	return !aooc_mute

/datum/admins/proc/check_aooc_mute()
	return aooc_mute
/*
checks if usr is an admin with at least ONE of the flags in rights_required. (Note, they don't need all the flags)
if rights_required == 0, then it simply checks if they are an admin.
if it doesn't return 1 and show_msg=1 it will prints a message explaining why the check has failed
generally it would be used like so:

proc/admin_proc()
	if(!check_rights(R_ADMIN)) return
	to_world("you have enough rights!")

NOTE: It checks usr by default. Supply the "user" argument if you wish to check for a specific mob.
*/
/proc/check_rights(rights_required, show_msg=1, var/mob/user = usr)
	if(user && user.client)
		if(rights_required)
			if(user.client.holder)
				if(rights_required & user.client.holder.rights)
					return 1
				else
					if(show_msg)
						to_chat(user, "<span class='warning'>Error: You do not have sufficient rights to do that. You require one of the following flags:[rights2text(rights_required," ")].</span>")
		else
			if(user.client.holder)
				return 1
			else
				if(show_msg)
					to_chat(user, "<span class='warning'>Error: You are not an admin.</span>")
	return 0

//probably a bit iffy - will hopefully figure out a better solution
/proc/check_if_greater_rights_than(client/other)
	if(usr && usr.client)
		if(usr.client.holder)
			if(!other || !other.holder)
				return 1
			if(usr.client.holder.rights != other.holder.rights)
				if( (usr.client.holder.rights & other.holder.rights) == other.holder.rights )
					return 1	//we have all the rights they have and more
		to_chat(usr, "<span class='warning'>Error: Cannot proceed. They have more or equal rights to us.</span>")
	return 0

/client/proc/deadmin()
	if(holder)
		holder.disassociate()
		//qdel(holder)
	return 1

/client/proc/toggle_aooc_holder_check()
	if(holder)
		return holder.toggle_aooc_mute_check()

/client/proc/aooc_mute_holder_check()
	if(holder)
		return holder.check_aooc_mute()
