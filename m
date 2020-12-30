Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12F2E75AA
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL3C3h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 21:29:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:58620 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL3C3h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Dec 2020 21:29:37 -0500
IronPort-SDR: vnN4OPbugvugU4k0f9bPuqoKq0rMpXGAqWRnclUWT7VWPACssSIPODdvLseDgDCdkGAYUb3Pra
 Vdq2oJrrSu7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="156347261"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="156347261"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 18:28:57 -0800
IronPort-SDR: YR3+1eKVcLd2fWv//eJ/K5gk6OSNKqKPAW0bpkcKN2ZIw3u2kn0+0UBhBwbiRw8/jMupij0ZV0
 o0DijPYgEVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="347604438"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2020 18:28:55 -0800
Date:   Wed, 30 Dec 2020 10:24:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com
Subject: Re: [PATCH 2/2] spi: fix the divide by 0 error when calculating xfer
  waiting time
Message-ID: <20201230022420.GF14854@yilunxu-OptiPlex-7050>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
 <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
 <20201229131308.GE4786@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229131308.GE4786@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 29, 2020 at 01:13:08PM +0000, Mark Brown wrote:
> On Tue, Dec 29, 2020 at 01:27:42PM +0800, Xu Yilun wrote:
> > The xfer waiting time is the result of xfer->len / xfer->speed_hz, but
> > when the following patch is merged,
> > 
> > commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
> > 
> > the xfer->speed_hz may always be clamped to 0 if the controller doesn't
> > provide its max_speed_hz. There may be no hardware indication of the
> > max_speed_hz so the controller driver leaves it, but exception happens
> > when it tries to do irq mode transfer.
> 
> Does this still apply with current code?  There have been some fixes in
> this area which I think should ensure that we don't turn the speed down
> to 0 if the controller doesn't supply a limit IIRC.

Yes, there is chance the speed is set to 0, some related code from 5.11-rc1

  int spi_setup(struct spi_device *spi)
  {
	...

	if (!spi->max_speed_hz ||
	    spi->max_speed_hz > spi->controller->max_speed_hz)
		spi->max_speed_hz = spi->controller->max_speed_hz;

If the controller doesn't supply a limit, spi->max_speed_hz will always
be clamped to 0 here, no matter what the client inputs.

BTW, Could we keep the spi->max_speed_hz if no controller->max_speed_hz?
Always clamp the spi->max_speed_hz to 0 makes no sense.

	...
  }

  static int __spi_validate(struct spi_device *spi, struct spi_message
			    *message)
  {
	...

	if (!xfer->speed_hz)
		xfer->speed_hz = spi->max_speed_hz;

	if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
		xfer->speed_hz = ctlr->max_speed_hz;

If spi->max_speed_hz & controller->max_speed_hz are 0, xfer->speed_hz is
always 0.

	...
  }


I tested it on 5.11-rc1 with spi-altera.

> 
> > This patch makes the assumption of 1khz xfer speed if the xfer->speed_hz
> > is not assigned. This avoids the divide by 0 issue and ensures a
> > reasonable tolerant waiting time.
> 
> It will cause absurdly slow transfers if the controller does actually
> implement speed setting though, if we're going to pick a default value

Maybe I didn't describe clearly, if the controller has a valid limit setting,
the xfer->speed_hz will be set to max_speed_hz and will not fall through to
a default value. The fix code takes function when all the checks in spi_setup &
spi_validate fails to assign the xfer->speed_hz. 

This fix only affects the waiting timeout, it will not slow down the normal
xfer anyway.

> I'd go for at least 100kHz. 

If some controller is actually working at a speed lower than the default
value, xfer will always be unexpectly early terminated.

I'm not sure how slow the controllers in the world could be. If 100kHz
is slow enough to everyone it's OK.
 
> 
> >  	} else {
> > +		speed_hz = xfer->speed_hz ? : 1000;
> 
> Please don't abuse the ternery operator, write normal conditional
> statements to make things more legible.

OK, I'll change it.

Thanks,
Yilun
