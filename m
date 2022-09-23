Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32EB5E822E
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWSy2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiIWSyX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 14:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A6121E6D
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 11:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD01D620DF
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 18:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8074AC433C1;
        Fri, 23 Sep 2022 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663959255;
        bh=63CI3bwEAdj1hbUTO+M2yM6yKn0UvUh/DxFkeWY1c5Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Up/C22lduxmRJMhC2QZu/HSjtqVh7r/NoWIthUUiKJHRx4xM54WPRR6aT1Axc9d2m
         Dvd6BnzUFUAl62fSn5wpoUX/6v8ruW7i3e2ql3MJ7kpMf+QfLcTDzq+3CecBZSth/G
         EaMJIBWxrfYZh5fBVqmdzk/WGhyKSR2D6gt/tf6vk8fx01lQbxYeSu9NacZeFfl7b/
         sRpvs1iqXmlt/j8GZz0UpmujCCqFxPU+6Yl4boJrIBxMRJMFSfDrWD+9oU9azAk26f
         DAqveiTbC0rlSNRiZ6FRKl57PkmS18XYUvb5E/fGwL09OyiPc+ly8AWua+qBINxMkE
         9XY3pHyrM0Fcg==
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220922150232.115843-1-zhangqilong3@huawei.com>
References: <20220922150232.115843-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH -next] spi: img-spfi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <166395925425.804455.11591507889276515887.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 19:54:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Sep 2022 23:02:32 +0800, Zhang Qilong wrote:
> Using the newest pm_runtime_resume_and_get is more appropriate
> for simplifing code here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: img-spfi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: c79ce0a2824bc987ee4cd19f6a0a4e1eb493a8d8

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
