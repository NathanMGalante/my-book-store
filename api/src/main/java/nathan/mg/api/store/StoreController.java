package nathan.mg.api.store;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import nathan.mg.api.user.Role;
import nathan.mg.api.user.User;
import nathan.mg.api.user.UserDto;
import nathan.mg.api.user.UserRepository;

@RestController
@RequestMapping("stores")
public class StoreController {
	
	@Autowired
	private StoreRepository repository;
	
	@Autowired
    private UserRepository userRepository; 
	
	@PostMapping
	@Transactional
	public void register(@RequestBody @Valid UserDto user) {
        Store store = new Store(user.store());
        
        User admin = new User(user, store, Role.ADMIN);
        
        repository.save(store);
        userRepository.save(admin);
	}
	
	@GetMapping
	public Page<StoreResponseDto> getStores(@PageableDefault(size = 10, sort = {"name"}) Pageable pagination) {
        return repository.findAll(pagination).map(StoreResponseDto::new);
	}

}














