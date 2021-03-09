Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F93321F8
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhCIJ3x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 04:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhCIJ3g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 04:29:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB5CC06174A;
        Tue,  9 Mar 2021 01:29:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w11so14412850wrr.10;
        Tue, 09 Mar 2021 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sO+epgmRhJDMZTjy7AJEtlpTCWTyWl78HxLY6u7YYT4=;
        b=K3v2aelY32sKpTuZ0I7x4JWtpKiNpmfBFly7VryV6+xxpJe4g7wPS7xh5S/doLXKcb
         mo03VIkPcwsmyDMuTKEflW0IX9bQz3bdkpAB8lwn4gHX3Yk/24v3TkRJra1g9MVRDVfr
         RshKTZw4JxQOHU32eMgwYbxaCNl0qhd5/P7GOvgGILcxFqzGPuyRG274SU6ZXMzZl3/2
         h5I8RdgVlBNapJaRIhb10UL+wE0BH2uKm4DAHjEIGJbTANjZCF5F5JCUfD1METY6HZv3
         XN9Gu51SLvvM/NoFw80hy0vNU50IQEDciM2LMZJcycbhpAt5YhLGv3J3l0j0GSzOtIoD
         sbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sO+epgmRhJDMZTjy7AJEtlpTCWTyWl78HxLY6u7YYT4=;
        b=RDh6ow8oglMIstty/O9cAA5FC3ieQtnNFv/PYLgo/bBwgQdrDea/9OIreCCrIv6Jzd
         5x/3ZPqoVdLHlT/4f+Qn3ys5KACxL7XtWPemIy46zaVP1Nrygdg3Nbiad5YVbXtQnWdE
         gJKjxIctuFvzeoCWZfFKxpAFJzZtIvDtMu7IHwKaEP95SJ4scHmPR5sPliiZwrmXRexc
         t2nQlQB8pY+n9BCU+Go2O0AE4vev3Or0g+ghU/liJUdVECS59EUS/dlhL3atthPCqf5U
         dnrcBLoR3Fldtb+elRyv4xPfhTVUCgUnn8oRlsRUYvAaue4R7G1CZStVKmFIWaeeMbIj
         5MQQ==
X-Gm-Message-State: AOAM532X5Rvkkzx7VaRcSAuCOxUlOoJG+Gw+zGRkDaU/smjE//E2+oCG
        vsL50yf13OR8gwQc1H0ZEEU=
X-Google-Smtp-Source: ABdhPJxRf5rC6bFM/jX0jWPH/MjxZL5FZ/8xf3aU9Yy6CPERflbdpoh/R7KczYhwdnyHNlKIBhJKmg==
X-Received: by 2002:adf:f841:: with SMTP id d1mr26884305wrq.36.1615282175248;
        Tue, 09 Mar 2021 01:29:35 -0800 (PST)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id o9sm3154597wmc.8.2021.03.09.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:29:34 -0800 (PST)
Date:   Tue, 9 Mar 2021 09:29:32 +0000
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, f.fainelli@gmail.com,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux@deviqon.com
Subject: Re: [PATCH 06/10] staging: greybus: spilib: use 'spi_delay_to_ns'
 for getting xfer delay
Message-ID: <20210309092932.kliwq6ylqlnpqekk@arch-thunder.localdomain>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
 <20210308145502.1075689-7-aardelean@deviqon.com>
 <20210309042809.dgop5dli36z27sj2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309042809.dgop5dli36z27sj2@vireshk-i7>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
On Tue, Mar 09, 2021 at 09:58:09AM +0530, Viresh Kumar wrote:
> On 08-03-21, 16:54, Alexandru Ardelean wrote:
> > The intent is the removal of the 'delay_usecs' field from the
> > spi_transfer struct, as there is a 'delay' field that does the same
> > thing.
> > 
> > The spi_delay_to_ns() can be used to get the transfer delay. It works by
> > using the 'delay_usecs' field first (if it is non-zero), and finally
> > uses the 'delay' field.
> > 
> > Since the 'delay_usecs' field is going away, this change makes use of the
> > spi_delay_to_ns() function. This also means dividing the return value of
> > the function by 1000, to convert it to microseconds.
> > To prevent any potential faults when converting to microseconds and since
> > the result of spi_delay_to_ns() is int, the delay is being computed in 32
> > bits and then clamped between 0 & U16_MAX.
> > 
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >  drivers/staging/greybus/spilib.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
> > index 672d540d3365..30655153df6a 100644
> > --- a/drivers/staging/greybus/spilib.c
> > +++ b/drivers/staging/greybus/spilib.c
> > @@ -245,6 +245,7 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
> >  	/* Fill in the transfers array */
> >  	xfer = spi->first_xfer;
> >  	while (msg->state != GB_SPI_STATE_OP_DONE) {
> > +		int xfer_delay;
> >  		if (xfer == spi->last_xfer)
> >  			xfer_len = spi->last_xfer_size;
> >  		else
> > @@ -259,7 +260,9 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
> >  
> >  		gb_xfer->speed_hz = cpu_to_le32(xfer->speed_hz);
> >  		gb_xfer->len = cpu_to_le32(xfer_len);
> > -		gb_xfer->delay_usecs = cpu_to_le16(xfer->delay_usecs);
> > +		xfer_delay = spi_delay_to_ns(&xfer->delay, xfer) / 1000;
> > +		xfer_delay = clamp_t(u16, xfer_delay, 0, U16_MAX);
> > +		gb_xfer->delay_usecs = cpu_to_le16(xfer_delay);
> >  		gb_xfer->cs_change = xfer->cs_change;
> >  		gb_xfer->bits_per_word = xfer->bits_per_word;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

------
Cheers,
     Rui
