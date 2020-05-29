Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74611E848A
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgE2RSh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RSg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:18:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA442074D;
        Fri, 29 May 2020 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772716;
        bh=mjF6mC3mF3QNXp2WlNCL1zZZbC1Evj4Ace79zxEKflE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=NEz58XCgYR+BQkwlF0Yd0sn/+mQGZhAx5KtSHLjD2aCqLCAR9s9EZJY54qh8LFlUY
         Kb4mNjHFdf5uYakcB3aw82g4hl78FvjpHtz3tcl3nIPSbRJksZhDDdbMw1O5t0sGPs
         feK9PjK4ZpJC6F55lSVelSCXhORaCJjf7TNMR29s=
Date:   Fri, 29 May 2020 18:18:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mips@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
In-Reply-To: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-Id: <159077271266.17043.13820488074564153429.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 29 May 2020 16:11:49 +0300, Serge Semin wrote:
> Baikal-T1 SoC provides a DW DMA controller to perform low-speed peripherals
> Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> APB SSI devices embedded into the SoC. Currently the DMA-based transfers
> are supported by the DW APB SPI driver only as a middle layer code for
> Intel MID/Elkhart PCI devices. Seeing the same code can be used for normal
> platform DMAC device we introduced a set of patches to fix it within this
> series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/15] spi: dw: Set xfer effective_speed_hz
        commit: de4c2875a5ff2c886df60f2086c6affca83f890a
[02/15] spi: dw: Return any value retrieved from the dma_transfer callback
        commit: f0410bbf7d0fb80149e3b17d11d31f5b5197873e
[03/15] spi: dw: Locally wait for the DMA transfers completion
        commit: bdbdf0f06337d3661b64c0288c291cb06624065e
[04/15] spi: dw: Add SPI Tx-done wait method to DMA-based transfer
        commit: 1ade2d8a72f9240825f6be050f0d49c840f7daeb
[05/15] spi: dw: Add SPI Rx-done wait method to DMA-based transfer
        commit: 33726eff3d98e643f7d7a0940f4024844b430c82
[06/15] spi: dw: Parameterize the DMA Rx/Tx burst length
        commit: c534df9d6225314d1403e4330a22d68c35e0eb55
[07/15] spi: dw: Use DMA max burst to set the request thresholds
        commit: 0b2b66514fc9971b3a6002ba038d74f77705fd34
[08/15] spi: dw: Fix Rx-only DMA transfers
        commit: 46164fde6b7890e7a3982d54549947c8394c0192
[09/15] spi: dw: Add core suffix to the DW APB SSI core source file
        commit: 77ccff803d27279ccc100dc906c6f456c8fa515c
[10/15] spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
        commit: 6c710c0cb6725bdbe647b958756685aed0295936
[11/15] spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
        commit: 06cfadb8c51b05c6b91c2d43e0fe72b3d643dced
[12/15] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
        commit: ecb3a67edfd353837dc23b538fb250d1dfd88e7b
[13/15] spi: dw: Cleanup generic DW DMA code namings
        commit: 57784411728ff4d72ae051fdbba1e54fcb1f8d6f
[14/15] spi: dw: Add DMA support to the DW SPI MMIO driver
        commit: 0fdad596d46b28d5c3e39d1897c5e3878b64d9a2
[15/15] spi: dw: Use regset32 DebugFS method to create regdump file
        commit: 8378449d1f79add31be77e77fc7df9f639878e9c

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
