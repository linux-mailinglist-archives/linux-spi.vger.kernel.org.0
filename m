Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD851F911B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgFOINC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 15 Jun 2020 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOINC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 04:13:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33636C061A0E
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 01:13:02 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jkkEl-00012a-JS; Mon, 15 Jun 2020 10:12:59 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jkkEj-0004Fe-Rl; Mon, 15 Jun 2020 10:12:57 +0200
Message-ID: <141ae52bdd22079ae5f88dd50c31cac2cc150676.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] spi: bcm63xx-spi: add reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 15 Jun 2020 10:12:57 +0200
In-Reply-To: <20200615080309.2897694-2-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
         <20200615080309.2897694-2-noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Álvaro,

On Mon, 2020-06-15 at 10:03 +0200, Álvaro Fernández Rojas wrote:
> bcm63xx arch resets the SPI controller at early boot. However, bmips arch
> needs to perform a reset when probing the driver.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  drivers/spi/spi-bcm63xx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 0f1b10a4ef0c..8ab04affaf7b 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/reset.h>
>  
>  /* BCM 6338/6348 SPI core */
>  #define SPI_6348_RSET_SIZE		64
> @@ -493,6 +494,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
>  	struct bcm63xx_spi *bs;
>  	int ret;
>  	u32 num_cs = BCM63XX_SPI_MAX_CS;
> +	struct reset_control *reset;
>  
>  	if (dev->of_node) {
>  		const struct of_device_id *match;
> @@ -529,6 +531,15 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
>  		return PTR_ERR(clk);
>  	}
>  
> +	reset = devm_reset_control_get(dev, NULL);

Please use devm_reset_control_get_exclusive(), same for patch 3.
With that changed,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
