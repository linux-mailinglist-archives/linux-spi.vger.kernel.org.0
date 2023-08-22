Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797037846A7
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHVQOW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHVQOW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 12:14:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33779CDA
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 09:14:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RVZCN5qYyz6HJbJ;
        Wed, 23 Aug 2023 00:13:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 17:14:16 +0100
Date:   Tue, 22 Aug 2023 17:14:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Li Zetao <lizetao1@huawei.com>
CC:     <broonie@kernel.org>, <chin-ting_kuo@aspeedtech.com>,
        <clg@kaod.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <florian.fainelli@broadcom.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <fancer.lancer@gmail.com>, <olteanv@gmail.com>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <linus.walleij@linaro.org>,
        <heiko@sntech.de>, <linux-spi@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH -next 24/25] spi: spl022: Use helper function
 devm_clk_get_enabled()
Message-ID: <20230822171414.00003a69@Huawei.com>
In-Reply-To: <20230822131237.1022815-25-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
        <20230822131237.1022815-25-lizetao1@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 22 Aug 2023 21:12:36 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> Moreover, the label "err_no_clk_en" is no used, drop it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
Hi.

There is some odd formatting in the existing file, but cleaning that up
should probably be a separate patch.

Thanks,

Jonathan

> ---
>  drivers/spi/spi-pl022.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 1af75eff26b6..468a7fea9091 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2168,19 +2168,13 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev_info(&adev->dev, "mapped registers from %pa to %p\n",
>  		&adev->res.start, pl022->virtbase);
>  
> -	pl022->clk = devm_clk_get(&adev->dev, NULL);
> +	pl022->clk = devm_clk_get_enabled(&adev->dev, NULL);
>  	if (IS_ERR(pl022->clk)) {
>  		status = PTR_ERR(pl022->clk);
>  		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
>  		goto err_no_clk;
>  	}
>  
> -	status = clk_prepare_enable(pl022->clk);
> -	if (status) {
> -		dev_err(&adev->dev, "could not enable SSP/SPI bus clock\n");
> -		goto err_no_clk_en;
> -	}
> -
>  	/* Initialize transfer pump */
>  	tasklet_init(&pl022->pump_transfers, pump_transfers,
>  		     (unsigned long)pl022);
> @@ -2236,16 +2230,14 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	return 0;
>  
> - err_spi_register:
> +err_spi_register:
>  	if (platform_info->enable_dma)
>  		pl022_dma_remove(pl022);
> - err_no_irq:
> -	clk_disable_unprepare(pl022->clk);
> - err_no_clk_en:
> - err_no_clk:
> - err_no_ioremap:
> +err_no_irq:
> +err_no_clk:
> +err_no_ioremap:
>  	amba_release_regions(adev);
> - err_no_ioregion:
> +err_no_ioregion:
>  	spi_master_put(master);
>  	return status;
>  }
> @@ -2268,7 +2260,6 @@ pl022_remove(struct amba_device *adev)
>  	if (pl022->master_info->enable_dma)
>  		pl022_dma_remove(pl022);
>  
> -	clk_disable_unprepare(pl022->clk);
>  	amba_release_regions(adev);
>  	tasklet_disable(&pl022->pump_transfers);
>  }

