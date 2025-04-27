package nathan.mg.api.user;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UserDto(
		@NotBlank
		String name,
		@NotBlank
		@Email
		String email,
		@NotBlank
		@Pattern(regexp = "\\d{6,10}")
		String password,
		String photo
) {}
