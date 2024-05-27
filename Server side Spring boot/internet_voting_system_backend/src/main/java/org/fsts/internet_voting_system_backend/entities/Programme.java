package org.fsts.internet_voting_system_backend.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Fetch;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
public class Programme {
    @Id
    private String programmeId;
    private String programmeTitle;
    private String programmeDescription;
    private Date creationDate;

    @ManyToOne(fetch = FetchType.EAGER)
    private Room programmeRoom;

    @ManyToOne(fetch = FetchType.EAGER)
    private UserApp creator;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Vote> voteList = new ArrayList<>();


}
