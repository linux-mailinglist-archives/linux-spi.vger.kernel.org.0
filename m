Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03C3CD6B3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbhGSN5M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 09:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240899AbhGSN5L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E42610FB;
        Mon, 19 Jul 2021 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626705471;
        bh=qSegALWE4Yh4Tp+o7047dXuFJLI9dzWkbXWCIzaY21I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWMTircKa41QyltdnJKMvXXQhgWh8z5bZ1UnqVPrVvn5x0q9V/hn1Rsl8T7AESTuz
         rVdDXnXxQeW13ZQOtBZCJREofZ96RcqnMgCukrnbiZKudoMud+hyYtmhYi3BxXVJpA
         0Nlb6N83kv8UIcK8m6/lnWMnaKK6Sr/b4Fd7xGUOxlQBH0F2vFblDvrUKze7SC9hNQ
         C31hU3kAGgcWw+3zyEHyOj1/ZfHuhXSaw4j5p/+a9hi9ykWlCnaQLCw6oBGreyFieY
         +MfSqvcHB07i2nqx7IdAsIydumQ4Yuby52yFVlMLWdSKsFyvT+uH3Jz2M9wBw8TRT6
         3KTTljRLInp1g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v1 1/3] spi: pxa2xx: Convert reset_sccr1() to use pxa2xx_spi_update()
Date:   Mon, 19 Jul 2021 15:37:41 +0100
Message-Id: <162670536704.50818.6835889742211265163.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
References: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Jul 2021 10:48:40 +0300, Andy Shevchenko wrote:
> Convert reset_sccr1() to use pxa2xx_spi_update().
> It will help for further improvements.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: pxa2xx: Convert reset_sccr1() to use pxa2xx_spi_update()
      commit: e0a6512d29126901dd16dfede314616b57ec8210
[2/3] spi: pxa2xx: Reset DMA bits in CR1 in reset_sccr1()
      commit: cdcb26ce747a5ec665a98fd6c303248a12418140
[3/3] spi: pxa2xx: Reuse int_stop_and_reset() in couple of places
      commit: 3bbdc083262dc082e5c8e7b0646faf8f4ef894dd

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
