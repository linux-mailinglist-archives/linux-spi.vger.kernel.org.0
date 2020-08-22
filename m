Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F6424E85E
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHVPVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Aug 2020 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHVPVW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 11:21:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FFFC061573;
        Sat, 22 Aug 2020 08:21:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp2so708498ejc.4;
        Sat, 22 Aug 2020 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szdpfOFdpj+kFf5WkuA7LsgAex8jUc7zBWyhuTfgUVk=;
        b=N1LRUrH6TM6gNjGbM6m2WExRtakXnGW/1VWbCJ4AqmXy3mJ17qNaP7HX7xaOHNOOSb
         HBmbtHvao5Ziy+BeaBkqwVemBr94kBWx1V4CMKNRmHAaYtAg6ATkJWBhl6o/z0NPo3TD
         P5ecB1Kb5Yo2/BZrHtF0XI4pYfeJPSnz5md2FTF8ayetuP1QNP/DXkXsvs29IKScoAbQ
         3e2aaRAjyEaMTjcSEIG9uzbd1A8DQ6mu4fTzp4H4V8GjwCTgAooss/WyxlRv7SEPItDo
         nU9Md0LOAMQXU+VWml2LP9EFgFDQjsZCwip7JI6UR2X7+k+BkZrX8HWFzo4HVUQmYcHY
         yNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szdpfOFdpj+kFf5WkuA7LsgAex8jUc7zBWyhuTfgUVk=;
        b=KIjgV6caIGIzP+Eqjb300OsSaoqtrzqT2bg3pPEemuUTZ8tE66xlNdqIHcA+09DwYw
         asp39lYwpM9/wZIHMd9clZ3VmWwitsfUGcFieFcXhbAvu91zNnMMdgR4Faxpsqc6SrST
         UCWeeh8kgV0PL9xH/9rAuWOND9y1v6wkhZZ+jYZLXZD+kfVekCG2r74M0obqSkVtrQP0
         oonna0X2YWXm7UMLoIeRNQ50E4EqkA9ik3o8imumbmZIVydWJPPGlkMqouojJNKB1uWV
         9hxuOr2JgHjjp79lxVIQgsKLDhtozSRkZkA57FtIcNisrSyi34cQe9JJghjz0qAlUjaW
         du+A==
X-Gm-Message-State: AOAM530Fl9s5pnnIeVr4e5kOjQq+7dn2C+7stbDC1eh+UESj/3QhHpXB
        ShQxEg9E1Bv3yZJkiOZghSg=
X-Google-Smtp-Source: ABdhPJz7hYyMaoYoMX3rTd/PbuGqogvjNLBUWmsB+xB6aevCMkEvvGTVC41iNuMISrSYRFyZwLYsLQ==
X-Received: by 2002:a17:906:fcb3:: with SMTP id qw19mr7874020ejb.271.1598109680954;
        Sat, 22 Aug 2020 08:21:20 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id j92sm2383790edc.82.2020.08.22.08.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 08:21:20 -0700 (PDT)
Date:   Sat, 22 Aug 2020 18:21:18 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200822152118.rlwbcgfk4abjldtg@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Aug 22, 2020 at 07:37:25PM +0530, Kuldip Dwivedi wrote:
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Friday, August 21, 2020 7:37 PM
> > To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> > Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Qiang Zhao
> > <qiang.zhao@nxp.com>; Pankaj Bansal <pankaj.bansal@nxp.com>; Varun Sethi
> > <V.Sethi@nxp.com>; tanveer <tanveer.alam@puresoftware.com>
> > Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
> >
> > On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:
> >
> > > +static const struct acpi_device_id fsl_dspi_acpi_ids[] = {
> > > +	{ "NXP0005", .driver_data =
> (kernel_ulong_t)&devtype_data[LS2085A], },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, fsl_dspi_acpi_ids);
> >
> > Does NXP know about this ID assignment from their namespace?  ACPI
> > IDs should be namespaced by whoever's assigning the ID to avoid
> > collisions.
> Yes, I got HID from NXP only.
> >
> > > -		ret = of_property_read_u32(np, "spi-num-chipselects",
> &cs_num);
> > > +		if (is_acpi_node(pdev->dev.fwnode))
> > > +			ret = device_property_read_u32(&pdev->dev,
> > > +					"spi-num-chipselects", &cs_num);
> > > +		else
> > > +			ret = of_property_read_u32(np,
> > > +					"spi-num-chipselects", &cs_num);
> >
> > The whole point with the device property API is that it works with
> > both DT and ACPI without needing separate parsing, though in this
> > case I'm wondering why we'd need to specify this in an ACPI system
> > at all?
> Understood. Will take care in v2 PATCH
> >

IMO there is zero reason for the existence of the "spi-num-chipselects"
property even for DT. We should deprecate it (start ignoring it in
existing device tree deployments) and populate struct
fsl_dspi_devtype_data with that info based on SoC compatible string.

> > > -		of_property_read_u32(np, "bus-num", &bus_num);
> > > +		if (is_acpi_node(pdev->dev.fwnode)) {
> > > +			ret = device_property_read_u32(&pdev->dev,
> > > +							"bus-num",
> &bus_num);
> >
> > This is a bad idea for DT and I can't understand why you'd carry it
> > over for ACPI - why would an ACPI system ever care about this?  It's
> > Linux internal at the best of times.
> Will take care in v2 PATCH

Yes, definitely bloatware from the old days. I think this driver needs
the existing device tree bindings rethought a little bit before
mindlessly porting them to ACPI.

> >
> > It looks like you've done this by simply adding these device
> > property alternatives for every DT property.  This isn't how that
> > API is intended to be used and suggests that this isn't a thought
> > through, idiomatic ACPI binding.  I'd suggest looking at the
> > Synquacer driver for an example of how this would normally be done,
> > I'd expect your ACPI code to look very much like theirs.

Speaking of which, on what SPI peripherals was this tested?
I am not sure how other controllers deal with this, but DSPI has, by
default, no CS-to-SCK and a SCK-to-CS delays. Those must be explicitly
requested through the custom "fsl,spi-cs-sck-delay" and
"fsl,spi-sck-cs-delay" DT bindings for each individual SPI peripheral.
Some peripherals just don't work when the CS-to-SCK and SCK-to-CS delays
are zero, and I don't see the ACPI variant of the driver attempting to
read those properties, hence the question.

Thanks,
-Vladimir
