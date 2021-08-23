Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201263F4FA9
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhHWRjJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 13:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231724AbhHWRjI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Aug 2021 13:39:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C65BB61378;
        Mon, 23 Aug 2021 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629740305;
        bh=ugd2XJQ8HC698Lo5FzAAM8u1s8A3IJx0MWF/1OqrKIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNkcNxjQZiq2NevldjYN9wHhKP3ebqdUG0iSjAdQt6Sc95AA73baqcuH5dazzdh5M
         1+W3RSf0cCaqS/U9vWtgp5xLqmZprDKl1IqJ1NK8jg8LGPDU/ov5cHWaVHLYXDaJUg
         xhV+Vl3A8piyvoK6rtl1XdWYh2YkhcdjO0sU5Jucz2XARITkL1kOCAdnFndupiv2mA
         nFAn47ebtS+3fLrCQgUa1bwOL47bFoj7VhWeEQS3kgKVBCVgNF/T2XfEsKLt+zyOU+
         5I8daYiSjfeh3/6X81s6jo4vptRzwMuIALDEHc7Tm54SE2XmtRo9ng3Gh/u9HF3Jv2
         4TIzDlsYTAgWw==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Jon Lin <jon.lin@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip-sfc: Remove redundant IO operations
Date:   Mon, 23 Aug 2021 18:37:51 +0100
Message-Id: <162974017517.3286.666459658265810667.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210821124925.6066-1-jon.lin@rock-chips.com>
References: <20210821124925.6066-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 21 Aug 2021 20:49:25 +0800, Jon Lin wrote:
> Coherent dma buffer is uncached and memcpy is enough.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Remove redundant IO operations
      commit: 8d00f9819458b95301e274c6df705df2963ba34f

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
