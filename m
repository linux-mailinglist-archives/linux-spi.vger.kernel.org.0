Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246CF4A4C4D
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378669AbiAaQjs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:39:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40424 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380553AbiAaQjs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:39:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8811DB82BB5
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 16:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78CEC340E8;
        Mon, 31 Jan 2022 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643647186;
        bh=UMM43pxIfISBbrWOGdGoB7ZkrMYq739YAgFu5Kn9DzM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T22nfdCm6xj01Tv9QjLrqH0Ug4Khr0FyTdKjqTabHT3cKnqFi7XwdA0io6Kx1/A0O
         EA2LPTs32GK5nvkq/KIpNjksc6bXyZd5H7S2ZU2dnzfOoKMjlU8qBNe2dlAOHpeuXs
         8Xw1UBP5nhBNyWXEaTJ4Mubutn4w5qVJrR9ojc2KPcMYgKj+DC99UtjzMUjNxDDbqu
         J4ES126SntW7J1oo+VCJSlCqhEspwrIZd5NeGGJuFX6wDu9tQppp2WXUa4ImXjzP47
         x0ODyhwzwpeFjWgggjB+RIBqDRs0QBR49iNLJ8M2TVRbnAWTmLmdVY5pbV8Qt4sXtX
         5ut+M5n4XqYkg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Mack <daniel@zonque.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20220121012014.287288-1-linus.walleij@linaro.org>
References: <20220121012014.287288-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: pxa2xx_spi: Convert to use GPIO descriptors
Message-Id: <164364718460.1030816.2508852341433231165.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 16:39:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Jan 2022 02:20:14 +0100, Linus Walleij wrote:
> This converts the PXA2xx SPI driver to use GPIO descriptors
> exclusively to retrieve GPIO chip select lines.
> 
> The device tree and ACPI paths of the driver already use
> descriptors, hence ->use_gpio_descriptors is already set and
> this codepath is well tested.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx_spi: Convert to use GPIO descriptors
      commit: 31455bbda2081af83f72bb4636348b12b82c37c1

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
