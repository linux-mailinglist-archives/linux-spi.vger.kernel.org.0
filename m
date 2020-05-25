Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7731E1119
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbgEYO5n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 10:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404081AbgEYO5m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 10:57:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAED1208A7;
        Mon, 25 May 2020 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590418662;
        bh=KZgLeB3b8W/zy8/Etavtg1/GXbyQ9qgZcEmZ7ArhdQU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xHCyhgk1XFHIgfjIf/8d8J17gm1AgTZBTnbHJ1HyRcMkX4fCUZuTy8qQhl8AKe1qv
         r3CgT63Af9zXYmvAL57EUNck48r0oFwRQAy+LUo7hb4Mf9MeeBOzQ5iF8s/aUVG3gf
         OKpJ3QVvxw8FXneS02Jr4ij6vE/KSJlftTrPUhHA=
Date:   Mon, 25 May 2020 15:57:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
In-Reply-To: <20200525104352.26807-1-peda@axentia.se>
References: <20200525104352.26807-1-peda@axentia.se>
Subject: Re: [PATCH] spi: mux: repair mux usage
Message-Id: <159041865398.1642.13467128308689680434.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 May 2020 12:43:52 +0200, Peter Rosin wrote:
> It is not valid to cache/short out selection of the mux.
> 
> mux_control_select() only locks the mux until mux_control_deselect()
> is called. mux_control_deselect() may put the mux in some low power
> state or some other user of the mux might select it for other purposes.
> These things are probably not happening in the original setting where
> this driver was developed, but it is said to be a generic SPI mux.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mux: repair mux usage
      commit: a2b02e4623fb127fa65a13e4ac5aa56e4ae16291

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
