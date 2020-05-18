Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B001D79A4
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgERNWP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 09:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgERNWP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 09:22:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B892C061A0C;
        Mon, 18 May 2020 06:22:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so4227869plr.0;
        Mon, 18 May 2020 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JqlTBOeFxsYXY8yGPgTaYilQ1ARPOh44vrjZNdkGyE=;
        b=HszmquuAQ6p2kVYYydKaErfRawcJaiRS/7CbxuLC9KhmSnKtCqI4+G6vWNB4rgUfFh
         aZ4VVrQKqwlOO7VBS6OcpnkTtp5dr0WvO+zaTbzgOh2OJZ4mFvIK9nh7yaS0eLQqBvEy
         4JVyfAZTY8iDycXtAS/+2DGDMOApCrtXCh6tWcduRRy7YZ2sC1i2pb710vwLyYUIBUUQ
         2tboclUUdVPR8YKqMcfDvt4FNYyNxrlofjhUe0WBT7nA6UxhdXhOQNbWrve8yFwQt/EX
         mQPFEPm0UHqYhoJ+4DX5F/V4outXYRxdT1+lsmsP16S8SaFo+tMmQWPxIOC+3fx3jJX0
         TUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JqlTBOeFxsYXY8yGPgTaYilQ1ARPOh44vrjZNdkGyE=;
        b=VfxQVgjAqxbBRNvgYUauj7X1LCN2bWE55F4Hyj2GYkKpqrNzNi8Lu2WI12kurv83CR
         BRiIxvp+oF/6CeT2WpdJb8S2YfqYfXARCxGulNkKR/BAp0wbRHeWZqrJ1Q2cgUgMkwiq
         xYP8ptsdb1cPfpP2yUQuIcB2ZESfTMwzLpAcxiKeFQSCF92s1XfjPWO/WdM0iK3LrpHN
         BKlzUusRGRkNXOPDQzWM1923YKo9Dbrjfhgeql3GF7giYRJCwa4JD8167JsPyvVC3SGB
         a7W8nNZWk2J68MqzEmwjA7NvfhPAGlCKZbbZDvTeLE3AqtQGDBzv31JigR55eszUKo+2
         VOrw==
X-Gm-Message-State: AOAM533/bsdGcJTEMtTt0MP4au1YWdSRG34B2ycVIrGkewc9usALUPU8
        iuKsJ1seAvP67nyZcwaeSGOTKuo6psTyOzSVFVk=
X-Google-Smtp-Source: ABdhPJyQuof7a7R82aHDECbaNCZA+hGhIGZx2TejPySxbPfh5Al8aPTl9+HdTVytT7Yz0G/ynv4siiDFJUHd2c5xzPU=
X-Received: by 2002:a17:902:930c:: with SMTP id bc12mr16440827plb.255.1589808134848;
 Mon, 18 May 2020 06:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru> <20200515104758.6934-7-Sergey.Semin@baikalelectronics.ru>
 <20200515123422.GZ185537@smile.fi.intel.com> <20200516142030.kburieaxjg4n7c42@mobilestation>
 <20200518110004.GW1634618@smile.fi.intel.com> <CAHp75Vf268nfwJ4Bm+A+-CsqjBSHgKVmiiON=ffUd79DCOcE8Q@mail.gmail.com>
 <20200518123242.xoosc4pcj7heo4he@mobilestation>
In-Reply-To: <20200518123242.xoosc4pcj7heo4he@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 16:22:03 +0300
Message-ID: <CAHp75Vd3RUYw45i+TZ+R1wJquYJvjR+P3-qWe=v+QBk46C_zRQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] spi: dw: Discard static DW DMA slave structures
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 3:32 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Mon, May 18, 2020 at 02:38:13PM +0300, Andy Shevchenko wrote:
> > On Mon, May 18, 2020 at 2:01 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, May 16, 2020 at 05:20:30PM +0300, Serge Semin wrote:

...

> > > I'm not talking about stack, it's fine for me, what I'm talking about is *how*
> > > they are being initialized. Read my message again carefully, please.
> >
> > And to avoid additional churn around this, the purpose is to show what
> > Dreq number is in use actually for these transfers (that's why 0
> > assignment is explicitly there and no counterpart Dreq filled).
>
> Sorry, but nothing persuasive so far. We still can remove their static definition
> and explicitly assign zero or one to the src and dst request IDs on stack. I'll do
> this in v3, since I have to send one anyway.

Right, I'm completely fine with it, thanks!

-- 
With Best Regards,
Andy Shevchenko
