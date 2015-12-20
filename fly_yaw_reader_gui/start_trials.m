function [ output_args ] = start_trials( run_obj )

stim_type = run_obj.stim_type;

if(strcmp(stim_type, 'Task File') == 1)
    
    task_file_path = run_obj.taskfile_path;
    
    tasks = read_task_file(task_file_path);
    task_cnt = length(tasks);
    
    scanimage_client_skt = '';
    if(run_obj.using_2p == 1)
        scan_image_client_skt = connect_to_scanimage();
    end
        
    viz_figs.run_traj_fig = figure();
    viz_figs.velocity_tc_fig = figure();
    session_id = run_obj.session_id;
    
    for i = 1:task_cnt
        cur_task = tasks{i};        
        
        [trial_bdata, trial_time] = run_trial(i, cur_task, run_obj, scanimage_client_skt );
        display_trial( cur_task, trial_time, trial_bdata, viz_figs );        

        % Save data              
        cur_trial_file_name = [ run_obj.experiment_dir '\trial_bdata_' datestr(now, 'yyyy_mmdd_HH_MM_SS') '_sid_' num2str(session_id) '_tid_' num2str(i-1) '.mat' ];
        save( cur_trial_file_name, 'trial_bdata', 'trial_time' );
        
        % wait for an inter-trial period
        if( i < task_cnt )
            disp(['Finished with trial: ' num2str(i-1) '. Waiting for ' num2str(run_obj.inter_trial_t) ' seconds till next trial']);
            pause(run_obj.inter_trial_t);
        end
    end    
       
    if(run_obj.using_2p == 1)
        flose(scan_image_client_skt);
    end
    
    % Save viz figures
    saveas( viz_figs.run_traj_fig, [run_obj.experiment_dir '\run_traj_' datestr(now, 'yyyy_mmdd_HH_MM_SS') '_sid_' num2str(session_id) '.fig'] );
    saveas( viz_figs.velocity_tc_fig, [run_obj.experiment_dir '\velocity_tc_' datestr(now, 'yyyy_mmdd_HH_MM_SS') '_sid_' num2str(session_id) '.fig'] );
    
    % Update session id    
    set(run_obj.sessiod_id_hdl, 'String', num2str(session_id+1));
    
    disp('Trials complete.')
else
    
    disp(stim_type);
    disp(['ERROR: stim_type: ' stim_type ' is not supported.']);
end

end

