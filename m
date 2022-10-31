Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42C613D77
	for <lists+linux-spi@lfdr.de>; Mon, 31 Oct 2022 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJaSh4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Oct 2022 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJaShy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Oct 2022 14:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7112626
        for <linux-spi@vger.kernel.org>; Mon, 31 Oct 2022 11:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A7B661381
        for <linux-spi@vger.kernel.org>; Mon, 31 Oct 2022 18:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF4EC433D6;
        Mon, 31 Oct 2022 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667241473;
        bh=i+yPzrCSz0YZ0l6H+oz4q1INYIikBfVEObARDZP/XIE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=t6S6ZlVa3WFsffDu54wGPUvJy4qqpE/yYJLUa/7i2YbJ9mgZ+AxpZCmv3PBSmOlk2
         oDgqaS2KVV5hb8xwPDaSB6yBOWyryftyRTMc4nfRLALzQhPHHuo8OPzJ4VAXzqTWe1
         3ZYM4/A3H1exb3aMtl1us/Ky8Hu4XFGijbjzSjBvRlNdOtfnxsN2l9oWRFPH5qbmTE
         GIfB97aTTEqNqxfGolCt7OJDJ1u+KYq6SOWRXHTHDrwSDmoY7Jmm8gnTItcHZ7LF8/
         dz+AEn016C7KHhKdBMi82EEHfVl3yP7wmc8SfEbrqoK2NxBSqBd6WL/FSCfbIy63Pm
         gvOh6sL2oCLPQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20221029071720.3041094-1-yangyingliang@huawei.com>
References: <20221029071720.3041094-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: mxic: Use devm_platform_ioremap_resource_byname()
Message-Id: <166724147229.755330.342817343045455692.b4-ty@kernel.org>
Date:   Mon, 31 Oct 2022 18:37:52 +0000
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

On Sat, 29 Oct 2022 15:17:20 +0800, Yang Yingliang wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxic: Use devm_platform_ioremap_resource_byname()
      commit: 347ad8f295c66f3193d57cc5b69b6138f2e24231

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
