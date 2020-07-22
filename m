Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00A7229982
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgGVNpq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 09:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgGVNpp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3802064C;
        Wed, 22 Jul 2020 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425545;
        bh=nHj4qidlCzPnSj6K3Rd04M4Ti2n81ozk+ic2UrNZ/uA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hIdorwcyP9KeG8W1hYiCVHJhwSRjuYWfbIeAtMkRiwREcpHJP/Bu6hWhbqFDUWOqu
         U8hDeuZUR9/dju4tLIU+lG2tDzWVeKQynQRtY8YZb0r/4BA+xKP3B0zHZ6QYkcLupG
         FgkN1CM21Q+ubYs8AokhGta/W2ztZw5f3uSIUaOs=
Date:   Wed, 22 Jul 2020 14:45:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20200721024819.7150-1-leilk.liu@mediatek.com>
References: <20200721024819.7150-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH] dt-bindings: spi: update bindings for MT8192 SoC
Message-Id: <159542550175.19884.11879506725313401487.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Jul 2020 10:48:19 +0800, Leilk Liu wrote:
> Add a DT binding documentation for the MT8192 soc.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: update bindings for MT8192 SoC
      commit: 30962fe33ab5ed4bbd78c12f4b9e25a85c3e8d0b

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
