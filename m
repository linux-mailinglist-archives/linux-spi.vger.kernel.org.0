Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1302B4258
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgKPLMe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 06:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgKPLMe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 06:12:34 -0500
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Nov 2020 03:12:34 PST
Received: from mx2.mailbox.org (mx2a.mailbox.org [IPv6:2001:67c:2050:104:0:2:25:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72426C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 03:12:34 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 14707A0E18;
        Mon, 16 Nov 2020 12:05:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id fuAU4mW-USTn; Mon, 16 Nov 2020 12:05:26 +0100 (CET)
Subject: Re: [PATCH for-5.10] spi: mt7621: Don't leak SPI master in probe
 error path
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <800f7035a29c1ae65386f2e17a2b5ef9d2b39268.1605512876.git.lukas@wunner.de>
From:   Stefan Roese <sr@denx.de>
Message-ID: <be0493ac-cc02-c79a-afa9-48e959a8442f@denx.de>
Date:   Mon, 16 Nov 2020 12:05:25 +0100
MIME-Version: 1.0
In-Reply-To: <800f7035a29c1ae65386f2e17a2b5ef9d2b39268.1605512876.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.81 / 15.00 / 15.00
X-Rspamd-Queue-Id: E30291778
X-Rspamd-UID: e63e3f
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16.11.20 09:23, Lukas Wunner wrote:
> If the calls to device_reset() or devm_spi_register_controller() fail on
> probe of the MediaTek MT7621 SPI driver, the spi_controller struct is
> erroneously not freed.  Fix by switching over to the new
> devm_spi_alloc_master() helper.
> 
> Moreover, the SYS clock is enabled on probe but not disabled if any of
> the subsequent probe steps fails.
> 
> Finally, there's an ordering issue in mt7621_spi_remove() wherein
> the spi_controller is unregistered after disabling the SYS clock.
> The correct order is to call spi_unregister_controller() *before* this
> teardown step because bus accesses may still be ongoing until that
> function returns.
> 
> All of these bugs have existed since the driver was first introduced,
> so it seems fair to fix them together in a single commit.
> 
> Fixes: 1ab7f2a43558 ("staging: mt7621-spi: add mt7621 support")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org> # v4.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
> Cc: <stable@vger.kernel.org> # v4.17+

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/spi/spi-mt7621.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index 2c3b7a2a1ec7..d7cda66c4b26 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -350,10 +350,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	if (status)
>   		return status;
>   
> -	master = spi_alloc_master(&pdev->dev, sizeof(*rs));
> +	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rs));
>   	if (!master) {
>   		dev_info(&pdev->dev, "master allocation failed\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_clk_disable;
>   	}
>   
>   	master->mode_bits = SPI_LSB_FIRST;
> @@ -377,10 +378,18 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	ret = device_reset(&pdev->dev);
>   	if (ret) {
>   		dev_err(&pdev->dev, "SPI reset failed!\n");
> -		return ret;
> +		goto err_clk_disable;
>   	}
>   
> -	return devm_spi_register_controller(&pdev->dev, master);
> +	ret = spi_register_controller(master);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(clk);
> +	return ret;
>   }
>   
>   static int mt7621_spi_remove(struct platform_device *pdev)
> @@ -391,6 +400,7 @@ static int mt7621_spi_remove(struct platform_device *pdev)
>   	master = dev_get_drvdata(&pdev->dev);
>   	rs = spi_controller_get_devdata(master);
>   
> +	spi_unregister_controller(master);
>   	clk_disable_unprepare(rs->clk);
>   
>   	return 0;
> 
