Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6860F1E8387
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgE2QVl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 12:21:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49750 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgE2QVk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 12:21:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 078768030772;
        Fri, 29 May 2020 16:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t-5OvJZSG0eC; Fri, 29 May 2020 19:21:31 +0300 (MSK)
Date:   Fri, 29 May 2020 19:21:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lars Povlsen <lars.povlsen@microchip.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/10] spi: Adding support for Microchip Sparx5 SoC
Message-ID: <20200529162130.hsjcde27xhohl6jl@mobilestation>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Lars,

On Wed, May 13, 2020 at 04:00:21PM +0200, Lars Povlsen wrote:
> This is an add-on series to the main SoC Sparx5 series
> (Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).
> 
> The series add support for Sparx5 on top of the existing
> ocelot/jaguar2 spi driver.
> 
> It spins off the existing support for the MSCC platforms into a
> separate driver, as adding new platforms from the MSCC/Microchip
> product lines will further complicate (clutter) the original driver.
> 
> New YAML dt-bindings are provided for the resulting driver.
> 
> It is expected that the DT patches are to be taken directly by the arm-soc
> maintainers.

Regarding our cooperation. It can be implemented as follows. Since your patchset
is less cumbersome than mine and is more ready to be integrated into the generic DW
APB SSI code, it would be better to first make it through Mark', Andy' and my reviews
to be further merged into the kernel version of the driver. After that I'll have
my code altered so it could be applied on top of your patches. When everything
is done we'll have a more comprehensive DW APB SSI driver with poll-based
PIO operations support, new features like rx-delay, etc.

Thank you one more time for the series you've shared with us. Let's see what can
be done to improve it...

-Sergey

> 
> Lars Povlsen (10):
>   spi: dw: Add support for polled operation via no IRQ specified in DT
>   spi: dw: Add support for RX sample delay register
>   spi: dw: Add support for client driver memory operations
>   dt-bindings: spi: Add bindings for spi-dw-mchp
>   spi: spi-dw-mmio: Spin off MSCC platforms into spi-dw-mchp
>   dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
>   spi: spi-dw-mchp: Add Sparx5 support
>   arm64: dts: sparx5: Add SPI controller
>   arm64: dts: sparx5: Add spi-nor support
>   arm64: dts: sparx5: Add spi-nand devices
> 
>  .../bindings/spi/mscc,ocelot-spi.yaml         |  89 ++++
>  .../bindings/spi/snps,dw-apb-ssi.txt          |   7 +-
>  MAINTAINERS                                   |   2 +
>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |  37 ++
>  .../boot/dts/microchip/sparx5_pcb125.dts      |  16 +
>  .../boot/dts/microchip/sparx5_pcb134.dts      |  22 +
>  .../dts/microchip/sparx5_pcb134_board.dtsi    |   9 +
>  .../boot/dts/microchip/sparx5_pcb135.dts      |  23 +
>  .../dts/microchip/sparx5_pcb135_board.dtsi    |   9 +
>  arch/mips/configs/generic/board-ocelot.config |   2 +-
>  drivers/spi/Kconfig                           |   7 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-dw-mchp.c                     | 399 ++++++++++++++++++
>  drivers/spi/spi-dw-mmio.c                     |  93 ----
>  drivers/spi/spi-dw.c                          |  31 +-
>  drivers/spi/spi-dw.h                          |   4 +
>  16 files changed, 644 insertions(+), 107 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>  create mode 100644 drivers/spi/spi-dw-mchp.c
> 
> --
> 2.26.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
