INSERT INTO public.organizations(
	id, name, inserted_at, updated_at)
	VALUES (1, 'Roman Empire');

	
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
	INSERT INTO roles (id, name, organization_id) 
	SELECT uuid_generate_v1(), 'super-admin', 1;
	
INSERT INTO public.accounts(
	id, email, hash_password)
	VALUES ('3210ec0b-a076-4a73-beb5-d9ac75b35cd6', 'ramzesball@gmail.com', 
			'$2b$12$2g9ODTHsMFlpKUPd.44iO.6Cxbd9d7sQn6lNISME.iZxSCV9bpdVW');
	
	
INSERT INTO public.users(
	id, full_name, gender, biography, account_id, organization_id)
	VALUES (1, 'Roman Alberda', '', '', 
			'3210ec0b-a076-4a73-beb5-d9ac75b35cd6', '3210ec0b-a076-4a73-beb5-d9ac75b35cd6');

INSERT INTO public.roles(
	id, full_name, gender, biography, account_id, organization_id)
	VALUES (1, 'Roman Alberda', '', '', 
			'3210ec0b-a076-4a73-beb5-d9ac75b35cd6', '3210ec0b-a076-4a73-beb5-d9ac75b35cd6');


INSERT INTO public.roles(
	id, name, organization_id)
	SELECT uuid_generate_v1(), 'roman', 1