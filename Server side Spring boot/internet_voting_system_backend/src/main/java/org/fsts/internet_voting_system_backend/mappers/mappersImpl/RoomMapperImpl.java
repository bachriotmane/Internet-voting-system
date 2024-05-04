package org.fsts.internet_voting_system_backend.mappers.mappersImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.RoomDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.mappers.RoomMapper;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
@AllArgsConstructor
@Component
public class RoomMapperImpl implements RoomMapper {
    private final UserService userService;
    private final ProgrammeService programmeService;



    @Override
    public Room fromDTO(RoomDTO roomDto) {

        List<UserApp> roomMembers = new ArrayList<>();
        List<Programme> roomProgrammes = new ArrayList<>();
       roomDto.programmeListId().forEach((progId) ->{
            roomProgrammes.add(programmeService.getProgrammeById(progId).get());
        });
        roomDto.roomMembersId().forEach((userId) ->{
            roomMembers.add(userService.getUserById(userId).get());
        });

        return  Room.builder()
                .roomId(roomDto.roomId())
                .roomCreator(userService.getUserById(roomDto.roomCreatorId()).get())
                .roomDescription(roomDto.roomDescription())
                .title(roomDto.title())
                .startAt(roomDto.startAt())
                .expireAt(roomDto.expireAt())
                .createAt(roomDto.createAt())
                .programmeList(roomProgrammes)
                .roomMembers(roomMembers)
                .code(roomDto.code())
                .build();
    }

    @Override
    public RoomDTO fromEntity(Room room) {
        List<String> roomMemberIds = new ArrayList<>();
        List<String> roomProgrammeIds = new ArrayList<>();
        room.getProgrammeList().forEach((prog) ->{
            roomProgrammeIds.add(prog.getProgrammeId());
        });
        room.getRoomMembers().forEach((user) ->{
            roomMemberIds.add(user.getUserId());
        });

        return  RoomDTO.builder()
                .roomId(room.getRoomId())
                .code(room.getCode())
                .programmeListId(roomProgrammeIds)
                .createAt(room.getCreateAt())
                .expireAt(room.getExpireAt())
                .roomCreatorId(room.getRoomCreator().getUserId())
                .roomDescription(room.getRoomDescription())
                .roomMembersId(roomMemberIds)
                .startAt(room.getStartAt())
                .title(room.getTitle())
                .build();

    }
}
