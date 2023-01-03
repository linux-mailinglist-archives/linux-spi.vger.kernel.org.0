Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1765C2C7
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jan 2023 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjACPMM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Jan 2023 10:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjACPMJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Jan 2023 10:12:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C2FD3D
        for <linux-spi@vger.kernel.org>; Tue,  3 Jan 2023 07:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AEB61359
        for <linux-spi@vger.kernel.org>; Tue,  3 Jan 2023 15:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64166C433EF;
        Tue,  3 Jan 2023 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672758725;
        bh=U8ATHxWS/5qdTc/xLmAkadVD7bM8DMC8wdJD8lvFd/k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O8Ijn7dfGNsj32xCLIOt9D/gbNl3dE8doCMT8JSAdPwdQKy9VGb8yd4SAHs0WE4x2
         x2paYmgVEGeYwN7KxO6K6CMGAzwcAEHeaIpfk7Lj93DOWQhzbabE3B+54yHie/FEYi
         dGLSulRZprcarM3R5pIoPZFkLGeqUXnoM+EYdg5c/sZsJm75Bwb79sT+i57UxhSOEj
         NEL06Q6yciwRM6vwVNYRtleGBmtlVuvlCzaIp4QpxbDu/uGWgLAbo4zadWH6vixhbR
         ll+oKdNpkOsTiJCNnZQ+d/S5w6p7aNxwoljfayBBBW3dTpA2JQq4+PHDF7xt84h/l6
         zAS4kn3cu+YtA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20221230092806.1687340-1-yangyingliang@huawei.com>
References: <20221230092806.1687340-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 0/3] spi: switch to use modern name
Message-Id: <167275872408.121994.1187657216248235453.b4-ty@kernel.org>
Date:   Tue, 03 Jan 2023 15:12:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 30 Dec 2022 17:28:03 +0800, Yang Yingliang wrote:
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller.
> 
> Yang Yingliang (3):
>   spi: ath79: switch to use modern name
>   spi: a3700: switch to use modern name
>   spi: ar934x: switch to use modern name
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: ath79: switch to use modern name
      commit: 5aede90a1f6d37c73395957a83b64a6a1cff6de4
[2/3] spi: a3700: switch to use modern name
      commit: 90ce7e7aaa418ff6c59d1c30267ff086994669b4
[3/3] spi: ar934x: switch to use modern name
      commit: 87384599a56f22bbfe6d91e23ef2c767541f2ad9

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
