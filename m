Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0238A765C2A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjG0TcJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjG0TcI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 15:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC3E2D68;
        Thu, 27 Jul 2023 12:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9768C61F25;
        Thu, 27 Jul 2023 19:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE67C433C8;
        Thu, 27 Jul 2023 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690486327;
        bh=vfQGAejKZ0C1dV2ZU3c4HwdGEhiVDbGHzWFLcFkuffE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Qe36Xr+GMFZHAlWFXazgGks/p2iLuJngiZ2Km0gjLCEDD7TpOghOa6JMm+GiaB9jM
         iFZBylzkCsPMUx5U0mtQaZvSepfxl4j/4Xbv/m3MSo6gJRSSkOQgoeg+rCgAWPghX/
         S+AgHcVZJiyoqwaW+53WSy+lkOnAFudeQKztsFSXQCuF7cZpG4/7y0VOZ0OxCw15Er
         lOm6F5XmbiWY+5hK5X95CmaKn5+W+24aqk1VO10dwQOPb19f1muimsekxmY0wY7w77
         uzv+/Z91wo83tAxiQJR9dgzEO/fzC085mEQgHP43loavg5K+27BBMnDOdilyTeWl3k
         CYB372eDEZl9g==
From:   Mark Brown <broonie@kernel.org>
To:     andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chen Jiahao <chenjiahao16@huawei.com>
In-Reply-To: <20230727131635.2898051-1-chenjiahao16@huawei.com>
References: <20230727131635.2898051-1-chenjiahao16@huawei.com>
Subject: Re: [PATCH -next] spi: s3c64xx: Clean up redundant dev_err_probe()
Message-Id: <169048632527.156543.15543418164260508901.b4-ty@kernel.org>
Date:   Thu, 27 Jul 2023 20:32:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 Jul 2023 21:16:35 +0800, Chen Jiahao wrote:
> Referring to platform_get_irq()'s definition, the return value has
> already been checked if ret < 0, and printed via dev_err_probe().
> Calling dev_err_probe() one more time outside platform_get_irq()
> is obviously redundant.
> 
> Removing dev_err_probe() outside platform_get_irq() to clean up
> above problem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Clean up redundant dev_err_probe()
      commit: b2b561757027ef03b1243c828820a9004458194c

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

