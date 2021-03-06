module CalCentralPages

  class MyAcademicsStatusAndBlocksCard < MyAcademicsPage

    include PageObject
    include CalCentralPages
    include ClassLogger

    table(:status_table, :class => 'cc-academics-status-holds-blocks-status-table')
    span(:reg_status_summary, :xpath => '//tr[@data-ng-if="api.user.profile.features.regstatus"]//span[@data-ng-bind="studentInfo.regStatus.summary"]')
    div(:reg_status_explanation, :xpath => '//td[@data-ng-bind-html="studentInfo.regStatus.explanation"]')
    image(:reg_status_icon_green, :xpath => '//tr[@data-ng-if="api.user.profile.features.regstatus"]//i[@class="cc-icon fa fa-check-circle cc-icon-green"]')
    image(:reg_status_icon_red, :xpath => '//tr[@data-ng-if="api.user.profile.features.regstatus"]//i[@class="cc-icon fa fa-exclamation-circle cc-icon-red"]')

    span(:res_status_summary, :xpath => '//span[@data-ng-bind="residency.description"]')
    image(:res_status_icon_green, :xpath => '//th[contains(.,"California Residency")]/following-sibling::td//i[@class="cc-icon fa fa-check-circle cc-icon-green ng-scope"]')
    image(:res_status_icon_gold, :xpath => '//th[contains(.,"California Residency")]/following-sibling::td//i[@class="cc-icon fa fa-warning cc-icon-gold ng-scope"]')
    image(:res_status_icon_red, :xpath => '//th[contains(.,"California Residency")]/following-sibling::td//i[@class="cc-icon fa fa-exclamation-circle cc-icon-red ng-scope"]')
    link(:res_slr_submit_link, :xpath => '//a[contains(text(),"Statement of Legal Residence")]')
    link(:res_slr_status_link, :xpath => '//a[contains(text(),"check the status of your submission")]')
    link(:res_info_link, :xpath => '//a[contains(text(),"residency information")]')

    h3(:active_blocks_heading, :xpath => '//h3[text()="Active Blocks"]')
    table(:active_blocks_table, :xpath => '//div[@data-ng-if="regblocks.activeBlocks.length"]/table')
    cell(:active_block_message, :xpath => '//td[@data-cc-compile-directive="block.message"]')
    div(:no_active_blocks_message, :xpath => '//div[contains(text(),"You have no active blocks at this time.")]')

    button(:show_block_history_button, :xpath => '//button[contains(.,"Show Block History")]')
    button(:hide_block_history_button, :xpath => '//button[contains(.,"Hide Block History")]')
    table(:inactive_blocks_table, :xpath => '//h3[text()="Block History"]/following-sibling::div/table')
    paragraph(:no_inactive_blocks_message, :xpath => '//p/strong[contains(text(),"No block history")]')

    def show_block_history
      WebDriverUtils.wait_for_page_and_click show_block_history_button_element
    end

    def hide_block_history
      WebDriverUtils.wait_for_page_and_click hide_block_history_button_element
    end

    def active_block_count
      active_blocks_table_element.when_visible WebDriverUtils.academics_timeout
      active_blocks_table_element.rows - 1
    end

    def active_block_types
      types = active_blocks_table_element.map { |row| row[0].text }
      types.drop 1
    end

    def active_block_reasons
      reasons = active_blocks_table_element.map { |row| row[1].text }
      reasons.drop 1
    end

    def active_block_offices
      offices = active_blocks_table_element.map { |row| row[2].text }
      offices.drop 1
    end

    def active_block_dates
      dates = active_blocks_table_element.map { |row| row[3].text }
      dates.drop 1
    end

    def inactive_block_count
      inactive_blocks_table_element.rows - 1
    end

    def inactive_block_types
      types = inactive_blocks_table_element.map { |row| row[0].text }
      types.drop 1
    end

    def inactive_block_dates
      dates = inactive_blocks_table_element.map { |row| row[1].text }
      dates.drop 1
    end

    def inactive_block_cleared_dates
      dates = inactive_blocks_table_element.map { |row| row[2].text }
      dates.drop(1).sort!
    end
  end
end
