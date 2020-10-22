Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E46295B32
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509203AbgJVJCP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Oct 2020 05:02:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509157AbgJVJCO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Oct 2020 05:02:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09M91o5v015922;
        Thu, 22 Oct 2020 04:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603357310;
        bh=AiaxKpP/xKYU6KOewMI8V4ZT/uzcjjBXfNkCfmsjUXc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=P2AiN0o4L3iGLwFgMZyGuEcx9Y+GEW/EaCNAToMH6Ng3h21tMOPZbajsimcIsV3Sx
         949PR0OvCJU4OItd42P5phNDXzbSoBesAK6u+gcA57NCy7G8lGXbkpcx3g0hxr3aVu
         WAebJSvbinlM8vPRJqOIqyI6Xo1HJFcRKMpWb0Ig=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09M91oWp046196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 04:01:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 22
 Oct 2020 04:01:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 22 Oct 2020 04:01:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09M91nLT058645;
        Thu, 22 Oct 2020 04:01:50 -0500
Date:   Thu, 22 Oct 2020 14:31:48 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     <vigneshr@ti.com>, <tudor.ambarus@microchip.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <simon.k.r.goldschmidt@gmail.com>, <dinguyen@kernel.org>,
        <richard@nod.at>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
Subject: Re: [PATCH v2 2/6] spi: cadence-quadspi: Disable the DAC for Intel
 LGM SoC
Message-ID: <20201022090146.2uj5gfx73dsfumjl@ti.com>
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021140015.3ldwk4az5nlzhnvr@ti.com>
 <a36fbe94-0cf2-eb42-3000-be4c055802b6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a36fbe94-0cf2-eb42-3000-be4c055802b6@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/10/20 10:17AM, Ramuthevar, Vadivel MuruganX wrote:
> Hi Pratyush,
> 
> On 21/10/2020 11:17 pm, Pratyush Yadav wrote:
> > Hi,
> > 
> > On 21/10/20 10:55AM, Ramuthevar,Vadivel MuruganX wrote:
> > > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > > 
> > > On Intel Lightning Mountain(LGM) SoCs QSPI controller do not use
> > > Direct Access Controller(DAC).
> > > 
> > > This patch adds a quirk to disable the Direct Access Controller
> > > for data transfer instead it uses indirect data transfer.
> > > 
> > > Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > > ---
> > >   drivers/spi/spi-cadence-quadspi.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > > index d7b10c46fa70..3d017b484114 100644
> > > --- a/drivers/spi/spi-cadence-quadspi.c
> > > +++ b/drivers/spi/spi-cadence-quadspi.c
> > > @@ -1106,6 +1106,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
> > >   	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> > >   	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> > > +	/* Disable direct access controller */
> > > +	if (!cqspi->use_direct_mode) {
> > > +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> > > +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> > > +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> > > +	}
> > > +
> > 
> > Do you really need to disable the DAC controller? cqspi_read() and
> > cqspi_write() already check for cqspi->use_direct_mode and avoid using
> > direct mode if it is false. While I don't think it would do any harm I'm
> > curious what prompted you to do this instead of just setting the quirk
> > like cdns_qspi does.
> > 
> > Anyway, if you do insist on doing it, it does not make any sense to set
> > a bit and then unset it immediately after. The datasheet I have says
> > this bit resets to 1 so the block above the code you added should be
> > removed.
> Thank you for your review comments..
> yes, we need this patch to disable DAC for our SoC to avoid any conflicts in
> future as well since Intel LGM SoC doesn't support DAC at all.

I'm not sure you got my point here. I understand that LGM SoCs don't 
support DAC. I'm not arguing if this _patch_ is needed. I'm arguing if 
this _hunk_ is needed. Does DAC mode need to be explicitly disabled 
here? Why will the check in cqspi_read() and cqspi_write() not be 
enough?

My other point is that if you absolutely need to disable DAC mode, then 
instead of the code you have added, it would make more sense to do 
something like below in cqspi_controller_init(). Because the bit resets 
to 1 so the block of code to enable it is useless [0].

--- 8< ---
diff --git a/drivers/spi/spi-cadence-quadspi.c 
b/drivers/spi/spi-cadence-quadspi.c
index d7ad8b198a11..d2c5d448a944 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2156,10 +2156,12 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
 	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 
-	/* Enable Direct Access Controller */
-	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
-	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
-	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	/* Disable Direct Access Controller */
+	if (!cqspi->use_dac_mode) {
+		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	}
 
 	cqspi_controller_enable(cqspi, 1);
 }
--- >8 ---

Disclaimer: not tested at all.

[0] Git blames Vignesh for that block of code added in a27f2eaf2b27. 
Vignesh, was this simply an oversight or was there any real reason to 
set the bit?
 
> Regards
> Vadivel
> > 
> > >   	cqspi_controller_enable(cqspi, 1);
> > >   }
> > > @@ -1388,6 +1395,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
> > >   	.quirks = CQSPI_NEEDS_WR_DELAY,
> > >   };
> > > +static const struct cqspi_driver_platdata intel_lgm_qspi = {
> > > +	.quirks = CQSPI_DISABLE_DAC_MODE,
> > > +};
> > > +
> > >   static const struct of_device_id cqspi_dt_ids[] = {
> > >   	{
> > >   		.compatible = "cdns,qspi-nor",
> > > @@ -1403,6 +1414,7 @@ static const struct of_device_id cqspi_dt_ids[] = {
> > >   	},
> > >   	{
> > >   		.compatible = "intel,lgm-qspi",
> > > +		.data = &intel_lgm_qspi,
> > >   	},
> > >   	{ /* end of table */ }
> > >   };
> > 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
