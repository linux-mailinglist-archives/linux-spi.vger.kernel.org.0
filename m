Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE46EE68D
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjDYRXi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjDYRXh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 13:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA996186
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 10:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18334616E0
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 17:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA88C433D2;
        Tue, 25 Apr 2023 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682443401;
        bh=zFaMvqpqHQBGOI/Ggem/GCjEDNjr+qvP09GqdsSChn0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C713p22wwoeUTsOPW1NCyX9s7Am9VCq26e5XZ0C5X/3td+u48Ee+PW6iDAm0/QoAm
         Q9DW3BXr3I8uksvLU2HIgFYdpuv/+dbX3kTlnji0uPF6J5WC5VU8qWJllbPygCbLRx
         HjrLCFlCIvPE31+iNSMkkRUxkzc0ZcNdBz+r3i9Eg7WZyAPpeTpkk16NtLrY+J6pk7
         5HTwOKY9fU4LIfjU6JB2EXsNkuV2A+1ZQlo6Upw219By41CGfDV1R3WI22TjCFnpN3
         Qb3E3d+h+Xw8KNubLUOaHNW3iwX3jVhon0eauuBJkl7Dgfl584WVw+FTWTajH6guv0
         398XE9nC5k6Jw==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org
In-Reply-To: <20230424102546.1604484-1-d-gole@ti.com>
References: <20230424102546.1604484-1-d-gole@ti.com>
Subject: Re: [PATCH] spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS
Message-Id: <168244340047.132997.1432969789675006214.b4-ty@kernel.org>
Date:   Tue, 25 Apr 2023 18:23:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Apr 2023 15:55:46 +0530, Dhruva Gole wrote:
> Using this macro makes the code more readable.
> It also inits the members of dev_pm_ops in the following manner
> without us explicitly needing to:
> 
> .suspend = bcm63xx_spi_suspend, \
> .resume = bcm63xx_spi_resume, \
> .freeze = bcm63xx_spi_suspend, \
> .thaw = bcm63xx_spi_resume, \
> .poweroff = bcm63xx_spi_suspend, \
> .restore = bcm63xx_spi_resume
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS
      commit: cc5f6fa4f6590e3b9eb8d34302ea43af4a3cfed7

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

