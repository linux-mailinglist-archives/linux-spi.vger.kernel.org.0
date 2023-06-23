Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB873ADC2
	for <lists+linux-spi@lfdr.de>; Fri, 23 Jun 2023 02:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFWAcT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 20:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjFWAcT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 20:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28522170E
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 17:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3F0F61935
        for <linux-spi@vger.kernel.org>; Fri, 23 Jun 2023 00:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5954C433C8;
        Fri, 23 Jun 2023 00:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687480337;
        bh=TFDRFbU74swzrPA43GJXQMuFOJYFnYNnIqfFG8Rp8Xg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=khyqe41vLwTQZiP/tc5tTDjdiH2TXITYOykH60LNtRCfllu3nL47zRB30YsT0bHis
         s6vbSsYjq8BCDGbrArTILArwDxAzvLxDmEz0b1e7VIyogR7KFLP2CPAM/LIpNiRBgo
         6BbNq/5mbiaiV64A+BzqQaL/O7071/Atrm8vGGqhzm4caj4y2n40nMRbD9oHy9AtZ9
         bZ7VUGcNGdO2nWCdUufsa2Y918AWiQTfLEWnXibt1bf2CTzOjAPiLUw490qbQihUjO
         CgAhV9X2GlBEU7agu3SgxrkHgYyDFyFlKdB9zUJ3YbBMs1e8o5gTBbXq5AUhsNaLnW
         rKQqFEft/rtsA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
References: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 0/3] spi: Helper for deriving timeout values
Message-Id: <168748033294.332493.4514818831480628225.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 01:32:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Jun 2023 11:06:31 +0200, Miquel Raynal wrote:
> I recently came across an issue with the Atmel spi controller driver
> which would stop my transfers after a too small timeout when performing
> big transfers (reading a 4MiB flash in one transfer). My initial idea
> was to derive a the maximum amount of time a transfer would take
> depending on its size and use that as value to avoid erroring-out when
> not relevant. Mark wanted to go further by creating a core helper doing
> that, based on the heuristics from the sun6i driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: Create a helper to derive adaptive timeouts
      commit: d8e4ebf87018736c0c29e2eb4afe3915156483cd
[2/3] spi: atmel: Prevent false timeouts on long transfers
      commit: e0205d6203c2ce598ae26d4b2707ca4224a9c90b
[3/3] spi: sun6i: Use the new helper to derive the xfer timeout value
      commit: 6eef895581c9b5fcd002ff77837e0c3a4b1eecf6

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

