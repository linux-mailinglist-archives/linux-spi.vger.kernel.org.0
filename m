Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B7785E5D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjHWRPM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjHWRPM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 13:15:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46433198
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 10:15:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RWCR621vMz67Ldy;
        Thu, 24 Aug 2023 01:10:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 18:15:07 +0100
Date:   Wed, 23 Aug 2023 18:15:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Li Zetao <lizetao1@huawei.com>, <andrew@aj.id.au>,
        <angelogioacchino.delregno@collabora.com>,
        <avifishman70@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <chin-ting_kuo@aspeedtech.com>, <clg@kaod.org>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <florian.fainelli@broadcom.com>, <heiko@sntech.de>,
        <jbrunet@baylibre.com>, <joel@jms.id.au>, <khilman@baylibre.com>,
        <linus.walleij@linaro.org>, <linux-amlogic@lists.infradead.org>,
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
Subject: Re: [PATCH -next v2 12/25] spi: dw-mmio: Use helper function
 devm_clk_get_*()
Message-ID: <20230823181506.00007731@Huawei.com>
In-Reply-To: <pflv2canelmm3ea7zpqgxrzj3s7cl56crpdbupkgqlabfnasjj@dkfyiubao2gj>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
        <20230823133938.1359106-1-lizetao1@huawei.com>
        <20230823133938.1359106-13-lizetao1@huawei.com>
        <pflv2canelmm3ea7zpqgxrzj3s7cl56crpdbupkgqlabfnasjj@dkfyiubao2gj>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Aug 2023 17:20:12 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Wed, Aug 23, 2023 at 09:39:25PM +0800, Li Zetao wrote:
> > Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> > and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> > replaced by devm_clk_get_enabled() when driver enables (and possibly
> > prepares) the clocks for the whole lifetime of the device. Moreover, it is
> > no longer necessary to unprepare and disable the clocks explicitly. Also,
> > devm_clk_get_optional() and clk_prepare_enable() can now be replaced by
> > devm_clk_get_optional_enabled(). Moreover, the lable "out_clk" no longer
> > makes sense, rename it to "out_reset".
> > 
> > Signed-off-by: Li Zetao <lizetao1@huawei.com>
> > ---
> > v1 -> v2: Return directly instead of calling reset_control_deassert()
> > before the reset control handler has been requested. And use the
> > "out_reset" label instead of "out" before calling pm_runtime_enable().  
> 
> LGTM. Thanks!
> Acked-by: Serge Semin <fancer.lancer@gmail.com>
Agreed - looks much better now.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> -Serge(y)
> 
> > 
> >  drivers/spi/spi-dw-mmio.c | 31 +++++++++----------------------
> >  1 file changed, 9 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 805264c9c65c..46801189a651 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -340,29 +340,20 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  	if (dws->irq < 0)
> >  		return dws->irq; /* -ENXIO */
> >  
> > -	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
> > +	dwsmmio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> >  	if (IS_ERR(dwsmmio->clk))
> >  		return PTR_ERR(dwsmmio->clk);
> > -	ret = clk_prepare_enable(dwsmmio->clk);
> > -	if (ret)
> > -		return ret;
> >  
> >  	/* Optional clock needed to access the registers */
> > -	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
> > -	if (IS_ERR(dwsmmio->pclk)) {
> > -		ret = PTR_ERR(dwsmmio->pclk);
> > -		goto out_clk;
> > -	}
> > -	ret = clk_prepare_enable(dwsmmio->pclk);
> > -	if (ret)
> > -		goto out_clk;
> > +	dwsmmio->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
> > +	if (IS_ERR(dwsmmio->pclk))
> > +		return PTR_ERR(dwsmmio->pclk);
> >  
> >  	/* find an optional reset controller */
> >  	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
> > -	if (IS_ERR(dwsmmio->rstc)) {
> > -		ret = PTR_ERR(dwsmmio->rstc);
> > -		goto out_clk;
> > -	}
> > +	if (IS_ERR(dwsmmio->rstc))
> > +		return PTR_ERR(dwsmmio->rstc);
> > +
> >  	reset_control_deassert(dwsmmio->rstc);
> >  
> >  	dws->bus_num = pdev->id;
> > @@ -383,7 +374,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  	if (init_func) {
> >  		ret = init_func(pdev, dwsmmio);
> >  		if (ret)
> > -			goto out;
> > +			goto out_reset;
> >  	}
> >  
> >  	pm_runtime_enable(&pdev->dev);
> > @@ -397,9 +388,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  
> >  out:
> >  	pm_runtime_disable(&pdev->dev);
> > -	clk_disable_unprepare(dwsmmio->pclk);
> > -out_clk:
> > -	clk_disable_unprepare(dwsmmio->clk);
> > +out_reset:
> >  	reset_control_assert(dwsmmio->rstc);
> >  
> >  	return ret;
> > @@ -411,8 +400,6 @@ static void dw_spi_mmio_remove(struct platform_device *pdev)
> >  
> >  	dw_spi_remove_host(&dwsmmio->dws);
> >  	pm_runtime_disable(&pdev->dev);
> > -	clk_disable_unprepare(dwsmmio->pclk);
> > -	clk_disable_unprepare(dwsmmio->clk);
> >  	reset_control_assert(dwsmmio->rstc);
> >  }
> >  
> > -- 
> > 2.34.1
> >   
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

