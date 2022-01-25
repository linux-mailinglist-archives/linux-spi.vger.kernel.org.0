Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C249B1E4
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiAYKb3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 05:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbiAYKVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 05:21:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5EC061773;
        Tue, 25 Jan 2022 02:21:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A13F61640;
        Tue, 25 Jan 2022 10:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C112EC340EC;
        Tue, 25 Jan 2022 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106075;
        bh=Waq7iN55oJ8pZCq6646pwR8UIZfAhl1qVIhA0SINmac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pvu50lKVRJh3onH/Z32EVmvRYm3q0PBN258cJjHpIaXsupS5fTTh6F2oMoNgrs3KR
         s6Q55ltp8Oa8LkNSRW4OKStlf/tL3BEd4iwR8uSaNxdNmlodpefLvwEFSiAvSwRvBH
         fwxCgj6I3VlHCIZpCqNBiK12CvzgeNCy1ZF8n1pPrUvJW7i3u3KsbLDBms+/z295PG
         i30cE8f8o/rHBUX7Y5VxqokgaFvx3+68ImfR57mYdP9H6pQbISNeFv8M86sZ4TO/a6
         HN+A/ikS0KiKx4J5YOlWMDLXvWG8wKBWG/QiMp/0QrvF11t43Bbz0Rd14r9LyQAm3T
         n7M3hrwixwh2A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20220118110928.120640-1-linus.walleij@linaro.org>
References: <20220118110928.120640-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3 v2] spi: s3c64xx: Delete unused boardfile helpers
Message-Id: <164310607451.75071.12191982229329069475.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:21:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jan 2022 12:09:26 +0100, Linus Walleij wrote:
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
