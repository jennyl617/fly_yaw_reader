function [ output_args ] = start_trials( run_obj )

stim_type = run_obj.stim_type;

if(strcmp(stim_type, 'Task File') == 1)
    
    task_file_path = ru_obj.task_file_path;
    
    tasks = read_task_file(task_file_path);
    task_cnt = length(tasks);
    
    scanimage_client_skt = '';
    if(run_obj.using_2 == 1)
        scan_image_client_skt = connect_to_scanimage();
    end
        
    viz_figs.run_traj_fig = figure();
    viz_figs.velocity_tc_fig = figure();
    
    for i = 1:task_cnt
        cur_task = tasks{i};        
        
        [trial_bdata, trial_time] = run_trial(i, cur_task, run_obj, scanimage_client_skt );
        display_trial( cur_task, trial_time, trial_bdata, viz_figs );        
    end    
       
    if(run_obj.using_2 == 1)
        flose(scan_image_client_skt);
    end
    
else
    disp(['ERROR: stim_type: ' stim_type ' is not supported.']);
end

end

