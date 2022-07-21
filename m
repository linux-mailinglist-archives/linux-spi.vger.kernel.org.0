Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED557D4DF
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jul 2022 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiGUUir (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jul 2022 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUir (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 16:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE05D5B5;
        Thu, 21 Jul 2022 13:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C7E360A6D;
        Thu, 21 Jul 2022 20:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E6C3411E;
        Thu, 21 Jul 2022 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658435925;
        bh=9t35aXgPifuH5PtTl+u6odFYmh2dHJHWft5gQDrHvPE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jGq1Qz3a1SHUQr8JE97axwZ/sX0PQDG15i6n7RV+xSsX8GomH7ebQcj0gv4gkOPsT
         vqkfc5b78A0hPkcsfrYQ9ZbR0v7awYtBfoJVGTLTdSWVX/mrjY5cBMF25vuQpKHuLH
         xcqaGexPKXR9xuYXj2K1tdTdtCVbUu3BF1e5Lj0jBceTVZFHYHMyVBktqdOVIWvMNW
         juLmy55YQtk/nq90eraYj0myHbhciwQcyI6NyMkOSOu0sYe1NFRxIpeqtXtbnSXViK
         6hkwNRIKnIS3xgozrlrGuZqxvBvzQ9zNizGtj81CvzWgO53GzwtRXrjwvZIeWRXdRi
         Kw7K5BrvyJEYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
In-Reply-To: <20220721143449.879257-1-biju.das.jz@bp.renesas.com>
References: <20220721143449.879257-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3] spi: spi-rspi: Fix PIO fallback on RZ platforms
Message-Id: <165843592359.1132948.11395615415483672270.b4-ty@kernel.org>
Date:   Thu, 21 Jul 2022 21:38:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 21 Jul 2022 15:34:49 +0100, Biju Das wrote:
> RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt
> and DMA transfer request. Setting DMARS register for DMA transfer
> makes the signal to work as a DMA transfer request signal and
> subsequent interrupt requests to the interrupt controller
> are masked.
> 
> PIO fallback does not work as interrupt signal is disabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-rspi: Fix PIO fallback on RZ platforms
      commit: b620aa3a7be346f04ae7789b165937615c6ee8d3

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
