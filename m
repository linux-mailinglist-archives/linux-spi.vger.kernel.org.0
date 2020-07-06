Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094B8215F25
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgGFTCP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 15:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgGFTCO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 15:02:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CB020675;
        Mon,  6 Jul 2020 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594062134;
        bh=gzTTX1PQu5ZqFe8WVzc64bdNxTkHUWXJXqQv1xAZ2lY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MkbsxLjlc8ZsZKalTS5xiMtkoDmPX/g5kmUkSt/4MDQ0VskwruegiIypclVRbg/UY
         c7WLSRd2eqY8tTkYrrk0F2r8VeiM5gWyMu/0F4Os6R28fTLvAIEiycEUG9maQFZ4rZ
         09SKhd8mHpplA7RxonE2A9RtAuJ/u8tJcXoMyq78=
Date:   Mon, 06 Jul 2020 20:02:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/10] spi: spi-sun6i: One fix and some improvements
Message-Id: <159406213007.15907.9385586711959946299.b4-ty@kernel.org>
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
        commit: 09a7139e9e172e70cd980c45e01a49e3c2630864
[03/10] spi: spi-sun6i: sun6i_spi_transfer_one(): remove useless goto
        commit: 642d75131c8cab1f355f513bd19e90960720b839
[04/10] spi: spi-sun6i: sun6i_spi_transfer_one(): remove not needed masking of transfer length
        commit: 05bf34283c8e1c44bcae9bdb9c07df6769cdc995
[05/10] spi: spi-sun6i: sun6i_spi_get_tx_fifo_count: Convert manual shift+mask to FIELD_GET()
        commit: e0430d9040983ab05f59136f4291ae04e01e1e30
[06/10] spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it
        commit: 9bfc242a93792b298b95003c691f46b838de0482
[07/10] spi: spi-sun6i: sun6i_spi_drain_fifo(): remove not needed length argument
        commit: 60b1f09675f2330c84055cb11389c6212fe53cec
[08/10] spi: spi-sun6i: sun6i_spi_fill_fifo(): remove not needed length argument
        commit: 15254b028dd6cf67e06dbc963fbd0c1cae33e35a
[09/10] spi: spi-sun6i: sun6i_spi_transfer_one(): collate write to Interrupt Control Register
        commit: 1e9ca016b623a3560831df811bc1eaa29b30359c
[10/10] spi: spi-sun6i: sun6i_spi_transfer_one(): enable RF_RDY interrupt only if needed
        commit: 878d4d57a6e5d3feae1f8a247ca04d3bfbc553cc

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
