Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628CC7847BF
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbjHVQeM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbjHVQeM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 12:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30355E70
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 09:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C109F65CA9
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 16:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C459BC433C8;
        Tue, 22 Aug 2023 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722034;
        bh=BITiUg9xjUD0U4d8fln5wHZVFYihEOlTqNuRo2Nh9Q4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qy0Q5XOnP9ivILe3m/JW01RTSG5JND59KiYDs157BGxcnpQc7xhS6jGQGG27H9rnB
         0flYke+EpIqCjFGSoA2U5cPiuBAcP8kB6R5qX8nT8GGDft/DmCr6+Zww7ZT4FACYPw
         O7NXwsE/xNaxsP3prB/h8m1kZpjEIRPiyPCmUgdJgPXjsl0+6oUt81Y5AXhlzqI8RF
         97W3ZWGuhAYe9hYf7367leL5S1NjKIMGvlUzQaQF4WIssdF5Y73vKrntHT2eRYu84Q
         //y5BHUjJ1oh8Db+FZDXrTv4rkS/il+Y1naGWLHdDzJaiV9sNNpSQ6FS6THzwp2A4o
         /xtfZ4X27TQyw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20230822124643.987079-1-ruanjinjie@huawei.com>
References: <20230822124643.987079-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to
 simplify code
Message-Id: <169272203252.71899.12983459585981918051.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:33:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 22 Aug 2023 20:46:42 +0800, Jinjie Ruan wrote:
> Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
> simplify code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify code
      commit: 60ea3db33fbddf559e18567ca8897f6bb9f25290

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

