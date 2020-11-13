Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5729A2B23F1
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 19:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKMSlh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 13:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgKMSlh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Nov 2020 13:41:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB4C206FB;
        Fri, 13 Nov 2020 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605292896;
        bh=3aI7hEWlQ+/jqdIzDmemQP02PwZxMiFpidfewThyHEA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1zMoOHjDCNY1+O+Nqgceb0TsR3cB3SBAVsf8SvOCQ7WIV9osxdfwfF9MXIJt1MBT8
         RNo/1QhpcSA0uRyb73LdYS2/x+5XRQ45PzQ4p3G+tfes1FTggMUrNfjFeaCrJttz2X
         kF2dlp8GheyxGrOJGY2IERjCEznZ5PMrYCGNSaKE=
Date:   Fri, 13 Nov 2020 18:41:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lukas Wunner <lukas@wunner.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201113180701.455541-1-natechancellor@gmail.com>
References: <20201113180701.455541-1-natechancellor@gmail.com>
Subject: Re: [PATCH] spi: bcm2835aux: Restore err assignment in bcm2835aux_spi_probe
Message-Id: <160529288073.31285.16420803496217581116.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 13 Nov 2020 11:07:02 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/spi/spi-bcm2835aux.c:532:50: warning: variable 'err' is
> uninitialized when used here [-Wuninitialized]
>                 dev_err(&pdev->dev, "could not get clk: %d\n", err);
>                                                                ^~~
> ./include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
>         _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                       ^~~~~~~~~~~
> drivers/spi/spi-bcm2835aux.c:495:9: note: initialize the variable 'err'
> to silence this warning
>         int err;
>                ^
>                 = 0
> 1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835aux: Restore err assignment in bcm2835aux_spi_probe
      commit: d853b3406903a7dc5b14eb5bada3e8cd677f66a2

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
