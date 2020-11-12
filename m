Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747442B0E37
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKLTkC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKLTkC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 14:40:02 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F016F2223F;
        Thu, 12 Nov 2020 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605210001;
        bh=n0K2PCeRFn0qZSe13mwgJxEi5/IxSs4vj8J4jg9HGzQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=U+uyc66N9WVTswSeNo4Be16wl7xN9MTyNwrM3TPKfxRbZCduikNj+zEHkbocI2WEj
         E9Hlvx32BdVZy53tXK5z+jja3Etg8XgDD1dEk55D9GnyQcCM6jGzrbAlso7RDYzspu
         ZndargBGB1eP99oMY/P0L6oKbauELvNUcvsrHsfg=
Date:   Thu, 12 Nov 2020 19:39:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <232281df1ab91d8f0f553a62d5f97fc264ace4da.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de> <232281df1ab91d8f0f553a62d5f97fc264ace4da.1604874488.git.lukas@wunner.de>
Subject: Re: [PATCH] spi: synquacer: Disable clock in probe error path
Message-Id: <160520996935.38820.15351366311414185070.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 8 Nov 2020 23:41:00 +0100, Lukas Wunner wrote:
> If the calls to platform_get_irq() or devm_request_irq() fail on probe
> of the SynQuacer SPI driver, the clock "sspi->clk" is erroneously not
> unprepared and disabled.
> 
> If the clock rate "master->max_speed_hz" cannot be determined, the same
> happens and in addition the spi_master struct is not freed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: synquacer: Disable clock in probe error path
      commit: 8853b2503014aca5c793d2c7f0aabc990b32bdad

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
