package nathan.mg.api.store;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import nathan.mg.api.shared.Role;
import nathan.mg.api.user.User;
import nathan.mg.api.user.UserRepository;

@RestController
@RequestMapping("store")
public class StoreController {
	
	@Autowired
	private StoreRepository storeRepository;
	
	@Autowired
    private UserRepository userRepository; 
	
	@PostMapping
	@Transactional
	public void register(@RequestBody @Valid StoreDto storeDto) {
        User admin = new User(storeDto.admin());
        admin.setRole(Role.ADMIN);
        userRepository.save(admin);
        
        Store store = new Store(storeDto);
        store.setAdmin(admin);
        storeRepository.save(store);
	}
	
}
