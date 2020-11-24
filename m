Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127582C2B7E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgKXPh4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 10:37:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbgKXPh4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Nov 2020 10:37:56 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8C0206FB;
        Tue, 24 Nov 2020 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606232275;
        bh=wysJbQawJky6HAom7k/wA773dcVsKPBMng7YnEY1ZP4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Kiz2G4P4CtGEkabgsI8B11VSp55/OyajcO6KwFkRQ6ZJGosN+Bu0ZIYLH82hezfph
         boTIxn3/K2zApchX/TL+ed+rAr+SwiQ73m2NSqYqRs9x65A7zElkFLH5J/UxFARzgb
         gJc67g/VEf1mE4nN6mX5pKYkGqofas7nOtv1YlKs=
Date:   Tue, 24 Nov 2020 15:37:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>, nikita.shubin@maquefel.me,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com
In-Reply-To: <20201124085247.18025-1-xiaoning.wang@nxp.com>
References: <20201124085247.18025-1-xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: imx: fix the unbalanced spi runtime pm management
Message-Id: <160623225208.5156.18283999364037268437.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 24 Nov 2020 16:52:47 +0800, Clark Wang wrote:
> If set active without increase the usage count of pm, the dont use
> autosuspend function will call the suspend callback to close the two
> clocks of spi because the usage count is reduced to -1.
> This will cause the warning dump below when the defer-probe occurs.
> 
> [  129.379701] ecspi2_root_clk already disabled
> [  129.384005] WARNING: CPU: 1 PID: 33 at drivers/clk/clk.c:952 clk_core_disable+0xa4/0xb0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: fix the unbalanced spi runtime pm management
      commit: 7cd71202961090d8f2d2b863ec66b25ae43e1d39

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
