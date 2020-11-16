Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228652B519E
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 20:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgKPTwx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 14:52:53 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:38506 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKPTwx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 14:52:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id F06748030865;
        Mon, 16 Nov 2020 19:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 353CsliEh_ra; Mon, 16 Nov 2020 22:52:43 +0300 (MSK)
Date:   Mon, 16 Nov 2020 22:52:41 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: fix build error by selecting MULTIPLEXER
Message-ID: <20201116195241.sbec7ecianaks2p7@mobilestation>
References: <20201116040721.8001-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201116040721.8001-1-rdunlap@infradead.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Randy

On Sun, Nov 15, 2020 at 08:07:21PM -0800, Randy Dunlap wrote:
> Fix build error for spi-dw-bt1.o by selecting MULTIPLEXER.
> 
> hppa-linux-ld: drivers/spi/spi-dw-bt1.o: in function `dw_spi_bt1_sys_init':
> (.text+0x1ac): undefined reference to `devm_mux_control_get'

Thank you very much.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> ---
>  drivers/spi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20201113.orig/drivers/spi/Kconfig
> +++ linux-next-20201113/drivers/spi/Kconfig
> @@ -255,6 +255,7 @@ config SPI_DW_MMIO
>  config SPI_DW_BT1
>  	tristate "Baikal-T1 SPI driver for DW SPI core"
>  	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> +	select MULTIPLEXER
>  	help
>  	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
>  	  controllers. Two of them are pretty much normal: with IRQ, DMA,
