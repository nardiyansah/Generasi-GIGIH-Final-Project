require_relative '../../controllers/userController'
require_relative '../../db_connector'
require 'mysql2'

RSpec.describe 'user controller' do
    db_client = create_db_client

    before(:each) do
        db_client.query('SET FOREIGN_KEY_CHECKS = 0')
        db_client.query('TRUNCATE users')
        db_client.query('SET FOREIGN_KEY_CHECKS = 1')
    end

    describe 'initialize controller' do
        it 'should contain db client that will be pass to model' do
            controller = UserController.new(db_client)

            expect(controller.db_client).to_not be_nil
            expect(controller.db_client).to be_an_instance_of(Mysql2::Client)
        end
    end

    describe 'create new account' do
        it 'should create account' do
            data = {"username" => "foo", "email" => "foo@mail.com"}
            controller = UserController.new(db_client)

            controller.create(data)
            id = db_client.last_id

            stored_data = db_client.query("SELECT * FROM users WHERE id = #{id}").each[0]

            expect(stored_data['username']).to eq(data['username'])
            expect(stored_data['email']).to eq(data['email'])
        end

        it 'should cannot create acount with same email' do
            data = {"username" => "foo", "email" => "foo@mail.com"}
            controller = UserController.new(db_client)

            controller.create(data)
            status = controller.create(data)

            expect(status).to eq(406)
        end

        it 'should not accept request withoud data' do
            controller = UserController.new(db_client)

            status = controller.create(nil)
            expect(status).to eq(400)

            status = controller.create({"username" => ""})
            expect(status).to eq(400)

            status = controller.create({"username" => "", "email" => "foo@mail.com"})
            expect(status).to eq(400)
        end
    end

    describe 'update data account' do
        it 'should change data account with specific id' do
            data = {"username" => "foo", "email" => "foo@mail.com"}
            controller = UserController.new(db_client)

            controller.create(data)
            
            id = db_client.last_id
            data['bio'] = 'i am foo'

            status = controller.update(id, data)

            expect(status).to eq(200)
        end
    end

end