Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4A79D430
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjILO7G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjILO67 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 10:58:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D98CD8
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 07:58:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA5CC433C7;
        Tue, 12 Sep 2023 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694530734;
        bh=TJoBw+mWmc58JqCD7DJqWCnTVQ917/a5DUjBKzMUc7w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=taSjR17dQQj+SSy3tb2PX0ZwebCSTDLur/rPW6WvlnEHXmFIh+XX5za9S6MCh9Gat
         IX1dsQIzPwFfN/qwEuR3w42yb5pWXG0S+dwE1O7NZE62sGGsRF6RuYfEkgOVIfu+tl
         CiTPaXDfnNqFLAqNAaMeikcF2iJi29mMv5zFU2H1pksY3DvKFiCPxwK2d9IlspV+vp
         rkJ2aZq/o4oHdeeA0ZfphcZvQ9dKoPvDOxCKd9QezeDqASm1Y7oSaVxs8QZwOkqHlA
         9vxRyIlmKhqL94PZRHmnGocMmJEIxqaJ1Y6/CmzZpn77LFUlAcmpNQE813sBs1tKU/
         yZAPW6q1xbvZQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230810083004.3988597-1-yangyingliang@huawei.com>
References: <20230810083004.3988597-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 00/21] spi: switch to use modern name (part3)
Message-Id: <169453073296.64310.4261264291069758430.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 15:58:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Aug 2023 16:29:43 +0800, Yang Yingliang wrote:
> I'm trying to rename the legacy name to modern name used in SPI drivers,
> this is part3 patchset.
> 
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller. Each patch compile test passed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/21] spi: lm70llp: switch to use modern name
        commit: 7c5d1d9787d67966c6e45643920e5bbfa859ccb8
[02/21] spi: lp-8841: switch to use modern name
        commit: 48815830a9f66cbec343f078da4ab72b2bdf992e
[03/21] spi: meson-spicc: switch to use modern name
        commit: 68bf3288c7ebc0b9ca8ba9b5b748bd306a3649a3
[04/21] spi: meson-spifc: switch to use modern name
        commit: 55591ac48152a5f5760b5a989654b95985861ac9
[05/21] spi: microchip-core-qspi: switch to use modern name
        commit: 5d97a3abbb5e24cf208f0339e09e58a591652818
[06/21] spi: microchip-core: switch to use modern name
        commit: 8f8bf52ed5b76fc7958b0fbe3131540aecdff8ac
[07/21] spi: mpc512x-psc: switch to use modern name
        commit: a21db73963c837332e21f1b7a7ee71ae7fd2ec16
[08/21] spi: mpc52xx-psc: switch to use modern name
        commit: 171639f8459192d1f7cc505a7a4269f916d3e4b5
[09/21] spi: mpc52xx: switch to use modern name
        commit: d6503d1192491bb9d38916b70f87e77ce93c3bb6
[10/21] spi: mt65xx: switch to use modern name
        commit: cae1578847e60a5cfb4ff881a1670c4b008ce37d
[11/21] spi: mt7621: switch to use modern name
        commit: e56e3de0039d66b1fe5a0e1b3338907797ef79cd
[12/21] spi: mtk-nor: switch to use modern name
        commit: a3a77a4268929888ab3ce9e68c83f0d7e63505df
[13/21] spi: mtk-snfi: switch to use modern name
        commit: efdf4c993494a52ee86fc7db83bb257c74cb8184
[14/21] spi: mux: switch to use spi_alloc_host()
        commit: 0fc8a1a43122d3775eb2fff2dc4ee9ff7828b15c
[15/21] spi: mxic: switch to use modern name
        commit: fc42bb55c05fa737b3057bbc5349f5fc8c6e68b5
[16/21] spi: mxs: switch to use modern name
        commit: 7647a16b682ea388830748efd8a8b85c51654dbf
[17/21] spi: npcm-pspi: switch to use modern name
        commit: 2b0aa563b36442068379909a880a741105d0d039
[18/21] spi: nxp-fspi: switch to use modern name
        commit: 8af8a27b7898ad688b7c50c404ed01cec54078a2
[19/21] spi: oc-tiny: switch to use modern name
        commit: ba0dada2ba1c9a1a948cdec91f4cc3c3efae2911
[20/21] spi: omap-uwire: switch to use modern name
        commit: 0d81c46e702903c75cce195ed0d3fb968e8341c0
[21/21] spi: omap2-mcspi: switch to use modern name
        commit: ee0f793cc1881225dee04216f1080201603b46bb

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

