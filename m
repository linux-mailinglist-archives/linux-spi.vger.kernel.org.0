Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A125392B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHZUlQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 16:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZUlP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 16:41:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D1C061574;
        Wed, 26 Aug 2020 13:41:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id oz20so4706461ejb.5;
        Wed, 26 Aug 2020 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OEHNQBqIQ3j/x1FwJ86oOM9T7cjlrKj+42ssBtV3FXk=;
        b=TECBFGlJdGKHvGXEafJ76TE80s9bCzMPLCkkaVJSbAgl7oEv0TMR3/KYBsV3U3gOGD
         pvOmYSJ0UqLVpejELnLu2igAhl/2HA8QhEcykNDUGysro/vEJKREraYNvMFdpndC28kT
         h8CH2i1zkiNPVTOQuMIG/HsA2M9FwCp1I9TQh+JwKCMsWOYhvP+uW1y+qP5WogxAqLN8
         nuijRkpK3TuUsaat5uu1xRkI1cDeBRy1FWoO5SnZ/XCCHVRq+ETvYKrKjruOtt45j8u5
         svUlHP+lUUywlvNkuJ3NuYZ6zbmdL6Ov4s7L00SsmdcLYi5Jmg8Ei2HkJ7DZ6x3V74WP
         d+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEHNQBqIQ3j/x1FwJ86oOM9T7cjlrKj+42ssBtV3FXk=;
        b=W0kzmGqEj597i8+kkTq/vAbkRsNhz0AOl/onrVOIxpq5ESRaUUOIZJHh5RF/PWVc96
         dcKM6oYgZ0Hdy6H9LMnMw5epcFav7cByyylmQDHG+eArne9VH3W90uXG1ahgkkERRBKM
         EXnx8QAzSqd3601tqGcSWq6HFPIA2tBibLPdQ5oDL2KqjDWhCYJ7g7gEP9RK7l46VMaB
         RtKCCFT8XSsZdBXEtAiffTdQTabgEeViTb6A9eQY6XwevsFhFHZixxI0dgDrP21ky9MF
         Wv5ErlIQD7vv9vAdfkX3POyjlZrgYu0NOdKloVtVgVGUaxD41pCbN1Z8ARRx3u5UmgzP
         YA9A==
X-Gm-Message-State: AOAM531ljccmBvxiqiOEaBhh3CSQPsBMiBbRATdtudJAE7C2zinyrJGV
        1HLYar0d6KsHiA+VIhAhGes=
X-Google-Smtp-Source: ABdhPJwVs4itkESl3B1zyf1XkhvgvyM/LNEElsRIkgnj7DVCwoKKFLi2GJKpDYbDIkYW0ozyirqNBA==
X-Received: by 2002:a17:906:4f11:: with SMTP id t17mr14820025eju.371.1598474471373;
        Wed, 26 Aug 2020 13:41:11 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id i25sm2860688edt.1.2020.08.26.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 13:41:10 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:41:08 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826204108.reuy7ieqabutwuwo@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf>
 <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 10:34:04PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 22, 2020 at 9:37 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:
>
> > Just noticed this now.
> > So for device tree, spi-fsl-dspi supports the following compatibles:
> >
> > fsl,vf610-dspi
> > fsl,ls1021a-v1.0-dspi
> > fsl,ls1012a-dspi
> > fsl,ls1028a-dspi
> > fsl,ls1043a-dspi
> > fsl,ls1046a-dspi
> > fsl,ls2080a-dspi
> > fsl,ls2085a-dspi
> > fsl,lx2160a-dspi
> >
> > Depending on the compatible string, the driver knows whether to use DMA
> > or XSPI mode, and what the FIFO size is.
> >
> > Now, of course not all of the above SoCs are going to support ACPI, but
> > it is reasonable to expect that more than one will. And in that case,
> > the driver should still be able to know on what SoC it's running,
> > because for example LS1043A doesn't support DMA, and LS2085A doesn't
> > support XSPI.
> >
> > How is this dealt with in ACPI?
>
> Theoretically you may declare your HID in the same / similar way as
> PRP0001 and use same compatible strings and all other DT properties
> (when they make sense and not duplicate ACPI functionality).
> But better if ACPI people can tell you (I Cc'ed Rafael and ACPI
> mailing list) if it is gonna work.
>

Something doesn't look right about PRP0001, what's the catch?
