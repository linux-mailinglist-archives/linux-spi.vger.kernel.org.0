Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC53CD6B5
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbhGSN5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 09:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240899AbhGSN5O (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CCD6112D;
        Mon, 19 Jul 2021 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626705474;
        bh=BWI3pvx4DEtc/bAdqcLe/NbSBCWY1F4gM6If+8JXt+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YK72Aw7CCzRA+RxsWucfqSdw+kYw1voHHtMmzUVq/zChi781M1B3Wjk9oab52Aeev
         dKcXi8gHCipdr137PjHBP4R3drgEWAYdv/9znMblZrG1a+iY/xB6P8Lz3Wpk+x50E0
         3Qe2yiwmJO7jX1NevxxhCONS7Hzh4eTbsTz1Io/U97eS97pVsc1uSBrNwfR49Cw78H
         RN1eXgjgfOxOcPRgTgDavxgSNSOViv7zYCg98ukrxKj9NQNwx2jhSFd7xg0Q97aFC5
         kK2mrae24Z2nyRheQa7Z9tKiq8Ck+MeP2IaV9BlXx3LNfuHneyVOCXkad7E4ODMCND
         ZOkcQ7f78Gj6g==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] spi: imx: Simplify logic in spi_imx_push()
Date:   Mon, 19 Jul 2021 15:37:42 +0100
Message-Id: <162670536703.50818.3968243168026993357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716173927.2050620-1-u.kleine-koenig@pengutronix.de>
References: <20210716173927.2050620-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Jul 2021 19:39:27 +0200, Uwe Kleine-König wrote:
> For each usage of fifo_words it is clear if ->dynamic_burst is true or
> not. This can be used to simplify the function a bit.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Simplify logic in spi_imx_push()
      commit: bd9616996bb8cd6fbceedf00f1aa72fd9a845519

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
