Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96B644F8C7
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 16:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhKNPrj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 10:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhKNPrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Nov 2021 10:47:23 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DAC061746;
        Sun, 14 Nov 2021 07:44:22 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2456C22234;
        Sun, 14 Nov 2021 16:44:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1636904659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO/0Zxv6yZSCtbzAWraXzJrioMAawPciLz//4U5rTVc=;
        b=aVrvmIRrpTWMvXpr5ZnUQSAn1V0QChAflw5ptlDKxMy0hwNX49gaelk9gz9VKMLnjrd7Ba
        wt0AV5QYGSg+ofOf+iF4YUGZcwh8hgifFRYykj5qKgfu9kLNySNFKDgg0KqP52BxkTmT0Y
        kb+MRq0RKeHIw8x+VO0RGlIlLr+AXQw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 14 Nov 2021 16:44:18 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-dspi: use devm_spi_alloc_master()
In-Reply-To: <20211113180642.7doe6dc5iotw5yez@skbuf>
References: <20211110161754.3312805-1-michael@walle.cc>
 <20211113180642.7doe6dc5iotw5yez@skbuf>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <cd4b16c6fb46cbb9670b5a9551bc46be@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-11-13 19:06, schrieb Vladimir Oltean:
> On Wed, Nov 10, 2021 at 05:17:54PM +0100, Michael Walle wrote:
>> Commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove 
>> path")
>> fixed the use-after-free by manually allocating memory. Nowadays, 
>> since
>> commit 5e844cc37a5c ("spi: Introduce device-managed SPI controller
>> allocation"), there is a devres version of spi_alloc_master() for 
>> exactly
>> this purpose. Revert the commit which introduced the manual allocation
>> and use the new devm_spi_alloc_master().
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Btw, using the devm_ version of spi_controller_register() doesn't seem 
>> to
> 
> you mean spi_register_controller.
> 
>> be a good idea, see commit 8d559a64f00b ("spi: stm32: drop devres 
>> version
>> of spi_register_master").
> 
> And you mention this because?

just in case someone thinks it is a good idea to convert the
spi_register_controller() call.

> The dspi driver doesn't use
> devm_spi_register_controller(). In fact, if it could be made to not use
> devres at all, I couldn't be happier. At this stage, the devres 
> wrappers
> for SPI are doing more harm than good.
> 
>>  drivers/spi/spi-fsl-dspi.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index fd004c9db9dc..29f8a596c8ee 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -1227,17 +1227,11 @@ static int dspi_probe(struct platform_device 
>> *pdev)
>>  	void __iomem *base;
>>  	bool big_endian;
>> 
>> -	dspi = devm_kzalloc(&pdev->dev, sizeof(*dspi), GFP_KERNEL);
>> -	if (!dspi)
>> -		return -ENOMEM;
>> -
>> -	ctlr = spi_alloc_master(&pdev->dev, 0);
>> +	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
>>  	if (!ctlr)
>>  		return -ENOMEM;
>> 
>> -	spi_controller_set_devdata(ctlr, dspi);
>> -	platform_set_drvdata(pdev, dspi);
>> -
>> +	dspi = spi_controller_get_devdata(ctlr);
>>  	dspi->pdev = pdev;
>>  	dspi->ctlr = ctlr;
>> 
>> @@ -1373,6 +1367,8 @@ static int dspi_probe(struct platform_device 
>> *pdev)
>>  	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
>>  		ctlr->ptp_sts_supported = true;
>> 
>> +	platform_set_drvdata(pdev, ctlr);
>> +
> 
> Why do you feel a need to change the drvdata from "dspi" to "ctrl"?

It was just a revert and that was the way it was done before
the patch mentioned above. You're right, dspi is better
here and then the hunk below will be superfluous.

Let me know if I should respin the patch or if you like to
keep the devm_kzalloc() as it is now, because you've mentioned
you don't like the spi devres mappers. During earlier debugging
I just noticed the following comment in drivers/spi/spi.c and
noticed that this driver isn't converted:

/* Release the last reference on the controller if its driver
  * has not yet been converted to devm_spi_alloc_master/slave().
  */

-michael

> 
>>  	ret = spi_register_controller(ctlr);
>>  	if (ret != 0) {
>>  		dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
>> @@ -1396,7 +1392,8 @@ static int dspi_probe(struct platform_device 
>> *pdev)
>> 
>>  static int dspi_remove(struct platform_device *pdev)
>>  {
>> -	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
>> 
>>  	/* Disconnect from the SPI framework */
>>  	spi_unregister_controller(dspi->ctlr);
>> --
>> 2.30.2
>> 
