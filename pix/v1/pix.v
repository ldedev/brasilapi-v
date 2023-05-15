module v1

import json
import net.http
import pix.errors { PixError }

// https://brasilapi.com.br/docs#tag/PIX
const uri_pix = 'https://brasilapi.com.br/api/pix/v1'

// get_participants Retorna informações de todos os participantes do PIX no dia atual ou anterior
//
// https://brasilapi.com.br/docs#tag/PIX/paths/~1pix~1v1~1participants/get
//
// Exemplo de uso:
// ```v
// if pixs := pix.get_participants() {
//  dump(pixs)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.PixError
pub fn get_participants() ![]Pix {
	uri := '${v1.uri_pix}/participants'

	resp := http.get(uri) or { return PixError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(PixError, resp.body) or { return PixError{
			message: err.msg()
		} }
	}

	temp_pix := json.decode([]TempPix, resp.body) or { return PixError{
		message: err.msg()
	} }

	return temp_pix.get_pix() or { [] }
}
