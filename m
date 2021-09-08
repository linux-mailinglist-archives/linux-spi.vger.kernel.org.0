Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF0F4036E5
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348774AbhIHJaF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 05:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348527AbhIHJ3x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 05:29:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B9C061575;
        Wed,  8 Sep 2021 02:28:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t19so3137359lfe.13;
        Wed, 08 Sep 2021 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n8eOf7/hVhoRuADP2UIJwuNpm4RI6xssDidC9ZyttAk=;
        b=IM9ARzd1e6pLYA8D59AlzvpewwFFC3An4UbiLYZjnLQhlE+7/9haBEnN/usOUG2UNR
         AU1R3GCEc1Xb/rj9mJCUU/jkyZ9ZnifnpnNJb0Gdbf4+/9Vc07B7ne9I83Q9CSz/qcF5
         /UtG/2soac3xziZ5Wn+9YuK7/KU4Z/R+t7TRxUCALsh8+Y7TKNVaq46sQT8xc7ggO7z7
         1qbgSWNzIS59GZG7/OmhBWizVpSuGyL8IY1VHEZQMj4Hq+KQpoQZ03lv9uIyrkqKK2U+
         1DuQ+zHdOnrtFPNezwvDxkd0wCI/UhqJPOWKAo87oOmx+5fMVXZdNWomdRABOLRrCJnr
         5I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n8eOf7/hVhoRuADP2UIJwuNpm4RI6xssDidC9ZyttAk=;
        b=ePOEwzhYYRWkm9aovSJ97Ip3vlQKSF0XvmS1bAqbLfbBgFp/u8lXs1Wm363/qGzqrq
         YVNrbElk9gwwtSW8iRuS5LchYCPcXc2o7RsVGVee0HeywU1M7XKpSOJibhDCqrD0VZI9
         JPu609HdU1qFslZTjipfGY40TtZUAwNjLXDwcLcnk97TeCe46rcZQFCDrfdN2wGWDNw9
         TeYaeBz1cXnPrZIuurdlcky5Y6RX8Ek8FTRiulDC8Fao1tsJV3v69DCgUfxpd5DEJJMq
         r2Vvgvnk9V4Fm2ZXA0+6E+JEDyN7ghZpE/qeXXT5PyZieLRhbK/BpIjzR54quuam4aUF
         vnEw==
X-Gm-Message-State: AOAM530jA0CggZHWNPx06LbyvjJik3Ii6PyQisI1dcqxjRsJ8PcZ7AjJ
        +uMPBaK5s2upqY5xGM739vgy90ON0OPaU/Qp
X-Google-Smtp-Source: ABdhPJykGVxDDItqY/fvJtGKVQUaL8Jq1cJT7bPPcd3d2jW7MLZduZuMoP/sFsFOdqzKUMkAMIRl2A==
X-Received: by 2002:a05:6512:114f:: with SMTP id m15mr1918092lfg.230.1631093324491;
        Wed, 08 Sep 2021 02:28:44 -0700 (PDT)
Received: from mobilestation (79-126-46-220.dynamic.mts-nn.ru. [79.126.46.220])
        by smtp.gmail.com with ESMTPSA id u14sm139370lfm.241.2021.09.08.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:28:43 -0700 (PDT)
Date:   Wed, 8 Sep 2021 12:28:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: Re: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Message-ID: <20210908092839.4n4wgx4nf7m2wji2@mobilestation>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
 <20210824085856.12714-3-nandhini.srikandan@intel.com>
 <20210905143356.z2xomprpgsknz3fb@mobilestation>
 <BN0PR11MB572717A9D159F96E276712B385D39@BN0PR11MB5727.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0PR11MB572717A9D159F96E276712B385D39@BN0PR11MB5727.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 07, 2021 at 10:54:10AM +0000, Srikandan, Nandhini wrote:
