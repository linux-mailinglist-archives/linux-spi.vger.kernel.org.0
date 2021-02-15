Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781C31B964
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 13:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBOMjL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 07:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhBOMjJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Feb 2021 07:39:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046BCC061756;
        Mon, 15 Feb 2021 04:38:26 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t2so3856092pjq.2;
        Mon, 15 Feb 2021 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1x7bFxRMxFkzhQJ3FsPRcWMZwloVqKz9aeYfS9bbHK8=;
        b=U/6xwuPrQIky8vio6ycHfVP4qeX0tMrUYsWQc+9WdvWpmTcQjWD3usKTJu1nVUAiam
         gT0bXalVYLepoqUJ1Xao0hIvz+opYKRiq3VHvVTZwsGYpNlEnaS5FtARzsgsJfSYeUUG
         /uDLCRh4X+4dDUm+8Gz69QexA50/m2VklYfX1V/k0ilcQCLFjsG+5rWiXq3198Uqa7V9
         nO1tib4g2k+1Yy9s03UWsEiZDKhrejCafd6sUzJ2JA7wHGRBioKAX1F7ASd5yOsjr1Hf
         jLm1pHRA3hdbjUKNUH/G7ERtmItZ+N5KAeesjbEsKMZniQvAS6zi3x1iwOhlRugQafJb
         dZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1x7bFxRMxFkzhQJ3FsPRcWMZwloVqKz9aeYfS9bbHK8=;
        b=fKU+xowIiCuRx80tw/zxw5CAvRBuE3oQ40almPEvHXCL623oC0MZ28xmLYoMZgZAZr
         pXa8bI0C0Xz/QDuSqdTZeqaFuwIcQkTj+cTSLvfFpa5JNyrKmQzNWiCpjMf/8zV3E5Mx
         3eXwbBOHURyJ/n8kc4tDNwBSdgDd/39MAXO7jhXfOTgZZDvr4R7lfM5rdoDMcevgutBH
         l5vu1Pnq2tzitqQEWyaPuhF/ZQHT8KTG0CIQGHGGTsDdfAWhzSdHm+/QZL/FF0MpBC/I
         ym9UkjxH0PMKL0JuFB+q11AeQOoPnxTOP/2puegNcImghYPawyUFcknHyKx7/h38DlAJ
         heRg==
X-Gm-Message-State: AOAM531VbaQSk04Jir2o9dEFSbstc5EdVZGnev8PdarSJERJISWNR7IW
        TMYu8VQGPOS42rVOHPyD63A=
X-Google-Smtp-Source: ABdhPJzffYI22J7ZgLVJY1Cwdu896/WT5M/lJtQfbDEDJIbSlMoEsRs7xETiDzOQNf89dylo03aLzw==
X-Received: by 2002:a17:90a:4609:: with SMTP id w9mr16583775pjg.69.1613392705533;
        Mon, 15 Feb 2021 04:38:25 -0800 (PST)
Received: from localhost (89.208.244.53.16clouds.com. [89.208.244.53])
        by smtp.gmail.com with ESMTPSA id 73sm18413112pfa.27.2021.02.15.04.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:38:25 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:38:23 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
Message-ID: <20210215123823.GA618076@nuc8i5>
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
 <d113b6f5-d234-452e-3e82-90c5237eff0e@siemens.com>
 <88dff093-b18f-e23c-9cec-b8623da5857b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88dff093-b18f-e23c-9cec-b8623da5857b@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Feb 15, 2021 at 11:41:50AM +0200, Jarkko Nikula wrote:
> On 2/15/21 11:23 AM, Jan Kiszka wrote:
> > On 14.02.21 15:57, Dejin Zheng wrote:
> > > Call to 'pci_free_irq_vectors()' are missing both in the error handling
> > > path of the probe function, and in the remove function. So add them.
> > > 
> > > Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
> > > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > > ---
> > >   drivers/spi/spi-pxa2xx-pci.c | 13 ++++++++++---
> > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> > > index 14fc41ed2361..1ec840e78ff4 100644
> > > --- a/drivers/spi/spi-pxa2xx-pci.c
> > > +++ b/drivers/spi/spi-pxa2xx-pci.c
> > > @@ -254,8 +254,10 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
> > >   	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
> > >   	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
> > >   					   c->max_clk_rate);
> > > -	 if (IS_ERR(ssp->clk))
> > > -		return PTR_ERR(ssp->clk);
> > > +	if (IS_ERR(ssp->clk)) {
> > > +		ret = PTR_ERR(ssp->clk);
> > > +		goto err_irq;
> > > +	}
> > >   	memset(&pi, 0, sizeof(pi));
> > >   	pi.fwnode = dev->dev.fwnode;
> > > @@ -268,12 +270,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
> > >   	pdev = platform_device_register_full(&pi);
> > >   	if (IS_ERR(pdev)) {
> > >   		clk_unregister(ssp->clk);
> > > -		return PTR_ERR(pdev);
> > > +		ret = PTR_ERR(pdev);
> > > +		goto err_irq;
> > >   	}
> > >   	pci_set_drvdata(dev, pdev);
> > >   	return 0;
> > > +err_irq:
> > > +	pci_free_irq_vectors(dev);
> > > +	return ret;
> > >   }
> > >   static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
> > > @@ -283,6 +289,7 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
> > >   	spi_pdata = dev_get_platdata(&pdev->dev);
> > > +	pci_free_irq_vectors(dev);
> > >   	platform_device_unregister(pdev);
> > >   	clk_unregister(spi_pdata->ssp.clk);
> > >   }
> > > 
> > 
> > Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> Please fix pca2xx-pci -> pxa2xx-pci in the subject line. With that change
> you may add:

Jan and Jarkko, Thanks very much for your review. I will modify the
subject name in patch v2, Thanks again!

Dejin

> 
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
