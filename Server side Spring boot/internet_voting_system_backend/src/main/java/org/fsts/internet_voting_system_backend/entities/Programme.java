package org.fsts.internet_voting_system_backend.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.*;

import java.time.LocalDate;
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
    private LocalDate creationDate;

    @ManyToOne
    private Room programmeRoom;

    @OneToMany
    private List<Vote> voteList;


}
