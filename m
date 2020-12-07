Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A612D1771
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 18:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGRXB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 12:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGRXB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Dec 2020 12:23:01 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
Subject: Re: [PATCH 00/17] SPI probe/remove sanitization for 5.11
Message-Id: <160736172966.53398.13275156803596013198.b4-ty@kernel.org>
Date:   Mon, 07 Dec 2020 17:22:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 7 Dec 2020 09:17:00 +0100, Lukas Wunner wrote:
> Patches [01/17] to [14/17] are reposts, now based on spi.git/for-5.11
> and amended with all collected Acked-by + Reviewed-by tags.
> 
> Links to their original submission:
> https://lore.kernel.org/linux-spi/dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de/
> https://lore.kernel.org/linux-spi/73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de/T/#t
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/17] spi: davinci: Fix use-after-free on unbind
        commit: 373afef350a93519b4b8d636b0895da8650b714b
[02/17] spi: spi-geni-qcom: Fix use-after-free on unbind
        commit: 8f96c434dfbc85ffa755d6634c8c1cb2233fcf24
[03/17] spi: spi-qcom-qspi: Fix use-after-free on unbind
        commit: 6cfd39e212dee2e77a0227ce4e0f55fa06d79f46
[04/17] spi: spi-sh: Fix use-after-free on unbind
        commit: e77df3eca12be4b17f13cf9f215cff248c57d98f
[05/17] spi: pxa2xx: Fix use-after-free on unbind
        commit: 5626308bb94d9f930aa5f7c77327df4c6daa7759
[06/17] spi: rpc-if: Fix use-after-free on unbind
        commit: 393f981ca5f797b58b882d42b7621fb6e43c7f5b
[07/17] spi: mxic: Don't leak SPI master in probe error path
        commit: cc53711b2191cf3b3210283ae89bf0abb98c70a3
[08/17] spi: spi-mtk-nor: Don't leak SPI master in probe error path
        commit: 0f4ad8d59f33b24dd86739f3be23e6af1a86f5a9
[09/17] spi: gpio: Don't leak SPI master in probe error path
        commit: 7174dc655ef0578877b0b4598e69619d2be28b4d
[10/17] spi: rb4xx: Don't leak SPI master in probe error path
        commit: a4729c3506c3eb1a6ca5c0289f4e7cafa4115065
[11/17] spi: sc18is602: Don't leak SPI master in probe error path
        commit: 5b8c88462d83331dacb48aeaec8388117fef82e0
[12/17] media: netup_unidvb: Don't leak SPI master in probe error path
        commit: e297ddf296de35037fa97f4302782def196d350a
[13/17] spi: mt7621: Disable clock in probe error path
        commit: 24f7033405abe195224ec793dbc3d7a27dec0b98
[14/17] spi: mt7621: Don't leak SPI master in probe error path
        commit: 46b5c4fb87ce8211e0f9b0383dbde72c3652d2ba
[15/17] spi: ar934x: Don't leak SPI master in probe error path
        commit: 236924ee531d6251c8d10e9177b7742a60534ed5
[16/17] spi: npcm-fiu: Disable clock in probe error path
        commit: 234266a5168bbe8220d263e3aa7aa80cf921c483
[17/17] spi: atmel-quadspi: Fix use-after-free on unbind
        commit: c7b884561cb5b641f3dbba950094110794119a6d

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
