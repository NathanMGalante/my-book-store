package nathan.mg.api.config;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import jakarta.persistence.EntityNotFoundException;

@RestControllerAdvice
public class ExceptionsManager {
	
	@ExceptionHandler(EntityNotFoundException.class)
	public ResponseEntity<?> exception404() {
		return ResponseEntity.notFound().build();
	}
	
	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<?> exception400(MethodArgumentNotValidException ex) {
		var errors = ex.getFieldErrors();
		return ResponseEntity.badRequest().body(errors.stream().map(ErrorValidation::new).toList());
	}
	
	private record ErrorValidation(String field, String message) {
		public ErrorValidation(FieldError error) {
			this(error.getField(), error.getDefaultMessage());
		}
	}
	
}
