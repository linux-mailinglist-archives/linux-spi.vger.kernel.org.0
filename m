Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB204B8FCB
	for <lists+linux-spi@lfdr.de>; Wed, 16 Feb 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiBPSCS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Feb 2022 13:02:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiBPSCS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Feb 2022 13:02:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35122CC82
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 10:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C6C96118E
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 18:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB56C004E1;
        Wed, 16 Feb 2022 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645034524;
        bh=l/k5GpJQVPT4Ln9GX9+sJsP+LrI33upgS3Bow25XLHQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ROff79xuP+zg7Y71xqh5q18qXQr0gK4faM9Ow3Lm8MBLrBQd2odjCry5qNMtkDd0o
         3cDVKsSS0N/Oh+S2ejpOLD61r02yr8ztarUVc029f9Y5TKxAnVOFLGcpH5Nyk9UCCK
         LoBY+f/7+hrWD//z47/ZxpY8GjpSKcdBT3G15FnlD2mu4xMBkcAkgN91nTrlHGK73w
         kAXyJQj5B+mk+wH3aR4QCQ/KR7ksPeUcEFThLQHuMXDWG6/AO4aDhVvIqgEFdfeO1Z
         8jSVVTnqDeUo4GRHiy5l5pU3kpT5bx6CmICEwuZncBVTf0F6QUFoZZByh86yVL+V8A
         bN6Ire9D44pJg==
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
In-Reply-To: <20220216091317.1302254-1-jarkko.nikula@linux.intel.com>
References: <20220216091317.1302254-1-jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Raptor Lake PCH-S
Message-Id: <164503452318.3088984.7333939263335657646.b4-ty@kernel.org>
Date:   Wed, 16 Feb 2022 18:02:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 16 Feb 2022 11:13:17 +0200, Jarkko Nikula wrote:
> Add support for LPSS SPI on Intel Raptor Lake PCH-S. It has four
> controllers each having two chip selects.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add support for Intel Raptor Lake PCH-S
      commit: 54d0fd06e2bd52d3b17648de787157a7c0625adb

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
