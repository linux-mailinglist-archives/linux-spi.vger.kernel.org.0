Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB352D7D64
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405729AbgLKRwt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436663AbgLKRwg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 12:52:36 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>, linus.walleij@linaro.org
Cc:     thesven73@gmail.com, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, letux-kernel@openphoenux.org,
        linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-gpio@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        andreas@kemnade.info, kernel@pyra-handheld.com, lukas@wunner.de
In-Reply-To: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
Message-Id: <160770909979.26609.3989372028641790318.b4-ty@kernel.org>
Date:   Fri, 11 Dec 2020 17:51:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Dec 2020 10:57:44 +0100, H. Nikolaus Schaller wrote:
> Behavior of CS signal in combination of spi-cs-high and gpio descriptors
> is not clearly defined and documented. So clarify the documentation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
      commit: 2fee9583198eb97b5351feda7bd825e0f778385c

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
