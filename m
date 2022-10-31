Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E91613D74
	for <lists+linux-spi@lfdr.de>; Mon, 31 Oct 2022 19:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJaShy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Oct 2022 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJaShx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Oct 2022 14:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7E12626
        for <linux-spi@vger.kernel.org>; Mon, 31 Oct 2022 11:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE6261381
        for <linux-spi@vger.kernel.org>; Mon, 31 Oct 2022 18:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC48FC433C1;
        Mon, 31 Oct 2022 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667241472;
        bh=k6N38e70/PPX6NSRdBrUX8Bzwq8mIT6o35ZKD786iR0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SkV5Wr/CIw5qdIkzVXHHGMNDEYK6AF3A4+9G8FNv2BL0f6tvVUzS+Og4VRTVFTHG3
         4kLQ3LzO4QztxK1vubOEUvdcWI03YJKkBuh1EHqjgb7wxsSp7rijUY11KxIacjCuBD
         kks/8F8mEaD8dojMbJeBi58ORTJ7q6t+yO1CM8iLz7msr/wMPUb8WsXRiSda6NBoRt
         c6ftjDScW2mwuM/eO8iHhg6ysrzaSqwHDg5kpMuZdITN7lD67XmNQrOteuFJGIcHKL
         POSbFh2b0jvLhDyDsqjYCh8IX3vz2uB3Jbm76i4IBObBsGklnRFJ5F1rQ5lGjSQyIl
         HXhjDHrfZPctA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, tmaimon77@gmail.com
In-Reply-To: <20221029071529.3019626-1-yangyingliang@huawei.com>
References: <20221029071529.3019626-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: npcm-fiu: Use devm_platform_ioremap_resource_byname()
Message-Id: <166724147061.755330.5013073524228405509.b4-ty@kernel.org>
Date:   Mon, 31 Oct 2022 18:37:50 +0000
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

On Sat, 29 Oct 2022 15:15:29 +0800, Yang Yingliang wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: npcm-fiu: Use devm_platform_ioremap_resource_byname()
      commit: 1793d36672eb8d86fb319cd28e056a154945506f

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
