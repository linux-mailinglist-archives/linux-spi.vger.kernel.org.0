Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171245EBFD5
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiI0Kew (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiI0Keo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 06:34:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80311453
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 03:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED567B81AE8
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 10:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389F8C433C1;
        Tue, 27 Sep 2022 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274871;
        bh=UMdr8CNUsHJdrIZbnLoxC+DdYUOyl1L+mmyLI65lhVM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I2YwGqDJWJnZ0pQ5RENpoM4blRvH2MB66ODZyQpy6/2qI233tf4c+u8iXBwTJDztS
         oxXCvAal2BFM/TVuy2rI5sefNcXKRFWBbuqDVZJTjC2Eb4OMknNhc3SxRl/kR6Mu7T
         U9i2BmNkVnIDQENbwiGvnt1JxPBAOUTJ4svpi2dK+PBguFCCGJH728Eg8PdUUyBIba
         6l3Fdwcu8tf+RrwPWk7qbUfnbN01Jzd2Mn/orZ85cchZ7rWDYgkorAHChPIqxAxdhV
         GQng+V3Tp8yYUBHpPFa3xnXyFhKCXQQkCuX1Uqmz3HTWKHDK5dSiZB3DPjeSPRitFC
         c7oaA7w/LcDJw==
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220924121310.78331-1-zhangqilong3@huawei.com>
References: <20220924121310.78331-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH -next 0/3] Fix PM disable depth imbalance in probe
Message-Id: <166427487094.61277.8173045546114429378.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 11:34:30 +0100
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

On Sat, 24 Sep 2022 20:13:06 +0800, Zhang Qilong wrote:
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed when error returns to keep it
> balanced. This series of patches fixed it in spi probe.
> 
> Zhang Qilong (3):
>   spi: cadence-quadspi: Fix PM disable depth imbalance in cqspi_probe
>   spi: dw: Fix PM disable depth imbalance in dw_spi_bt1_probe
>   spi/omap100k:Fix PM disable depth imbalance in omap1_spi100k_probe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: cadence-quadspi: Fix PM disable depth imbalance in cqspi_probe
      commit: 4d0ef0a1c35189a6e8377d8ee8310ea5ef22c5f3
[2/3] spi: dw: Fix PM disable depth imbalance in dw_spi_bt1_probe
      commit: 618d815fc93477b1675878f3c04ff32657cc18b4
[3/3] spi/omap100k:Fix PM disable depth imbalance in omap1_spi100k_probe
      commit: 29f65f2171c85a9633daa380df14009a365f42f2

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
