Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A74215F0C
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 20:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgGFSxC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 14:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFSxC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 14:53:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3719206B6;
        Mon,  6 Jul 2020 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594061582;
        bh=1pgcZAcTyrqQrn6MY0IG27g0n+HxZi89cxBxSn/Hj9k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xjD+DOuNF1rMkrbnG663BKV27d8KZqrgl1NVJS5jh2Q6t7a/dA8kwXU2BrKcBgvQ9
         5f2IGHxD8Nvk4UbUNQ4ZFQzrpoQliQHbbgBO+HhUh4tii/PXu/T9V/RQ7TtDtqkf5T
         dWKtxqUti48GzpXoAeVF+0AHF4y1w1FUsIOk//Gg=
Date:   Mon, 06 Jul 2020 19:52:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/10] spi: spi-sun6i: One fix and some improvements
Message-Id: <159406157795.12660.13647887275558305804.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 6 Jul 2020 16:34:33 +0200, Marc Kleine-Budde wrote:
> this series first fixes the calculation of the clock rate. The driver will
> round up to the nearest clock rate instead of rounding down. Resulting in SPI
> devices accessed with a too high SPI clock.
> 
> The remaining patches improve the performance of the driver. The changes range
> from micro-optimizations like reducing MMIO writes to the controller to
> reducing the number of needed interrupts in some use cases.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/10] spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate
        commit: ed7815db70d17b1741883f2da8e1d80bc2efe517
[02/10] spi: spi-sun6i: sun6i_spi_transfer_one(): report effectivly used speed_hz of transfer
        (no commit info)
[03/10] spi: spi-sun6i: sun6i_spi_transfer_one(): remove useless goto
        (no commit info)
[04/10] spi: spi-sun6i: sun6i_spi_transfer_one(): remove not needed masking of transfer length
        (no commit info)
[05/10] spi: spi-sun6i: sun6i_spi_get_tx_fifo_count: Convert manual shift+mask to FIELD_GET()
        (no commit info)
[06/10] spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it
        (no commit info)
[07/10] spi: spi-sun6i: sun6i_spi_drain_fifo(): remove not needed length argument
        (no commit info)
[08/10] spi: spi-sun6i: sun6i_spi_fill_fifo(): remove not needed length argument
        (no commit info)
[09/10] spi: spi-sun6i: sun6i_spi_transfer_one(): collate write to Interrupt Control Register
        (no commit info)
[10/10] spi: spi-sun6i: sun6i_spi_transfer_one(): enable RF_RDY interrupt only if needed
        (no commit info)

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
