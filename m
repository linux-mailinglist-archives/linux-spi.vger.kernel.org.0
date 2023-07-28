Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B328D7676BA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjG1UGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjG1UF7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995E7423C
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 13:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36A06621CF
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 20:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A2DC433C7;
        Fri, 28 Jul 2023 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690574755;
        bh=py0omZqtWccXsrf8j+lto97C93J9zBJrNhqqVxtPVZ4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rZ8QC/PzAunJKjKpc6WD5MJNL+eKN488pPoz0VtyJiVV7hjBAbYEYL27psyZ5AeZk
         d9w+HDLcskzdR1BVAu3MCeehK7h9BOM/2gs10axZpMhGInc2nlPiLDuIBU4JSxCuX7
         hxbsJq+cYrkk/Ev9tbXNikypgPlG0/XgE65lgQvMZ47xF0PEUICeJJPCTxrYSHqxGo
         9shkLinNJzgzXthKlis4vJQ4c8FvQsb/BBGDxmfUsrEFJkqe9nh37rmkxHZn35ogMF
         oJtsbXxSPK73bgdiwSIA+N17WKQkcpefpQRkV7yCut09IbfUl7e4GE33VkugVBmOHu
         K6KFp1mBmOYpg==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        Chen Jiahao <chenjiahao16@huawei.com>
In-Reply-To: <20230728075729.3451867-1-chenjiahao16@huawei.com>
References: <20230728075729.3451867-1-chenjiahao16@huawei.com>
Subject: Re: [PATCH -next v2] spi: microchip-core: Clean up redundant
 dev_err_probe()
Message-Id: <169057475433.253217.4192656130835572334.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 21:05:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Jul 2023 15:57:29 +0800, Chen Jiahao wrote:
> Refering to platform_get_irq()'s definition, the return value has
> already been checked if ret < 0, and printed via dev_err_probe().
> Calling dev_err_probe() one more time outside platform_get_irq()
> is obviously redundant.
> 
> Furthermore, platform_get_irq() will never return irq equals 0,
> removing spi->irq == 0 checking to clean it up.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: Clean up redundant dev_err_probe()
      commit: 71ee2a4f95e205bd33e79c7bd4bece3885e0e366

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

