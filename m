Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FEC91D4B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2019 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfHSGq1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Aug 2019 02:46:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:34045 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSGq1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Aug 2019 02:46:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 23:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="377334420"
Received: from mylly.fi.intel.com (HELO [10.237.72.162]) ([10.237.72.162])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2019 23:46:25 -0700
Subject: Re: [PATCH] spi: pxa2xx: restore lpss state after resume
To:     Curtis Malainey <cujomalainey@chromium.org>,
        linux-spi@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20190816223333.144924-1-cujomalainey@chromium.org>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <b9c7bb4f-e115-670a-99df-af37e7e299b0@linux.intel.com>
Date:   Mon, 19 Aug 2019 09:46:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816223333.144924-1-cujomalainey@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 8/17/19 1:33 AM, Curtis Malainey wrote:
> On broadwell machines it has been observed that the registers do not
> maintain their state through a suspend resume cycle. This is given that
> after a suspend resume cycle the SW CS bit is no longer set. This can
> break reads as CS will now be asserted between transmissions in messages
> and therefore reset the slave device unintentionally.
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index fc7ab4b268802..3f313a9755640 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1913,6 +1913,9 @@ static int pxa2xx_spi_resume(struct device *dev)
>   			return status;
>   	}
>   
> +	if (is_lpss_ssp(drv_data))
> +		lpss_ssp_setup(drv_data);
> +
>   	/* Start the queue running */
>   	return spi_controller_resume(drv_data->controller);
>   }

So there is actually a regression caused by my b53548f9d9e4 ("spi: 
pxa2xx: Remove LPSS private register restoring during resume").

Which suggests to me there may be need to save/restore other private 
registers too.

Do you Andy or Heikki remember why this LPSS context save/restore wasn't 
implemented for Lynxpoint? I was testing my above commit on a Haswell 
based machine which didn't need it but apparently Broadwell needs.

Curtis: would a diff below fix the issue you are seeing? I added context 
save/restore for I2C and UART controllers too.

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index d696f165a50e..60bbc5090abe 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -219,12 +219,13 @@ static void bsw_pwm_setup(struct lpss_private_data 
*pdata)
  }

  static const struct lpss_device_desc lpt_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
+			| LPSS_SAVE_CTX,
  	.prv_offset = 0x800,
  };

  static const struct lpss_device_desc lpt_i2c_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR | LPSS_SAVE_CTX,
  	.prv_offset = 0x800,
  };

@@ -236,7 +237,8 @@ static struct property_entry uart_properties[] = {
  };

  static const struct lpss_device_desc lpt_uart_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
+			| LPSS_SAVE_CTX,
  	.clk_con_id = "baudclk",
  	.prv_offset = 0x800,
  	.setup = lpss_uart_setup,
