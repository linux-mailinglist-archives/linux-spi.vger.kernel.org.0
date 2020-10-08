Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5CB287E74
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 00:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgJHWCH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Oct 2020 18:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgJHWCH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Oct 2020 18:02:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D462322243;
        Thu,  8 Oct 2020 22:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602194526;
        bh=3RIpzEcj7T30YTVlBHibHypn1NGJKou2PJuhumSR8qo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=l3gyT2w0X9PLE/i7GwXzfWcTgTaN/XxY9XDQlijuMqhj3vNjePFK7Z9lI8r2VdDKW
         MwILL8+ba+bsPaNiXM5TO5ht1KcZlRBjoXoziJVXPr7ItbXOVdZEbynptOCxVkaDQc
         368kREJm19k43DNVeoRUWS7FXa5dhCoBi+fxF+7Y=
Date:   Thu, 08 Oct 2020 23:02:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     "wuxu . wu" <wuxu.wu@huawei.com>, devicetree@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201007235511.4935-1-Sergey.Semin@baikalelectronics.ru>
References: <20201007235511.4935-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 00/21] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-Id: <160219452406.29901.9988267577138948294.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 8 Oct 2020 02:54:49 +0300, Serge Semin wrote:
> Originally I intended to merge a dedicated Baikal-T1 System Boot SPI
> Controller driver into the kernel and leave the DW APB SSI driver
> untouched. But after a long discussion (see the link at the bottom of the
> letter) Mark and Andy persuaded me to integrate what we developed there
> into the DW APB SSI core driver to be useful for another controllers,
> which may have got the same peculiarities/problems as ours:
> - No IRQ.
> - No DMA.
> - No GPIO CS, so a native CS is utilized.
> - small Tx/Rx FIFO depth.
> - Automatic CS assertion/de-assertion.
> - Slow system bus.
> All of them have been fixed in the framework of this patchset in some
> extent at least for the SPI memory operations. As I expected it wasn't
> that easy and the integration took that many patches as you can see from
> the subject. Though some of them are mere cleanups or weakly related with
> the subject fixes, but we just couldn't leave the code as is at some
> places since we were working with the DW APB SSI driver anyway. Here is
> what we did to fix the original DW APB SSI driver, to make it less messy.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/21] spi: dw: Use an explicit set_cs assignment
        commit: f68fe8de360b9c441caf22f35557b4c9fd97dd84
[02/21] spi: dw: Add DWC SSI capability
        commit: d6bbd1193fe93b7ee037724553b3574dcb48e6da
[03/21] spi: dw: Detach SPI device specific CR0 config method
        commit: a3577bd8cba554f962b6af082eb43dde7fe7cd09
[04/21] spi: dw: Update SPI bus speed in a config function
        commit: f76f3142c5fc90f67794f6649cecec86a6eb87b0
[05/21] spi: dw: Simplify the SPI bus speed config procedure
        commit: c449ad7425aa2eb58f275ce977130918827b0d20
[06/21] spi: dw: Update Rx sample delay in the config function
        commit: 2613d2bfbeacea2bc796a54219ba05385ae7436a
[07/21] spi: dw: Add DW SPI controller config structure
        commit: 3ff60c6b644e2002e062ed97825ead19e31c2769
[08/21] spi: dw: Refactor data IO procedure
        commit: 8dedbeac8ab24d2da9271df2c8291971169846f2
[09/21] spi: dw: Refactor IRQ-based SPI transfer procedure
        commit: ddcc2733c1591c137f7ce60f24ba5401c295427f
[10/21] spi: dw: Perform IRQ setup in a dedicated function
        commit: 82d02944d238a6fdac729d135623b1d88ca8cbd6
[11/21] spi: dw: Unmask IRQs after enabling the chip
        commit: da8f58909e7e047a01e4577807e648482672eddd
[12/21] spi: dw: Discard chip enabling on DMA setup error
        commit: c6cb3815f70d39e377bec6b44d25f2d8b68b324e
[13/21] spi: dw: De-assert chip-select on reset
        commit: fbddc989a5c441099978aad320ada0d5327309f4
[14/21] spi: dw: Explicitly de-assert CS on SPI transfer completion
        commit: 49d7d695ca4bb2f62290c7039c4165556f0ca1e4
[15/21] spi: dw: Move num-of retries parameter to the header file
        commit: cf75baeac72c7cb57a8cf781e90cfd8ea77f2d51
[16/21] spi: dw: Add generic DW SSI status-check method
        commit: bf64b66036eef7d5a92fb1cb7398ef67a29fc64b
[17/21] spi: dw: Add memory operations support
        commit: 6423207e57ea53826eaae1a14c14fd6d22561b06
[18/21] spi: dw: Introduce max mem-ops SPI bus frequency setting
        commit: 84ecaf4a7837e8c0957a59d77fd7e8e4926968cb
[19/21] spi: dw: Add poll-based SPI transfers support
        commit: 14345c33461bc2373bc4f75f40baf4650e95ee54
[20/21] spi: dw: Add Baikal-T1 SPI Controller bindings
        commit: ca4e2ac20f938c372b83d1cb16ec00f7c89191df
[21/21] spi: dw: Add Baikal-T1 SPI Controller glue driver
        commit: abf00907538e21c469a10809dc2991982673fcbf

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
