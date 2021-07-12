Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763673C5AF1
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhGLKty (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 06:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234167AbhGLKts (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C58C61106;
        Mon, 12 Jul 2021 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086820;
        bh=ZYpcfcf7qgIM+Qx1cNCzTr/iRgF5v3a7dsuOCWZerQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqcY7kabzCOe/xumC/yEPj+39L0m9zh4Y1QLct1cLj3pAq2sT8QHX8GWDYGDCeSdr
         sxrFVI3WeeWaSwKMaPfubJg0bHl/C78i+luF5jkQo4rGWBazJ1d8kGFi/2p4/rpEU4
         VnngVKoZuaGqdrZNau1NDR0gl1EIUWMvIftaZ4RZlyB3K4dYo425Z7ltrJhnno9u/O
         6z80yyGci6U5/fvp7OgpcigzdRpEWaYKF6qJSY93oUNCnQEZBrFEeQi50d1hv5H1FZ
         FaRf3PPRCGo7hq3m9BR9IeHjZowaxtPgfHiOm05e6+sqwwrjHg0DCT9h1y3hHcgYtw
         G74jBB5+G306w==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mason Zhang <mason.zhang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        linux-spi@vger.kernel.org, leilk.liu@mediatek.com
Subject: Re: [PATCH 1/2] spi: mediatek: add no_need_unprepare support
Date:   Mon, 12 Jul 2021 11:45:43 +0100
Message-Id: <162608669456.4543.1877349027408478150.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210629100814.21402-1-mason.zhang@mediatek.com>
References: <20210629100814.21402-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 29 Jun 2021 18:08:15 +0800, Mason Zhang wrote:
> This patch add no_need_unprepare support for spi, if spi src clk is
> MAIN PLL, it can keep the clk_prepare and will not cause low power
> issue. So we no need do clk_prepare/clk_unprepare in runtime pm,
> and it will get better performance, because clk_prepare has called
> mutex lock.
> In the same way,
> clk_get_rate also has called mutex lock, so we moved it to spi_probe.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: mediatek: add no_need_unprepare support
      commit: 162a31effc4182dd5a0675d9fd0336d5096e0ad3

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
