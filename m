Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2FD1E2761
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbgEZQqD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 12:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbgEZQqD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 12:46:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702E720787;
        Tue, 26 May 2020 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511562;
        bh=S8DXF5whCJVrLiIbJyuxDnBvjgMNZGsJRChfwI5ZWs0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JjlT5DAKDOqfsolwZ+sidtirEa1omgURXCzlAlJDb8g32UYbF700xgJKFJn5IHdYl
         Jx4mOmdN6KgaZTg52fTOzkklbj4SCRTGs8Gw3y1utGzs1PNnAbpTXGRikRWBAqGAsP
         zzQjtJHZp/V0tDCoz3azzkawrkCo6Cpeku1Jc5KQ=
Date:   Tue, 26 May 2020 17:46:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <cover.1590408496.git.lukas@wunner.de>
References: <cover.1590408496.git.lukas@wunner.de>
Subject: Re: [PATCH 0/3] Intel SPI unbind fixes
Message-Id: <159051156064.36444.8173070417753169615.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 May 2020 14:25:00 +0200, Lukas Wunner wrote:
> Fix unbind ordering issues in the Designware and PXA2xx SPI controllers
> built into Intel SoCs.
> 
> To test, you'll also need the following commit:
> https://git.kernel.org/broonie/spi/c/84855678add8
> 
> This is compile-tested only, so please review and test thoroughly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dw: Fix controller unregister order
      commit: ca8b19d61e3fce5d2d7790cde27a0b57bcb3f341
[2/3] spi: pxa2xx: Fix controller unregister order
      commit: 32e5b57232c0411e7dea96625c415510430ac079
[3/3] spi: pxa2xx: Fix runtime PM ref imbalance on probe error
      commit: 65e318e17358a3fd4fcb5a69d89b14016dee2f06

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
