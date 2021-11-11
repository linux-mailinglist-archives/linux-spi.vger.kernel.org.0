Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994FB44D8A1
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhKKOzk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhKKOzk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 09:55:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFAC061766;
        Thu, 11 Nov 2021 06:52:50 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h11so12487026ljk.1;
        Thu, 11 Nov 2021 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8A7hURGRK27cExB7JA3d0U7r7U3aVexHtqO36HqGG9I=;
        b=cld9pHE9I3y0XFBMaSeIu8abMfVMmti6/tE8JjUkGWw92zjXZjEXRxyJpW/aSo70RO
         BcvCLwhP1je724JwxU2mSeGh1uP445lRQhbY9riFt2JFHKLyqJNYdpIWfZiNGeY1rbgw
         QfnJ/wMAW199ncO2+S8oaYgEbx7Fqd/xJZRzB178Omvd/HKj5ECMStN5P2//k2niL39G
         40VzQL5jHmWR5+eS9lSwb9zGlpyF8vF7evDwjPdjgkMg4Yynbt9M4WHnsP29om3qf1zS
         wJWK2KSFsNft0AAEiQLdQR5/onl+yAGbuq45f9H1jZ0IYeUDo/Kn+JcqU4pNyD7iSoeS
         wtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8A7hURGRK27cExB7JA3d0U7r7U3aVexHtqO36HqGG9I=;
        b=dr7NdZOISZFELbSVfDP7LSrwkZJMRYIaNdQp3uAU/vlwzhiIabgt5Dk4Aslgls2MSe
         AZel6zMRJDS3euoXnVd4HOztXHCKVzDNn8SBxfBjWQIY5OkUu22Pqfr3XHOtgkQmc3S5
         B2xEX8H71BdB0e5fXx9vj01H84PSmFXNj5D2uwt0fsbSzKGQHVkS7L39xrKVA8bsFF2v
         UY55FX4VmQTsH7FdmgRxR1A3R5OYViR8wOT1WT23jFI2lDi8pqntHnZ9klqbvUeKbOY1
         zcT8+GR58Fao+iPbo1gWHrMmYA8t9CGOy9+VuUcJLaWNvh+j0HId/pFdzpu9ZFPYHn5K
         4ftw==
X-Gm-Message-State: AOAM5306aB5TKOUpi/fayWm5Gb3gPgJfrpMjRLjR81F8DhBu4k/Ytt7b
        xfeFmy/oHUzlL6TmuxtHzmU=
X-Google-Smtp-Source: ABdhPJzTU0BqBSsZ7ne4RJyZ92AjdR7Y8f2NrJ2uLoNVETVKBLVcUHV+kRaA+7zD4MWqm8GxgvubjQ==
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr7734881ljf.54.1636642369080;
        Thu, 11 Nov 2021 06:52:49 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id l19sm320244lji.27.2021.11.11.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:52:48 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:52:46 +0300
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
Message-ID: <20211111145246.dj4gogl4rlbem6qc@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY0lpZkIsJih+g2o@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

On Thu, Nov 11, 2021 at 02:16:05PM +0000, Mark Brown wrote:
> On Thu, Nov 11, 2021 at 02:51:59PM +0800, nandhini.srikandan@intel.com wrote:
> 
> > Add support to select the controller mode as master mode by setting
> > Bit 31 of CTRLR0 register. This feature is supported for controller
> > versions above v1.02.
> 

> Clearly older versions of the controller can also run in this mode...

Yes, but the driver doesn't support the slave mode at the moment.
So always enabling the master mode seems natural. (see my next comment
also concerning this matter)

> 
> > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > -			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
> > +		/* CTRLR0[31] MST */
> > +		cr0 |= DWC_SSI_CTRLR0_MST;
> 

> This makes the configuration unconditional, it's not gated by controller
> version checks or any kind of quirk any more meaning that if anything
> interprets that bit differently things might break.  If this is really
> required to put the controller in master mode it seems that either the
> 1.02 version is not widespread or this is generally the hardware
> default.

We have already discussed this feature in v2:
https://patchwork.kernel.org/project/spi-devel-general/patch/20210824085856.12714-3-nandhini.srikandan@intel.com/
Since that bit has been reserved before 1.02a but is no available for
any DWC SSI controller and the driver doesn't support the SPI-slave mode
at the moment I suggested to just always set that flag for the DWC SSI
code. Please see my reply to Nandhini here:
https://patchwork.kernel.org/project/spi-devel-general/patch/20210824085856.12714-3-nandhini.srikandan@intel.com/#24433679

-Sergey

