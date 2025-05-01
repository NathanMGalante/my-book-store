package nathan.mg.api.store;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Store {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false, updatable = false)
    private LocalDateTime creationDateTime;
    
    
    private String name;
    private String slogan;
    @Column(columnDefinition = "LONGTEXT", nullable = true)
    private String banner;

    public Store(StoreDto store) {
    	this.creationDateTime = LocalDateTime.now();
        this.name = store.name();
        this.slogan = store.slogan();
        this.banner = store.banner();
    }
}
