Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6272DFF03
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 18:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgLURbQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 12:31:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgLURbQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Dec 2020 12:31:16 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Roman Guskov <rguskov@dh-electronics.com>,
        linux-spi@vger.kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, marex@denx.de,
        alexandre.torgue@st.com
In-Reply-To: <20201221123532.27272-1-rguskov@dh-electronics.com>
References: <20201221123532.27272-1-rguskov@dh-electronics.com>
Subject: Re: [PATCH] spi: stm32: FIFO threshold level - fix align packet size
Message-Id: <160857182009.9832.11490882818266811084.b4-ty@kernel.org>
Date:   Mon, 21 Dec 2020 17:30:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Dec 2020 13:35:32 +0100, Roman Guskov wrote:
> if cur_bpw <= 8 and xfer_len < 4 then the value of fthlv will be 1 and
> SPI registers content may have been lost.
> 
> * If SPI data register is accessed as a 16-bit register and DSIZE <= 8bit,
>   better to select FTHLV = 2, 4, 6 etc
> 
> * If SPI data register is accessed as a 32-bit register and DSIZE > 8bit,
>   better to select FTHLV = 2, 4, 6 etc, while if DSIZE <= 8bit,
>   better to select FTHLV = 4, 8, 12 etc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: FIFO threshold level - fix align packet size
      commit: a590370d918fc66c62df6620445791fbe840344a

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
