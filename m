Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9D6BF010
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCQRpI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCQRow (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 13:44:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB950A5CF
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 10:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90CB1B82661
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 17:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B58C433D2;
        Fri, 17 Mar 2023 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075065;
        bh=Ke60Wp7AjiuhY7XxwdAZTtvqsKUizAF9JWLIxQtx5Wk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vCKP/ZB4kCkuLBtqwu+BenUjEHNdkKJycYRtxbTK0KTXP1DnIHkVwiiX4ji0EelGh
         Vgc7L+StdhGdnBefgstc3f1azQEwUxi4/SVx0mgdlMw7iy1uIDvuzPtXUHpVM5InAg
         H5IrozAhxSfvHuc0OzTOCAaCHnCPFGYb6VZSTW4Cs5pcAxkIYW8x9hv0Ixz8HRcoO3
         GtUvHr4RUJPe7rO9aDq/AHGPTKD8nxe9BcwuWuzYVTz3ZLjjgCXmEceWP63nVBrYs+
         du0pCidzNbsI81MadsOrvFNfbOi6TV1y8qP97oLtamVAyShfiJqYKTksR7iq+5FqDr
         ZaQOLx7yExxkQ==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
In-Reply-To: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] spi: atmel-quadspi: Convert to platform remove
 callback returning void
Message-Id: <167907506357.52032.17972055222889817145.b4-ty@kernel.org>
Date:   Fri, 17 Mar 2023 17:44:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Mar 2023 09:42:29 +0100, Uwe Kleine-König wrote:
> this series converts the atmel-quadspi driver to use the .remove_new()
> callback that doesn't return an int but void. The motivation is to not
> give driver authors a reason to (wrongly) believe that returning an
> error code was sensible error handling. In fact the spi core only emits
> a warning message in this case and otherwise continues as if the return
> value was zero. This usually yields resource leaks that sometimes can
> lead to exceptions later on.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: atmel-quadspi: Don't leak clk enable count in pm resume
      commit: c18bbac353ffed50be134b0a2a059a2bd540c503
[2/3] spi: atmel-quadspi: Free resources even if runtime resume failed in .remove()
      commit: 9448bc1dee65f86c0fe64d9dea8b410af0586886
[3/3] spi: atmel-quadspi: Convert to platform remove callback returning void
      commit: 4d70dd0a25081bc4e6378d0da4a7c367389df707

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

