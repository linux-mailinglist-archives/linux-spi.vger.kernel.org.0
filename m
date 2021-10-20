Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F2434303
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 03:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJTBoa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Oct 2021 21:44:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:10152 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTBoa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Oct 2021 21:44:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="314868476"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="314868476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 18:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="594469826"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2021 18:41:42 -0700
Date:   Wed, 20 Oct 2021 09:35:11 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
Message-ID: <20211020013511.GB145760@yilunxu-OptiPlex-7050>
References: <20211019002401.24041-1-russell.h.weight@intel.com>
 <278aa054-9710-440e-df6e-96c7b835e2ab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278aa054-9710-440e-df6e-96c7b835e2ab@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 18, 2021 at 05:27:38PM -0700, Russ Weight wrote:
> If there are no concerns with this patch, it will need to have the "cc stable"
> tag added for earlier kernels.

The code is good to me, and please add the cc stable tag.

> 
> I don't think it needs a "Fixes" tag, as the problem has been there since the
> driver was introduced.

You could add the Fixes tag for the patches that introduce the drivers.

> 
> Thanks,
> - Russ
> 
> On 10/18/21 5:24 PM, Russ Weight wrote:
> > The spi-altera driver has two flavors: platform and dfl. I'm seeing
> > a case where I have both device types in the same machine, and they
> > are conflicting on the SPI ID:
> >
> > ... kernel: couldn't get idr
> > ... kernel: WARNING: CPU: 28 PID: 912 at drivers/spi/spi.c:2920 spi_register_controller.cold+0x84/0xc0a
> >
> > Both the platform and dfl drivers use the parent's driver ID as the SPI
> > ID. In the error case, the parent devices are dfl_dev.4 and
> > subdev_spi_altera.4.auto. When the second spi-master is created, the
> > failure occurs because the SPI ID of 4 has already been allocated.
> >
> > Change the ID allocation to dynamic (by initializing bus_num to -1) to
> > avoid duplicate SPI IDs.
> >
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Please add the tags and then,
Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> > ---
> >  drivers/spi/spi-altera-dfl.c      | 2 +-
> >  drivers/spi/spi-altera-platform.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> > index 44fc9ee13fc7..ca40923258af 100644
> > --- a/drivers/spi/spi-altera-dfl.c
> > +++ b/drivers/spi/spi-altera-dfl.c
> > @@ -134,7 +134,7 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> >  	if (!master)
> >  		return -ENOMEM;
> >  
> > -	master->bus_num = dfl_dev->id;
> > +	master->bus_num = -1;
> >  
> >  	hw = spi_master_get_devdata(master);
> >  
> > diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
> > index f7a7c14e3679..65147aae82a1 100644
> > --- a/drivers/spi/spi-altera-platform.c
> > +++ b/drivers/spi/spi-altera-platform.c
> > @@ -48,7 +48,7 @@ static int altera_spi_probe(struct platform_device *pdev)
> >  		return err;
> >  
> >  	/* setup the master state. */
> > -	master->bus_num = pdev->id;
> > +	master->bus_num = -1;
> >  
> >  	if (pdata) {
> >  		if (pdata->num_chipselect > ALTERA_SPI_MAX_CS) {
