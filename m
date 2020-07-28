Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B233230F4C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jul 2020 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgG1Qbp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jul 2020 12:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731437AbgG1Qbp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F394B2074F;
        Tue, 28 Jul 2020 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953904;
        bh=uOlSz/K5CQEMSlJY2imn72GM1L/U1a0Z/O+/V2lbTsQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Xh3Mi/uf3qB/eiCbAmaZ++dPUxW0HPHbAEbS07wRmYPAjLPBt/BZZfDAYvKrURqTS
         zrt4YYzlzQsFFWHeSKyZqLj+j8cC7cwlt54Awzrvf3vgM1oRmPBOaT5sHNJDnS3++C
         f9l0psRGPcl/aOUSQSHtVbLLTTkDZMNmLmJundOE=
Date:   Tue, 28 Jul 2020 17:31:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     kernel@esmil.dk, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200723004356.6390-1-jon.lin@rock-chips.com>
References: <20200723004356.6390-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH v3 1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
Message-Id: <159595388006.15302.14458547695511068322.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 23 Jul 2020 08:43:54 +0800, Jon Lin wrote:
> The burst length can be adjusted according to the transmission
> length to improve the transmission rate

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
      commit: 4d9ca632c847ab88f2f7e7e2747aea966f1390ce
[2/3] spi: rockchip: Support 64-location deep FIFOs
      commit: 13a96935e6f66bafb6da92791120546a4bf20889
[3/3] spi: rockchip: Fix error in SPI slave pio read
      commit: 4294e4accf8d695ea5605f6b189008b692e3e82c

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
