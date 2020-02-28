Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C7173200
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 08:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB1Hq5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 28 Feb 2020 02:46:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1Hq5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 02:46:57 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CC48B29691E;
        Fri, 28 Feb 2020 07:46:54 +0000 (GMT)
Date:   Fri, 28 Feb 2020 08:46:51 +0100
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
Message-ID: <20200228084651.1ad0e334@collabora.com>
In-Reply-To: <f82e4964-f030-9aac-5895-a715921ed6db@linux.intel.com>
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200227183032.77ef0795@collabora.com>
        <f82e4964-f030-9aac-5895-a715921ed6db@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Feb 2020 12:11:09 +0800
"Ramuthevar, Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> Hi Boris,
> 
>       Thank you so much for the review comments...
> 
> On 28/2/2020 1:30 AM, Boris Brezillon wrote:
> > On Thu, 27 Feb 2020 14:27:08 +0800
> > "Ramuthevar, Vadivel MuruganX"
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> >  
> >> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>
> >> Add support for the Cadence QSPI controller. This controller is
> >> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> >> This driver has been tested on the Intel LGM SoCs.
> >>
> >> This driver does not support generic SPI and also the implementation
> >> only supports spi-mem interface to replace the existing driver in
> >> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> >> flash memory  
> > Is it really supporting SPI NORs only, or is it just that you only
> > tested it with a spi-nor?  
> 
> The existing drivers/mtd/spi-nor/cadence-quadspi.c supports SPI-NORs 
> only, because the driver is developed
> 
> such a way that it does not support other SPI based flash memories, also 
> never uses SPI/SPI-MEM based framework.
> 
> So we Vignesh suggested me to  develop the new driver which supports 
> both SPI-NOR and SPI-NAND based on the SPI-MEM framework.

Hm, your commit message makes it sound like even the new driver isn't
generic enough to support SPI NANDs. Maybe there's something to improve
to clarify the fact that this new version is not limited to SPI NORs.
