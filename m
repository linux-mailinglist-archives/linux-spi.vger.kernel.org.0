Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EFC253736
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHZSdo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZSdn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 14:33:43 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08050C061756;
        Wed, 26 Aug 2020 11:33:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l23so2608466edv.11;
        Wed, 26 Aug 2020 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5kmOizgxtwlauHhhTaD0zLARzpI1VK6AvYoiDVPxbI=;
        b=G8W5/xzwifQCjyEKbG3xTJZCOrYyj91kZ7Mh8iovYXInrjXwbIWRxvBJbkhWUOZwst
         YwsPhO8jN86sKW0tNXXJWZukIt16K7EG4Das5IrOifYSNFIqKFj02t8tN4IxtK6dSDGC
         WS2nDA5qSX00tEutTvPjF6LstQlxJHcuWN0AQ0poRHC5F4PCwL5gLw/VZ4JzD7C8gyT8
         x3PjwOdjqgup/KoxRco/669QBZdZiTg8+ku/JBV3maW7MFQmbgAmK46cnJpcGFGFAZBH
         7ziT60smA77rfBzTOwL84v13bIEamkaqgXaVheJ5OTO+aDPM5If/5dyQGgOGFM1O4Dnb
         V+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5kmOizgxtwlauHhhTaD0zLARzpI1VK6AvYoiDVPxbI=;
        b=O8S8HgAdhD/mHw6QhIxy44i1KT3ZkJcH5wsDPV+7ZEkmhmUioQK/OxcEFwQzzUq/zC
         W9BMrEoQ8PTTGUUn7M1E4oQNZ8JxtE1fTqoOXBsBJYJZDrQFqTnAqZMX4620FsCFQaQc
         /dp+EzRXJFOQr4CeXnkKmSQOiN9nViMJ7wHPiwOBfntBgPPM7QVyJH5gL1B7Pnsqs1BE
         +tn/5Lfj9RnXAeDFvG15mPePvichieV2s2GdPxRXgwH1vwkid37FQLDv7AaeKFxU0Lyd
         2qq+GSuXKmTqET9THdHK0JBn9Deq9v0V6W4kmMnI32M48rSSbHZCDDEGGQfwCgxGLau1
         iF+g==
X-Gm-Message-State: AOAM532W/izc2e+gim9wZ/LBpsDKIsVG5DJPhjBAuPip1XWryodUQ2HC
        s4U1UsK6f9i+Dxt5jBa9YC8=
X-Google-Smtp-Source: ABdhPJxwlkjns6BzliD8Bm85S3+ZbZxF+WzhfQY058593cbFboT2AQ7zW7fNRGXoi6i6eCB08y327A==
X-Received: by 2002:a05:6402:1210:: with SMTP id c16mr16543655edw.71.1598466821634;
        Wed, 26 Aug 2020 11:33:41 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id g11sm2648135edt.88.2020.08.26.11.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:33:40 -0700 (PDT)
Date:   Wed, 26 Aug 2020 21:33:38 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826183338.rwacm5cstialye7p@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
 <20200826165552.GK4965@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826165552.GK4965@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 05:55:52PM +0100, Mark Brown wrote:
> On Wed, Aug 26, 2020 at 05:47:44PM +0300, Vladimir Oltean wrote:
> > On Wed, Aug 26, 2020 at 03:23:12PM +0100, Mark Brown wrote:
> > > On Wed, Aug 26, 2020 at 02:47:58PM +0300, Vladimir Oltean wrote:
> 
> > > >   { "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], }
> 
> > > Based on some other stuff I've seen with ACPI on NXP stuff it looks like
> > > they're following the same scheme but only caring about that one SoC for
> > > the time being.
> 
> > So, no argument about caring only about ACPI on one particular SoC for
> > the time being, but there's a big difference between a solution that
> > works for N=1 and one that works for N=2...
> 
> > Showing my ignorance here, but is there something equivalent to
> > of_machine_is_compatible() for ACPI?
> 
> The NXP0005 is the ACPI equivalent of a compatible (comprehensibility is
> not ACPI's forte) and they're tying driver data to it there.

Where I was trying to get here is that we could have a single _HID for
the DSPI controller, and corroborate that with the ACPI equivalent of
of_machine_is_compatible("fsl,ls2085a") at driver probe time before
assigning the driver data.

Thanks,
-Vladimir
