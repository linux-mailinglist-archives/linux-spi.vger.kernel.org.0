Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CBA281ACF
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgJBSZQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJBSZQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 14:25:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D88C0613D0;
        Fri,  2 Oct 2020 11:25:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so1824013pfp.11;
        Fri, 02 Oct 2020 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbpVtDGCEyDNfEPlp0W69stECiimKW/FhnrQFUDEppM=;
        b=AqIYwn3miaGQ+Jkk+hYVeI9yKUay3vDZjhZA4ulKLQoPNNydR+JBlxLBBK/inx9R/C
         LtRKWB5OG4Ur5g9Qe2Bzn6Q1QkBWFtPSjFyTsbZ9GHP67V9T06ZxgdR43b8f3BCAyGhv
         rpoUGSUlUhM2UEmJJ5jNMBjTmWJbAD7ic3Xu2JphmeNUuCDD/Bidv0AIdRhx4xy8JwzC
         RjJtj8PQ9lPv/fOwREiMISXPcRt8o5NDN5RQysIU4Z5N8lVSXI4+IAbZdnbfLYF4OR2t
         c8kcDPiyeO01LwzqMz95QIJLETRrUc+1MxvjTfQYgZIiIpKTEufkbHs/9t68jhP7vpdD
         DgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbpVtDGCEyDNfEPlp0W69stECiimKW/FhnrQFUDEppM=;
        b=W6fSobVM/YmQx+j3HbzcAh4MlWFJEnH5XDYCSyrdMoXo3lQmHV29mok/rZgmD6E+1N
         hLHVMM6lci7RjFh++xL5ybATLD9q/qB2LPnRjCLJW0u7o/0a86pzgRI6zhJ0EpZx2ASr
         AVSGKWKyV816IS1+ur7mjWyZT1Ls9PWzzHoTVBRmZQj/75zWaU5BN+beCDzU6pIgQkvw
         nQRv/BWQhtkgo+3+xOHd5Oq80ebP1cRtuKROtNtcQQG7wMlgF5EfyEyaA/ON7A8F51c2
         o4/Fm9cIcCk8bKthvave0R4jYLf4uPDX6LhKhMPPObEQlmhZVblq3ioZI3Bd8m93eYoP
         EhvA==
X-Gm-Message-State: AOAM530VbhVOvuikFsSXI/0vgMeCHc/Qoi4UiwTzpdh+aJbpIfK9AmKu
        eP+7zFIIDRUi9yaCLtG9STQI+VJYPFb/mF3CSV920eyD4CZ2ng==
X-Google-Smtp-Source: ABdhPJyif/p/Pbn0ODio9g2AdTRUDfuH9fvp71NdIy0MeM6epspjWhKRVrlqdKxrBfcVVAfKiBJtGTR2Bp44KDpbexc=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr3289889pgj.74.1601663114294;
 Fri, 02 Oct 2020 11:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-4-Sergey.Semin@baikalelectronics.ru>
 <20201002102246.GX3956970@smile.fi.intel.com> <20201002174725.rpwdgfo6xzxafqhs@mobilestation>
In-Reply-To: <20201002174725.rpwdgfo6xzxafqhs@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Oct 2020 21:24:55 +0300
Message-ID: <CAHp75VeO9NGAU_zH99wqS9F9mXANNWaep=j_Pi6YAz_hsCxR2g@mail.gmail.com>
Subject: Re: [PATCH v3 03/21] spi: dw: Detach SPI device specific CR0 config method
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

On Fri, Oct 2, 2020 at 8:47 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Fri, Oct 02, 2020 at 01:22:46PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2020 at 01:28:11AM +0300, Serge Semin wrote:

> > > +   /*
> > > +    * Update CR0 data each time the setup callback is invoked since
> > > +    * the device parameters could have been changed, for instance, by
> > > +    * the MMC SPI driver or something else.
> > > +    */
> > > +   chip->cr0 = dw_spi_get_cr0(dws, spi);
> >
>
> > I would rather name it prepare or alike. 'get' assumes getting value or
> > something like that.
>
> This seems reasonable. What verb do you think would be better: prepare,
> calc, assemble, construct, make, compute, collect, compose, form, compile, etc ?
> Personally prepare or calc or assemble are the best candidates. What do you
> think?

prepare is good enough if you agree on it.


-- 
With Best Regards,
Andy Shevchenko
