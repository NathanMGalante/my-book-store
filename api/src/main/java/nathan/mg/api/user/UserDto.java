package nathan.mg.api.user;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import nathan.mg.api.store.StoreRequestDto;

public record UserDto(
		@NotBlank
		String name,
		@NotBlank
		@Email
		String email,
		@NotBlank
		String password,
		String photo,
		@Valid
		StoreRequestDto store
) {}
