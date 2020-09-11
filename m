Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66681265F29
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgIKMCq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIKMC2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Sep 2020 08:02:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191EAC0613ED
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2020 05:02:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q13so13413855ejo.9
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2020 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=MB8KR/cuoizxWcYxBx51GB3knSYT3+P7WpQmn9XtoNc=;
        b=BCsdMv/qZu57CnDlGgysC+BzA1p1EgCDicm8DWRwDUMUhQpDR2Rg9NqQWbXGN6WLZd
         8O48ycLGqIlQA/c1IXwmaUSIkPV/4xU2qzadkGdTrQ8RzNavt3YE2CeSY2gUGk9+SPvL
         qGVGVM3x4UBWPSanOTKXqlsOTB3kiwRL5ItGdyIsHHAN0Aips5EhoJohuqZic/kKGbhL
         bEuOfCuQFUH2Pf0k5u2jmgBM18O5G0BGEBIYAB81moyikw1L9GJ1BNWvcl75mibJR+Cj
         MXrp0kepHyZVXjzQK9uzr6VFb/iQ1tt4PrXhDOscYK4ONpbe/SQvsyxbGHIIiW4kj2eE
         kSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=MB8KR/cuoizxWcYxBx51GB3knSYT3+P7WpQmn9XtoNc=;
        b=fEBF1FoSySfNdBtYOpUllRA2VIK3WpHjliG1uSXlLDaZ7DDE4oaCjxM+VwO7d4Yo//
         hMIzkoUmueCs4cBrCSacdmXzRpc0SMPfLg+ydLURDaY6Zl3OB+pMZHZsuBgMhhr9efi/
         h6ISWby1rFGMwCQETLTcI1nRo10xHTHK+RdUUUE9uCO4TiSt2PMtPoLtKKOJc52EMKZO
         uUIg6bjgtSqi1mYKdm9vBHxP7+sMoRoMmTqVRVAtzzeX+TbctLH2qNJCCAGM4NDJyaAB
         4GYzyHv+8Y5fgbvexuHcWyF7HBXjYXwK1/ybBTn4CuB8qKsXNv3OLcERmDh1arD26qHO
         xNGg==
X-Gm-Message-State: AOAM531sBfQnRlMysGpH5APKQmRcehy3DK0+cOuu65dxnO5rykR/cnWe
        BZIjnkVXTCQuVQ2BGygWTJJL8w6dYbty9CweIWsGZQ==
X-Google-Smtp-Source: ABdhPJzsWOdDJHOMjHDQrcC6m+XTKm8emOB/0is3CABIgP+xvTnUtGAWCNKsftUnsw9k4IThb+kSo1/KyqI2UpdtODI=
X-Received: by 2002:a17:906:915:: with SMTP id i21mr1638194ejd.113.1599825745575;
 Fri, 11 Sep 2020 05:02:25 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <20200911110018.GD4895@sirena.org.uk> <9a6ce5d0-2f39-eb55-c3a9-cae2a8093fbc@arm.com>
In-Reply-To: <9a6ce5d0-2f39-eb55-c3a9-cae2a8093fbc@arm.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK/xI2P7uxCBV5mjF/xjkF3M143zQFA0ZONANRlRQCngC+DsA==
Date:   Fri, 11 Sep 2020 17:32:24 +0530
Message-ID: <01f42ace75808be76c78a4a67b78ec06@mail.gmail.com>
Subject: RE: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Ard Biesheuvel <ard.biesheuvel@arm.com>
> Sent: Friday, September 11, 2020 4:46 PM
> To: Mark Brown <broonie@kernel.org>; kuldip dwivedi
> <kuldip.dwivedi@puresoftware.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> <arokia.samy@nxp.com>; Samer El-Haj-Mahmoud <Samer.El-Haj-
> Mahmoud@arm.com>; Paul Yang <Paul.Yang@arm.com>
> Subject: Re: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
>
> On 9/11/20 1:00 PM, Mark Brown wrote:
> > On Fri, Sep 11, 2020 at 01:58:06PM +0530, kuldip dwivedi wrote:
> >
> >>   	/* find the resources - configuration register address space */
> >>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "fspi_base");
> >> +#ifdef CONFIG_ACPI
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0); #endif
> >
> > This is buggy, it is equivalent to just removing the name based lookup
> > since we'll do the name based lookup then unconditionally overwrite
> > the results with an index based lookup.
> >
>
> Also, note that CONFIG_ACPI kernels may still boot in DT mode.
In case of ACPI we need to use indexed based lookup.
For reference Please see , Line :23 and Line:24
https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platfor
ms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/FSPI.asl?h=LX2160_UEFI_
ACPI_EAR3
Here I can think two possible approaches
1. Changes in DT to use indexed based lookup
2. We Can check for ACPI fw node to distinguish between DT and ACPI like
below..
if (is_acpi_node(f->dev->fwnode))
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
else
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
"fspi_base");
Please share your thoughts

Thanks
