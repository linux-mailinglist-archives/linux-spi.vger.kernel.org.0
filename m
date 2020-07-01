Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2A2115ED
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGAWYg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgGAWYf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD938207E8;
        Wed,  1 Jul 2020 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642275;
        bh=ZtxAWjE39NzDXq1FuKkTxOe+E45NfjwE+SIqZVm1Mc4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=IZ2hld1te52uSRaSEG8MzyydRr3eAK26MFEWmUHeE7ADAMJanlrHGSwbXDdDkUhVJ
         uEIeLFBCq7LXdK94aFKKbQsrcbUdyvqNy8grnWaxIqajDMkNUPEIZcTsryzpB72zX1
         eIf+Fr8+GQK+U6E/KBV1iXNfXiZK4Iaq4q2XXLXs=
Date:   Wed, 01 Jul 2020 23:24:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        swboyd@chromium.org, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid>
References: <20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid>
Subject: Re: [PATCH] spi: Avoid setting the chip select if we don't need to
Message-Id: <159364224814.10988.2511800063055608801.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 29 Jun 2020 16:41:06 -0700, Douglas Anderson wrote:
> On some SPI controllers (like spi-geni-qcom) setting the chip select
> is a heavy operation.  For instance on spi-geni-qcom, with the current
> code, is was measured as taking upwards of 20 us.  Even on SPI
> controllers that aren't as heavy, setting the chip select is at least
> something like a MMIO operation over some peripheral bus which isn't
> as fast as a RAM access.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Avoid setting the chip select if we don't need to
      commit: d40f0b6f2e21f2400ae8b1b120d11877d9ffd8ec

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
