Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404284A6233
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiBARSq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 12:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiBARSq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 12:18:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA0C06173B
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 09:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0926126B
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85901C340F0;
        Tue,  1 Feb 2022 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643735904;
        bh=9gQwwfcbH9sKUiSH9MVtDlw0g0gv6oeHCHeIojLZ8CY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FqKSm71gCCgL1fnuIVL9DKRCkmEyvTQD0KYJKq2z3U9CfCO+cwXxxrKVHLqC+c+kT
         7yLPL12PvcxC+jGhH1zYX4XVCPMOYRdDvbCX8xzKpiFDGHPffr/Yrs6WVLe7TZDd6k
         d13VAgPewIvrpSunJSTUo/trEJ1FK1x/HhhRYsj6Flsau+B03fiBVKuVRFyRhSR9r3
         apGJYCfBKm1MRFjX+pF1DiYWZcZY8AJ2bo2by8QOizvhrjSk3BLKx+3umNty2egGSc
         BWNM/jb9nbmQlgtWHt8p0+jb6vt2BGWmS0ggNhGx8rQT/ovTXRMAB4VYLFi3ibEc0F
         0whc/KEIAKurA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        Lukas Wunner <lukas@wunner.de>
In-Reply-To: <20220121224126.312227-1-linus.walleij@linaro.org>
References: <20220121224126.312227-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: bcm2835aux: Convert to use GPIO descriptors
Message-Id: <164373590325.2398858.13463837677080973733.b4-ty@kernel.org>
Date:   Tue, 01 Feb 2022 17:18:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Jan 2022 23:41:26 +0100, Linus Walleij wrote:
> This one is pretty straight forward to switch over, the driver
> already relies on inspecting cs_gpio just check cs_gpiod instead
> and stop the special handling of requesting the GPIO and stuff
> the core will take care of.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835aux: Convert to use GPIO descriptors
      commit: b651d1da86aa525c5a5b2bd61f528353c28d589d

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
