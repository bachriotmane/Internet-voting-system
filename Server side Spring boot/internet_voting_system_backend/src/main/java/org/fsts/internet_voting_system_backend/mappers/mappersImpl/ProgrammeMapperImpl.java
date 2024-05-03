package org.fsts.internet_voting_system_backend.mappers.mappersImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.ProgrammeDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.ProgrammeMapper;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@Component
public class ProgrammeMapperImpl implements ProgrammeMapper {
    private final RoomService roomService ;
    private final VoteService voteService;

    @Override
    public Programme fromDTO(ProgrammeDTO programmeDTO){
        Programme programme = new Programme();
        programme.setProgrammeId(programmeDTO.programmeId());
        programme.setProgrammeTitle(programme.getProgrammeTitle());
        programme.setProgrammeDescription(programme.getProgrammeDescription());
        Room room = roomService.getRoomById(programmeDTO.programmeRoom());
        programme.setProgrammeRoom(room);
        programme.setCreationDate(programmeDTO.creationDate());
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
        return new ProgrammeDTO(programme.getProgrammeId(), programme.getProgrammeTitle(), programme.getProgrammeDescription(), programme.getProgrammeRoom().getRoomId(),programme.getCreationDate(), voteIds);
    }
}
