Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1941CFF56
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgELUfW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728882AbgELUfW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:35:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D3C061A0C;
        Tue, 12 May 2020 13:35:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b8so6696767pgi.11;
        Tue, 12 May 2020 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVFW6oIEuEyDeRl3Bg5H2zPOgggIm8lzWUpr4cAUXc0=;
        b=PptOoIXpSNuFOhmHbdDkbkZyYo24SjYpZtgRf1eSccsXirEvsAvaVHBe5PebjyD+i6
         ar7qmlFWqvhCtpiDskWezNkG9ip5bzSTdEW8V89Fn7sVEqtasX8OsWbDEPp28HCO4p13
         XGD/UNskTpsPq5/jrdPV+QBNUAS4NZTfU3arve44f+h2YHCVHuOuwfHjl38bi6nbTDZZ
         GoFzPRcCoGGun6jLZhXJ/4K9d8flLKu8E3wINm7DT2Cc8nwA9WJyyxzW1Vyc203nacpK
         murxAbJ5Ijr7WpyaP6bIbzIBzl7UsbdlsVgol0WPQwmxVdK7hOzPyRDW5eggFpG1sFGe
         ti2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVFW6oIEuEyDeRl3Bg5H2zPOgggIm8lzWUpr4cAUXc0=;
        b=LjnWOLpY9ANHWepxXo3l8gkxJpD4yJYoGm4hS8dlhxoxHeLEZL9UrM4pSV5imRH0gn
         vOoCNUWEWK6mz00jIORvkV9921uSnG/ORjvrkPLXcVwUEsiq/4LeaUccExr8Kkp1U9P0
         GwXQa/KO0TPeIHtYdDmmXcC9va1vwzystGRl72P4MohOrSVQ0Cw2eBRQ/YnBFSSTwebq
         zInf8geOb9h2iHUfs5l2Nl5xKY7SgMU7qGU7LTH3j/tBWLQaU7YmBkznxwVDDf1THpMx
         /2laXZ++AxeHrrmZ8+9x7euRjjoQPlGYxyEI5Ycs6IpaykEYP76ZGWcyv8Mh8r9dYZBH
         dWqw==
X-Gm-Message-State: AGi0PuYg588xU1sXis7KbEpbB/UTknLdGBiKsv1X9GUKf9kpJpx2bmy/
        XSun4wvXFbxfEg6X6kumb9l5PyCTVQ8wUrw6aHY=
X-Google-Smtp-Source: APiQypJTLDvBe0FVtK0RKin5GJBBZUcW1n4ZDU2eps4uS029pWA8iLJCh5A9HjKGnTF4TEbKdT0ener6wvLDJk7Zn0E=
X-Received: by 2002:a65:6251:: with SMTP id q17mr20697891pgv.4.1589315721498;
 Tue, 12 May 2020 13:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-2-Sergey.Semin@baikalelectronics.ru> <20200508193934.GY185537@smile.fi.intel.com>
 <20200512202814.e6havutfpzu2gdfc@mobilestation>
In-Reply-To: <20200512202814.e6havutfpzu2gdfc@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 May 2020 23:35:08 +0300
Message-ID: <CAHp75VfUzx6F8QinUZf6P76ne_uG1mVitMaMZc2WREMspOAyZA@mail.gmail.com>
Subject: Re: [PATCH 01/17] dt-bindings: spi: Convert DW SPI binding to DT schema
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-mips@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 12, 2020 at 11:29 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> +Cc: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
>
> On Fri, May 08, 2020 at 10:39:34PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 04:29:26PM +0300, Serge Semin wrote:
> > > Modern device tree bindings are supposed to be created as YAML-files
> > > in accordance with dt-schema. This commit replaces two DW SPI legacy
> > > bare text bindings with YAML file. As before the bindings file states
> > > that the corresponding dts node is supposed to be compatible either
> > > with generic DW APB SSI controller or with Microsemi/Amazon/Renesas
> > > vendors-specific controllers, to have registers, interrupts and clocks
> > > properties. Though in case of Microsemi version of the controller
> > > there must be two registers resources specified. Properties like
> > > clock-names, reg-io-width, cs-gpio, num-cs and SPI-specific sub-nodes
> > > are optional.
> >
> > Can you incorporate work done here or agree with Wan how to proceed?
> >
> > https://lore.kernel.org/linux-spi/20200505191910.GA2970@bogus/T/#md626b5f6f2294b0ebd70995d5ed0e67a360e000b
>
> Don't worry. I'll make sure the updates provided by Wan including the new IP
> support are preserved after rebasing this series on top of the spi/for-next.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
