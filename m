Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AAC44306E
	for <lists+linux-spi@lfdr.de>; Tue,  2 Nov 2021 15:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBOdx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 2 Nov 2021 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKBOdv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Nov 2021 10:33:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23CC061714
        for <linux-spi@vger.kernel.org>; Tue,  2 Nov 2021 07:31:16 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhuoi-0006Af-GS; Tue, 02 Nov 2021 15:31:12 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhuof-004FRU-PC; Tue, 02 Nov 2021 15:31:09 +0100
Message-ID: <96ea286255e411c194eadd418bd82336830557c8.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] SPI: Add SPI driver for Sunplus SP7021
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "LH.Kuo" <lhjeff911@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Date:   Tue, 02 Nov 2021 15:31:09 +0100
In-Reply-To: <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
         <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2021-11-01 at 14:18 +0800, LH.Kuo wrote:
[...]
> +static int pentagram_spi_controller_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +	int mode;
> +	unsigned int max_freq;
> +	struct spi_controller *ctlr;
> +	struct pentagram_spi_master *pspim;
> +
> +	FUNC_DBG();

Drop these.

[...]
> +	/* clk*/
> +	pspim->spi_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pspim->spi_clk)) {
> +		dev_err(&pdev->dev, "devm_clk_get fail\n");
> +		goto free_alloc;
> +	}
> +	ret = clk_prepare_enable(pspim->spi_clk);

Move this and reset_control_deassert() as far back as possible.

> +	if (ret)
> +		goto free_alloc;
> +
> +	/* reset*/
> +	pspim->rstc = devm_reset_control_get(&pdev->dev, NULL);

Use devm_reset_control_get_exclusive() instead.
This should be done before clk_prepare_enable().

> +	dev_dbg(&pdev->dev, "pspim->rstc : 0x%x\n", (unsigned int)pspim->rstc);
> +	if (IS_ERR(pspim->rstc)) {
> +		ret = PTR_ERR(pspim->rstc);
> +		dev_err(&pdev->dev, "SPI failed to retrieve reset controller: %d\n", ret);
> +		goto free_clk;
> +	}
> +	ret = reset_control_deassert(pspim->rstc);

Same as the clock, I'd move this after the dma allocations.

> +	if (ret)
> +		goto free_clk;
> +
> +	/* dma alloc*/
> +	pspim->tx_dma_vir_base = dma_alloc_coherent(&pdev->dev, bufsiz,
> +					&pspim->tx_dma_phy_base, GFP_ATOMIC);

Consider using dmam_alloc_coherent, same for rx_dma_vir_base.

regards
Philipp
