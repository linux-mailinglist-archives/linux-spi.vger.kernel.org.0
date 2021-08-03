Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9233DF7E0
	for <lists+linux-spi@lfdr.de>; Wed,  4 Aug 2021 00:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhHCWgI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 18:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhHCWgI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E241601FD;
        Tue,  3 Aug 2021 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030156;
        bh=JG9m2MSBIzYBZolTfpn9n8Dn4NcI+G/B3R/BgSHZWF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=En27IaiQYBwRJ9qUvaNiy2pMitswO/5cjIzYjb681mGQjm2nR7zhcU0m3Afn5xJwh
         gYwiGdIqpW4HNcLt4X+a30U9azmT6z2QvynD0cyiMJ0h1q4s8V1kIM/NCToNRNbW8Q
         bIq+hibTxV+x7EslKTsuy562Ei+jT6Au7FrHBdTgdDPtIMvZZaQfwBw8oh8Nhh5Y68
         lO+n1ksi2+q44NiKOe6MdE0wcqextHamDfBRSj9JaX0lRhKmcz3G7pqzxklUo8eg4m
         5E1yIQiG8Lxl+V9eKhNGIYZlmaQY4Tj/L1HmYD4vSGsY+xhXTLf2kcIJui+NUt3AjG
         NAMrLjh7kgN+A==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tzung-Bi Shih <tzungbi@google.com>,
        Peter Hess <peter.hess@ph-home.de>,
        Hsin-Yi Wang <hsinyi@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH] spi: mediatek: Fix fifo transfer
Date:   Tue,  3 Aug 2021 23:35:29 +0100
Message-Id: <162803013702.42391.66595124838577926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802030023.1748777-1-linux@roeck-us.net>
References: <20210802030023.1748777-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 1 Aug 2021 20:00:23 -0700, Guenter Roeck wrote:
> Commit 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode") claims that
> fifo RX mode was never handled, and adds the presumably missing code
> to the FIFO transfer function. However, the claim that receive data
> was not handled is incorrect. It was handled as part of interrupt
> handling after the transfer was complete. The code added with the above
> mentioned commit reads data from the receive FIFO before the transfer
> is started, which is wrong. This results in an actual transfer error
> on a Hayato Chromebook.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: Fix fifo transfer
      commit: 0d5c3954b35eddff0da0436c31e8d721eceb7dc2

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
