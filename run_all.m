% Запуск всей лабораторной. Файлы результатов перезаписываются при новом запуске.
labRoot = fileparts(mfilename('fullpath'));
addpath(labRoot);
resultsDir = fullfile(labRoot,'results');
if ~exist(resultsDir,'dir'), mkdir(resultsDir); end
logPath = fullfile(resultsDir,'run_log.txt');
if exist(logPath,'file'), delete(logPath); end
diary(logPath);
diaryCleanup = onCleanup(@() diary('off'));
existingFigures = findall(groot,'Type','figure');
cfg = lab_config();
pre = preliminary();
r1 = task1(); r2 = task2(); r3 = task3();
r4 = task4(); r5 = task5(); r6 = task6();
save(fullfile(resultsDir,'lab2_results.mat'),'cfg','pre','r1','r2','r3','r4','r5','r6');
figures = setdiff(findall(groot,'Type','figure'),existingFigures);
if ~isempty(figures)
    [~,order] = sort(arrayfun(@(f) f.Number,figures));
    figures = figures(order);
end
for t = 1:numel(figures)
    set(figures(t),'PaperPositionMode','auto','InvertHardcopy','off');
    print(figures(t),fullfile(resultsDir,sprintf('figure_%02d.png',t)),'-dpng','-r150','-painters');
end
fprintf('\nВсе проверки пройдены. Результаты сохранены в %s\n',resultsDir);
diary off;
clear diaryCleanup;
