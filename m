Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF251CE18C
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgEKRVt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730644AbgEKRVt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 13:21:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6451E20746;
        Mon, 11 May 2020 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589217708;
        bh=uLiY26Fl0HsdaY+0df8HTe/ulHJxBjmHpFvc/MQdxKo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=D85ROROMtcdx6iqvyEY3chT8cRwx2acwED/ck89w9onUCiajphvGfrEaUuGOYC7ja
         87qbsFodx/iGjXkelEMrwc0r+VX06FWesqsnMaF3dFTzFq/o4+v3KNJpaghu4zqI+8
         kuSN6VvDWwH8O69xThbxxzSEvUhRK73ymiQ183F0=
Date:   Mon, 11 May 2020 18:21:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <1589185530-28170-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1589185530-28170-1-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/2] spi: uniphier: Depend on HAS_IOMEM
Message-Id: <158921769452.22432.4067237223059688972.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 May 2020 17:25:29 +0900, Kunihiko Hayashi wrote:
> The driver uses devm_ioremap_resource() which is only available when
> CONFIG_HAS_IOMEM is set, so the driver depends on this option.

Applied to

   local tree spi/for-5.7

Thanks!

[1/2] spi: uniphier: Depend on HAS_IOMEM
      (no commit info)
[2/2] spi: uniphier: Use devm_platform_get_and_ioremap_resource() to simplify code
      (no commit info)

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
