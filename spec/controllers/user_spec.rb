require_relative '../../controllers/userController'
require_relative '../../db_connector'
require 'mysql2'

RSpec.describe 'user controller' do
    db_client = create_db_client

    describe 'initialize controller' do
        it 'should contain db client that will be pass to model' do
            controller = UserController.new(db_client)

            expect(controller.db_client).to_not be_nil
            expect(controller.db_client).to be_an_instance_of(Mysql2::Client)
        end
    end
end