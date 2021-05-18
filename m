Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B0387D94
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbhERQdn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 12:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350725AbhERQdm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 May 2021 12:33:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F3466124C;
        Tue, 18 May 2021 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355544;
        bh=Q4paQaxSq7kQJvKQS61olOPIv6iy2psAfTLVH+1Cki0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBBm9beQoy0ifM3MOu5bz8Q5MBpkb0ZJaAywayUbNyMy6dmxwOBvAMc8xiz32UjwZ
         ubGXiFUY3LN7JLmGVlwuH7frWAPNIo1PFhFPGIhwfAC1XIhNI91Gb9REAzKaFS/fKX
         ab4pFpIZeAwucOQxoXQB7jHJIZg7dcM7L4Bp+xvANepXBJQjUCO8sBhtJASTLYafF4
         BaPtgN4zw8Eu2zXvHhYqKcXCWt2Ow58e6a4d0+7yHRa3dhPafA61Er4es0IZGCra4k
         /FzeSkl5vRE4xoEHV3jjxWcucnk2bq3zxTEVnFdb4IFW4OVJDyjXvQxPHnm0NxeyIl
         oEW48LxyylxRA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 0/9] spi: pxa2xx: Convert to use SPI core GPIO handling
Date:   Tue, 18 May 2021 17:31:27 +0100
Message-Id: <162135545749.38023.1340306670750259166.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 17 May 2021 17:03:42 +0300, Andy Shevchenko wrote:
> Convert the PXA2xx SPI host controller driver to use SPI core GPIO handling.
> On top of that a few additional cleanups.
> 
> Has been tested on Intel Merrifield with SPI ADC and TFT display connected.
> 
> Andy Shevchenko (9):
>   spi: pxa2xx: Propagate firmware node to the child SPI controller
>     device
>   spi: pxa2xx: Switch to use SPI core GPIO (descriptor) CS handling
>   spi: pxa2xx: Switch to use SPI core GPIO (legacy) CS handling
>   spi: pxa2xx: Drop duplicate chip_select in struct chip_data
>   spi: pxa2xx: Drop unneeded '!= 0' comparisons
>   spi: pxa2xx: Fix printf() specifiers
>   spi: pxa2xx: Fix style of and typos in the comments and messages
>   spi: pxa2xx: Update documentation to point out that it's outdated
>   spi: pxa2xx: Use predefined mask when programming FIFO thresholds
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: pxa2xx: Propagate firmware node to the child SPI controller device
      commit: 94acf80755c8d8dd066d4f5a2afbdf393f0e2afd
[2/9] spi: pxa2xx: Switch to use SPI core GPIO (descriptor) CS handling
      commit: 778c12e69481d544e6fcfa45b23ae3c5379b5a02
[3/9] spi: pxa2xx: Switch to use SPI core GPIO (legacy) CS handling
      commit: de6926f307e7ff605f3e37f11a4b3cc20c85c365
[4/9] spi: pxa2xx: Drop duplicate chip_select in struct chip_data
      commit: ccd60b2030a04b91977d9fee9e0ec6469ac4cd1b
[5/9] spi: pxa2xx: Drop unneeded '!= 0' comparisons
      commit: eb743ec600be596553bf4e42c85b0bbc65083791
[6/9] spi: pxa2xx: Fix printf() specifiers
      commit: 684a3ac720c3fd4c09ae5aa3d349861bf12dcff6
[7/9] spi: pxa2xx: Fix style of and typos in the comments and messages
      commit: 8083d6b812cac5e38db9c707b41cd478beed4a0c
[8/9] spi: pxa2xx: Update documentation to point out that it's outdated
      commit: f96e6c0ef63b981d295547ef624f4da7c820e097
[9/9] spi: pxa2xx: Use predefined mask when programming FIFO thresholds
      commit: 70252440b2b6337d03f2b95bc475fedbea79072f

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
