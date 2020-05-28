Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317A31E61B7
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 15:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbgE1NHw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 09:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390031AbgE1NHv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 May 2020 09:07:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1D9206C3;
        Thu, 28 May 2020 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590671271;
        bh=8+bOiBn4UNeBdFBuZD/p0QmjYGJU/3XrtqwKS+6zzpg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CxtiDCqlNaippwrhA4i2xZr+ffnMK/syNCND6rSfmhvdLl4OLl9mmx8kY7nE93W5s
         gFCpgBwgHAgBjfUey3uaWcHyjuyeCGvqSx2H/MhxcrhYkn1Wf2fxmp3Rlt1Jb7TWmj
         G/Q1OSL6UUWc8xQBW6jE+loSktf5coi1ahy7ch48=
Date:   Thu, 28 May 2020 14:07:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     catalin.marinas@arm.com, vkoul@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, s.hauer@pengutronix.de, festevam@gmail.com,
        dan.j.williams@intel.com, Robin Gong <yibin.gong@nxp.com>,
        shawnguo@kernel.org, u.kleine-koenig@pengutronix.de,
        martin.fuzzey@flowbird.group, robh+dt@kernel.org
Cc:     linux-imx@nxp.com, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Subject: Re: [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Message-Id: <159067126729.55053.2503604469157949492.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 21 May 2020 04:34:12 +0800, Robin Gong wrote:
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
> or not.
> The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
> have the chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: fallback to PIO if dma setup failure
      commit: bcd8e7761ec9c128b9102b0833d9c7052ae2dbcf

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
