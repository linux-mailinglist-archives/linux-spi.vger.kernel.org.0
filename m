Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6351D5BD292
	for <lists+linux-spi@lfdr.de>; Mon, 19 Sep 2022 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiISQv1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Sep 2022 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiISQu3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Sep 2022 12:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB233DBE7
        for <linux-spi@vger.kernel.org>; Mon, 19 Sep 2022 09:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7036D61E09
        for <linux-spi@vger.kernel.org>; Mon, 19 Sep 2022 16:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9956C433D6;
        Mon, 19 Sep 2022 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663606205;
        bh=jqnP47xBAm2GgPhUFh4b/X6SxBO7CS9GHbe6ehMHX3U=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ZnaJTXeiPoAp+sv9P9zVw0Lp/DdN7SczIGdGfRlTUjPaljgLPYu6Cf1t6GXSjcuGd
         0Qsz+z76mTt2+UHOpRkN+Fc484fs84BkJyJkOMEH1zJzzwr5CHzzKh1ECl1xPlUUy6
         iiOcvPw+hvqdvRQirDN45faogq804LRF3smxNFZZ5IM51OAugL1GeCOjPJUGxsun4M
         KnaEFpHkvBfoPSVraOM7vFvDtY6P974ILEkRE8iHVLDcLQQV7KmfgymROAOeFCZI2+
         W4QsAiacrKJW+WcojxZa/DEUXQXhIQWisl5e0WuEEDVicEArQryAi/48EkSFtIZ/mN
         E32CPq9vybeow==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20220917122504.1896302-1-yangyingliang@huawei.com>
References: <20220917122504.1896302-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: omap2-mcspi: Switch to use dev_err_probe() helper
Message-Id: <166360620456.3110754.11216184008174998846.b4-ty@kernel.org>
Date:   Mon, 19 Sep 2022 17:50:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 17 Sep 2022 20:25:04 +0800, Yang Yingliang wrote:
> In the probe path, dev_err() can be replace with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Switch to use dev_err_probe() helper
      commit: f4ca8c88c2c7ea3ea17c6fdfcc1af4b007403833

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
