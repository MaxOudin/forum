RSpec.describe ArticlePolicy do
  let(:user) { build(:user) } # Crée un utilisateur
  let(:article) { build(:article, user: user) } # Crée un article lié à l'utilisateur

  subject { described_class.new(user, article) } # Utilise ArticlePolicy.new sans factory

  context 'when user is not authenticated' do
    let(:user) { nil } # Utilisateur non authentifié

    it 'forbids the create/update/destroy action' do
      expect(subject).to forbid_action(:create)
      expect(subject).to forbid_action(:update)
      expect(subject).to forbid_action(:destroy)
    end

    it 'allows the show action' do
      expect(subject).to permit_action(:show)
    end
  end

  context 'when user is authenticated' do
    let(:user) { build(:user) } # Crée un utilisateur

    it 'permits the create/update/destroy action' do
      expect(subject).to permit_action(:create)
    end
  end

  context 'when user is authenticated and article is public' do
    let(:user) { build(:user) } # Crée un utilisateur
    let(:article) { build(:article, public: true) } # Crée un article public

    it 'permits the show action' do
      expect(subject).to permit_action(:show)
    end

    it 'forbids the update action' do
      expect(subject).to forbid_action(:update)
    end
  end

  context 'when user is authenticated and article is not public' do
    let(:user) { build(:user) } # Crée un utilisateur
    let(:article) { build(:article, public: false) } # Crée un article non public

    it 'forbids the show action' do
      expect(subject).to forbid_action(:show)
    end
  end

  context 'when user updates an article that they authored' do
    it 'permits the update action' do
      expect(subject).to permit_action(:update)
    end
  end

  context 'when user updates an article that they did not author' do
    let(:other_user) { build(:user) } # Crée un autre utilisateur
    let(:article) { build(:article, user: other_user) } # Crée un article lié à l'autre utilisateur

    it 'forbids the update action' do
      expect(subject).to forbid_action(:update)
      expect(subject).to forbid_action(:destroy)
    end
  end

  context 'when user is an admin' do
    let(:user) { build(:user, :admin) } # Crée un administrateur

    it 'permits index action' do
      expect(subject).to permit_action(:index)
      expect(subject).to permit_action(:update)
      expect(subject).to permit_action(:destroy)
    end
  end

end
