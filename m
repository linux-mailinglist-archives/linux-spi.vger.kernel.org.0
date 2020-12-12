Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1682D8658
	for <lists+linux-spi@lfdr.de>; Sat, 12 Dec 2020 13:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438835AbgLLMGw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Dec 2020 07:06:52 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:52445 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390904AbgLLMGv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Dec 2020 07:06:51 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A8B682800A287;
        Sat, 12 Dec 2020 13:05:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2758D110C0; Sat, 12 Dec 2020 13:06:08 +0100 (CET)
Date:   Sat, 12 Dec 2020 13:06:08 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        bbrezillon@kernel.org, p.yadav@ti.com, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] spi: tegra210-quad: Add support for Tegra210 QSPI
 controller
Message-ID: <20201212120608.GA24303@wunner.de>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
 <1607721363-8879-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607721363-8879-5-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 11, 2020 at 01:15:58PM -0800, Sowjanya Komatineni wrote:
> Tegra SoC has a Quad SPI controller starting from Tegra210.

The probe/remove hooks LGTM now.  Just two tiny nits that caught my eye:


> +	master = devm_spi_alloc_master(&pdev->dev, sizeof(*tqspi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "failed to allocate spi_master\n");
> +		return -ENOMEM;
> +	}

The memory allocater already emits an error message if it can't satisfy
a request.  Emitting an additional message here isn't really necessary.


> +exit_free_irq:
> +	free_irq(qspi_irq, tqspi);
> +exit_pm_disable:
> +	pm_runtime_disable(&pdev->dev);
> +	tegra_qspi_deinit_dma(tqspi);
> +	return ret;
> +}
> +
> +static int tegra_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
> +
> +	spi_unregister_master(master);
> +	free_irq(tqspi->irq, tqspi);
> +	tegra_qspi_deinit_dma(tqspi);
> +	pm_runtime_disable(&pdev->dev);

The order of tegra_qspi_deinit_dma() and pm_runtime_disable() is
reversed in the remove hook vis-a-vis the probe error path.
It's nicer to use the same order as in the probe error path.

Thanks,

Lukas
