/// @description Insert description here
// You can write your code in this editor

steps += 1;
if steps >= room_speed{ 
steps = 0;
seconds += 1;
} 

//Metabolism
if Phenotype[0] == 1{
	var inst;
	inst = instance_place(x, y, oPhoton);
	if inst != noone{
		with (inst) instance_destroy();
		mass += 1;
	}
	
	if seconds >= metabolicRate && mass > 0{
	mass -= 1;
	energy += 1;
	seconds = 0;
	}
	
	if mass <= 0{
	show_debug_message(string(id)+"The Progenitor Starved!")
	instance_destroy();	
	}
	
}

else{
	
}

if Phenotype[1] == 1{
	if (energy >= energyThreshold){
		repeat(litter){
			angleToSpawn = random_range(0,359);
			var child = instance_create_layer(x + lengthdir_x(distanceToSpawn,angleToSpawn),y + lengthdir_y(distanceToSpawn,angleToSpawn),"Instances",oReplicator); //creates child and saves it's unique ID into a variable
			child.parent = id; //sets the parent body of the arm to this object
			child.Genotype[0,0] = metabolicRate;
			child.Genotype[0,1] = massType;
			child.Genotype[0,2] = eats;
			child.Genotype[1,0] = energyThreshold;
			child.Genotype[1,1] = litter;
			child.Genotype[1,2] = partingGift;
			child.changeableValues[1] = partingGift;
			child.Genotype[1,3] = distanceToSpawn;
			child.Genotype[1,4] = angleToSpawn;
		}
		energy -= partingGift;
	}
}