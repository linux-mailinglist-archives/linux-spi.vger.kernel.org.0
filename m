Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2122CA4C1
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbgLAN7r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 08:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbgLAN7r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:47 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAADA2168B;
        Tue,  1 Dec 2020 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831141;
        bh=1f8DKykxSDA5io+UHgcjrB0nbmxwjwqm3ExrQn3rCnI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pddORyXloZvg6CqOfu+YVEB08+8cHMTMT68HRlLEhpqHlJHqu8Hnm0/V6Q3hrR+sH
         YrtzLqsLx7PRlcK8g9ECjrmHJYPO0DPURWdgWnfzJwxpRPjZEy2pnvzLmTB0k0QTyx
         k9FWaYuCE0nFwDDOi45GrUQ7Ipi1gta7oikqkkME=
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Abylay Ospan <aospan@netup.ru>,
        Kozlov Sergey <serjk@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
In-Reply-To: <48e6a396526bcd0a26e970036dbe3207cce57ea6.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de> <48e6a396526bcd0a26e970036dbe3207cce57ea6.1605512876.git.lukas@wunner.de>
Subject: Re: [PATCH for-5.10] media: netup_unidvb: Don't leak SPI master in probe error path
Message-Id: <160683107676.35139.9712038469304834803.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Nov 2020 09:23:13 +0100, Lukas Wunner wrote:
> If the call to spi_register_master() fails on probe of the NetUP
> Universal DVB driver, the spi_master struct is erroneously not freed.
> 
> Likewise, if spi_new_device() fails, the spi_controller struct is
> not unregistered.  Plug the leaks.
> 
> While at it, fix an ordering issue in netup_spi_release() wherein
> spi_unregister_master() is called after fiddling with the IRQ control
> register.  The correct order is to call spi_unregister_master() *before*
> this teardown step because bus accesses may still be ongoing until that
> function returns.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] media: netup_unidvb: Don't leak SPI master in probe error path
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
