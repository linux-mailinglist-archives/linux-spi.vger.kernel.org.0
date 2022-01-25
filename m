Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5568449B1E7
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiAYKbc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 05:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbiAYKVV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 05:21:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F2C061776;
        Tue, 25 Jan 2022 02:21:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FC66B8174B;
        Tue, 25 Jan 2022 10:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E48C340E0;
        Tue, 25 Jan 2022 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106079;
        bh=qW9cVwE+5dH0IFpPL717Qa3dRXeY9HY/mvR982mEXgg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V9GfVxyUJnASYIat8Btt3+WCQtL+zj5T+rpF3/pF/WJoqaf9VtgJZgm3xsddJ3fA+
         Xmwe3uY4NuYHM3FFkQAK1Q6aoQNtFsbxFXkgSp9Z/yTEIw+Mtuo96BLQGYFoqLoSkZ
         EZhma67xO+X5p3KrQwzMLgV7w4UpjcEEZ8DkyLjs2S+3L3338t52EMlMx5t2zJzzdy
         Mj1k0rqW1OCjCOhxqTs035xtGm4ZHpcw4fy7QEidogFRaHd6jS+DPOejFTlpSf46FR
         E/rL4UgbF3Ag1kL3sSQocX6TiQTFO4y71Tu+fN2hjATeClF8kADjPabP5gtUPjFzPA
         +isGN27WsBORg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20220119000914.192553-1-linus.walleij@linaro.org>
References: <20220119000914.192553-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: s3c24xx: Convert to GPIO descriptors
Message-Id: <164310607765.75071.12847134364885643457.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:21:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jan 2022 01:09:14 +0100, Linus Walleij wrote:
> This driver has a bunch of custom oldstyle GPIO number-passing
> fields and a custom set-up callback.
> 
> The good thing is: nothing in the kernel is using it.
> 
> Convert the driver to use GPIO descriptors with a SPI_MASTER_GPIO_SS
> flag so that the local CS callback also get invoked as the hardware
> needs this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c24xx: Convert to GPIO descriptors
      commit: 7f2a3cf4e6077a1525092f114be7819e505773a1

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
