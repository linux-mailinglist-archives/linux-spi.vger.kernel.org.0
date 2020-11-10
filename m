Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C6E2ADB2A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgKJQDX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 11:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgKJQDW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Nov 2020 11:03:22 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80388206E3;
        Tue, 10 Nov 2020 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605024202;
        bh=tYzebxvvIl+AqH/gZPnCqLFWNKnltjbTDEax/CxRhkQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=x4R2xD+FKIx0hjei+c+BjzooCPbKqnMRRXDPHvU4CwIExRp9QziSSp5PRCL21njC9
         hJxnvbOsSHRBQzgkk/NFMnwIZkT7tDlNVcs3v1L3ueJQNKuhcOp8gTVN4KIhj18drY
         RSqt8q4IjREGQaXfTP4fai7jI41vx+ZPr2Uzf41I=
Date:   Tue, 10 Nov 2020 16:03:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <8f8dc2815aa97b2378528f08f923bf81e19611f0.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de> <8f8dc2815aa97b2378528f08f923bf81e19611f0.1604874488.git.lukas@wunner.de>
Subject: Re: [PATCH] spi: atmel-quadspi: Disable clock in probe error path
Message-Id: <160502418758.46020.24776310363658040.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 8 Nov 2020 23:41:00 +0100, Lukas Wunner wrote:
> If the call to of_device_get_match_data() fails on probe of the Atmel
> QuadSPI driver, the clock "aq->pclk" is erroneously not unprepared and
> disabled.  Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Disable clock in probe error path
      commit: 0e685017c7ba1a2fe9f6f1e7a9302890747d934c

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
