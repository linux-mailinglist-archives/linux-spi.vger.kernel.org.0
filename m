Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEC2760B3
	for <lists+linux-spi@lfdr.de>; Wed, 23 Sep 2020 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIWTBi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Sep 2020 15:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWTBi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Sep 2020 15:01:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA5721D92;
        Wed, 23 Sep 2020 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600887698;
        bh=Igc65mvAGJbOqQmdVgC2uSf7g2Il4NU4ki+TAP+5LMk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=alykKdChnZebxBOcghM0qWxNbVmg102PZk+TuO+MpjND7M79iYBOTRos7nNATHo+W
         rpF1xjcaBqCh5w6YxzEY6o86lf1cLEyujKnJIe1sOtlUTotI7LI4YcHy/XJsi6Ovl3
         zY2Cubv5qvUF2X8q67FuB7cagMZjngc7uR2w7/bM=
Date:   Wed, 23 Sep 2020 20:00:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org
Cc:     kernel@pengutronix.de, Vladimir Oltean <olteanv@gmail.com>
In-Reply-To: <20200923131026.20707-1-s.hauer@pengutronix.de>
References: <20200923131026.20707-1-s.hauer@pengutronix.de>
Subject: Re: [PATCH] spi: fsl-dspi: fix use-after-free in remove path
Message-Id: <160088764365.36195.16185348610086043664.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Sep 2020 15:10:26 +0200, Sascha Hauer wrote:
> spi_unregister_controller() not only unregisters the controller, but
> also frees the controller. This will free the driver data with it, so
> we must not access it later dspi_remove().
> 
> Solve this by allocating the driver data separately from the SPI
> controller.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: fix use-after-free in remove path
      commit: 530b5affc675ade5db4a03f04ed7cd66806c8a1a

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
