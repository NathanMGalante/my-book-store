package nathan.mg.api.store;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Store {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String slogan;
    @Column(columnDefinition = "LONGTEXT", nullable = true)
    private String banner;

    public Store(StoreDto store) {
        this.name = store.name();
        this.slogan = store.slogan();
        this.banner = store.banner();
    }
}
