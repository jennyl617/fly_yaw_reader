function [ output_args ] = start_trials_JL( run_obj )

task_cnt = run_obj.num_trials;

scanimage_client_skt = '';
if(run_obj.using_2p == 1)
    scanimage_client_skt = connect_to_scanimage();
    disp(['Connected to scanimage server on socket.']);
end
        
viz_figs.run_traj_fig = figure();
session_id = run_obj.session_id;
    
for i = 1:task_cnt
    exp_type = run_obj.loop_types_str;    
    
    cur_task = select_trial(run_obj.loop_types_str, i, task_cnt);        

    cur_trial_corename = [cur_task '_' datestr(now, 'yyyymmdd_HHMMSS') '_sid_' num2str(session_id) '_tid_' num2str(i-1)];

    [trial_bdata, trial_time] = run_trial_JL(i, cur_trial, run_obj, scanimage_client_skt, cur_trial_corename );

    display_trial_JL( trial_time, trial_bdata, viz_figs, run_obj.experiment_dir );        

    % Save data              
    cur_trial_file_name = [ run_obj.experiment_dir '\bdata_' cur_trial_corename '.mat' ];
    save( cur_trial_file_name, 'trial_bdata', 'trial_time' );

    % wait for an inter-trial period
    if( i < task_cnt )
        disp(['Finished with trial: ' num2str(i-1) '. Waiting for ' num2str(run_obj.inter_trial_t) ' seconds till next trial']);
        pause(run_obj.inter_trial_t);
    end
end    

if(run_obj.using_2p == 1)
    fprintf(scanimage_client_skt, 'END_OF_SESSION');
    fclose(scanimage_client_skt);
end

% Save viz figures       
saveas( viz_figs.run_traj_fig, [run_obj.experiment_dir '\run_traj_' datestr(now, 'yyyy_mmdd_HH_MM_SS') '_sid_' num2str(session_id) '.fig'] );
%saveas( viz_figs.velocity_tc_fig, [run_obj.experiment_dir '\velocity_tc_' datestr(now, 'yyyy_mmdd_HH_MM_SS') '_sid_' num2str(session_id) '.fig'] );

% Update session id    
set(run_obj.session_id_hdl, 'String', num2str(session_id+1));

disp('Trials complete.');

end

%% This function helps determine trial type
function trial = select_trial(exp_type, trial_num, total_trials)
if ( strcmp(task, 'Closed Loop') == 1 )
    trial = 'ClosedLoop';
elseif ( strcmp(task, 'Open Loop') == 1 )
    trial = 'OpenLoop';
elseif ( strcmp(task, 'Optokinetic') == 1 )
    trial_types = {'OpenLoopRight', 'OpenLoopLeft');
    choice = randi(2,1);
    trial = trial_types{choice};
end

end
