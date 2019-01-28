/// @description Insert description here
// You can write your code in this editor
clamp(changeableValues[2],0,999);
clamp(changeableValues[1],0,999);
steps += 1;
if steps >= room_speed{ 
steps = 0;
seconds += 1;
}

otherRep = instance_place(x,y,oReplicator)
if instance_exists(otherRep){
    //if MoveToPlayer == false{
        Reposition = true;
        move_towards_point(otherRep.x+(random_range(-1,1)),otherRep.y +(random_range(-1,1)),-1);
    //}
}
if Reposition == true{
    if !instance_exists(otherRep){
        Reposition = false;
        speed = 0;
    }
}


//Metabolism
if Phenotype[0] == 1{
	var inst;
	inst = instance_place(x, y, oPhoton);
	if inst != noone{
		with (inst) instance_destroy();
		changeableValues[1] += 1;
	}
	
	if seconds >= Genotype[0,0] && changeableValues[1] > 0{
	changeableValues[1] -= 1;
	changeableValues[2] += 1;
	seconds = 0;
	}
	
	if changeableValues[1] <= 0{
		show_debug_message(string(id)+" starved!")
		instance_destroy();	
	}
	
}

else{
	
}

if Phenotype[1] == 1{
	if (changeableValues[2] >= Genotype[1,0]) && (changeableValues[2] >= (Genotype[1,2] * Genotype[1,1])){
		repeat(Genotype[1,1]){
			var child = instance_create_layer(x + lengthdir_x(Genotype[1,3],Genotype[1,4]),y + lengthdir_y(Genotype[1,3],Genotype[1,4]),"Instances",oReplicator); //creates child and saves it's unique ID into a variable
			child.changeableValues[0] = id; //sets the parent body of the arm to this object
			child.Genotype[0,0] = sGeneMutator(Genotype[0,0],100,2,child.id,"metbolismRate");
			child.Genotype[1,0] = sGeneMutator(Genotype[1,0],100,2,child.id,"energyThreshold");
			child.Genotype[1,1] = sGeneMutator(Genotype[1,1],100,2,child.id,"Litter");
			child.Genotype[1,2] = sGeneMutator(Genotype[1,2],100,2,child.id,"partingGift");
			child.changeableValues[1] = Genotype[1,2];
			child.Genotype[1,3] = sGeneMutator(Genotype[1,3],100,10,child.id,"reproductionDistance");
			child.Genotype[1,4] = sGeneMutator(Genotype[1,4],359,10,child.id,"reproductionAngle");
			
			changeableValues[2] -= Genotype[1,2]; //parting gift
		}
		
	}
}