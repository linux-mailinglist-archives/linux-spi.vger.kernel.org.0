Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569741F895
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 02:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJBASZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 20:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhJBASY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 689D4610EA;
        Sat,  2 Oct 2021 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133800;
        bh=pr6ueWr5ng9Kvy0A//jRGHw2liBk7j4t5NnblF6sngM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYz0qtYJxJA/pyP1cycAOTy3iXM2TulNT+RjQWpeg/cTxxGoP/E65IX69G8cBa3yV
         KtYUdJ9w0U9xehRlPwKc3Uhc82o3xVuCA9/sdY8NWddHePmTqCZ/dsdEqDtB2lgpbd
         512iEEbrkyjdQ7T7HqmHQr42pW6qFuTKlvEvB0TnqVkq3KHnNjdoC1yFdoVEVWL5t7
         jy8Fg14Aq/RljaI7fUH0aqThahRUNK4flr2n37ZtYEeXPYNNncEbsnOX6gUCyEKN0e
         GHPtOu8ao8tF1KRi3Abx076Ch2b2v/SptpSJlLyRxv9ENohaZEXM6r6o3iyV20cGuJ
         51DvvUOgvowfQ==
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, git@xilinx.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        saikrishna12468@gmail.com, linux-spi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] spi: cadence-quadspi: Add Xilinx Versal OSPI support
Date:   Sat,  2 Oct 2021 01:16:23 +0100
Message-Id: <163313375302.13893.17701279153875577835.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Sep 2021 15:37:07 +0530, Sai Krishna Potthuri wrote:
> Add Octal SPI(OSPI) controller support for Xilinx Versal SoC.
> Update the binding to add Xilinx Versal compatible string, also add
> 'power-domains' property and made as required for Xilinx Versal SoCs.
> Add API in xilinx firmware for configuring OSPI Mux, which is
> required to change the interface to OSPI. Xilinx Versal SoC
> has external DMA support, so by using the OSPI MUX selection, interface
> to the OSPI will be selected (either DMA interface or AXI slave interface).
> Xilinx Versal OSPI external DMA:
> Xilinx Versal OSPI DMA module is integrated to the Cadence OSPI Controller
> with the DMA write channel. Cadence OSPI Controller which reads the data
> from the Flash and stores in its internal SRAM and Xilinx Versal OSPI DMA
> which reads the data from the SRAM in the Cadence OSPI Controller using
> the DMA SRC channel and then the DMA DST channel initiates a write DMA
> transfer into the destined address location.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] firmware: xilinx: Add OSPI Mux selection support
      commit: 74e78adc6ccf6c3b53939788cf0c49f54db70731
[2/4] dt-bindings: spi: cadence-quadspi: Add support for Xilinx Versal OSPI
      commit: 8db76cfae1004f5476d9c35670f0a0f084c6b73f
[3/4] spi: cadence-quadspi: Add OSPI support for Xilinx Versal SoC
      commit: 09e393e3f13970f194f7ed9a93140a8601225b46
[4/4] spi: cadence-quadspi: Add Xilinx Versal external DMA support
      commit: 1a6f854f7daab100ff0a94d31f35a387b462b4d1

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
