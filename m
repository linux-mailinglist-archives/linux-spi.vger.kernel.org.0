Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7252B616315
	for <lists+linux-spi@lfdr.de>; Wed,  2 Nov 2022 13:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKBMxl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Nov 2022 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBMxk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Nov 2022 08:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868D12ACD
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 05:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1288E61938
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 12:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F757C433D6;
        Wed,  2 Nov 2022 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667393618;
        bh=HUaX7/YlSarkGhwpq8zkE1UE6fTkb+hUhR5lKuSb+2U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fcFRw8lH23Z4PEu6PYHiuEZdvW4+vNJFfIRbM5pUF9xHyIz8PiyO58vN6MZlOtPvF
         f9jeeLHkh/eYmWvTAmTB4w4PDvmszmysPMj2J+YGSUvY7bRmI2U3W1VEavoBQtJJGJ
         WDXKJ83qyj5Lalp7j1FKb8TKlrXDC+poWUmqVMWG7t6CSsuYX7zvaG7FsCGrTEclMh
         +FPT9hDt8jKMbaTeiw4+1Wdp5ULFNXU0a5SifOKZ4FH8L4Xp0+Off+cdgRnSLPtjo5
         VrIRFqrv69MCE+angBSD6q7/L9AmyHMbel84fvhuvfzEeYOENuJ0fXmjrGBr/WwPte
         rpnQRujA5ua8Q==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20221011092204.950288-1-yangyingliang@huawei.com>
References: <20221011092204.950288-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next v2] spi: introduce new helpers with using modern naming
Message-Id: <166739361729.53459.11070295966522868765.b4-ty@kernel.org>
Date:   Wed, 02 Nov 2022 12:53:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 11 Oct 2022 17:22:04 +0800, Yang Yingliang wrote:
> For using modern names host/target to instead of all the legacy names,
> I think it takes 3 steps:
>   - step1: introduce new helpers with modern naming.
>   - step2: switch to use these new helpers in all drivers.
>   - step3: remove all legacy helpers and update all legacy names.
> 
> This patch is for step1, it introduces new helpers with host/target
> naming for drivers using.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: introduce new helpers with using modern naming
      commit: b8d3b056a78dcc941fd1a117697ab2b956c2953f

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
