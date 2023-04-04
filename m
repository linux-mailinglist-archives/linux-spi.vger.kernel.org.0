Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277F56D67B2
	for <lists+linux-spi@lfdr.de>; Tue,  4 Apr 2023 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjDDPlt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Apr 2023 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbjDDPlm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Apr 2023 11:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16D5FC3;
        Tue,  4 Apr 2023 08:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE41B63623;
        Tue,  4 Apr 2023 15:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707B6C4339C;
        Tue,  4 Apr 2023 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680622873;
        bh=n//VaCjNu9218CXZ/dYzy2wxaSAVAeL37OTLjJJEbxc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DRoMcTBeRTsey8ioIY1DcWRZ9t9gipJUYhGz8ndyHBoGJ/mJ++fVTYGwcHfeyczqa
         bq37zHQHBBg5Jmrn6ae15OELVN86ovlya+GzY4lLWMyCx6aijhq6+y8ZZljyXx7O8l
         mUit6HjQxFpQrsQP/R0k0lSHhTdkrk+hnp59J0/j7gbE6R/A3K1Tk+CEn+XoBa4PX2
         8NN0lsV141Kp5KuaHgt1PvAGCbJzdXneAum9/wh3SbchCEvBBRIEwwbso7QmHvzhcQ
         xzy+zuC382LHkoJwnyT9EwSns+Zplkba/jajMVYdgl+kt77st4l3FBcPtbeElPhm1t
         pWRJ2IOt4cxjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
In-Reply-To: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
References: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] spi: qup: Convert to platform remove callback
 returning void
Message-Id: <168062287113.55756.14239306718114556460.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 16:41:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 30 Mar 2023 23:03:39 +0200, Uwe Kleine-König wrote:
> after fixing the error handling in the .remove() callback of the qup
> driver, convert it to .remove_new() preparing to make platform driver's
> remove functions return void.
> 
> Best regards
> Uwe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: qup: Don't skip cleanup in remove's error path
      commit: 61f49171a43ab1f80c73c5c88c508770c461e0f2
[2/2] spi: qup.c: Convert to platform remove callback returning void
      commit: dea8e70f68f4105279bbc6de4d68d89fb07665c2

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

