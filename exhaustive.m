%% exhaustive feature selection

combinations = nchoosek(features, 5);
n = size(combinations, 1);
 label=table2array(label);
    per_class_accuracy_table=[];
for i = 1061:2476
    f1 = (eval(combinations{i, 1}));
    f2 = (eval(combinations{i, 2}));
      f3 = (eval(combinations{i, 3}));
      f4 = (eval(combinations{i, 4}));
        f5 = (eval(combinations{i, 5}));
    f1=table2array(f1);
     f2=table2array(f2);
     f3=table2array(f3);
      f4=table2array(f4);
     f5=table2array(f5);
    data = [f1 f2 f3 f4 f5 label];