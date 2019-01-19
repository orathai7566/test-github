from tabulate import tabulate
import redis

redis_host = "localhost"
redis_port = 6379
redis_password = ""


print('Hello Please introduce yourself to us.')
first_name_list = []
last_name_list = []
age_list = []
job_position_list = []
data=[]
input_string = 'word'
while input_string != None:
        first_name = input("What is your name? ")
        last_name = input("What is your surename? ")
        age = input("What is your age? ")
        job_position = input("What is your position of work? ")
        if first_name != '' and last_name != '' and age != '' and job_position != '':
            first_name_list.append(first_name)
            last_name_list.append(last_name)
            age_list.append(age)
            job_position_list.append(job_position)
            data = [first_name_list, last_name_list, age_list, job_position_list]
            print(tabulate([[first_name, last_name, age, job_position]],
                           headers=['Name', 'Surename', 'Age', 'Job Position']))
            first_name = ''
            last_name = ''
            age = ''
            job_position = ''
        else:
            table = zip(data[0], data[1], data[2], data[3])
            print(tabulate(table,headers=['Name', 'Surename', 'Age', 'Job Position']))
            break


def hello_redis():

    input_string = 'word'
    i = 1
    while input_string != None:
        try:
            redis = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)
            msg_select_chore = input("What do you do? ")

            if msg_select_chore == 'Add':
                while msg_select_chore != 'Add':
                    print('A')
                    redis.set(f'user_add_chore{i}', f'{input("name:")} {input("surename:")}{input("age:")} {input("position:")}')
                    msg_insert_chore = redis.get(f'user_add_chore{i}')
                    insert_result = """\
                    Insert successfuly
                    Result data of you
                    """
                    print(f'{insert_result}{msg_insert_chore}')

            elif msg_select_chore == 'Delete':
               print('D')

            else:
                print('S')
            i+=1

        except Exception as e:
           print(e)


if __name__ == '__main__':
    hello_redis()

