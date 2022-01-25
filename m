Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE8649B1E6
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 11:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355360AbiAYKba (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 05:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbiAYKVT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 05:21:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7CC061774;
        Tue, 25 Jan 2022 02:21:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AFFE61631;
        Tue, 25 Jan 2022 10:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA9FC340E9;
        Tue, 25 Jan 2022 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106077;
        bh=GZBZI8el6N7chcs1+Q4bact+nbq/SBhs/tMlshfzetM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PteXvhymNpG2cqn3OKRGKkKJQe37mBDe0IJrF+j+CBR6AfbMPIHJhaBsCduvvP/lh
         JjY2MXnjOqLi0ZfhzxPiGoBKxHeKA1um9jIPsEBhg4llb3qZstXpNK3KdjwmEsmHYJ
         ZuF3ibrKsSA0IxV/nQK4kSUA7BERZmE5WJ/I5T1kTyf/fh46le7NN/EOUbVFGRf5bY
         /07D0kLGIxWCGG6xj33xja2gDecTQ0ajQJ1Dq0tQM6GKienvXGmvgm65V8DpQ0acNe
         2KkVSY+Sw+ZbrpAnjj14lP/qMpGUsrZD5xhOgWE2LyyEQTDV9RAK4di5+Aycm+r8dl
         4ebFdIWhCGKsA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20220118230915.157797-1-linus.walleij@linaro.org>
References: <20220118230915.157797-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3 v3] spi: s3c64xx: Delete unused boardfile helpers
Message-Id: <164310607598.75071.11615059052850898088.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:21:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jan 2022 00:09:13 +0100, Linus Walleij wrote:
> The helpers to use SPI host 1 and 2 are unused in the kernel
> and taking up space and maintenance hours. New systems should
> use device tree and not this, so delete the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: s3c64xx: Delete unused boardfile helpers
      commit: f1ba938e4f98941dc2b77795062e49444ec1fee1
[2/3] spi: s3c64xx: Drop custom gpio setup argument
      commit: 3b5529ae7f3578da633e8ae2ec0715a55a248f9f
[3/3] spi: s3c64xx: Convert to use GPIO descriptors
      commit: a45cf3cc72dd9cfde9db8af32cdf9c431f53f9bc

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
