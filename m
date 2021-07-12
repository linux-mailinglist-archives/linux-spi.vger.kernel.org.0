Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B33C5AEE
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhGLKts (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 06:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234055AbhGLKtn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F7661106;
        Mon, 12 Jul 2021 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086815;
        bh=s+olitVcChZMJGcS+kpqQWJ7gxyw/XxMyh2v/cXCmg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMH9edpbkpi1nI/fSamz9TwXwBOsZIGevcHb0hhOp2eVJeNptfX151q00O/PDAZJt
         p2wthnmzwnE9cbIwTRXzn9++jj+Kc5iH+Esv9LSkGghHqkv+0CmOqbt14+C8+0a7Ak
         5OJE/q+iZ5L8UNSn3fvzh31PG3LspVdTNtRKCb/U+SnQMsmHmeky6CCWZoW1tBIO2+
         wN5PgdBuFKIsevEaaheaZWNeyDV/EENeg4ShTLhGbiYR5yLoJF7+Xve1GwpacbNvkJ
         8kf0quxY0wLuQRmickbowGeMY1whS0QnQWbPzkfFaIA7cMqIBbHSnu+ps5zZwhurC8
         6vBGrIAqTNasQ==
From:   Mark Brown <broonie@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Hess <peter.hess@ph-home.de>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: fix fifo rx mode
Date:   Mon, 12 Jul 2021 11:45:41 +0100
Message-Id: <162608669457.4543.2374973099687363958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210706121609.680534-1-linux@fw-web.de>
References: <20210706121609.680534-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 6 Jul 2021 14:16:09 +0200, Frank Wunderlich wrote:
> In FIFO mode were two problems:
> - RX mode was never handled and
> - in this case the tx_buf pointer was NULL and caused an exception
> 
> fix this by handling RX mode in mtk_spi_fifo_transfer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: fix fifo rx mode
      commit: 3a70dd2d050331ee4cf5ad9d5c0a32d83ead9a43

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
