Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D057BD21
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGTRpM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 13:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiGTRpK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 13:45:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E3E1B
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 10:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80D6BCE2274
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 17:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0936CC3411E;
        Wed, 20 Jul 2022 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658339104;
        bh=O4w3qcQUaTwHAX2CUDDrayqMkythkwD6JfA7GkUle4A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZuEvYvijeFf4RJmwkb+0EQhrCtt48LmahbLB60hn7BDNno0S+qaW5e0mYboXyhqi2
         NIRyQ9ygbjJ0t2IjCwTiFIJtUBO+uzqrsoSI8WBuOkFnWaqn0BK+dOebQa3vxyokyz
         x+wdXmCcbFMl7c9gPshULyZH4H4PyBy+Ge4+K0ve7x87yu/k6NKu+CxiygVHUvKsLS
         cP6bfp9ejbnzNg5h42J07zjK6BgaJFVboR2sPFiov9mKFDzhJDL9Asqh5yN5PP+K3o
         5ye4MA+mS/0qkLu2cW4PAmRhak7JoWm/S28pZYpGwnMmebHeFt+m6NLPfyWqtDD4G0
         CjHgj8rgJ6vwQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, lukas@wunner.de
In-Reply-To: <20220719072234.2782764-1-mkl@pengutronix.de>
References: <20220719072234.2782764-1-mkl@pengutronix.de>
Subject: Re: [PATCH] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers
Message-Id: <165833910370.536468.9368716525642665956.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 18:45:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 19 Jul 2022 09:22:35 +0200, Marc Kleine-Budde wrote:
> In case a IRQ based transfer times out the bcm2835_spi_handle_err()
> function is called. Since commit 1513ceee70f2 ("spi: bcm2835: Drop
> dma_pending flag") the TX and RX DMA transfers are unconditionally
> canceled, leading to NULL pointer derefs if ctlr->dma_tx or
> ctlr->dma_rx are not set.
> 
> Fix the NULL pointer deref by checking that ctlr->dma_tx and
> ctlr->dma_rx are valid pointers before accessing them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers
      commit: 4ceaa684459d414992acbefb4e4c31f2dfc50641

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
