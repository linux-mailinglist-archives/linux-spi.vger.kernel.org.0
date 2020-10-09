Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850B3288C09
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbgJIPBt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 11:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389099AbgJIPBs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Oct 2020 11:01:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6ED222BA;
        Fri,  9 Oct 2020 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602255707;
        bh=6NZ8zOwL7bY9Nd0DY52Ldtdc2XtEm9Ur36QdxeJujio=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0P2I4H+QTszVocjDUYzXRmLZxIryr4Z+xLlrFpiTLRbzqPM39g44Cm81SLUM8tbM3
         akqW/mFL/lrqD9S1OKESUsvIDX7qxkgR5YmLHgDKuf4WWIFNxYUSxu/GjxNLIy9p9E
         mO5DEPvX/lkYPsI6hNWg+gjld0viFF4j4jpDxoxo=
Date:   Fri, 09 Oct 2020 16:01:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>
In-Reply-To: <20201009100309.381279-1-daniel@zonque.org>
References: <20201009100309.381279-1-daniel@zonque.org>
Subject: Re: [PATCH] spi: cadence: Add SPI transfer delays
Message-Id: <160225570526.9185.14171623686022305868.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Oct 2020 12:03:09 +0200, Daniel Mack wrote:
> When processing an SPI transfer, honor the delay that might be passed
> along with it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Add SPI transfer delays
      commit: 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42

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
