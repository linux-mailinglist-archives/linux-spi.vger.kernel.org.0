Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5124E7C5
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgHVOHa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Aug 2020 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHVOH3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 10:07:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C4C061573
        for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2020 07:07:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b2so3932160edw.5
        for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2020 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=Zfgk8dyvwVv5/BR9Ue01YxFjydKGHjpfZPQCE6N5dCY=;
        b=j22PzrSXJp7S9KTi4ai9+3RJnFl3jhWm5OLVtMbJt84BPAMXR7zE+e7KtUoQcIHuo/
         rok6cCAq/8Fcvjo3T0USmhKgJQ2JMM0AbuXuu0TDNn5GknrmE/fO0WuVSL3o7LCwfwbw
         sXQjsu2oHLRCGPscTa+rewdcWlLSZVAo72qXeIWCMAR+WAne2IAPmiWI6Henwq2kTKSY
         Qx33SS6iDCE08N2sAR8wzvTikBmNDMC2VSyC2W+SSC6ZnqtfLsYPCgf7EzSJmOXwOVsn
         jxj1TXwD7saodxUJyXPE8ivHjFNbzPZJ7jt+se0lU/72N+15nmKEnxXTA6NXvI5CyQxv
         Iv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=Zfgk8dyvwVv5/BR9Ue01YxFjydKGHjpfZPQCE6N5dCY=;
        b=cSWpDjENn9kw7qPHxzhP4gmRobDMenzE3AkySqupwQ8gO4+PkE+TgpUDrLDI8VS7GT
         Dk/zQdBUqyJPkNapbIn+LvgoNYRyNECYEGGzKZw0SX54f29dvO45DD+WhOjaEgyjbOPP
         JzdQNajYQ6f5apejTM4XNQwfdSxxMrRxhKGMT4BiNpqjKDpTngDO9S2i3xX8BjAcTR8E
         kqr0WYWUDWAYxqT4/uhkWxeiwkIVQ9osUDfbolWhPBDkQUUy1wCaLjl3yxMbD0O1KFQW
         0fNn1uhdJLgYnF0HXa2gjW0RfniCNbFoICOusChCbnHUatdljgafKQSPGWGOKlG9KVO8
         aoMA==
X-Gm-Message-State: AOAM533vVM76kt1C8ly3yd7slwUc6WWSYBG3FNM/k/Iszd77wcqEEd7/
        //wTDdXrWqvPgIACPBenSO88JntfEYkWM61+wGzk9Q==
X-Google-Smtp-Source: ABdhPJxQ0ysFnTuqs9rgaiQ8b/3EFOcOhfeR7EJ3S37mninIiktIStaqJRUNfY9yq9MPVRaLzvh+IMG+UFtQxxDqzhk=
X-Received: by 2002:a05:6402:1d17:: with SMTP id dg23mr7429245edb.198.1598105246846;
 Sat, 22 Aug 2020 07:07:26 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com> <20200821140718.GH4870@sirena.org.uk>
In-Reply-To: <20200821140718.GH4870@sirena.org.uk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF7/ycK6cTpjLXBKD+ruXNZEs6GEAE4wSq+qe9WNoA=
Date:   Sat, 22 Aug 2020 19:37:25 +0530
Message-ID: <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
Subject: RE: [PATCH] spi: spi-fsl-dspi: Add ACPI support
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, August 21, 2020 7:37 PM
> To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Qiang Zhao
> <qiang.zhao@nxp.com>; Pankaj Bansal <pankaj.bansal@nxp.com>; Varun Sethi
> <V.Sethi@nxp.com>; tanveer <tanveer.alam@puresoftware.com>
> Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
>
> On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:
>
> > +static const struct acpi_device_id fsl_dspi_acpi_ids[] = {
> > +	{ "NXP0005", .driver_data =
(kernel_ulong_t)&devtype_data[LS2085A], },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fsl_dspi_acpi_ids);
>
> Does NXP know about this ID assignment from their namespace?  ACPI IDs
should
> be namespaced by whoever's assigning the ID to avoid collisions.
Yes, I got HID from NXP only.
>
> > -		ret = of_property_read_u32(np, "spi-num-chipselects",
&cs_num);
> > +		if (is_acpi_node(pdev->dev.fwnode))
> > +			ret = device_property_read_u32(&pdev->dev,
> > +					"spi-num-chipselects", &cs_num);
> > +		else
> > +			ret = of_property_read_u32(np,
> > +					"spi-num-chipselects", &cs_num);
>
> The whole point with the device property API is that it works with both
DT and ACPI
> without needing separate parsing, though in this case I'm wondering why
we'd
> need to specify this in an ACPI system at all?
Understood. Will take care in v2 PATCH
>
> > -		of_property_read_u32(np, "bus-num", &bus_num);
> > +		if (is_acpi_node(pdev->dev.fwnode)) {
> > +			ret = device_property_read_u32(&pdev->dev,
> > +							"bus-num",
&bus_num);
>
> This is a bad idea for DT and I can't understand why you'd carry it over
for ACPI -
> why would an ACPI system ever care about this?  It's Linux internal at
the best of
> times.
Will take care in v2 PATCH
>
> It looks like you've done this by simply adding these device property
alternatives
> for every DT property.  This isn't how that API is intended to be used
and suggests
> that this isn't a thought through, idiomatic ACPI binding.  I'd suggest
looking at the
> Synquacer driver for an example of how this would normally be done, I'd
expect
> your ACPI code to look very much like theirs.
