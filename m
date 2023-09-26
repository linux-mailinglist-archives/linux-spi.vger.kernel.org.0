Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4527AEB0E
	for <lists+linux-spi@lfdr.de>; Tue, 26 Sep 2023 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjIZLIv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Sep 2023 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjIZLIu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 07:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0397AE9
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 04:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DFBC433C9;
        Tue, 26 Sep 2023 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695726523;
        bh=jQrrNY4WO/EXAky46FBS3wZWboPvdx/wNKeZCzXERe0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q6yn4qmExdhyPIqy05Or2lb/0bjFn6xu/ixZUFpQhwHiaGTKG54qD9GyXLePDUrVX
         AdMGE7HyBpxLw50pJucZXsqPO2v6w18prC1BJVd34Lba2FIXTAInM/UzDhgpqywb+x
         0NzQgQnu+ezXM4GbMhKtKMnBCxj1+7ZBey9UTQvN8Ty1BS8vMkxTgx53FFo3j3G2Ak
         SWip6w5WQ351MZDpyinJDrMUaj6Vr1+ggC2vsOQFYH2gN7/A3VdXQYK3ggw7J9W/kj
         RuZteJ7PNSezAeBxjNkEF1o6g3ePuJwQuMDBzi7AGT8z+VS1TKRx6RcYxwtlywLGnv
         6Y80uKx1G1DpQ==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20230924183904.752415-1-festevam@gmail.com>
References: <20230924183904.752415-1-festevam@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: fsl-imx-cspi: Document missing
 entries
Message-Id: <169572652181.2600426.16905514948305432960.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 13:08:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 24 Sep 2023 15:39:04 -0300, Fabio Estevam wrote:
> The imx25, imx50, imx51 and imx53 SPIs are compatible with the imx35.
> 
> Document them accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: fsl-imx-cspi: Document missing entries
      commit: 3b4e5194138b4576e7b703edcd85ffe8783df798

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

