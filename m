Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1144B6CC3
	for <lists+linux-spi@lfdr.de>; Tue, 15 Feb 2022 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiBOMzO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Feb 2022 07:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiBOMzJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 07:55:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001EA43EC4
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 04:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2BDAB8197E
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 12:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E3C340EB;
        Tue, 15 Feb 2022 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644929697;
        bh=uVWI4CMV+I3jJ276SMUxmo3/TkrU9pzutKfov4C0bo8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ug28vgVvrnr8BBPz858ILYOlQ04tcHaq0eC3mna79cbvy2TY+sPjNFV3s/6Tks9uK
         Wxz3hZRzZIQlPZmAiOW0E4PsZap9XyyabLwvn4yaLPaxPXXCEaxfZ0fORuuJzXh5lS
         wtar7XCYy4Pi+giTA74vtVAE0E2ul6tSPPZLUkwZBTx4Bk4fiOpukt9QNrHFWZ9ePB
         jvlLAFMXGtFaM14CoZEoYjReHnsIbkY1M+a+1v2cJRE8+ismI4M6a6uc6ElqDY8wfY
         qv4nIUQoQgxhzqxCGarTLyXdVSuqWtEpYl0mERo5WLeUVwoZFEIfSXxXTffxZhjeXe
         EwMAfZXFL/TWA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
In-Reply-To: <20220210231954.807904-1-linus.walleij@linaro.org>
References: <20220210231954.807904-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: Retire legacy GPIO handling
Message-Id: <164492969672.14011.3447263844526022620.b4-ty@kernel.org>
Date:   Tue, 15 Feb 2022 12:54:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 11 Feb 2022 00:19:54 +0100, Linus Walleij wrote:
> All drivers using GPIOs as chip select have been rewritten to use
> GPIO descriptors passing the ->use_gpio_descriptors flag. Retire
> the code and fields used by the legacy GPIO API.
> 
> Do not drop the ->use_gpio_descriptors flag: it now only indicates
> that we want to use GPIOs in addition to native chip selects.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Retire legacy GPIO handling
      commit: f48dc6b9664963107e500aecfc2f4df27dc5afb6

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
