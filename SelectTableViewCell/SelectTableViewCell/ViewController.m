//
//  ViewController.m
//  SelectTableViewCell
//
//  Created by chenshunyi on 2017/12/8.
//  Copyright © 2017年 house365. All rights reserved.
//

#import "ViewController.h"
#import "SYTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *editArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    _tableView.editing = !_tableView.editing;
}
-(NSMutableArray *)editArr{
    if (!_editArr) {
        _editArr = [NSMutableArray array];
    }
    return _editArr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.editArr isKindOfClass:[NSMutableArray class]]){
        NSMutableArray *array = (NSMutableArray *)self.editArr;
        for (id value in array) {
            NSInteger index = [value integerValue];
            if (indexPath.row == index) {
                [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }
    SYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SYTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld个cell",indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {//设置左滑编辑的文本
    NSLog(@"董亚杰的修改");
    NSLog(@"修改  测试git工具");
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.editing){//----通过表视图是否处于编辑状态来选择是左滑删除，还是多选删除。
        //当表视图处于没有未编辑状态时选择多选删除
        return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.isEditing) {
        NSArray *subviews = [[tableView cellForRowAtIndexPath:indexPath] subviews];
        for (id subCell in subviews) {
            if ([subCell isKindOfClass:[UIControl class]]) {
                
                for (UIImageView *circleImage in [subCell subviews]) {
                    circleImage.image = [UIImage imageNamed:@"favEditSelect.png"];
                }
            }
        }
        [self.editArr addObject:@(indexPath.row)];
    }else{
        NSLog(@"非编辑状态逻辑");
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *subviews = cell.subviews;
    for (id subCell in subviews) {
        if ([subCell isKindOfClass:[UIControl class]]) {
            for (UIImageView *circleImage in [subCell subviews]) {
                circleImage.image = [UIImage imageNamed:@"favEditUnSelect.png"];
            }
        }
    }
    [self.editArr removeObject:@(indexPath.row)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
