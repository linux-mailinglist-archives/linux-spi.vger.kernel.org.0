Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1D172517
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 18:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgB0Rai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 12:30:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgB0Rai (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 12:30:38 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 09A3E296482;
        Thu, 27 Feb 2020 17:30:36 +0000 (GMT)
Date:   Thu, 27 Feb 2020 18:30:32 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        tien.fong.chee@intel.com, tudor.ambarus@gmail.com,
        boris.brezillon@free-electrons.com, richard@nod.at,
        qi-ming.wu@intel.com, simon.k.r.goldschmidt@gmail.com,
        david.oberhollenzer@sigma-star.at, dinguyen@kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        cheol.yong.kim@intel.com, mark.rutland@arm.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        cyrille.pitchen@atmel.com
Subject: Re: [PATCH v11 2/2] spi: cadence-quadspi: Add support for the
 Cadence QSPI controller
Message-ID: <20200227183032.77ef0795@collabora.com>
In-Reply-To: <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 Feb 2020 14:27:08 +0800
"Ramuthevar, Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
> 
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.

Is it really supporting SPI NORs only, or is it just that you only
tested it with a spi-nor?

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reported-by? What has been reported?

> ---
>  drivers/mtd/spi-nor/Kconfig                        |  11 -
>  drivers/mtd/spi-nor/Makefile                       |   1 -
>  drivers/spi/Kconfig                                |  10 +
>  drivers/spi/Makefile                               |   1 +
>  .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------

Looks like this could be split in several patches to ease the review:

1/ convert to spi-mem
2/ move the driver to drivers/spi
3/ add support for intel,lgm-qspi

other than that, that's good to see one more spi-nor controller driver
converted to spi-mem.

