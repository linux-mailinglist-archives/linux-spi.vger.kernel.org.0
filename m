Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06233170F3
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 21:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBJUOn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Feb 2021 15:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhBJUOm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Feb 2021 15:14:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF8764EDA;
        Wed, 10 Feb 2021 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988042;
        bh=HXbD6+omxDsYOOdWUR5Q/TMtgVvFhX3rk1zEGyAMCGY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=srXat2kJ71vHsiVQJX1mYJimvtLkFSjX+XUVMS8oNRTE5U+vZorg4iGVHdNUvwzH7
         Jbzd8BMmbdy8Yok3ysy6NaU//IEi2wzKbi//Iyq2tuELhjqkt+9ttkbB4mI8YYJkTW
         fDPnrEIbgraF++KQWJfoIcAp9PsuS5IBJzUkfNG8iQAh8pCIdza3d+rQVTus8d9nsp
         C5wqsg+qzGLb8wl0lJPaCQ+8C5Y0wp4m8bxkwVo03atvIeHvjG78rayF+u8c6DzHJy
         u6lHZl7bvseF74RaRMR1mLWU8fbSaWROmNJH/PKg2X7pSuY+MPQGNrEHyEwOBWuMqn
         EGm/LFaANb2iw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Leif Liddy <leif.liddy@gmail.com>
In-Reply-To: <20210208163816.22147-1-andriy.shevchenko@linux.intel.com>
References: <20210208163816.22147-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: Fix the controller numbering for Wildcat Point
Message-Id: <161298798949.6180.15248539955734234716.b4-ty@kernel.org>
Date:   Wed, 10 Feb 2021 20:13:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Feb 2021 18:38:15 +0200, Andy Shevchenko wrote:
> Wildcat Point has two SPI controllers and added one is actually second one.
> Fix the numbering by adding the description of the first one.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pxa2xx: Fix the controller numbering for Wildcat Point
      commit: 54c5d3bfb0cfb7b31259765524567871dee11615
[2/2] spi: pxa2xx: Add IDs for the controllers found on Intel Lynxpoint
      commit: 2395183738a01048584c4b49c502c44b18971597

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
