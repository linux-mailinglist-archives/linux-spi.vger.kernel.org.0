Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC400346BD5
	for <lists+linux-spi@lfdr.de>; Tue, 23 Mar 2021 23:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhCWWMb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Mar 2021 18:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhCWWMX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Mar 2021 18:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED45B61879;
        Tue, 23 Mar 2021 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616537542;
        bh=pwSmxqNMkA747BUHnXfYuf0RrtYw2mTZVLOuLq6Q5b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODtRG9pEjmcKRgX6egp7zU8A5yxsvBnuhzQY5l1GDx+pC3p/ykOXEqotqzb4+Z7bR
         cA61sk9vtgdao0uFkQ+yZviKh3FbYeS+qq/YHtrJWoL+ffFSUl/pr+T6oWWL52ZlHp
         oJtj8cHLjkzf2tlVGtBYnttWMiNR3p88ZTb0K/3pfMcJA4O1zeKJyOhGbDVdkZoy8E
         YnnQVejhYymD/WKzgnRgukH6Z3gOqzov85OyiCPKnDoYFdOfnVHNXy8f7Bmz6WO3vW
         1ocYMKaejFKao4TR2o4T2h8n3lJHGtFFVlN5U0xKYWCyYgzj7OvrCp545HxSolNexh
         4SpsRL8s2s34g==
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, fparent@baylibre.com
Subject: Re: [PATCH 0/4] Add Mediatek MT8195 SPI driver support
Date:   Tue, 23 Mar 2021 22:12:11 +0000
Message-Id: <161653753131.32935.1864016176434654452.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322055244.30179-1-leilk.liu@mediatek.com>
References: <20210322055244.30179-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Mar 2021 13:52:40 +0800, Leilk Liu wrote:
> This series are based on spi/for-next, and provide 4 patches to add MT8195 spi support.
> 
> Leilk Liu (4):
>   spi: update spi master bindings for MT8195 SoC
>   spi: update spi slave bindings for MT8195 SoC
>   spi: mediatek: add mtk_spi_compatible support
>   spi: mediatek: add mt8195 spi slave support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: update spi master bindings for MT8195 SoC
      commit: 08b020d3e9a87fb6d94b02782c42c001a4e084f4
[2/4] spi: update spi slave bindings for MT8195 SoC
      commit: f42698a8dc589dc7cc8e36641e86e6a9b3b32f9b
[3/4] spi: mediatek: add mtk_spi_compatible support
      commit: d666a833b0b9f5b8e08ecdc002a4cf5d34932b7a
[4/4] spi: mediatek: add mt8195 spi slave support
      commit: 1527b09bc80018f02fe0b6d14e97c95f93596221

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
