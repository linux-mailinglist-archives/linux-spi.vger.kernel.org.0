Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A9419D50
	for <lists+linux-spi@lfdr.de>; Mon, 27 Sep 2021 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhI0Rsm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Sep 2021 13:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238150AbhI0RsU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 509D360F44;
        Mon, 27 Sep 2021 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764802;
        bh=FSMXtPhnWPq6diY6hiFhNED/y8RCkkFjlPW9MVqz4Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSTfHsJ6qKseWBD2s1VY46g/SaPYeEdluIS6uGBTxY8+9SFKAP9vPIl9iBq4eufCG
         lTqgeB4hvJDd7BIZN/sxp1JTBnUvuPFJ2Q/waBduQSeMdqO1kkF5Q1uXisXfOApGGe
         mktyq0Hqy9iwm+p73YQazmULQ3E5BbM/PSYwf6xhf6vvHwP8KsfxJ4zbCNAvCtzhSe
         kU2LOASKRRTrVCE07j/NTpU82DLfxMbl0WHrOZGxzZKCJGagnvCBXNnyeAhWJqKmjQ
         gOD/8+iKxWflIWYJGIK0gun8LMKPoMj34FmJc0lSeJ3bE7m0lwxTruQwx/92mRSP8z
         QzDrjR7o9+jSg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: spidev: Add SPI ID table
Date:   Mon, 27 Sep 2021 18:45:18 +0100
Message-Id: <163276467077.29936.11995608205913405531.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923170023.1683-1-broonie@kernel.org>
References: <20210923170023.1683-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 23 Sep 2021 18:00:23 +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding an id_table listing the
> SPI IDs for everything.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Add SPI ID table
      commit: 6840615f85f6046039ebc4989870ddb12892b7fc

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
