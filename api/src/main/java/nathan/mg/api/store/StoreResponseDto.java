package nathan.mg.api.store;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotBlank;

public record StoreResponseDto(
		Long id,
		LocalDateTime creationDateTime,
		@NotBlank
		String name,
		@NotBlank
		String slogan,
		String banner
) {
	
	public StoreResponseDto(Store store) {
		this(store.getId(), store.getCreationDateTime(),store.getName(), store.getSlogan(), store.getBanner());
	}
}
