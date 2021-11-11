Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3544D9D3
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhKKQJX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 11:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhKKQJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 11:09:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37813C061766;
        Thu, 11 Nov 2021 08:06:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu18so15402419lfb.0;
        Thu, 11 Nov 2021 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CKJUqhZF5ZFTvwMtANSKQusnvw1X0fA7nKg2F8RC/Ms=;
        b=E7DOIK5OLuR7Qd875x9oQw0cG2GNuu07Tgb4xeBwdyfFZXqPTxXbM3idPFqr5FDewI
         9g3cmkTcvYRpXDkTeupkc8+UiJFVWjYFmkOImZ/IcvmOTa3lBCc8h2voJIkWd7fddoRv
         +ovIqqHdzpwQHLWoXo37dnZy+YbsBkQYSHzqP1F8IvIOkzCZdFKWvyxHRZIg82N4BtZy
         S1MfKKR3XM81iZSXu+cWhcrCz4WwcxbkDVZO7Ywr5Hb70OOc38pZtOJzizlc/AVdld6l
         dF6uA6L+aJwQY97YkgfpaKnoIgb0GWD0yCLmxDWNFytHu12MQpIMVFUdIlk4UyPoslOs
         zbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKJUqhZF5ZFTvwMtANSKQusnvw1X0fA7nKg2F8RC/Ms=;
        b=TcOPwfaE2JukoHc9P8HXpGUDZ0F0nhR5dMoSCsAdPvhd6aIeXR4pK8FgXRZn6VJ9sk
         ueU8Wniv1tTLqvHANWPoQ2pgIhz1M0kSJbYk1qwhko5/YOxMIAQ0GipJUOZtm3aPmnTB
         HuUvWq7LuHI+7gJsf2SrNX7Oa6SFdsIcv9mfe3i8jRcwpcG2Cb5WJguUNnkTcMKMXQ2u
         4xr8CMkDtY85dlOuXfrVEnnV8skn4K4BrFsvJJ1783D+qCLAu/biDATFhUfUES2tXmNe
         6ZKjXA3q/Swd+6SI/OwLYQH9aYReDMMwG5PYkeTr/CDo60JniKZpPReTjWdRNVz1uJET
         6/Zg==
X-Gm-Message-State: AOAM531J694Nc4UYQwxvFoVOt5Q20I83XFUV9xTjNBLfo6JcIpeOl9iM
        RElbdXjdVFDzKmBmYiUkVsw=
X-Google-Smtp-Source: ABdhPJxPJz3SZSMyS0anevF9Xao7uDB74dc0E1Dk6qIJ+s4vfldsk+aSk7BmjfUwQjCZLAB2xV2Esw==
X-Received: by 2002:ac2:4e44:: with SMTP id f4mr7401210lfr.458.1636646791483;
        Thu, 11 Nov 2021 08:06:31 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id u23sm311037lji.56.2021.11.11.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 08:06:31 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:06:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        nandhini.srikandan@intel.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
 <YY0zUjjVobtg85o6@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY0zUjjVobtg85o6@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 11, 2021 at 03:14:26PM +0000, Mark Brown wrote:
> On Thu, Nov 11, 2021 at 05:52:46PM +0300, Serge Semin wrote:
> > On Thu, Nov 11, 2021 at 02:16:05PM +0000, Mark Brown wrote:
> > > On Thu, Nov 11, 2021 at 02:51:59PM +0800, nandhini.srikandan@intel.com wrote:
> 
> > > > Add support to select the controller mode as master mode by setting
> > > > Bit 31 of CTRLR0 register. This feature is supported for controller
> > > > versions above v1.02.
> 
> > > Clearly older versions of the controller can also run in this mode...
> 
> > Yes, but the driver doesn't support the slave mode at the moment.
> > So always enabling the master mode seems natural. (see my next comment
> > also concerning this matter)
> 

> The commit message makes it sound like master mode is only supported for
> the newer versions.

I meant it doesn't really matter if the bit has been reserved before
and the driver doesn't support the Slave-mode of the controller
anyway.
Regarding the Master-mode feature availability. Originally Wan added
that flag setting for v1.01a here:
https://patchwork.kernel.org/project/spi-devel-general/patch/20200312113129.8198-8-wan.ahmad.zainie.wan.mohamad@intel.com/
Nandhini said in v2 that both Keem Bay and Thunder Bay uses DWC SSI
v1.02a and the BIT[31] functionality is not Intel-specific, but
generic for DWC SSIs.  So version-wise it's either Wan or Nandhini
ware mistaken at some point.

> 
> > > This makes the configuration unconditional, it's not gated by controller
> > > version checks or any kind of quirk any more meaning that if anything
> 
> > We have already discussed this feature in v2:
> > https://patchwork.kernel.org/project/spi-devel-general/patch/20210824085856.12714-3-nandhini.srikandan@intel.com/
> > Since that bit has been reserved before 1.02a but is no available for
> > any DWC SSI controller and the driver doesn't support the SPI-slave mode
> > at the moment I suggested to just always set that flag for the DWC SSI
> > code. Please see my reply to Nandhini here:
> 

> Given that people seem to frequently customise these IPs when
> integrating them I wouldn't trust people not to have added some other
> control into that reserved bit doing some magic stuff that's useful in
> their system.

In that case the corresponding platform code would have needed to have
that peculiarity properly handled and not to use a generic compatibles
like "snps,dwc-ssi-1.01a" or "snps,dw-apb-ssi", which are supposed to
be utilized for the default IP-core configs only. For the sake of the
code simplification I'd stick to setting that flag for each generic
DWC SSI-compatible device. That will be also helpful for DWC SSIs
which for some reason have the slave-mode enabled by default.

Alternatively the driver could read the IP-core version from the
DW_SPI_VERSION register, parse it (since it's in ASCII) and then use
it in the conditional Master mode activation here. But that could have
been a better solution in case if the older IP-cores would have used
that bit for something special, while Nandhini claims it was reserved.
So in this case I would stick with a simpler approach until we get to
face any problem in this matter, especially seeing we already pocking
the reserved bits of the CTRL0 register in this driver in the
spi_hw_init() method when it comes to the DFS field width detection.

-Sergey

