Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3504539EE
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhKPTSs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 14:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhKPTSp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 14:18:45 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAAC061570;
        Tue, 16 Nov 2021 11:15:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u3so291210lfl.2;
        Tue, 16 Nov 2021 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iJ4UbTyx0xYSrKsT+KZw01D3yr4wr+sTORIlc74dG70=;
        b=ja1oJQhqa5HUt1YVG8UHgCiHcm4d5EFjjWyeL7uQgxXe1YDxtRqhZH6QKja9YG2Eym
         CysYq8oh1qOI1rDy7F7m9qxFN+1Xkzg4/lqwk44bm2X4uzoLScRiaQhSNV8e4THA8Q26
         j4usJhgmSAc6/agSiN4nQxWCGWX6+jditUjlJ26O1mcomHTRysG63avm5wYsKTlI/UtU
         jt/3vFFEf2KVxLR5MMU+4lGHbGAtFVwUI0cQ0wraZkEIckzg4EXxuP3N0fJGB1ri2FmU
         dZqCLJZPPxrxNkHFs3RheiR/5Zoxfu/9Zzye6sz5bUmFDRfNsSvW4H1QyVEfNCHmAGMQ
         JWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJ4UbTyx0xYSrKsT+KZw01D3yr4wr+sTORIlc74dG70=;
        b=NGkpoI5qtf6R4lXiM9H1MUfNTalKiTcjtG/qpbwAVJnZmj6EZMoUGZcAyXESQUwS3K
         AWShdOxWgo9NBsamTEtIQ4f9hxSmAz7ICE+yuTVM8ZkzE1bc/UuYSwhDNXwe+dAi3T/k
         HQQTwXU12wCBsYhPSWtifU2BDbokqOHzwxT9QgQy+X/9EGp064sFJSx81Mvb/zAaKG9u
         rutieRpdezrkdEIvTyj2hWyQnvNN43eUx2omNQ+Ss6YpAdY+6Yg8uwUbWNNWHZgWdOgw
         JYwDz14rqDH5HrT0Olf/er+9MA12i1H1fEKfvMMquEGBPzuna1CnLCbKNzpFyWETaYPP
         U8nA==
X-Gm-Message-State: AOAM532I5SPwUEhnewt93nxY6UFLv7I7fQ3IiudsKM6xRDVrXxiplF7z
        jHTr7XRjM6yjvtjSqAs7YjHsJ3PlCymiaw==
X-Google-Smtp-Source: ABdhPJxa5RKZ5XwYDB5GwzjUJhlvOMfUgZb5AjfmGpIEAgIILxJAfOIDxpYXKsecBXtc0Aq7HGp9LA==
X-Received: by 2002:a05:6512:1382:: with SMTP id p2mr1943501lfa.403.1637090145862;
        Tue, 16 Nov 2021 11:15:45 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id q6sm1928399ljh.1.2021.11.16.11.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:15:45 -0800 (PST)
Date:   Tue, 16 Nov 2021 22:15:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>, nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <20211116191542.vc42cxvflzn66ien@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
 <YY0zUjjVobtg85o6@sirena.org.uk>
 <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
 <YY1D3tM4fg8h6mmj@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY1D3tM4fg8h6mmj@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 11, 2021 at 04:25:02PM +0000, Mark Brown wrote:
> On Thu, Nov 11, 2021 at 07:06:27PM +0300, Serge Semin wrote:
> > On Thu, Nov 11, 2021 at 03:14:26PM +0000, Mark Brown wrote:
> 
> > > Given that people seem to frequently customise these IPs when
> > > integrating them I wouldn't trust people not to have added some other
> > > control into that reserved bit doing some magic stuff that's useful in
> > > their system.
> 
> > In that case the corresponding platform code would have needed to have
> > that peculiarity properly handled and not to use a generic compatibles
> > like "snps,dwc-ssi-1.01a" or "snps,dw-apb-ssi", which are supposed to
> > be utilized for the default IP-core configs only. For the sake of the
> > code simplification I'd stick to setting that flag for each generic
> > DWC SSI-compatible device. That will be also helpful for DWC SSIs
> > which for some reason have the slave-mode enabled by default.
> 

> That's easier right up until the point where it explodes - I'd prefer to
> be more conservative here.  Fixing things up after the fact gets painful
> when people end up only finding the bug in released kernels, especially
> if it's distro end users or similar rather than developers.

Since IP-core and components versions is now supported that will easy
to implement. Thanks for merging the corresponding series in BTW.

> 
> > Alternatively the driver could read the IP-core version from the
> > DW_SPI_VERSION register, parse it (since it's in ASCII) and then use
> > it in the conditional Master mode activation here. But that could have
> > been a better solution in case if the older IP-cores would have used
> > that bit for something special, while Nandhini claims it was reserved.
> > So in this case I would stick with a simpler approach until we get to
> > face any problem in this matter, especially seeing we already pocking
> > the reserved bits of the CTRL0 register in this driver in the
> > spi_hw_init() method when it comes to the DFS field width detection.
> 
> If the device has a version register checking that seems ideal - the
> infrastructure will most likely be useful in future anyway.  A bit of a
> shame that it's an ASCII string though.

That's what the patchset has been implemented for in the first place
https://lore.kernel.org/linux-spi/20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru/

Nandhini, Mark has just merged in the series that adds the IP-core
versions infrastructure support to the DW SSI driver.  So now you can
easily convert this patch to be using that new interface like this:
-               if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-                       cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+               /* CTRLR0[31] MST */
+		if (dw_spi_ver_is_ge(dws, HSSI, 102A))
+       	        cr0 |= DWC_HSSI_CTRLR0_MST;

Please don't forget to convert the DWC_SSI_CTRLR0_KEEMBAY_MST name to
something like DWC_HSSI_CTRLR0_MST and place it at the top of the DWC
HSSI CTRLR0 register macros list.

-Sergey

