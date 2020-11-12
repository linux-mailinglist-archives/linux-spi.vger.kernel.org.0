Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023B22B0E38
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKLTkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKLTkH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 14:40:07 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743CC20B80;
        Thu, 12 Nov 2020 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605210007;
        bh=bSkBVFCyAg9z1ZaXJuo9KtVsfePE0JfXXOlWPC+fmMw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UWfsTcKkPGuDxUTneQrFnh4swyNifdlPleqUSNLxGdy3sLVUyIbOY5bLepMMhI1CJ
         Pq8lM1z43nreKA15urf6CKoh7VjMtaPNW0I7iyROedHLPqnuhLouqXIujQXEngXyzt
         Fsp8YbyF42v9kR0DI9Y4Tf0mJ422W8xTdlg4fsm4=
Date:   Thu, 12 Nov 2020 19:39:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
In-Reply-To: <fbe8768c30dc829e2d77eabe7be062ca22f84024.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de> <fbe8768c30dc829e2d77eabe7be062ca22f84024.1604874488.git.lukas@wunner.de>
Subject: Re: [PATCH] spi: st-ssc4: Fix unbalanced pm_runtime_disable() in probe error path
Message-Id: <160520996935.38820.2622853048888593416.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 8 Nov 2020 23:41:00 +0100, Lukas Wunner wrote:
> If the calls to devm_platform_ioremap_resource(), irq_of_parse_and_map()
> or devm_request_irq() fail on probe of the ST SSC4 SPI driver, the
> runtime PM disable depth is incremented even though it was not
> decremented before.  Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: st-ssc4: Fix unbalanced pm_runtime_disable() in probe error path
      commit: 5ef76dac0f2c26aeae4ee79eb830280f16d5aceb

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
