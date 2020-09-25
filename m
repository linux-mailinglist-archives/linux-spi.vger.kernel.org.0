Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7524727926B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgIYUnE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 16:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUnE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Sep 2020 16:43:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C892086A;
        Fri, 25 Sep 2020 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066583;
        bh=xf6ysVOG2uVTAcryG8bfT29KwpI5ya8L2UosHuVYtBQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EPHFzjT/2BkLbqF6RwI8IWvPzyWepx9xJvpGtf3UuswRKHQ/EIyNEhmucPB07JFk5
         c3hz5tlFhS0Besb9P4smZ0womnRXZuK9svCcuZc2VpB3+Lj+wOVc5fJn+yjObvAWlX
         IcaxKhAAJTd2uWJogP3cDqlZvkb4/nygZbs3PXrU=
Date:   Fri, 25 Sep 2020 21:42:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>, john.garry@huawei.com
Cc:     linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org
In-Reply-To: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
References: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
Subject: Re: [PATCH 0/4] Add IRQ mode support for hisi-sfc-v3xx driver and some cleanups
Message-Id: <160106652820.3325.14809043608395665853.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 24 Sep 2020 20:24:26 +0800, Yicong Yang wrote:
> This series mainly add the IRQ mode support for hisi-sfc-v3xx driver, and some
> cleanups for the preparation of the IRQ mode.
> After this patch, the device can work in IRQ mode, or if firmware doesn't
> declare irq support it will fall back to Poll mode.
> 
> Patch 1-2 refactor the .exec_op() path to make it simpler and clearer.
> Patch 3 factor the definition of the interrupt bits.
> Patch 4 add the IRQ support of the driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: hisi-sfc-v3xx: factor out IO modes configuration
      commit: 2c8af6a59744b242a193118c799a45621476f8ed
[2/4] spi: hisi-sfc-v3xx: factor out bus config and transfer functions
      commit: f6d2737720d6f6e5f4825b7203ad8b5cfcf9906c
[3/4] spi: hisi-sfc-v3xx: factor out the bit definition of interrupt register
      commit: aac6edff843871d7d732a6aa6f495b9eb1dea83a
[4/4] spi: hisi-sfc-v3xx: add support for IRQ mode
      commit: b1dd565124bea0f3ecde87336b48c5d0e98cd5bc

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
