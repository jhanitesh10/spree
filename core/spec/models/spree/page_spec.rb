require 'spec_helper'

describe Spree::Page, type: :model do
  let(:store) { create(:store) }
  let(:theme) { create(:theme, store: store) }
  let(:page) { theme.pages.first }

  context 'slugs' do
    let(:custom_page) { create(:page, pageable: theme, type: 'Spree::Pages::Custom', name: 'Landing Page') }

    it 'should only generate slugs for custom pages' do
      expect(page.slug).to be_nil

      expect(custom_page.slug).not_to be_nil
      expect(custom_page.slug).to eq('landing-page')
    end
  end

  describe '#create_preview' do
    it 'should create a preview' do
      expect { page.create_preview }.to change { page.previews.count }.by(1)

      new_preview = page.previews.last
      expect(new_preview.parent).to eq(page)

      expect(new_preview.sections.count).to eq(page.sections.count)
      expect(new_preview.sections.map(&:display_name)).to contain_exactly(*page.sections.map(&:display_name))
    end
  end

  describe '#promote' do
    let!(:page_preview) { page.create_preview }

    it 'should promote the preview to the main page' do
      expect { page_preview.promote }.to change { page_preview.parent }.from(page).to(nil).and change { Spree::Page.count }.by(-1)

      expect(page_preview.reload.preview?).to be(false)
    end
  end
end
