Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C297EA3E9
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 20:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjKMTk5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 14:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjKMTks (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 14:40:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B05173D
        for <linux-spi@vger.kernel.org>; Mon, 13 Nov 2023 11:40:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6188BC433C8;
        Mon, 13 Nov 2023 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904444;
        bh=HVX1nWhmjGRePbzxnLv7UeMhU7yYQBJcckvpwFnTaEc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eZ2BFnM+M1KBgtOtnywjNSxwITPbrub9axyU7Bu4g+p+bIW0OJV051H0YDxL5XntR
         cp9B6kCQYtRoEbLMAKY/N/qwK+ij0a9qYHep7s02DvlE8jfQt+fPHdVkzTGxazIagl
         1XRXB8BD7qLDEbtc4Q8KOh9ndpWwb02suEDHO2KWRNrkZ5x5ilV0tsWt6mXpz7c4+Z
         GPZbNl4yGxZBE0biQN8J6j/zuJpQDZkAZa8y8sRnmbopW18iV7rW6k697+JvqMjvoy
         ts50u1cSFOZV4WZyOV2M+rAeA9wsiogYzgXbANY2QZTBND6ATnzsGn9jKHav/ZQqDQ
         O7HFK0rzrnEWg==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
In-Reply-To: <20231105172649.3738556-2-u.kleine-koenig@pengutronix.de>
References: <20231105172649.3738556-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: spi-ti-qspi: Convert to platform remove callback
 returning void
Message-Id: <169990444271.3294163.9545811716692480043.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 05 Nov 2023 18:26:50 +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: Convert to platform remove callback returning void
      commit: 2f2802d1a59d79a3d00cb429841db502c2bbc3df

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

