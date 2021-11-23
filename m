Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADA845A35C
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhKWNBf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 08:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhKWNBf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Nov 2021 08:01:35 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Nov 2021 04:58:27 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A4C061574;
        Tue, 23 Nov 2021 04:58:27 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C491110176B2C;
        Tue, 23 Nov 2021 13:48:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9BD2530A8C7; Tue, 23 Nov 2021 13:48:27 +0100 (CET)
Date:   Tue, 23 Nov 2021 13:48:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvorkin@tibbo.com,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <20211123124827.GA22253@wunner.de>
References: <cover.1637547799.git.lh.kuo@sunplus.com>
 <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 10:33:32AM +0800, LH.Kuo wrote:
> +static int sp7021_spi_controller_probe(struct platform_device *pdev)
> +{
[...]
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "spi_register_master fail\n");
> +		goto disable_runtime_pm;
> +	}

You need to use spi_register_controller() here (*not* the devm_ variant)
because you're using spi_unregister_controller() in
sp7021_spi_controller_remove().

> +
> +	// clk
> +	pspim->spi_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pspim->spi_clk)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pspim->spi_clk),
> +				     "devm_clk_get fail\n");
> +	}
> +
> +	// reset
> +	pspim->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	dev_dbg(&pdev->dev, "pspim->rstc : 0x%x\n", (unsigned int)pspim->rstc);
> +	if (IS_ERR(pspim->rstc)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pspim->rstc),
> +				     "devm_rst_get fail\n");
> +	}
> +
> +	ret = clk_prepare_enable(pspim->spi_clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +			"failed to enable clk\n");
> +
> +	ret = reset_control_deassert(pspim->rstc);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			"failed to deassert reset\n");
> +		goto free_reset_assert;
> +
> +	}

You need to move the above steps *before* the call to
spi_register_controller().  Once spi_register_controller() returns,
it must be able to perform SPI transactions.  So you have to enable
all required clocks before calling it.  You also have to perform the
reset step before registration to avoid interfering with an ongoing
transaction.  The order of these steps must mirror the order in
sp7021_spi_controller_remove():  There you're unregistering the
controller *before* disabling the clock and asserting reset,
so the order must be inverted here.


> +static int sp7021_spi_controller_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
> +	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +
> +	spi_unregister_controller(pspim->ctlr);
> +	clk_disable_unprepare(pspim->spi_clk);
> +	reset_control_assert(pspim->rstc);
> +
> +	return 0;
> +}

I think the two calls to pm_runtime_* should be moved after
spi_unregister_controller() but that's probably not critical.

Thanks,

Lukas
