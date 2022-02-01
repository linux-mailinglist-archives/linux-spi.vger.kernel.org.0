Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5564E4A622E
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiBARS3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 12:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiBARS2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 12:18:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2FC061714
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 09:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05287B82F21
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 17:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BEDC340F2;
        Tue,  1 Feb 2022 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643735905;
        bh=hhmJVUls7d3g5So+jSLBjekQLHs1uRXRoo31r3wlQp4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VIpN01nW5TUPYEzxCDeEVJ+6ZLW0crI7RsyE8SckE+4Ryh4lxrr48Suhca9vVHOyV
         Fyv8cHXM+omFqduoClTI4lYhSW3mBUw9ZmNEsJzp7hxr5Vu0xjYMGJTyZOZMbM6Gyu
         vdzkee1SyailfLfTB465o5ctcCiDOVM5uOd9C8aodHTN4rF9EhW8JjFMb/AKk1Eev+
         gh/MVxwX//AueXwwnOpsEF0QkrRr2c5dp/ux5uZpIUDoHT6R2Xl5aDICffd8z0KTyz
         JptXjJQPuOB7p3jzF1mnlfp5YCdBaDououS2kufwetgvkjFjvmQVpRZdn51DBE96Jl
         IvB1A3mDPVOTg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20220125011047.495828-1-linus.walleij@linaro.org>
References: <20220125011047.495828-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: st-ssc4: Covert to use GPIO descriptors
Message-Id: <164373590459.2398858.6850126950936064642.b4-ty@kernel.org>
Date:   Tue, 01 Feb 2022 17:18:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Jan 2022 02:10:47 +0100, Linus Walleij wrote:
> This switches the ST SSC SPI controller to use GPIO
> descriptors from the core instead of GPIO numbers.
> It is already using the core parsing of GPIO numbers
> so the switch is pretty straight-forward.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: st-ssc4: Covert to use GPIO descriptors
      commit: 321599693213c81b2ce8530abb27e39528e969f9

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
