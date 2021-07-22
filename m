Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889E23D2BE4
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGVRpv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGVRpv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jul 2021 13:45:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8403C061575;
        Thu, 22 Jul 2021 11:26:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a12so9907359lfb.7;
        Thu, 22 Jul 2021 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=++ilJkM9DmuNfERJEN/XEAayG4W80CgatuWGNaGVg5w=;
        b=ANs6Uu+PYD4Bd9nlafLIO67bSXuqJFGHi/Ga7Qv2FT2/v6don60TfAeQOb2aL/MvrA
         1rZRUk8E03Ad1KYTAizGc+9FVd3zRbkbqVApIf0qwKbWriQtuXVINP0aQKwtTl6bav72
         962WPXOPBtEVrzjodQ88c+81xVxQYzVR1uFx0j0jTBsJh1Kc/Po1W2zjM9V+lO0K+6hh
         7mpG2nOL3ybxfF9xrnlhTHfeKxixWWOAz0LQn16rAVrpPzP7p6fzq70pQ/6HkPRgRtUA
         y85/tuOzYz6zlgW8zcJ7+I5g/ZGEaH4uBr9DicKfPT/oW+12Xx/zsaijE7rBmFeRySsg
         woBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++ilJkM9DmuNfERJEN/XEAayG4W80CgatuWGNaGVg5w=;
        b=bkB+X2R4ziui7JCtOCJ/uyV1s22bPL4fM+6InyhcpWqO2O6c4f/zUaPLOEXc9RVnVd
         2snSDJYBLq/xf2wbS6y3U0fvoDo9tVy9jqE4uFjw7kaFTRmEgE68boAxD/6zDi6W7nrg
         sp8OxK2x7eYvjk/3nUZTo0SqA7NGcFzi6I4ZiK/UOamObM9LzvX31G0qRXCEHyo0/hj4
         sJzblACIgR0iWsccWVVuyYj2Q4Dy/OmrXg7a9YkTDXf9nJBoQ+UAoutLiza8Up7ttQr5
         hcYuHFgkuMu+1J85IZ1nxZioSkZfJehvZwgTeK59K0zreSq3P14qGDmrKP//JNd6+bvl
         wxBw==
X-Gm-Message-State: AOAM532uid5xH5OHTe2/9kjeCQQYyRvCZgnyzqLvdyd/RAnCDMQ1EEuT
        AW1vS59z4Ewrp7agG6R5Uw0=
X-Google-Smtp-Source: ABdhPJxklqZn3gmldenmoyrJBo0O5o1gTlEH7U3WESixsuKAjUQ8jFZCibITUk99zF6TBD3m54uZzg==
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr536144lfv.0.1626978383254;
        Thu, 22 Jul 2021 11:26:23 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id r200sm2035203lff.208.2021.07.22.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 11:26:22 -0700 (PDT)
Date:   Thu, 22 Jul 2021 21:26:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: =?utf-8?B?W+KAnFBBVENI?= =?utf-8?B?4oCd?= 2/2] spi: dw: Add
 support for Intel Thunder Bay SPI
Message-ID: <20210722182620.elakoxagvsjqnolj@mobilestation>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
 <20210722053358.29682-3-nandhini.srikandan@intel.com>
 <20210722170435.y6fla7ixfgzwkje2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722170435.y6fla7ixfgzwkje2@mobilestation>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

One more nitpick below.

