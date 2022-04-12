Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64144FE9C1
	for <lists+linux-spi@lfdr.de>; Tue, 12 Apr 2022 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiDLVDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Apr 2022 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiDLVDF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Apr 2022 17:03:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E998C624F;
        Tue, 12 Apr 2022 13:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48A9DCE20E5;
        Tue, 12 Apr 2022 20:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D95C385A1;
        Tue, 12 Apr 2022 20:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649796218;
        bh=R1XhCzCCwjDR5qBtwumVM1053ajSl182DoQ3ugbJpBY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UndEVf4CzoFIAqWZeN9FSC0yVmiZZsEJu+0zZmjofklFfW2/7YaXJE8OyupXOKCUY
         mapiKjtv82At9S2yszH49LjtzfGkMbqInKwofrfhybBQLjiptIa1K+WZQbUNwKCq6V
         118rCoVfA0Ho6WB7rNGfRsZ1zIZAu9Q6KAzozteMD+GMlpwp0cAbpswIiOOGL3ZrhS
         7WBrJqH3dFJeukj3qBnWm4zxcXv/wo0nMLs8T/Ic7LqFGbhmadXhZ9F0bWG4974CnU
         dSI2jQmpTR1UefYq8x9vTUJvVBU3UGGefhPx39nkH+BysNo5ChHG1Yr8egcBSPIgSs
         Uxy685zCOXc2A==
From:   Mark Brown <broonie@kernel.org>
To:     biju.das.jz@bp.renesas.com
Cc:     Chris.Paterson2@renesas.com, vkoul@kernel.org,
        linux-spi@vger.kernel.org, geert+renesas@glider.be,
        biju.das@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
In-Reply-To: <20220411173115.6619-1-biju.das.jz@bp.renesas.com>
References: <20220411173115.6619-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] spi: spi-rspi: Remove setting {src,dst}_{addr,addr_width} based on DMA direction
Message-Id: <164979621667.474093.7041894961679858887.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 21:43:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 Apr 2022 18:31:15 +0100, Biju Das wrote:
> The direction field in the DMA config is deprecated. The rspi driver
> sets {src,dst}_{addr,addr_width} based on the DMA direction and
> it results in dmaengine_slave_config() failure as RZ DMAC driver
> validates {src,dst}_addr_width values independent of DMA direction.
> 
> This patch fixes the issue by passing both {src,dst}_{addr,addr_width}
> values independent of DMA direction.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-rspi: Remove setting {src,dst}_{addr,addr_width} based on DMA direction
      commit: 6f381481a5b236cb53d6de2c49c6ef83a4d0f432

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
