module tests

import pix.v1 as pix

fn test_get_participants_pix() {
	if pixs := pix.get_participants() {
		assert pixs.len > 0
	} else {
		assert false
	}
}