On Thu, Jul 22, 2021 at 08:04:35PM +0300, Serge Semin wrote:
> On Thu, Jul 22, 2021 at 01:33:58PM +0800, nandhini.srikandan@intel.com wrote:
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > 
> > Add support for Intel Thunder Bay SPI controller, which uses DesignWare
> > DWC_ssi core.
> > Bit 31 of CTRLR0 register is added for Thunder Bay, to
> > configure the device as a master or as a slave serial peripheral.
> 
> > Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.
> 
> Could you elaborate what this bit mean?
> 
> > Added reset of SPI controller required for Thunder Bay.
> 
> If it's really required (is it?) then you were supposed to reflect
> that in the code by returning a negative error if the driver fails to
> retrieve the reset control handler. In accordance with that the
> bindings should have been also updated so the dtbs_check procedure
> would make sure the Thunder Bay SPI DT-node comply to the requirements
> in that matter.
> 
> Anyway I've got a few comments regarding this part of your patch.
> Please see them below.
> 
> > 
> > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > ---
> >  drivers/spi/spi-dw-core.c |  6 ++++++
> >  drivers/spi/spi-dw-mmio.c | 20 ++++++++++++++++++++
> >  drivers/spi/spi-dw.h      | 15 +++++++++++++++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index a305074c482e..eecf8dcd0677 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -302,6 +302,12 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
> >  
> >  		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> >  			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
> > +
> 
> > +		if (dws->caps & DW_SPI_CAP_THUNDERBAY_MST)
> > +			cr0 |= DWC_SSI_CTRLR0_THUNDERBAY_MST;
> 
> I guess that KeemBay and ThunderBay SPI controllers have been
> synthesized based on the same IP-core with a few differences. Is that
> true? Could you tell us what is the difference between them?
> 
> Anyway regarding this the Master/Slave part. Is the ThunderBay
> implementation of the Master/Slave capability the same as it was
> embedded in the KeemBay controller? If so then what do you think about
> just renaming DW_SPI_CAP_KEEMBAY_MST to something like
> DW_SPI_CAP_INTEL_MST and using it then for both Keembay and ThunderBay
> versions of the SPI-controllers? (The similar renaming needs to be
> provided for the DWC_SSI_CTRLR0_KEEMBAY_MST macro then.) You can
> implement it as a preparation patch posted before this one in the
> series.
> 
> > +
> > +		if (dws->caps & DW_SPI_CAP_THUNDERBAY_SSTE)
> > +			cr0 |= DWC_SSI_CTRLR0_THUNDERBAY_SSTE;
> 
> Similar question regarding the SSTE bit. Is it something ThunderBay
> specific only? Was the corresponding functionality embedded into the
> KeemBay or any other Intel version of the DW SPI controller?
> 
> >  	}
> >  
> >  	return cr0;
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 3379720cfcb8..ca9aad078752 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -222,6 +222,15 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
> >  	return 0;
> >  }
> >  
> > +static int dw_spi_thunderbay_init(struct platform_device *pdev,
> > +				  struct dw_spi_mmio *dwsmmio)
> > +{
> 
> > +	dwsmmio->dws.caps = DW_SPI_CAP_THUNDERBAY_MST | DW_SPI_CAP_THUNDERBAY_RST |
> > +			    DW_SPI_CAP_THUNDERBAY_SSTE | DW_SPI_CAP_DWC_SSI;
> > +
> 
> Originally the DW_SPI_CAP-functionality was provided to modify the DW
> SPI core driver behavior when it was required. For instance it was
> mostly connected with the platform-specific CR0-register
> configurations. So as I see it the reset part can be successfully
> handled fully in the framework of the MMIO-platform glue-driver.
> Instead of defining a new capability you could have just added the
> next code in the ThunderBay init-method:
> 
> +	if (!dwsmmio->rstc) {
> +		dev_err(&pdev->dev, "Reset control is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	reset_control_assert(dwsmmio->rstc);

> +	udelay(2);

Please, don't forget to add a header file with udelay() declaration to
this module.

-Sergey

> +	reset_control_deassert(dwsmmio->rstc);
> +
> 
> Thus you'd reuse the already implemented reset-controller handler
> defined in the dw_spi_mmio structure with no need of implementing
> a new capability.
> 
> > +	return 0;
> > +}
> > +
> >  static int dw_spi_canaan_k210_init(struct platform_device *pdev,
> >  				   struct dw_spi_mmio *dwsmmio)
> >  {
> > @@ -243,6 +252,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  			 struct dw_spi_mmio *dwsmmio);
> >  	struct dw_spi_mmio *dwsmmio;
> >  	struct resource *mem;
> > +	struct reset_control *rst;
> >  	struct dw_spi *dws;
> >  	int ret;
> >  	int num_cs;
> > @@ -309,6 +319,15 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  			goto out;
> >  	}
> >  
> 
> > +	if (dws->caps & DW_SPI_CAP_THUNDERBAY_RST) {
> > +		rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +		if (!IS_ERR(rst)) {
> > +			reset_control_assert(rst);
> > +			udelay(2);
> > +			reset_control_deassert(rst);
> > +		}
> > +	}
> > +
> 
> Please see my comment above. We don't need to have this code here if
> you get to implement what I suggest there.
> 
> >  	pm_runtime_enable(&pdev->dev);
> >  
> >  	ret = dw_spi_add_host(&pdev->dev, dws);
> > @@ -349,6 +368,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
> >  	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
> >  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
> >  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> > +	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_thunderbay_init},
> >  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> >  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> >  	{ /* end of table */}
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > index b665e040862c..bfe1d5edc25a 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -82,6 +82,18 @@
> >   */
> >  #define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
> >  
> 
> > +/*
> > + * For Thunder Bay, CTRLR0[14] should be set to 1.
> > + */
> 
> Could you provide a bit more details what this bit has been
> implemented for?
> 
> > +#define DWC_SSI_CTRLR0_THUNDERBAY_SSTE	BIT(14)
> > +
> 
> > +/*
> > + * For Thunder Bay, CTRLR0[31] is used to select controller mode.
> > + * 0: SSI is slave
> > + * 1: SSI is master
> > + */
> > +#define DWC_SSI_CTRLR0_THUNDERBAY_MST	BIT(31)
> 
> Please see my suggestion regarding the Master/Slave capability in one
> of the comments above.
> 
> Regards
> -Serge
> 
> > +
> >  /* Bit fields in CTRLR1 */
> >  #define SPI_NDF_MASK			GENMASK(15, 0)
> >  
> > @@ -125,6 +137,9 @@ enum dw_ssi_type {
> >  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> >  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> >  #define DW_SPI_CAP_DFS32		BIT(3)
> > +#define DW_SPI_CAP_THUNDERBAY_MST	BIT(4)
> > +#define DW_SPI_CAP_THUNDERBAY_RST	BIT(5)
> > +#define DW_SPI_CAP_THUNDERBAY_SSTE	BIT(6)
> >  
> >  /* Slave spi_transfer/spi_mem_op related */
> >  struct dw_spi_cfg {
> > -- 
> > 2.17.1
> > 
