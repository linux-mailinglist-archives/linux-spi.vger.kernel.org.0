Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F64222F88
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 02:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGPX6V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 19:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C8B20760;
        Thu, 16 Jul 2020 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943900;
        bh=dJo9kb4YBE6Pgvpr6n4Zd+8VS1tf2cegsNKG4P8EmYg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=boLZUyu1ctS28LcswoTG1uu4Duuw7z35fsuAGBITmdl48usvMejqhnN7Kl0orqKxz
         yagX4N7/kBA2R46MivdQQBzPOk18pufuX3mhRcE/F2gI+txPkji3bE1o2/nHU/FCZ5
         xrQxMzZlK4GCOMl1fr1ddq0MQGY1JaZ0n81nRmYs=
Date:   Fri, 17 Jul 2020 00:58:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
In-Reply-To: <20200709074120.110069-1-mkl@pengutronix.de>
References: <20200709074120.110069-1-mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] spi: bcm2835/bcm2835aux: support effective_speed_hz
Message-Id: <159494389042.42455.5858455166841706248.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 9 Jul 2020 09:41:18 +0200, Marc Kleine-Budde wrote:
> I've picked up and forward ported Martin Sperl's patches which add support for
> effective_speed_hz to the SPI controllers found on all raspberry pi models.
> 
> See the following patch, which adds this feature to the SPI core, for more
> information:
> 
>     5d7e2b5ed585 spi: core: allow reporting the effectivly used speed_hz for a transfer
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: bcm2835: support effective_speed_hz
      commit: 9df2003df79a0f763dbf76891fcc7d4a5141861d
[2/2] spi: bcm2835aux: support effective_speed_hz
      commit: 5e94c3cdaa29e28f6739c91a74d9ddd96f4ba6b6

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
