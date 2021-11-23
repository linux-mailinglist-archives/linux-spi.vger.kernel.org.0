Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E545A6B8
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhKWPqe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 10:46:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:19263 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhKWPqd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 10:46:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215071473"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215071473"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:43:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509055823"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:43:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpXx2-009oii-HF;
        Tue, 23 Nov 2021 17:43:20 +0200
Date:   Tue, 23 Nov 2021 17:43:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] spi: deduplicate spi_match_id() in
 __spi_register_driver()
Message-ID: <YZ0MGP0HDjLN/HfD@smile.fi.intel.com>
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
 <1572a2ff-dcfb-422f-c4c3-5a454a36d31d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572a2ff-dcfb-422f-c4c3-5a454a36d31d@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 23, 2021 at 03:22:38PM +0000, Jon Hunter wrote:
> On 19/11/2021 17:37, Andy Shevchenko wrote:

> > @@ -474,12 +473,8 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
> >   			if (sdrv->id_table) {
> >   				const struct spi_device_id *spi_id;
> > -				for (spi_id = sdrv->id_table; spi_id->name[0];
> > -				     spi_id++)
> > -					if (strcmp(spi_id->name, of_name) == 0)
> > -						break;

> > -				if (spi_id->name[0])
> > +				spi_id = spi_match_id(sdrv->id_table, of_name);
> > +				if (!spi_id)

Seems I have inverted condition here. Shouldn't it be

				if (spi_id)

instead?

> >   					continue;
> >   			} else {
> >   				if (strcmp(sdrv->driver.name, of_name) == 0)
> > 
> 
> 
> Following this change I am seeing the following warnings again although most
> of these have now been fixed ...
> 
>  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45
>  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for
> atmel,dataflash
>  WARNING KERN SPI driver spi-nor has no spi_device_id for jedec,spi-nor
>  WARNING KERN SPI driver mmc_spi has no spi_device_id for mmc-spi-slot
>  WARNING KERN SPI driver cros-ec-spi has no spi_device_id for
> google,cros-ec-spi
> 
> I have not looked any further yet, but this appears to cause the SPI ID
> match to fail.

Ah, thanks for testing!
Can you try above?

-- 
With Best Regards,
Andy Shevchenko


