Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419C2358A36
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhDHQzX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 12:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhDHQzV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C91D610CC;
        Thu,  8 Apr 2021 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900909;
        bh=Y7Rcibi7S++/A5pLpU5dNxRkxSOe21dPW7V7o9iSTHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsYjUMfpcbb/51LuDF6grg/s4upCSrPx1PkXQ6fwpR5dum52ACWMfvubydwAbf46w
         EW7W5B8CV9Eim1RHP8qHkWYIKd8uinMeebxuSbvqwGpmPQhwBsq4wikfoUcYIrQykk
         FMlF7Zs9Ys7BvTsHO2zVjpFKYmXHsXgL6nrzXPC3zttQwPNfJ3QVvVQnOZAg1xuuYq
         YyuWLZDRobjz9mZWu5TynwyUpkw+vCtfBxhzE2Mi8KXQD57iiBWKq0x+7s7iEQngJe
         iD6bhurCTavznsQOYBYu6pOC82Yig5GPKsUh2y+epOw54GpV8tGnZRCpof0+4lX7Km
         bfEVTNgQ+NlmQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM/spi: spear: Drop PL022 num_chipselect
Date:   Thu,  8 Apr 2021 17:54:33 +0100
Message-Id: <161790025316.17096.6364777976598906991.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408075045.3435046-1-linus.walleij@linaro.org>
References: <20210408075045.3435046-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 8 Apr 2021 09:50:45 +0200, Linus Walleij wrote:
> A previous refactoring moved the chip select number handling
> to the SPI core and we missed a leftover platform data user
> in the ST spear platform. The spear is not using this
> chipselect or PL022 for anything and should be using device
> tree like the rest of the platform so just delete the
> offending platform data.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] ARM/spi: spear: Drop PL022 num_chipselect
      commit: d570838efb6fb3154cbd08ab1b22d1f6442b1e78

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
