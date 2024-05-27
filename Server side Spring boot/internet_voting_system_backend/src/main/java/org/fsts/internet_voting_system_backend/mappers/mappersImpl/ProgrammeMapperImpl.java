package org.fsts.internet_voting_system_backend.mappers.mappersImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.ProgrammeDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.ProgrammeMapper;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@Component
public class ProgrammeMapperImpl implements ProgrammeMapper {
    private final RoomService roomService ;
    private final VoteService voteService;
    private final UserAppRepository userService;

    @Override
    public Programme fromDTO(ProgrammeDTO programmeDTO){
        Programme programme = new Programme();

        programme.setProgrammeId(programmeDTO.programmeId());
        programme.setProgrammeTitle(programmeDTO.programmeTitle());
        programme.setProgrammeDescription(programmeDTO.programmeDescription());
        Optional<Room> room = roomService.getRoomById(programmeDTO.programmeRoom());
        programme.setProgrammeRoom(room.get());
        programme.setCreationDate(programmeDTO.creationDate());
        UserApp creator = userService.findUserAppByUsername(programmeDTO.creatorUserName());
        programme.setCreator(creator);
        List<Vote> voteList= new ArrayList<>();
        for (String voteId : programmeDTO.voteIds()){
            Vote vote = voteService.getVoteById(voteId);
            voteList.add(vote);
        }
        programme.setVoteList(voteList);
        return programme;
    }

    @Override
    public ProgrammeDTO fromEntity(Programme programme){
        List<String> voteIds = new ArrayList<>();
        for(Vote vote : programme.getVoteList()){
            voteIds.add(vote.getVoteId());
        }
        return new ProgrammeDTO(programme.getProgrammeId(), programme.getProgrammeTitle(), programme.getProgrammeDescription(), programme.getProgrammeRoom().getRoomId(),programme.getCreationDate(), voteIds, programme.getCreator().getUsername());
    }
}
