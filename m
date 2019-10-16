Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE287D96B5
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2019 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbfJPQNO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 12:13:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:58055 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404056AbfJPQNN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 16 Oct 2019 12:13:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 09:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="186196071"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2019 09:13:01 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iKlv2-0005Q2-48; Wed, 16 Oct 2019 19:13:00 +0300
Date:   Wed, 16 Oct 2019 19:13:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        sam@ravnborg.org, david@lechnology.com,
        dri-devel@lists.freedesktop.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 05/11] drm/tinydrm: Remove
 tinydrm_spi_max_transfer_size()
Message-ID: <20191016161300.GW32742@smile.fi.intel.com>
References: <20190719155916.62465-1-noralf@tronnes.org>
 <20190719155916.62465-6-noralf@tronnes.org>
 <20191015143236.GA5363@smile.fi.intel.com>
 <253aec49-e51c-b35b-4e7d-53a8a948655d@tronnes.org>
 <20191015155720.GQ11828@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191015155720.GQ11828@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 15, 2019 at 05:57:20PM +0200, Daniel Vetter wrote:
> On Tue, Oct 15, 2019 at 05:41:53PM +0200, Noralf Trønnes wrote:
> > Den 15.10.2019 16.32, skrev Andy Shevchenko:
> > > On Fri, Jul 19, 2019 at 05:59:10PM +0200, Noralf Trønnes wrote:
> > >> spi-bcm2835 can handle >64kB buffers now so there is no need to check
> > >> ->max_dma_len. The tinydrm_spi_max_transfer_size() max_len argument is
> > >> not used by any callers, so not needed.
> > >>
> > >> Then we have the spi_max module parameter. It was added because
> > >> staging/fbtft has support for it and there was a report that someone used
> > >> it to set a small buffer size to avoid popping on a USB soundcard on a
> > >> Raspberry Pi. In hindsight it shouldn't have been added, I should have
> > >> waited for it to become a problem first. I don't know it anyone is
> > >> actually using it, but since tinydrm_spi_transfer() is being moved to
> > >> mipi-dbi, I'm taking the opportunity to remove it. I'll add it back to
> > >> mipi-dbi if someone complains.
> > >>
> > >> With that out of the way, spi_max_transfer_size() can be used instead.
> > >>
> > >> The chosen 16kB buffer size for Type C Option 1 (9-bit) interface is
> > >> somewhat arbitrary, but a bigger buffer will have a miniscule impact on
> > >> transfer speed, so it's probably fine.
> > > 
> > > This breaks the SPI PXA2xx case I'm using. The world is not a Pi:e.
> > > 
> > > [  388.445752] mi0283qt spi-PRP0001:01: DMA disabled for transfer length 153600 greater than 65536
> > > [  388.634437] mi0283qt spi-PRP0001:01: DMA disabled for transfer length 153600 greater than 65536
> > > [  388.822933] mi0283qt spi-PRP0001:01: DMA disabled for transfer length 153600 greater than 65536
> > > 
> > > The crucial thing is to check the transfer size against maximum DMA length
> > > of the master.
> > > 
> > 
> > Isn't this a spi controller driver problem?
> > spi_max_transfer_size() tells the client what the maximum transfer
> > length is. The controller driver can use ctlr->max_transfer_size if it
> > has restrictions.
> > AFAIUI max_dma_len is used when splitting up the buffer for the sg table
> > in spi_map_buf().
> 
> Something like this, as a test patch.

max_transfer_size should be a function. In that case it works.
However I'm not sure it's the best approach, thus, Cc to SPI PXA people.

> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index bb6a14d1ab0f..f77201915033 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1707,6 +1707,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>  		} else {
>  			controller->can_dma = pxa2xx_spi_can_dma;
>  			controller->max_dma_len = MAX_DMA_LEN;
> +			controller->max_transfer_size = MAX_DMA_LEN;
>  		}
>  	}
>  

-- 
With Best Regards,
Andy Shevchenko


