Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B162275B6D0
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jul 2023 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjGTSb0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jul 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGTSbZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jul 2023 14:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58390270D
        for <linux-spi@vger.kernel.org>; Thu, 20 Jul 2023 11:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B203261BD5
        for <linux-spi@vger.kernel.org>; Thu, 20 Jul 2023 18:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F19C433D9;
        Thu, 20 Jul 2023 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877883;
        bh=g1K2s+Hbonbf9gtZhEFrcfK7/dlT2inxpu/JqkMKQLk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rN2VUELExx0NcpWCyBp03eG95T6IubQOmzlBJr10tMRklUYuZWURCXTWdmaXcwgRn
         dbUSY1tL1YAKEGPuFabCw0jrGtMMnXLG8fA+Oe+Ce35WASa/vw6fX0C4bcmL8gdo1e
         mpPiHp6WIgSEqdEAl2OLJLlw5ISy22L33vaiybvYpK1QRGwI0dprO00iFRJqDzM+Eq
         WANxvBiVwegCsly8zJNWaFn8shLuNjsX5EE1XVv2WPSuuDkhYKdQWgm/w5IoT5TmE0
         r4TkdAhYwPmYNj73Y1W5aV2TUrKic8l78E/RQppgBteCg5cCY/oOWpEXgohdAaZ9Cl
         TspK8L16InoOA==
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-spi@vger.kernel.org,
        Yuanjun Gong <ruc_gongyuanjun@163.com>
In-Reply-To: <20230720140859.33883-1-ruc_gongyuanjun@163.com>
References: <20230720140859.33883-1-ruc_gongyuanjun@163.com>
Subject: Re: [PATCH 1/1] spi: fix return value check in bcm2835_spi_probe()
Message-Id: <168987788201.226162.16815806255628581135.b4-ty@kernel.org>
Date:   Thu, 20 Jul 2023 19:31:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 Jul 2023 22:08:59 +0800, Yuanjun Gong wrote:
> in bcm2835_spi_probe(), clk_prepare_enable() may fail, therefore,
> the return value of clk_prepare_enable() should be checked, and
> the function should return error if clk_prepare_enable() fails.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix return value check in bcm2835_spi_probe()
      commit: 1e7dae68510aa90a022fefed392fa794b16bc68b

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

