Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8B21CCE5
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 03:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGMBxQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Jul 2020 21:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMBxQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 12 Jul 2020 21:53:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9C32068F;
        Mon, 13 Jul 2020 01:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594605195;
        bh=E07fs/fFtZfacNtML4TOsGjkQOlBjfF+Cm++G1ijnDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sk41Pf64ApswXUutH0w0I1dOSDQwfUhQ/AEcOJyYQzwnIJ+/wuCHhta+t86gPaetw
         0QFIjvraXYUV/3NwWhmlcwBlZx+mVxjVdOi21kF4qrRJ7xKpxZ3t+VK86c399xMBZx
         GsQJBp2Bx2YTjx4ok8d6M5iv1kOhzsUYCq2LHxVM=
Date:   Mon, 13 Jul 2020 09:53:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] spi: imx/fsl-lpspi: Convert to GPIO descriptors
Message-ID: <20200713015308.GS21277@dragon>
References: <20200625200252.207614-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625200252.207614-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 25, 2020 at 10:02:52PM +0200, Linus Walleij wrote:
> This converts the two Freescale i.MX SPI drivers
> Freescale i.MX (CONFIG_SPI_IMX) and Freescale i.MX LPSPI
> (CONFIG_SPI_FSL_LPSPI) to use GPIO descriptors handled in
> the SPI core for GPIO chip selects whether defined in
> the device tree or a board file.
> 
> The reason why both are converted at the same time is
> that they were both using the same platform data and
> platform device population helpers when using
> board files intertwining the code so this gives a cleaner
> cut.
> 
> The platform device creation was passing a platform data
> container from each boardfile down to the driver using
> struct spi_imx_master from <linux/platform_data/spi-imx.h>,
> but this was only conveying the number of chipselects and
> an int * array of the chipselect GPIO numbers.
> 
> The imx27 and imx31 platforms had code passing the
> now-unused platform data when creating the platform devices,
> this has been repurposed to pass around GPIO descriptor
> tables. The platform data struct that was just passing an
> array of integers and number of chip selects for the GPIO
> lines has been removed.
> 
> The number of chipselects used to be passed from the board
> file, because this number also limits the number of native
> chipselects that the platform can use. To deal with this we
> just augment the i.MX (CONFIG_SPI_IMX) driver to support 3
> chipselects if the platform does not define "num-cs" as a
> device property (such as from the device tree). This covers
> all the legacy boards as these use <= 3 native chip selects
> (or GPIO lines, and in that case the number of chip selects
> is determined by the core from the number of available
> GPIO lines). Any new boards should use device tree, so
> this is a reasonable simplification to cover all old
> boards.
> 
> The LPSPI driver never assigned the number of chipselects
> and thus always fall back to the core default of 1 chip
> select if no GPIOs are defined in the device tree.
> 
> The Freescale i.MX driver was already partly utilizing
> the SPI core to obtain the GPIO numbers from the device tree,
> so this completes the transtion to let the core handle all
> of it.
> 
> All board files and the core i.MX boardfile registration
> code is augmented to account for these changes.
> 
> This has been compile-tested with the imx_v4_v5_defconfig
> and the imx_v6_v7_defconfig.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Trent Piepho <tpiepho@impinj.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
