Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01C3389B7
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhCLKLT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 05:11:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45762 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhCLKK7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 05:10:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12CAAeIR047426;
        Fri, 12 Mar 2021 04:10:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615543840;
        bh=w9BhnOsEXmDnJr92k5Gv+KiRM15+qBMHanC1ChiW5y8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Q1y4mXRmZoDuNdAxSGTuidk/rBcl5zVhXbMMSrben/24a6sldTbhEvz/T84eVCUD9
         Zb/9ylbktvKAocZiKm3aYcervRw2AWWppoMaADkwV+bKFYfb8Db/ZbJ+5WtAgtDIX1
         nSwMa/4tHCDvMbE9QUm9Fh1ITR7/Ey7tThYBVmNU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12CAAeDF039353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Mar 2021 04:10:40 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 12
 Mar 2021 04:10:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 12 Mar 2021 04:10:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12CAAdIv038442;
        Fri, 12 Mar 2021 04:10:39 -0600
Date:   Fri, 12 Mar 2021 15:40:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Message-ID: <20210312101036.jfz2733ssv4nhfey@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <9c551f56-4c00-b41a-f051-8b7e197fbcdc@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c551f56-4c00-b41a-f051-8b7e197fbcdc@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/03/21 09:09AM, Tudor.Ambarus@microchip.com wrote:
> On 3/11/21 9:12 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi,
> > 
> > This series adds support for OSPI PHY calibration on the Cadence OSPI
> > controller. This calibration procedure is needed to allow high clock
> > speeds in 8D-8D-8D mode. The procedure reads some pre-determined pattern
> > data from the flash and runs a sequence of test reads to find out the
> > optimal delays for high speed transfer. More details on the calibration
> > procedure in patch 5/6.
> 
> Can the calibration sequence be avoided if the controller is informed
> about the frequency on which the flash operates?

Maybe I don't understand this correctly, but there should not be any 
frequency on which the flash operates. The controller drives the SPI 
clock so the frequency is decided by the controller. Sure, there is a 
max supported frequency for the flash but the controller can run it 
slower than that if it wishes. The flash has no say in that.

Anyway, the exact frequency at which the flash is running is not it is 
looking for. More details below.

> 
> Can you add more details about the optimal delays? Are we talking about
> flash's AC characteristics? Is the calibration still needed if the upper
> layer informs the QSPI controller about the needed delays?

There is usually a delay from when the flash drives the data line (IOW, 
puts a data bit on it) and when the signal reaches the controller. This 
delay can vary by the flash, board, silicon characteristics, 
temperature, etc.

At lower speeds (25 MHz for example) this delay is not a problem because 
the clock period is longer so there is much more time to sample the data 
line. It is very likely the controller will sample at a time when the 
data line is valid. At high speeds (166 MHz for example), especially in 
DDR mode, this delay starts to play a larger role because the time to 
sample the data line is much smaller. Now unless the delay is accounted 
for, it is possible that the controller samples the data line too late 
or too early and sees invalid data.

These delays depend on physical characteristics so it is not possible 
for any upper layer to inform the controller about it. How will they 
even know what the required delay is?

In summary, no, there is no way an upper layer can inform the controller 
about this delay.

> 
> Cheers,
> ta
> 
> > 
> > The main problem here is telling the controller where to find the
> > pattern and how to read it. This RFC uses nvmem cells which point to a
> > fixed partition containing the data to do the reads. It depends on [0]
> > and [1].
> > 
> > The obvious problem with this is it won't work when the partitions are
> > defined via command line. I don't see any good way to add nvmem cells to
> > command line partitions. I would like some help or ideas here. We don't
> > necessarily have to use nvmem either. Any way that can cleanly and
> > consistently let the controller find out where the pattern is stored is
> > good.
> > 
> > The dts patch depends on [2].
> > 
> > Tested on TI's J721E EVM.
> > 
> > [0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210302190012.1255-1-zajec5@gmail.com/
> > [1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210308011853.19360-1-ansuelsmth@gmail.com/
> > [2] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210305153926.3479-2-p.yadav@ti.com/
> > 
> > Pratyush Yadav (6):
> >   spi: spi-mem: Tell controller when device is ready for calibration
> >   mtd: spi-nor: core: consolidate read op creation
> >   mtd: spi-nor: core: run calibration when initialization is done
> >   spi: cadence-qspi: Use PHY for DAC reads if possible
> >   spi: cadence-qspi: Tune PHY to allow running at higher frequencies
> >   arm64: dts: ti: k3-j721e-som-p0: Enable PHY calibration
> > 
> >  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi |  55 ++
> >  drivers/mtd/spi-nor/core.c                  |  74 +-
> >  drivers/spi/spi-cadence-quadspi.c           | 820 +++++++++++++++++++-
> >  drivers/spi/spi-mem.c                       |  12 +
> >  include/linux/spi/spi-mem.h                 |   8 +
> >  5 files changed, 916 insertions(+), 53 deletions(-)
> > 
> > --
> > 2.30.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