> 
> 
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Sunday, September 5, 2021 8:04 PM
> > To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; broonie@kernel.org;
> > robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> > Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > Subject: Re: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
> > 
> > Hi Nandhini
> > 
> > On Tue, Aug 24, 2021 at 04:58:56PM +0800, nandhini.srikandan@intel.com
> > wrote:
> > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > >
> > > Add support for Intel Thunder Bay SPI controller, which uses
> > > DesignWare DWC_ssi core.
> > > Bit 31 of CTRLR0 register is set for Thunder Bay, to configure the
> > > device as a master or as a slave serial peripheral.
> > > Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.
> > 
> > After reading your response to my v1 comments, I've got a better notion of
> > the features you are trying to implement here. Please see my comments
> > below.
> > 
> > >
> > > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > ---
> > 
> > Just to note for your future patchwork. Instead of having a single general
> > changelog text in the cover letter it is much more convenient for reviewers to
> > see both the summary changelog and a changelog of individual patches here
> > under '---' delimiter.
> Sure, I will add changelog for individual patches also.
> 
> > 
> > >  drivers/spi/spi-dw-core.c |  7 +++++--  drivers/spi/spi-dw-mmio.c |
> > > 20 +++++++++++++++++++-
> > >  drivers/spi/spi-dw.h      | 12 +++++++++---
> > >  3 files changed, 33 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > index a305074c482e..f7d45318db8a 100644
> > > --- a/drivers/spi/spi-dw-core.c
> > > +++ b/drivers/spi/spi-dw-core.c
> > > @@ -300,8 +300,11 @@ static u32 dw_spi_prepare_cr0(struct dw_spi
> > *dws, struct spi_device *spi)
> > >  		/* CTRLR0[13] Shift Register Loop */
> > >  		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) <<
> > > DWC_SSI_CTRLR0_SRL_OFFSET;
> > >
> > > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > > -			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
> > 
> > > +		if (dws->caps & DW_SPI_CAP_DWC_MST)
> > > +			cr0 |= DWC_SSI_CTRLR0_MST;
> > 
> > Since you've used a generic suffix here, are you sure the MST/SLV feature
> > toggled by the BIT(31) bit is generic for all DWC SSI controllers?
> > I am asking because I don't have DWC SSI IP manual, but there is a
> > CTRL0 register layout posted by your colleague Wan Ahmad Zainie a year
> > ago: https://patches.linaro.org/patch/214693/ . It doesn't have that bit
> > defined.
> > 
> > If you are and it's specific to all DWC SSI controllers of v1.01a and newer,
> > then why not to implement that flag setting up in the framework of the
> > "DW_SPI_CAP_DWC_SSI" capability? Thus we'd have all "snps,dwc-ssi-
> > 1.01a"-compatible devices and devices with the DW_SPI_CAP_DWC_SSI flag
> > set working well if for some reason they have got slave-mode enabled by
> > default.
> 

> Intel Keem Bay and Thunder Bay uses v1.02a version of DWC SSI controller. According to v1.02a, BIT31 of CTRLR0 is used for selecting Master or slave mode. In earlier versions, it was reserved. Both Keem Bay and Thunder Bay has to work in master mode, so this bit is set. The dwc_ssi controller can either function in master or slave (default) mode as per the spec. The bit31 requirement is only for Keem Bay and Thunder bay and other controllers can have a requirement to function in slave mode as well. Hence the bit is set only for Keem Bay/Thunder Bay. Please let me know if it should be set default to master mode.
> Wan Ahmed Zainie has posted that patch based on earlier version of the controller and later up streamed the DW_SPI_CAP_KEEMBAY_MST capability flag. This will become generic now.

I see. Thanks for clarification. IIUC BIT(31) is indeed specific to
all DWC SSI (not only Keem/Thunder Bay SPI IPs) and indeed determines
the Master/Slave mode of the controller. Then I don't really
understand why Wan Ahmed didn't make it set generically in CR0 for all
DWC SSI v1.01a instead of marking it as "intel,keembay-ssi"-specific
seeing he provided a generic "snps,dwc-ssi-1.01a" compatible code in
that same patchset.

That decision might have been caused by having different default
states of CTRLR0.31 bit in generic DWC SSI and Keem/Thunder Bay SSI...
Anyway I believe it won't hurt to set that bit for each DWC SSI
especially seeing the DW APB SSI driver doesn't support the SPI slave
mode at the moment. So please do that in a dedicated patch by converting
the DWC_SSI_CTRLR0_KEEMBAY_MST macro to a generic DWC_SSI_CTRLR0_MST and
applying it for CTRLR0.31 for each DW_SPI_CAP_DWC_SSI controller.

