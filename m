Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8112235A304
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhDIQXk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234120AbhDIQXj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4535610A7;
        Fri,  9 Apr 2021 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985406;
        bh=pa2AjAoluq/aoXrCWtDRuMHjAZVPUHpKBrOfayVzouk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5NVjfM2LsLT8CzeBbO8qfTYWmQaOFItqCV2INyJHkuY4FjxWAkTwUhmdPz9mjFDM
         YfVVLnSyLKHe/PAAYNlIYGpN42tI+DdfBGtT5ytbGwcdApaFDo6zrDKb1scU26B3Bp
         7y0+wAKLYaHs0J5JbMBISRzus9W3U+RgWkrDJnoLodNPtAeJLugxe59UVEjzAmslD7
         JqUnm0L/T7geeHUTZ0+tMXlrdXoP+7VglLuAcy9p2gaB7houOqnPe7OnQtakjiJgrt
         ppn8/l3MDmdOcPrqLnnzNcgsYmgY5l9uVRZCr49k/1odFReqegaueEiM/oTTNMrDV5
         6yj72O+Qz2MoA==
From:   Mark Brown <broonie@kernel.org>
To:     s.hauer@pengutronix.de, Clark Wang <xiaoning.wang@nxp.com>,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] spi: imx: add a check for speed_hz before calculating the clock
Date:   Fri,  9 Apr 2021 17:22:42 +0100
Message-Id: <161798356988.48466.14829479576984252197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408103347.244313-2-xiaoning.wang@nxp.com>
References: <20210408103347.244313-1-xiaoning.wang@nxp.com> <20210408103347.244313-2-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 8 Apr 2021 18:33:47 +0800, Clark Wang wrote:
> When some drivers use spi to send data, spi_transfer->speed_hz is
> not assigned. If spidev->max_speed_hz is not assigned as well, it
> will cause an error in configuring the clock.
> Add a check for these two values before configuring the clock. An
> error will be returned when they are not assigned.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: add a check for speed_hz before calculating the clock
      commit: 4df2f5e1372e9eec8f9e1b4a3025b9be23487d36

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
