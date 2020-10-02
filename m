Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC28281AD2
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgJBS02 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBS02 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 14:26:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954DC0613D0;
        Fri,  2 Oct 2020 11:26:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so1836683pfn.8;
        Fri, 02 Oct 2020 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5Qu6kzc0je40aaylKFGhBE9ciufdx4NIevmkc9acUs=;
        b=Tgi5SHCg/upuurb/lAne5p59ZmYBXbGkZrnD9nJUdEIrD7OZSyzTCqngsfiKJu2sHr
         FoLsZSl9IFrgi+GOBRbgsCmkYgHr+9OgqzDiBKryD6fTq4yOuxPLGTlcZ1b+JSDX2J+f
         vYzryLHFgFIP6qz/g8gESYYx+vFoyPhWWPikK1noKuU9X+pVyeRWLCnkTrne+pX3E27R
         uSjy2jMthdKMKRCbD1JV9ZM67qL1Qzq80Tt2Wr1MaPf8yr0/qlsownO6FhFLeiIsxHk8
         513FPuVOjA7M8E+ssC5N3RVAp8W+EpAxn78zrdi1feNB9EcJ/Kk6wMJNFuyAgV4cxzzs
         TXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5Qu6kzc0je40aaylKFGhBE9ciufdx4NIevmkc9acUs=;
        b=dGXpMOV1Kk4h9eEBvymjmv0lvloxZcZt/8xg3bYf5Yr6o2LQwf2tqr+riOaf8XpvsU
         njDSidZPCplmF3SZazEFpFMSkP9irS4vZeYG51X5avJzi+hM6UWjG/DMzx5nza6n0PoD
         9cEdYxGEvKmBDHdte4d3L2kSeUNfKAPPIINfmUONZ1bJjdkSKu8Kb+VXgSLHmuN/hBni
         KdCK6Bs92rYUsFMERYQBDyVhCzPQAbDfpbky2SMu42oKPR3OIBj1Ldm1Hl5H5lU+t3UE
         77ktjv742S7ko3T3n22GJEo2oMN95UPQs44BoTAIXpMzTDwlONGCVBgX980CxzfF5i3Y
         YspQ==
X-Gm-Message-State: AOAM533KsZ9Vjh3ho6YUqqqrGoh18v31LqrqPrlL5PQ3xC6+XlkbpWze
        vNPDrfsiDmXpmzK0yWTjc7RsEcJ/lEbOJbeDBgY=
X-Google-Smtp-Source: ABdhPJxRTvYT6J27OfbxGIa5JmCB724t70AGaA3QY65X4EmlQ646FARhwItE8mlr4ap0Uo4eIhGZuP8fCH9x110jG3o=
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id
 1-20020aa792010000b029013ed13da10cmr3952944pfo.40.1601663186163; Fri, 02 Oct
 2020 11:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-3-Sergey.Semin@baikalelectronics.ru>
 <20201002101929.GW3956970@smile.fi.intel.com> <20201002171849.jhio6nz6r6jigrf3@mobilestation>
In-Reply-To: <20201002171849.jhio6nz6r6jigrf3@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Oct 2020 21:26:07 +0300
Message-ID: <CAHp75Vd7KS+sGT=1aZLJXzQi+L3wZ1430dj1TmE=u3PUHoDz7Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/21] spi: dw: Add DWC SSI capability
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 2, 2020 at 8:18 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Fri, Oct 02, 2020 at 01:19:29PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2020 at 01:28:10AM +0300, Serge Semin wrote:
> > > Currently DWC SSI core is supported by means of setting up the
> > > core-specific update_cr0() callback. It isn't suitable for multiple
> > > reasons. First of all having exported several methods doing the same thing
> > > but for different chips makes the code harder to maintain. Secondly the
> > > spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets
> > > the private data callback with one of them so to be called by the core
> > > driver again. That makes the code logic too complicated. Thirdly using
> > > callbacks for just updating the CR0 register is problematic, since in case
> > > if the register needed to be updated from different parts of the code,
> > > we'd have to create another callback (for instance the SPI device-specific
> > > parameters don't need to be calculated each time the SPI transfer is
> > > submitted, so it's better to pre-calculate the CR0 data at the SPI-device
> > > setup stage).
> > >
> > > So keeping all the above in mind let's discard the update_cr0() callbacks,
> > > define a generic and static dw_spi_update_cr0() method and create the
> > > DW_SPI_CAP_DWC_SSI capability, which when enabled would activate the
> > > alternative CR0 register layout.
> > >
> > > While at it add the comments to the code path of the normal DW APB SSI
> > > controller setup to make the dw_spi_update_cr0() method looking coherent.
> >
>
> > What the point to increase indentation level and produce additional churn?
> > Can't you simply leave functions, unexport them, and call in one conditional of
> > whatever new function is called?
>
> I forgot to mention that in the commit log, there is another reason why it's
> better to create a generic dw_spi_update_cr0() instead of doing what you suggest.
> As it will be seen from the following up patches, the dw_spi_update_cr0() function
> (to be more precise it's successor, but anyway) will be used from the SPI memory
> ops implementation. So if-else-ing here and there isn't a good idea for
> maintainability. For the same reason of the maintainability it's better to have a
> generic method which reflects all the config peculiarities, so in case of any
> changes they would be not be forgotten to be introduced for both DWC SSI and DW
> APB SSI parts of the setup procedures. As I see it that overbeats the additional
> indentation level drawback.

What I meant is to leave functions as is and call them under conditional

if ()
 call one
else
 call another


-- 
With Best Regards,
Andy Shevchenko
