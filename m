Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657722EE18
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgG0N5V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgG0N5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 09:57:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1172070A;
        Mon, 27 Jul 2020 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858240;
        bh=Egeq+a8oWDr1xtB1xbFHglsSZ6j1GXnIOgGl3YfP39c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QJCj4FlhVyGBn71gPApMPrk9ALQq2zR3lQwvdtcITRWzDgFvw8Ee6+fxmp3zzej1i
         cd9WgMNsMCUVx45aAqG7OgEDWFqhv5r8PG22q3uOqOXksz8j/4jP6edNRQl4x3IRH7
         1E3qFQDxdiLPFrLPuOHhqZE+5jj+JZEDWw+xAlwY=
Date:   Mon, 27 Jul 2020 14:57:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jonathan Liu <net147@gmail.com>
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-sunxi@googlegroups.com
In-Reply-To: <20200727072328.510798-1-net147@gmail.com>
References: <20200727072328.510798-1-net147@gmail.com>
Subject: Re: [PATCH] spi: sun4i: update max transfer size reported
Message-Id: <159585821344.22560.5654112245536281167.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Jul 2020 17:23:28 +1000, Jonathan Liu wrote:
> The spi-sun4i driver already has the ability to do large transfers.
> However, the max transfer size reported is still fifo depth - 1.
> 
> Update the max transfer size reported to the max value possible.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sun4i: update max transfer size reported
      commit: 241b888791ee2fa47b97b3b9dc0e857d241db18d

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
