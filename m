Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECB1DBAFA
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgETRRg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 13:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgETRRg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 13:17:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416B8206B6;
        Wed, 20 May 2020 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589995055;
        bh=xltVI1+pEmM6zj2tzZiSZnN117AjeYjfwjSrkN5huHg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VkwZD3r0X6BGTzKnlUlwQOmtTp0aMzo3WDTyACwJkV3UdiA043Qp3ZQY/yqR04pj4
         jBbNO4LyAotapaxo4GWUK+ajtn3ICZ3QwZ4gPTXuBzYAaU+ao4J3nXhc4mKrlqTRH9
         dgY6tCbZsXzoRYf6yRBKFlR5W61xwtpSB6PD62zc=
Date:   Wed, 20 May 2020 18:17:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
In-Reply-To: <cover.1589557526.git.lukas@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
Subject: Re: [PATCH 0/5] Raspberry Pi SPI unbind fixes
Message-Id: <158999505312.5069.2701114941516266440.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 15 May 2020 17:58:00 +0200, Lukas Wunner wrote:
> This series fixes ordering issues occurring on unbind of the
> Raspberry Pi SPI drivers:
> 
> Turns out devm_spi_register_controller() is prone to
> incorrect use and dozens of drivers have gotten it wrong.
> I'm only documenting this gotcha here and fixing it in the
> Raspberry Pi drivers.  Fixing the rest is for another day.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Fix controller unregister order
      commit: 84855678add8aba927faf76bc2f130a40f94b6f7
[2/4] spi: bcm2835: Fix controller unregister order
      commit: 9dd277ff92d06f6aa95b39936ad83981d781f49b
[3/4] spi: bcm2835aux: Fix controller unregister order
      commit: b9dd3f6d417258ad0beeb292a1bc74200149f15d
[4/4] spi: bcm2835: Tear down DMA before turning off SPI controller
      (no commit info)

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
