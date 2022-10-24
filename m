Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FBA60B295
	for <lists+linux-spi@lfdr.de>; Mon, 24 Oct 2022 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJXQuS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Oct 2022 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiJXQsp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Oct 2022 12:48:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A3237E4
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 08:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E769B81A00
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 12:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08628C4347C;
        Mon, 24 Oct 2022 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666616082;
        bh=/Hvz+l0AENVRBaJq5ELeg6RQrp2Zccyv0iMqeDx7GLI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aURGS+WXZsbsRaG1jhb9epj4xEQvDWnnYIBVQjbW9SXiTJ8aCf6gV+PKItA5/qfbL
         R6ezgbAO0yrcs1ertWKF+0L5mXO1q/qe8c172iLcmFkf/cYbcva99iQoubmSq7PX+D
         dqFljRVPd94Wekspopbrll8GBvQ2mtyywLa16dvJmXCkjI2Opy+8m3E0sqPDpKy6I9
         w1f8RhJivBdF04SpyGryYAyeyJfO6DamkfQujtVy/qreDjJr29QJVuJzzt7aFutQxq
         BW36KJAe8oXpi+jce3uUMvfwg4tCFaPO/mR9KdaitGWJsHJPx4LC+4bD4NdGwm/qre
         ExfvC211GQ96g==
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
In-Reply-To: <20221018183513.206706-1-marex@denx.de>
References: <20221018183513.206706-1-marex@denx.de>
Subject: Re: [PATCH] spi: stm32: Print summary 'callbacks suppressed' message
Message-Id: <166661608074.206590.10120140622465679611.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 13:54:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Oct 2022 20:35:13 +0200, Marek Vasut wrote:
> The original fix "spi: stm32: Rate-limit the 'Communication suspended' message"
> still leads to "stm32h7_spi_irq_thread: 1696 callbacks suppressed" spew in the
> kernel log. Since this 'Communication suspended' message is a debug print, add
> RATELIMIT_MSG_ON_RELEASE flag to inhibit the "callbacks suspended" part during
> normal operation and only print summary at the end.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Print summary 'callbacks suppressed' message
      commit: 195583504be28df5d608a4677dd796117aea875f

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
