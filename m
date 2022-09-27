Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7F5EBFD6
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiI0Key (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 06:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiI0Ker (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 06:34:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5832215FF9
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 03:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ACB0B81AE1
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 10:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36778C433D7;
        Tue, 27 Sep 2022 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274873;
        bh=ZVjN0xxHSAa6ZxI4uknUhVSZgHiVGfBmHB9JFh+T8oU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jP1k4xgfZ5oDyMi7Eg4MNY6sY5RpUfYyGg45HrenZjuDZf0i00gSsS5tZVFwc14+N
         eeJD3uwHq87IaDUgCDufHHXPGYhK7GchBA5isPwdsbYKS09gOzmYfN+eAZFDqoZo64
         Ya3+hNV6q3oLz5ONFJ0ECXRYA7UiiqiN3PyFw7pXcRJQUWuqKaHfL38PNol/Mzap5M
         a7F+Bqm/+qiVGILkCZpc1+O5wOYsarK2BbNeDAKl845/mn+dPFHIiRFnLvzfCemEGY
         c+sdlAg8Vo3jKQpHm9ceyCWuL7q8PiiGIDI+LxrE5/CzkjEDhmXaxWqUNCXENTqkmD
         tbKVSTQaz6wvw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, olteanv@gmail.com
In-Reply-To: <20220924131854.964923-1-yangyingliang@huawei.com>
References: <20220924131854.964923-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/3] spi: spi-fsl-dspi: Use devm_platform_get_and_ioremap_resource()
Message-Id: <166427487193.61277.16583804674559801107.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 11:34:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 24 Sep 2022 21:18:52 +0800, Yang Yingliang wrote:
> Use the devm_platform_get_and_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-fsl-dspi: Use devm_platform_get_and_ioremap_resource()
      commit: f96087a38cca6f3bb4c7cf582b949016aeb59d0e
[2/3] spi: spi-fsl-lpspi: Use devm_platform_get_and_ioremap_resource()
      commit: c9e1bb724d884b12a4c0d1dc9f802946cf427a92
[3/3] spi: spi-fsl-qspi: Use devm_platform_ioremap_resource_byname()
      commit: fc13b5a25e18b0de5e04b6f5616c60d71d2610ee

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
