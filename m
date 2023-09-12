Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75E79D02C
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjILLib (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjILLiN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 07:38:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E510DD
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 04:38:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574B7C433C7;
        Tue, 12 Sep 2023 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518684;
        bh=eC1SKY1lRRQfbXqU3JXJ7zM40IsYGNqnW2q2A+2NZbo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qp5d0DmQi1Kak77khGdhzJq0maxBWwA/APer/0UA/i+af64CXkQNjok7OvrRZ9pcS
         kLDVlQ9CQ9CEOAL0v0gqLz4173DCXaRgmA9icAo9JLUZO/I/OM2PgeyMCFJvDf1eZD
         k5S25O93pmDhRwjJ24pvhiTzRpYNqDdNPu73DeQUDJ14o//hEscNy2REYwIqxzndtH
         BJZMmaqspVvTJgo/RRlX2FfGUht2Q2L6/n7MsHLh+eZXKRqLQRKyKyW5a357qExokc
         eSy1WIRjW0fKa1p0D4h0fnCKDLEZ954EF+7CRGG32wEiHOepDGjSSO7v+8PyiCE0fX
         Z5pM2Z4weq6Fg==
From:   Mark Brown <broonie@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     andrew@aj.id.au, angelogioacchino.delregno@collabora.com,
        avifishman70@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        benjaminfair@google.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, conor.dooley@microchip.com,
        daire.mcnamara@microchip.com, fancer.lancer@gmail.com,
        florian.fainelli@broadcom.com, heiko@sntech.de,
        jbrunet@baylibre.com, joel@jms.id.au, khilman@baylibre.com,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        martin.blumenstingl@googlemail.com, matthias.bgg@gmail.com,
        neil.armstrong@linaro.org, olteanv@gmail.com,
        openbmc@lists.ozlabs.org, rjui@broadcom.com, sbranden@broadcom.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next v2 00/25] spi: Use devm_clk_get_*() helper
 function to simplify the drivers.
Message-Id: <169451867563.2398433.2879364442627175413.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:37:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Aug 2023 21:39:13 +0800, Li Zetao wrote:
> Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks") provides a new helper function for prepared and
> enabled clocks when a driver keeps a clock prepared (or enabled) during
> the whole lifetime of the driver. So where drivers get clocks and enable
> them immediately, it can be combined into a single function
> devm_clk_get_*(). Moreover, the unprepare and disable function
> has been registered to devm_clk_state, and before devm_clk_state is
> released, the clocks will be unprepareed and disable, so it is unnecessary
> to unprepare and disable clocks explicitly when remove drivers or in the
> error handling path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/25] spi: ar934x: Use helper function devm_clk_get_enabled()
        commit: 1d3ea34b7b69b2cbdcc82f1d399705c06ea5f748
[02/25] spi: armada-3700: Use helper function devm_clk_get_prepared()
        commit: f918b3a67ccbcf326a80100c17e107eece5df868
[03/25] spi: aspeed: Use helper function devm_clk_get_enabled()
        commit: 9ee8fbc05ef0b69e8cb4295b2663e044dd3868a3
[04/25] spi: ath79: Use helper function devm_clk_get_enabled()
        commit: b3422ea3913e27fd43a7a1883f358cb20599289e
[05/25] spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
        commit: a08199b309f833fd4221ab5ee2391c791fe26385
[06/25] spi: bcm2835: Use helper function devm_clk_get_enabled()
        commit: ba85f5fad849821bfce0ee154a72df7e2376c5eb
[07/25] spi: bcm2835aux: Use helper function devm_clk_get_enabled()
        commit: 0135a38436111366bc2fe6d3cd82a9c2cc92ce7f
[08/25] spi: spi-cadence: Use helper function devm_clk_get_enabled()
        commit: f64b1600f92e786e502cc30d31d9e3c5f2f6d682
[09/25] spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
        commit: c32cb76e8d5e487698f8eceb5b53df95a33fe388
[10/25] spi: davinci: Use helper function devm_clk_get_enabled()
        commit: 9dc2aa96a3533215fbed9cf1297f7aa70dae840b
[11/25] spi: dw-bt1: Use helper function devm_clk_get_enabled()
        commit: 10c3937890be2c53bfa4aaf3b22a46749857f86a
[12/25] spi: dw-mmio: Use helper function devm_clk_get_*()
        commit: 349112b6769ec0018404f87dd4632f8ea393fcaf
[13/25] spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
        commit: 4812bc31af2b523d4da8386a524a2cd2f6f5919b
[14/25] spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
        commit: e2b9622b2a3d058e7d06827b99487b27f777b9c2
[15/25] spi: meson-spicc: Use helper function devm_clk_get_enabled()
        commit: 7ef51102d32ddc4776b2cdd583fe84afb84c823f
[16/25] spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
        commit: c45fd1217b38048332c4f5bff8bfb7c1fe6ab6dd
[17/25] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
        commit: e922f3fff21445117e9196bd8e940ad8e15ca8c7
[18/25] spi: microchip-core: Use helper function devm_clk_get_enabled()
        commit: 605204fcb9c49818a8a7e533147061a305ac39e3
[19/25] spi: mtk-snfi: Use helper function devm_clk_get_enabled()
        commit: a06b6935f10267a300be724dca11226d6d519156
[20/25] spi: npcm-fiu: Use helper function devm_clk_get_enabled()
        commit: 82c4fadb0b957c817b5a3fcc05dc774bf32a4d07
[21/25] spi: orion: Use helper function devm_clk_get_enabled()
        commit: bbd0a66b85fe860e8b6acfb1739d15b517a4f6fb
[22/25] spi: pic32-sqi: Use helper function devm_clk_get_enabled()
        commit: 909d4cd6bc316e6cd7958832f3efe9e2fd51dcbf
[23/25] spi: pic32: Use helper function devm_clk_get_enabled()
        commit: 6b6cc88c4e5b42d2ba6af43152af6d9d96872ee8
[24/25] spi: spl022: Use helper function devm_clk_get_enabled()
        commit: 9351339c1a99cca47e6fbeef88b1ef6438d36127
[25/25] spi: rockchip: Use helper function devm_clk_get_enabled()
        commit: d6c612a34740118855cd1c8acc4339adea686266

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

