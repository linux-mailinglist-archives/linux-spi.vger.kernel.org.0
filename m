Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33267785E4E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjHWRKj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjHWRKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 13:10:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26746E7C
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 10:10:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RWCPp3qVPz6HJb9;
        Thu, 24 Aug 2023 01:09:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 18:10:33 +0100
Date:   Wed, 23 Aug 2023 18:10:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Li Zetao <lizetao1@huawei.com>
CC:     <andrew@aj.id.au>, <angelogioacchino.delregno@collabora.com>,
        <avifishman70@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <chin-ting_kuo@aspeedtech.com>, <clg@kaod.org>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <fancer.lancer@gmail.com>, <florian.fainelli@broadcom.com>,
        <heiko@sntech.de>, <jbrunet@baylibre.com>, <joel@jms.id.au>,
        <khilman@baylibre.com>, <linus.walleij@linaro.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
        <matthias.bgg@gmail.com>, <neil.armstrong@linaro.org>,
        <olteanv@gmail.com>, <openbmc@lists.ozlabs.org>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <tali.perry1@gmail.com>, <tmaimon77@gmail.com>,
        <venture@google.com>, <yuenn@google.com>
Subject: Re: [PATCH -next v2 02/25] spi: armada-3700: Use helper function
 devm_clk_get_prepared()
Message-ID: <20230823181032.00001455@Huawei.com>
In-Reply-To: <20230823133938.1359106-3-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
        <20230823133938.1359106-1-lizetao1@huawei.com>
        <20230823133938.1359106-3-lizetao1@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Wed, 23 Aug 2023 21:39:15 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare() can now be replaced
> by devm_clk_get_prepared() when driver prepares the clocks for the whole
> lifetime of the device. Moreover, it is no longer necessary to unprepare
> the clocks explicitly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v1 -> v2: Drop the empty remove function a3700_spi_remove().
> 
>  drivers/spi/spi-armada-3700.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> index 0103ac0158c0..3c9ed412932f 100644
> --- a/drivers/spi/spi-armada-3700.c
> +++ b/drivers/spi/spi-armada-3700.c
> @@ -865,18 +865,12 @@ static int a3700_spi_probe(struct platform_device *pdev)
>  
>  	init_completion(&spi->done);
>  
> -	spi->clk = devm_clk_get(dev, NULL);
> +	spi->clk = devm_clk_get_prepared(dev, NULL);
>  	if (IS_ERR(spi->clk)) {
>  		dev_err(dev, "could not find clk: %ld\n", PTR_ERR(spi->clk));
>  		goto error;
>  	}
>  
> -	ret = clk_prepare(spi->clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare clk: %d\n", ret);
> -		goto error;
> -	}
> -
>  	host->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
>  					clk_get_rate(spi->clk));
>  	host->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
> @@ -888,40 +882,29 @@ static int a3700_spi_probe(struct platform_device *pdev)
>  			       dev_name(dev), host);
>  	if (ret) {
>  		dev_err(dev, "could not request IRQ: %d\n", ret);
> -		goto error_clk;
> +		goto error;
>  	}
>  
>  	ret = devm_spi_register_controller(dev, host);
>  	if (ret) {
>  		dev_err(dev, "Failed to register host\n");
> -		goto error_clk;
> +		goto error;
>  	}
>  
>  	return 0;
>  
> -error_clk:
> -	clk_unprepare(spi->clk);
>  error:
>  	spi_controller_put(host);
>  out:
>  	return ret;
>  }
>  
> -static void a3700_spi_remove(struct platform_device *pdev)
> -{
> -	struct spi_controller *host = platform_get_drvdata(pdev);
> -	struct a3700_spi *spi = spi_controller_get_devdata(host);
> -
> -	clk_unprepare(spi->clk);
> -}
> -
>  static struct platform_driver a3700_spi_driver = {
>  	.driver = {
>  		.name	= DRIVER_NAME,
>  		.of_match_table = of_match_ptr(a3700_spi_dt_ids),
>  	},
>  	.probe		= a3700_spi_probe,
> -	.remove_new	= a3700_spi_remove,
>  };
>  
>  module_platform_driver(a3700_spi_driver);

