module errors

pub struct PixError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err PixError) msg() string {
	return err.message
}
