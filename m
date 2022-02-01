Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED954A622F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiBARSb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiBARSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 12:18:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3BCC061714
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 09:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D615B82F21
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 17:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3016FC340F4;
        Tue,  1 Feb 2022 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643735908;
        bh=4nibB/PcFWKd0ixj5AgbQWeKJ2hFluRq3qhs6as9yos=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c53FqZw0nnHd+lDJ33PpTTt/QbIKWTWVeQRiyn8gMxGZ7xV/rjD1IGzXbGj+cQVRu
         3SC5eKcquhfW9QU4LLKf6kj5nxHiEUAAWO3CjKUujEB079ce+h8390V0hJl7kDGOz6
         AW8apRheBzL3bYy7xWnipwi4j5aE6RICzwo8OPwVP1ftEhZY/lOnlN0zD/PoQ/FthD
         uVyeWtPWriDOOuZ9JeYJWfVINgnidvszRPBGoPNH2AQra7j5Ar0C27o+YZkGeg1I5n
         hYzRWF8I5CUYJYZCoyeJS7xuEi8dtopfLmBAhh7LCH9gJ1ODfhGvWBx6paOG/RCnXR
         hk0LABdY3CiCA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        Lukas Wunner <lukas@wunner.de>
In-Reply-To: <20220201012956.563272-1-linus.walleij@linaro.org>
References: <20220201012956.563272-1-linus.walleij@linaro.org>
Subject: Re: [PATCH v2] spi: bcm2835aux: Convert to use GPIO descriptors
Message-Id: <164373590690.2398858.9893279264814646349.b4-ty@kernel.org>
Date:   Tue, 01 Feb 2022 17:18:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 1 Feb 2022 02:29:56 +0100, Linus Walleij wrote:
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
