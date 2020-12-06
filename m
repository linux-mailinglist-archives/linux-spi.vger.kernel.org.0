Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C242D067A
	for <lists+linux-spi@lfdr.de>; Sun,  6 Dec 2020 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLFSQ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 6 Dec 2020 13:16:59 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:55513 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLFSQ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 6 Dec 2020 13:16:58 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3FBB3282269E8;
        Sun,  6 Dec 2020 19:15:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EB15EF67; Sun,  6 Dec 2020 19:16:12 +0100 (CET)
Date:   Sun, 6 Dec 2020 19:16:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <20201206181612.GA26286@wunner.de>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
> +	ret = devm_spi_register_master(&pdev->dev, master);
[...]
> +static int tegra_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct tegra_qspi_data	*tqspi = spi_master_get_devdata(master);
> +
> +	free_irq(tqspi->irq, tqspi);
> +
> +	tegra_qspi_deinit_dma_param(tqspi, false);
> +	tegra_qspi_deinit_dma_param(tqspi, true);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		tegra_qspi_runtime_suspend(&pdev->dev);
> +
> +	return 0;
> +}

With devm_spi_register_master(), the SPI controller is unregistered
*after* tegra_qspi_remove().  SPI transactions may still be ongoing
until the SPI controller is unregistered, yet you perform teardown
steps (such as freeing the IRQ) while it is still registered.

Bottom line is, you can't use devm_spi_register_master() in this case.
You need to use spi_register_master() and explicitly call
spi_unregister_master() in tegra_qspi_remove() *before* performing
teardown steps.

However, be sure to use the devm variant to *allocate* the SPI controller,
i.e. use devm_spi_alloc_master() instead of spi_alloc_master().

Thanks,

Lukas
