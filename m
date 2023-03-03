Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36566A9DB6
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCCRaW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 3 Mar 2023 12:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCCRaU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:30:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F6E858B59
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:30:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B47106F;
        Fri,  3 Mar 2023 09:31:02 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03EEB3F67D;
        Fri,  3 Mar 2023 09:30:17 -0800 (PST)
Date:   Fri, 3 Mar 2023 17:30:15 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 75/87] spi: sun6i: Convert to platform remove callback
 returning void
Message-ID: <20230303173015.620567b2@donnerap.cambridge.arm.com>
In-Reply-To: <20230303172041.2103336-76-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
        <20230303172041.2103336-76-u.kleine-koenig@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri,  3 Mar 2023 18:20:29 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/spi/spi-sun6i.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 23ad052528db..43c29afea6bb 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -683,7 +683,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int sun6i_spi_remove(struct platform_device *pdev)
> +static void sun6i_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master = platform_get_drvdata(pdev);
>  
> @@ -693,7 +693,6 @@ static int sun6i_spi_remove(struct platform_device *pdev)
>  		dma_release_channel(master->dma_tx);
>  	if (master->dma_rx)
>  		dma_release_channel(master->dma_rx);
> -	return 0;
>  }
>  
>  static const struct of_device_id sun6i_spi_match[] = {
> @@ -710,7 +709,7 @@ static const struct dev_pm_ops sun6i_spi_pm_ops = {
>  
>  static struct platform_driver sun6i_spi_driver = {
>  	.probe	= sun6i_spi_probe,
> -	.remove	= sun6i_spi_remove,
> +	.remove_new = sun6i_spi_remove,
>  	.driver	= {
>  		.name		= "sun6i-spi",
>  		.of_match_table	= sun6i_spi_match,

