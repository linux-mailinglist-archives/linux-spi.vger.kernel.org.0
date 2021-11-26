Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A945EC79
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbhKZLZX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 26 Nov 2021 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbhKZLXX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:23:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD04C08EC1D
        for <linux-spi@vger.kernel.org>; Fri, 26 Nov 2021 02:36:37 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mqYan-0002aX-6K; Fri, 26 Nov 2021 11:36:33 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mqYaj-0006P8-DU; Fri, 26 Nov 2021 11:36:29 +0100
Message-ID: <63a467164c985cadce0e28e50508363a8d2f6622.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lh Kuo =?UTF-8?Q?=E9=83=AD=E5=8A=9B=E8=B1=AA?= 
        <lh.Kuo@sunplus.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, "LH.Kuo" <lhjeff911@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?UTF-8?Q?=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>
Date:   Fri, 26 Nov 2021 11:36:29 +0100
In-Reply-To: <33d50e94059b4734939db60b5c531bc9@sphcmbx02.sunplus.com.tw>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
         <cover.1637547799.git.lh.kuo@sunplus.com>
         <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
         <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
         <YZz0n6Mpjl3tKmMe@sirena.org.uk>
         <CAHp75Vf6+monqu4Hq-yoFSohD9tNFqZTuKjqDDKAJE3Om2BUYQ@mail.gmail.com>
         <6eb68a8153ba46c48862d00f7aa6e0fe@sphcmbx02.sunplus.com.tw>
         <CAHp75VftSORts5cbDxvfyHgqhxmb7K74BfPd=mST+75C+Ch9dQ@mail.gmail.com>
         <33d50e94059b4734939db60b5c531bc9@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi LH,

On Fri, 2021-11-26 at 07:40 +0000, Lh Kuo 郭力豪 wrote:
[...]
> Amended as follows, is it okay?
> 
> 	ret = devm_request_irq(dev, pspim->mas_irq, sp7021_spi_mas_irq
> 			, IRQF_TRIGGER_RISING, pdev->name, pspim);
> 	if (ret)
> 		return ret;

Comma at the end of the line and align the next line with the opening
parenthesis:

	ret = devm_request_irq(dev, pspim->mas_irq, sp7021_spi_mas_irq,
			       IRQF_TRIGGER_RISING, pdev->name, pspim);

You can use scripts/checkpatch --strict to find these issues before
review.

> > >         pspim->rstc = devm_reset_control_get_exclusive(dev, NULL);
> > >         if (IS_ERR(pspim->rstc)) {
> > >                 return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst
> > > get fail\n");
> > 
> 
> Amended as follows, is it okay?
> 
> 	pspim->rstc = devm_reset_control_get_exclusive(dev, NULL);
> 	if (IS_ERR(pspim->rstc))
> 		return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get fail\n");

Yes.
> > 

> > >         ret = devm_spi_register_controller(dev, ctlr);
> > 
> > You can't mix non-devm with devm APIs. Either all non-devm, or devm followed by non-devm.
> > 
> 
>   I don't understand so I need to change to spi_register_controller(ctlr)?   why?

devm_spi_register_controller() shouldn't be called after
pm_runtime_enable().

You could either switch to devm_pm_runtime_enable() or move the
pm_runtime_enable() after the devm_spi_register_controller() call if
possible, or switch to spi_register_controller().

> I modified the remove-function as follows. I think devm_spi_register_controller(dev, ctlr); should be no problem in the probe funciton.
> static int sp7021_spi_controller_remove(struct platform_device *pdev)
> {
> 	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
> 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
> 
> 	pm_runtime_disable(&pdev->dev);

I'm not sure if the SPI framework requires the spi_controller to be
unregistered before hardware is powered off, maybe it is enough to call
spi_controller_suspend() in the right place?

> 	pm_runtime_set_suspended(&pdev->dev);
> 	reset_control_assert(pspim->rstc);
> 	clk_disable_unprepare(pspim->spi_clk);
> 
> 	return 0;
> }

regards
Philipp
