Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7A1DD459
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgEUR2k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 13:28:40 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39784 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgEUR2j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 13:28:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BD6ED803087B;
        Thu, 21 May 2020 17:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eHxoNLgoGl2o; Thu, 21 May 2020 20:28:36 +0300 (MSK)
Date:   Thu, 21 May 2020 20:28:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        Liang Jin J <liang.j.jin@ericsson.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH 1/2] spi: dw: add reset control
Message-ID: <20200521172835.pf37pyd7whg76d3a@mobilestation>
References: <20200521170359.20430-1-dinguyen@kernel.org>
 <20200521171203.GH4770@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521171203.GH4770@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 06:12:03PM +0100, Mark Brown wrote:
> On Thu, May 21, 2020 at 12:03:58PM -0500, Dinh Nguyen wrote:
> > Add mechanism to get the reset control and deassert it in order to bring
> > the IP out of reset.
> > 
> > Signed-off-by: Liang Jin J <liang.j.jin@ericsson.com>
> > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> 
> Is the From: correct here?
> 
> Also adding everyone else who's got patches in flight for this driver
> right now.
> 
> > ---
> >  drivers/spi/spi-dw-mmio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 384a3ab6dc2d..5c813e15ed89 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> > +#include <linux/reset.h>
> >  
> >  #include "spi-dw.h"
> >  
> > @@ -30,6 +31,7 @@ struct dw_spi_mmio {
> >  	struct clk     *clk;
> >  	struct clk     *pclk;
> >  	void           *priv;
> > +	struct reset_control	*rstc;
> >  };
> >  
> >  #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
> > @@ -145,6 +147,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  	if (!dwsmmio)
> >  		return -ENOMEM;
> >  

> > +	dwsmmio->rstc = devm_reset_control_get_exclusive(&pdev->dev, "spi");

It would be better to use the optional-version of the reset getter:
devm_reset_control_get_optional_exclusive(), since for instance our DW APB SSI
doesn't have a dedicated reset line.

Note also that you don't need to check the rstc for being NULL. It's null if the
reset line is optional and isn't provided.

If we get to have this patch applied, then DT binding shall be also updated...
Though we haven't got it reviewed yet.(

-Sergey



> > +	if (!IS_ERR(dwsmmio->rstc))
> > +		reset_control_deassert(dwsmmio->rstc);
> > +
> >  	dws = &dwsmmio->dws;
> >  
> >  	/* Get basic io resource and map it */
> 
> Should we also undo the reset in error paths from probe()?  It's not the
> end of the world if we don't but...
> 
> > @@ -220,6 +226,9 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
> >  	clk_disable_unprepare(dwsmmio->pclk);
> >  	clk_disable_unprepare(dwsmmio->clk);
> >  
> > +	if (dwsmmio->rstc)
> > +		reset_control_assert(dwsmmio->rstc);
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.17.1
> > 


