Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CA739CE9F
	for <lists+linux-spi@lfdr.de>; Sun,  6 Jun 2021 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFFKtZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 6 Jun 2021 06:49:25 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:49011 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFKtY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 6 Jun 2021 06:49:24 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B576A2801E137;
        Sun,  6 Jun 2021 12:47:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A7AB42D42A1; Sun,  6 Jun 2021 12:47:33 +0200 (CEST)
Date:   Sun, 6 Jun 2021 12:47:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-spi@vger.kernel.org, jon.lin@rock-chips.com,
        broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC v4 2/8] spi: rockchip-sfc: add rockchip serial flash
 controller
Message-ID: <20210606104733.GA30175@wunner.de>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
 <20210604151055.28636-3-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604151055.28636-3-macroalpha82@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 04, 2021 at 10:10:49AM -0500, Chris Morgan wrote:
> +static int rockchip_sfc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_master *master;
> +	struct resource *res;
> +	struct rockchip_sfc *sfc;
> +	int ret;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(*sfc));

You need to use devm_spi_alloc_master() here because you're not
freeing the allocation in any of the probe error paths.

> +	if (!master) {
> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");
> +		return -ENOMEM;
> +	}

The dev_err() is superfluous as the memory allocator will dump a
stack trace anyway on allocation failure.

> +	ret = clk_prepare_enable(sfc->hclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable ahb clk\n");
> +		goto err_hclk;
> +	}

Return directly here and get rid of the err_hclk label.

> +	ret = devm_spi_register_master(dev, master);

You need to use spi_register_master() here (*not* the devm variant)
and add spi_unregister_master() at the top of rockchip_sfc_remove().

The reason is that ->remove() is executed *before* devres resources
are freed and rockchip_sfc_remove() disables the clocks, presumably
rendering the chip inaccessible.

However the chip may be performing SPI transfers until
spi_unregister_master() returns, so the chip needs to be accessible
as long.

Because you're using devm_spi_register_master(), the chip may try
to perform SPI transfers even though its clocks have been disabled.
So you've got an ordering problem with the devm variant.

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Rockchip Serial Flash Controller Driver");
> +MODULE_AUTHOR("Shawn Lin <shawn.lin@rock-chips.com>");

Why isn't Shawn Lin cc'ed or gets commit authorship even though they're
the driver author?

Thanks,

Lukas
