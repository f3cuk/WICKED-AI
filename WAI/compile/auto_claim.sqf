			if (!_claimed) then {
			
				// Find the closest player and send an alert
				if (isNull _closestPlayer) then {
					_closestPlayer = _position call wai_isClosest; // Find the closest player
					[_closestPlayer,_name,"Start"] call wai_AutoClaimAlert; // Send alert
					_claimTime = diag_tickTime; // Set the time variable for countdown
				};
				
				// After the delay time, check player's location and either claim or not claim
				if ((diag_tickTime - _claimTime) > ac_delay_time) then {
					if ((_closestPlayer distance _position) > ac_alert_distance) then {
						[_closestPlayer,_name,"Stop"] call wai_AutoClaimAlert; // Send alert to player who is closest
						_closestPlayer = objNull; // Set to default
						_acArray = []; // Set to default
					} else {
						_claimed = true;
						[_closestPlayer,_name,"Claimed"] call wai_AutoClaimAlert; // Send alert to all players
						_acArray = [getplayerUID _closestPlayer, name _closestPlayer]; // Add player UID and name to array
					};
				};
			};
			
			if (_claimed) then {
				
				// Used in the marker when a player has left the mission area
				_leftTime = round (ac_timeout - (diag_tickTime - _claimTime));
				
				// If the player dies at the mission, change marker to countdown and set player variable to null
				if ((!alive _closestPlayer) && !_left) then {
					_closestPlayer = objNull; // Set the variable to null to prevent null player errors
					_claimTime = diag_tickTime; // Set the time for countdown
					_left = true; // Changes the marker to countdown
				};
				
				// Check to see if the dead player has returned to the mission
				if (isNull _closestPlayer) then {
					_closestPlayer = [_position,_acArray] call wai_checkReturningPlayer;
				};
				
				// Notify the player that he/she is outside the mission area
				if (!(isNull _closestPlayer) && ((_closestPlayer distance _position) > ac_alert_distance) && !_left) then {
					[_closestPlayer,_name,"Return"] call wai_AutoClaimAlert;
					_claimTime = diag_tickTime; // Set the time for the countdown
					_left = true; // Set the mission marker to countdown
				};
				
				// If the player returns to the mission before the clock runs out then change the marker
				if (!(isNull _closestPlayer) && ((_closestPlayer distance _position) < ac_alert_distance) && _left) then {
					[_closestPlayer,_name,"Reclaim"] call wai_AutoClaimAlert;
					_left = false; // Change the mission marker back to claim
				};
				
				// If the player lets the clock run out, then set the mission to unclaimed and set the variables to default
				// Player left the server
				if ((isNull _closestPlayer) && ((diag_tickTime - _claimTime) > ac_timeout)) then {
					[_acArray ,_name,"Unclaim"] call wai_AutoClaimAlert; // Send alert to all players
					_claimed = false;
					_left = false;
					_acArray = [];
				} else {
					// Player is alive but did not return to the mission
					if (((diag_tickTime - _claimTime) > ac_timeout) && ((_closestPlayer distance _position) > ac_alert_distance)) then {
						[_closestPlayer,_name,"Unclaim"] call wai_AutoClaimAlert; // Send alert to all players
						_closestPlayer = objNull;
						_claimed = false;
						_left = false;
						_acArray = [];
						
					};
				};
			};