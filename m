Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92562456353
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 20:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhKRTV4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 14:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:32854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhKRTVw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 14:21:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19373610F8;
        Thu, 18 Nov 2021 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637263131;
        bh=t9+2AiggnVqrgGTuAYu/rgjO7OPWObSz0aLxHrxrgzk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hOWlFB/lIwuYvXFb2FfpbBsiesTwCfVP8m5EXaSYw9bMGp+EkhorGv/URD7L+I/gb
         KBTra7PW94zlwnSKUq7QD/jM6+CWqBCnswF6cP44rNSLr27btWKM+kv0GzVZPwvLor
         XUX6Nn7gQowciyO3WBzJyOkFpFo48coP0DypGBtSeXdno2+NecxxyOLXnWna14TpiX
         Yz3W/1yDoRJDf3mtyP+ekBcpo4iHk7Sv9GgtrSMSEAnw2P7cKq4ApHTbXUDzAcv+kL
         77iRMLh7323djq5r9jtJoQfJqAfrs8Vekx+bnZR8FZktcDmtDEDwvALeNtELmaUfEW
         ivilocTl078Pg==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 0/3] RSPI driver support for RZ/G2L
Message-Id: <163726312883.102649.5640486048664140521.b4-ty@kernel.org>
Date:   Thu, 18 Nov 2021 19:18:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Nov 2021 03:10:38 +0000, Lad Prabhakar wrote:
> This patch series adds RSPI driver and dt binding support to RZ/G2L SoC.
> 
> Cheers,
> Prabhakar
> 
> Changes for v2:
> * Fixed review comments pointed by Geert.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: renesas,rspi: Document RZ/G2L SoC
      commit: 5a8f8542e34b6469cd5c5a3d075fa5977d90775e
[2/3] spi: spi-rspi: Add support to deassert/assert reset line
      commit: aadbff4af5c90919cbe67e2c4d77c68cdefa454e
[3/3] spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()
      commit: 1d734f592e1a1d41af80e90001d109cec1c98fb4

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
