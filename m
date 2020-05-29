Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D091E86F2
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2Sty (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 14:49:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:55983 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE2Sty (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 14:49:54 -0400
IronPort-SDR: uFhIBb7mtdZEaA2w/vVea8zaZsD2MYKdv690vHLaUIRMKnOEj/4h3YU5T4wja/Z2gGuYgDHGDs
 zBNBtFb1gaHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:49:53 -0700
IronPort-SDR: t9N/z8lErEK+HiiIeY2yJLdDInwb4iwk3SGkICs3JKHuY4PtJt5b6R/Ibgz/m9QrhS57Af8abo
 f2lIQQfa5ADA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="443493393"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2020 11:49:52 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jek4p-009fzX-93; Fri, 29 May 2020 21:49:55 +0300
Date:   Fri, 29 May 2020 21:49:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
Message-ID: <20200529184955.GY1634618@smile.fi.intel.com>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
 <20200529184050.bkn72tash33zgoo4@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529184050.bkn72tash33zgoo4@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 09:40:50PM +0300, Serge Semin wrote:
> On Fri, May 29, 2020 at 09:31:49PM +0300, Andy Shevchenko wrote:
> > The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
> > did a clean up of global variables, which is fine, but messed up with
> > the carefully provided information in the custom DMA slave structures.
> > There reader can find an assignment of the DMA request lines in use.
> > 
> > Partially revert the above mentioned commit to restore readability
> > and maintainability of the code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: rebased against latest spi/for-next
> >  drivers/spi/spi-dw-dma.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index 1b96cec6d8cd..53d5257662e8 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -61,10 +61,8 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
> >  
> >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> >  {
> > -	struct dw_dma_slave slave = {
> > -		.src_id = 0,
> > -		.dst_id = 0
> > -	};
> 
> > +	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> > +	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
> 
> You know my attitude to these changes.) But anyway what's the point in having
> the *tx and *rx pointers here? Without any harm to the readability you can use
> the structures names directly, don't you?

I will wait for Mark to decide.

-- 
With Best Regards,
Andy Shevchenko


