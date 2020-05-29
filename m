Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A21E8491
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2RS6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RS5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:18:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0FA420897;
        Fri, 29 May 2020 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772737;
        bh=5AnoZIQt/nUngVMipM9Z3V3UapCgO2srd+PigzQFs3Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OhJ+mVVaKP2Dl1XjqU+DoGalrBE9hn5wEeNejkhRZA5ZekruQZcuIfpeU5f2aUE+G
         a6XQuHzTos903BkVK35wpK0T+HnHSC0V6cwE2jqrvM5InXkrQYrOau6Pb9CV5Cqgmn
         Ejsn76KQEKsB0k9FQVw1Wk34d2B1ENh/TGzWL67o=
Date:   Fri, 29 May 2020 18:18:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Sperl <kernel@martin.sperl.org>
In-Reply-To: <20200528185805.28991-1-nsaenzjulienne@suse.de>
References: <20200528185805.28991-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH] spi: bcm2835: Enable shared interrupt support
Message-Id: <159077271265.17043.9288577188746299196.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 28 May 2020 20:58:04 +0200, Nicolas Saenz Julienne wrote:
> bcm2711, Rasberry Pi 4's SoC, shares one interrupt for multiple
> instances of the bcm2835 SPI controller. So this enables shared
> interrupt support for them.
> 
> The early bail out in the interrupt routine avoids messing with buffers
> of transfers being done by other means. Otherwise, the driver can handle
> receiving interrupts asserted by other controllers during an IRQ based
> transfer.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Enable shared interrupt support
      commit: ecfbd3cf3b8bb73ac6a80ddf430b5912fd4402a6

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
