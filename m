Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B14598C2
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 01:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhKWADi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 19:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232677AbhKWADg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9C696101A;
        Tue, 23 Nov 2021 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637625628;
        bh=ARZtdnYVkDDzWubL/eOjshZWqCo06As9GZuYBFAAzv4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GVwpYyozHvEFXNb9Yv4RmHp+WxcZwz0xorHsxblUK25gZ1cdMaeZOq9DZ+XBRQxBl
         NnNQ8ijIqBZGUBqH1NYorolgpCxkQsCg50JwsHGzzyxb2Eswf6nEK538YiuEGbxwKn
         rlC//oY5m/4xX9DfhD7DI3Lk0u4d4z0QUHx+Ds9ie8f4Bo5EnVtYGIy3masSyWmso8
         OZeW3HxK0iG2Do5MZ6lOwPbSel/7Ln/uSOGq184iJ1+CVubWoBdhLCtqY5JwtMwKvA
         q85GdMANA38HcYgnhte6p9jB5Jvi6osXpo6miDj9cUvOdgVkFcCYqrnUvpgTcvMGJa
         EIsvwsrcAD3zQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org
In-Reply-To: <20211120011715.2630873-1-linus.walleij@linaro.org>
References: <20211120011715.2630873-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: spi: Add resets to the PL022 bindings
Message-Id: <163762562745.2472045.372621212417525202.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 00:00:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 20 Nov 2021 02:17:15 +0100, Linus Walleij wrote:
> Some PL022 implementations provide a reset line to the silicon
> IP block, add a device tree property for this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Add resets to the PL022 bindings
      commit: d94758b344e3b6f16d31cb5b51b93e3e5a4c3567

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
