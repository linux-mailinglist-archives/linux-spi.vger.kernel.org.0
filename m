Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACAC5A6C99
	for <lists+linux-spi@lfdr.de>; Tue, 30 Aug 2022 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiH3Sxb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Aug 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH3SxX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Aug 2022 14:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B03A56B81;
        Tue, 30 Aug 2022 11:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B605D6150E;
        Tue, 30 Aug 2022 18:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62060C433D6;
        Tue, 30 Aug 2022 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661885601;
        bh=n2oCNckMdWFuTnsc9BCHrAKAiEPqoAK9e1Dl3nAkMYA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aJGnySLbRmkplRrzI8eOM4Lv9QBHleBdnI1+59aeZesedGt53LEYzDwQHWqHVUNt0
         4hmlKBilLm3UOCQgYRP5HZQ16DvlcA4qXFvU6kMlXbX11xEeo20nb3atR97/9wUNE0
         mjBWi8qDPSs7j6SMC0F8jEJME7yF4TLsHpj4MsU1DCWmVihA+7xiv1DT3zxbgm81Pi
         phG8Xb3CV+2kvyAW+O0Jt+4ZOpnQU0b7tM2YN4km8IRsKztphe1kYlk1K8WTzwIJl8
         1uEEkgElZXWryg5XGM/ecPgDdESdf5Fn8Gu74QqwZDbw3tjYYB595pAnIDNUhJpnRA
         h80ACPHDtmn1g==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-spi@vger.kernel.org
In-Reply-To: <20220830124452.33561-1-sebastian.reichel@collabora.com>
References: <20220830124452.33561-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/1] spi: spi-rockchip: Add rk3588-spi compatible
Message-Id: <166188559907.1148585.13680922112371234952.b4-ty@kernel.org>
Date:   Tue, 30 Aug 2022 19:53:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 30 Aug 2022 14:44:52 +0200, Sebastian Reichel wrote:
> This adds a compatible string for the SPI controller found in
> the RK3588 and RK3588s SoCs.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: spi-rockchip: Add rk3588-spi compatible
      commit: fb43eb0a930ca9474484b1ff04c3fd532efdc8e3

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
