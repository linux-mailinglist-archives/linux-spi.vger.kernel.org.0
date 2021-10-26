Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D115143BA55
	for <lists+linux-spi@lfdr.de>; Tue, 26 Oct 2021 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhJZTJb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Oct 2021 15:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238524AbhJZTJa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F3B96109D;
        Tue, 26 Oct 2021 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635275226;
        bh=vZTpReTVu8G45pFyoSoR2KCp22nstJkeL/RzTNGG1Ik=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qfK6NGcvyLii2uJZpeLvlkpovnVBvdFnxiETaIMv5jgznWWBvGi3iGMk9wfBugUWi
         Bw0kGMWlWGy/qDI08yvmRfJcGG2gLTBzqPuyAtxOVvSutZxXy4g29u+THRUIgNEmqc
         hoA1uH3iZwd/prK5FGNI+JheGBgdDXRlFCPS25nQg6/jtPJ0Cq9yb/BzLewUZh/d+n
         QdM11okNuFf8cWp3V3SsOi0w/XWgf/z+rJiG//PEhrfp2SU+rtIveOtHKB2VXjuYqZ
         O3O/RLiKiuszRSuR0FV4TfPmZuFd46pVg/9cJuSXR877e2xn0h9DzXjcs+qkXCoHse
         rAGrt2zPLX/Kg==
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH v2 0/7] Add SPI Multi I/O Bus Controller support for RZ/G2L
Message-Id: <163527522326.2033998.11228661564873952732.b4-ty@kernel.org>
Date:   Tue, 26 Oct 2021 20:07:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 Oct 2021 21:56:24 +0100, Lad Prabhakar wrote:
> This patch series adds a couple of fixes for rpc-if driver and
> adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
> is identical to the RPC-IF block found on R-Car Gen3 SoC's.
> 
> Cheers,
> Prabhakar
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[3/7] spi: spi-rpc-if: Check return value of rpcif_sw_init()
      commit: 0b0a281ed7001d4c4f4c47bdc84680c4997761ca

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