> > 
> > > +
> > > +		if (dws->caps & DW_SPI_CAP_DWC_SSTE)
> > > +			cr0 |= DWC_SSI_CTRLR0_SSTE;
> > 
> > Regarding SSTE flag and feature implemented behind it. First of all AFAICS
> > from the Wan Ahmad Zainie post sited above it is indeed generic for both
> > DWC SSI and DW APB SSI IP-cores of the controllers. Thus we don't need an
> > additional DWC SSI capability flag defined for it, but need to have it
> > generically implemented in the DW SPI core driver.
> > Secondly as you said it two weeks ago it defines a slave-specific protocol, the
> > way the SSI and CLK signals are driven between consecutive
> > frames:
> > >> SSTE (Slave Select Toggle Enable)
> > >> When SSTE bit is set to 1, the slave select line will toggle between
> > >> consecutive data frames, with the serial clock being held to its
> > >> default  value while slave select line is high.
> > >> When SSTE bit is set to 0, slave select line will stay low and clock
> > >> will  run continuously for the duration of the transfer.
> > In general DWC SSI/DW APB SSI controller can be connected to slave devices
> > with SSTE and normal communication protocol requirements at the same
> > time by using different CS-lanes. Therefore the SSTE feature turns to be
> > Slave/Peripheral-device specific rather than controller-specific and needs to
> > be enabled/disabled when it's required by a slave device.
> > 
> > Thus here is what I'd suggest to implement the SSTE feature generically:
> > 1) Add a new SPI-slave Synopsys-specific DT-property into the bindings file
> > like this:
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -143,6 +143,12 @@ patternProperties:
> >            is an optional feature of the designware controller, and the
> >            upper limit is also subject to controller configuration.
> > 
> > +      snps,sste:
> > +        description: Slave select line will toggle between consecutive
> > +          data frames, with the serial clock being held to its default
> > +          value while slave select line is high.
> > +        type: boolean
> > +
> >  unevaluatedProperties: false
> > 
> >  required:
> > 
> > Please do that in a separate preparation patch submitted before the
> > "dt-bindings: spi: Add bindings for Intel Thunder Bay SoC" patch in this
> > series.
> Sure, will modify SSTE as DT-property and do the necessary changes in both code and in DT.
> > 
> > 2) Add that property support into the driver like this:
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c index
> > a305074c482e..5caa74b9aa74 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -27,6 +27,7 @@
> >  struct chip_data {
> >  	u32 cr0;
> >  	u32 rx_sample_dly;	/* RX sample delay */
> > +	bool sste;		/* Slave Select Toggle flag */
> >  };
> > 
> >  #ifdef CONFIG_DEBUG_FS
> > @@ -269,6 +270,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
> > 
> >  static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)  {
> > +	struct chip_data *chip = spi_get_ctldata(spi);
> >  	u32 cr0 = 0;
> > 
> >  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) { @@ -285,6 +287,9 @@
> > static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
> > 
> >  		/* CTRLR0[11] Shift Register Loop */
> >  		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
> > +
> > +		/* CTRLR0[24] Slave Select Toggle Enable */
> > +		cr0 |= chip->sste << SPI_SSTE_OFFSET;
> >  	} else {
> >  		/* CTRLR0[ 7: 6] Frame Format */
> >  		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET; @@
> > -300,6 +305,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct
> > spi_device *spi)
> >  		/* CTRLR0[13] Shift Register Loop */
> >  		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) <<
> > DWC_SSI_CTRLR0_SRL_OFFSET;
> > 
> > +		/* CTRLR0[14] Slave Select Toggle Enable */
> > +		cr0 |= chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
> > +
> >  		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> >  			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
> >  	}
> > @@ -789,6 +797,9 @@ static int dw_spi_setup(struct spi_device *spi)
> >  		chip->rx_sample_dly =
> > DIV_ROUND_CLOSEST(rx_sample_dly_ns,
> >  							NSEC_PER_SEC /
> >  							dws->max_freq);
> > +
> > +		/* Get slave select toggling feature requirement */
> > +		chip->sste = device_property_read_bool(&spi->dev,
> > "snps,sste");
> >  	}
> > 
> >  	/*
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > b665e040862c..2ee3f839de39 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -65,8 +65,10 @@
> >  #define SPI_SLVOE_OFFSET		10
> >  #define SPI_SRL_OFFSET			11
> >  #define SPI_CFS_OFFSET			12
> > +#define SPI_SSTE_OFFSET			24
> > 
> >  /* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
> > +#define DWC_SSI_CTRLR0_SSTE_OFFSET	14
> >  #define DWC_SSI_CTRLR0_SRL_OFFSET	13
> >  #define DWC_SSI_CTRLR0_TMOD_OFFSET	10
> >  #define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
> > 
> > Please also do that in a separate preparation patch.
> > 
> > 3) If MST BIT(31) feature is generic, then please discard the
> > DW_SPI_CAP_KEEMBAY_MST capability flag and set the MST bit for each
> > DWC SSI device with DW_SPI_CAP_DWC_SSI capability set. If it's Intel-
> > specific, then convert the DW_SPI_CAP_KEEMBAY_MST capability macro
> > name to DW_SPI_CAP_INTEL_MST.
> > 
> > Please also do that in a separate preparation patch.

> The feature is for the controller version v1.02a and above. The controller can function on master or slave mode, default being slave mode. So, it is modified to master only in Keem bay and Thunder bay. 
> The difference between v1.01a and v1.02a w.r.t CTRLR0 is BIT31 selection of master/slave mode. Though the feature is generic but BIT31 is needed to be set only for bay, I will rename the macros to a generic name. 

Please, see my comment above. Let's set that bit for each DWC SSI
controller, so to have the driver protected from having the inverted
default state on any other vendor-specific controller.

> 
> > 
> > 4) After all of that you can add the "Thunder Bay SPI" controller support into
> > the DW SPI MMIO driver by placing the "intel,thunderbay-ssi" compatibility
> > string into the OF-device table.
> > Since both Thunder and Keembay SPIs are based on the same IP-core then
> > you can just reuse the dw_spi_keembay_init() for both of them after
> > renaming it to something like dw_spi_intel_init().
> > 

> Sure, will do the same.

Thanks.

Regards,
-Sergey

> 
> Regards,
> Nandhini
> > 
> > >  	}
> > >
> > >  	return cr0;
> > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > index 3379720cfcb8..2bd1dedd90b0 100644
> > > --- a/drivers/spi/spi-dw-mmio.c
> > > +++ b/drivers/spi/spi-dw-mmio.c
> > > @@ -217,7 +217,24 @@ static int dw_spi_dwc_ssi_init(struct
> > > platform_device *pdev,  static int dw_spi_keembay_init(struct
> > platform_device *pdev,
> > >  			       struct dw_spi_mmio *dwsmmio)  {
> > > -	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST |
> > DW_SPI_CAP_DWC_SSI;
> > > +	/*
> > > +	 * Set MST to make keem bay SPI as master.
> > > +	 */
> > > +	dwsmmio->dws.caps = DW_SPI_CAP_DWC_MST |
> > DW_SPI_CAP_DWC_SSI;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int dw_spi_thunderbay_init(struct platform_device *pdev,
> > > +				  struct dw_spi_mmio *dwsmmio)
> > > +{
> > > +	/*
> > > +	 * Set MST to make thunder bay SPI as master.
> > > +	 * Set SSTE to enable slave select toggle bit which is required
> > > +	 * for the slave devices connected to the thunder bay SPI controller.
> > > +	 */
> > > +	dwsmmio->dws.caps = DW_SPI_CAP_DWC_MST |
> > DW_SPI_CAP_DWC_SSTE |
> > > +			    DW_SPI_CAP_DWC_SSI;
> > >
> > >  	return 0;
> > >  }
> > > @@ -349,6 +366,7 @@ static const struct of_device_id
> > dw_spi_mmio_of_match[] = {
> > >  	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
> > >  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
> > >  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> > > +	{ .compatible = "intel,thunderbay-ssi", .data =
> > > +dw_spi_thunderbay_init},
> > >  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> > >  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> > >  	{ /* end of table */}
> > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > > b665e040862c..9fffe0a02f3a 100644
> > > --- a/drivers/spi/spi-dw.h
> > > +++ b/drivers/spi/spi-dw.h
> > > @@ -76,11 +76,16 @@
> > >  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
> > >
> > >  /*
> > > - * For Keem Bay, CTRLR0[31] is used to select controller mode.
> > > + * CTRLR0[31] is used to select controller mode.
> > >   * 0: SSI is slave
> > >   * 1: SSI is master
> > >   */
> > > -#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
> > > +#define DWC_SSI_CTRLR0_MST		BIT(31)
> > > +
> > > +/*
> > > + * CTRLR0[14] is used to enable/disable Slave Select Toggle bit  */
> > > +#define DWC_SSI_CTRLR0_SSTE		BIT(14)
> > >
> > >  /* Bit fields in CTRLR1 */
> > >  #define SPI_NDF_MASK			GENMASK(15, 0)
> > > @@ -122,9 +127,10 @@ enum dw_ssi_type {
> > >
> > >  /* DW SPI capabilities */
> > >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> > > -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > > +#define DW_SPI_CAP_DWC_MST		BIT(1)
> > >  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> > >  #define DW_SPI_CAP_DFS32		BIT(3)
> > > +#define DW_SPI_CAP_DWC_SSTE		BIT(4)
> > >
> > >  /* Slave spi_transfer/spi_mem_op related */  struct dw_spi_cfg {
> > > --
> > > 2.17.1
> > >
