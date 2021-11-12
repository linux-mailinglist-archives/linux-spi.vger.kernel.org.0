Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94F44EEBD
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhKLVlR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhKLVlM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 16:41:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE8C06120A;
        Fri, 12 Nov 2021 13:38:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so43119455edd.10;
        Fri, 12 Nov 2021 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZV/3xFxWciiOMgBGBUohTkz1VMYErPDsJ+IhZGr78GA=;
        b=XemI0gYueh58+dbHXxMzNSV7+y5myS2i22WeGcnA/5r0l1GC3UtqlJXWr80sB3TkJq
         zdQ6HUedKz7ixy4nQQuFkGnJuuGL2mD2OFgB3FwwBgUVbBcqqbgvjdA+K35PJegmltwk
         q//9EnRH4P/SL2tUOVlsXjFGHp3yNU500E39PfTUp9xXo9FYTb+y8e/1HF+LvEXt+TQj
         OpgGky6p+7b/79K1h+xErxOSJFDkVU1RUokjS4uslDj1ORKKO+NF7ZJ2IhWJSps6FHl8
         5FIvzJF/5NLxi9+H/rnaI6xCHZYUK7qWOeOf8Buqz+kX+zNCQX6WmkiyKO/Vy5OoV9bK
         jQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZV/3xFxWciiOMgBGBUohTkz1VMYErPDsJ+IhZGr78GA=;
        b=W2DWJXCO1zqQ+M8ms86kiSVsoe+coxeaA0RDhWVEnhYLgyhok+3ksnafjXC1QTlWIp
         TsTya7QhpmOr7rxoGoH8FfuiDDQsjENOVyb2xlRYhPKiKL+x1+AWbe81KEbJDBE3JPfx
         Ws0ZlMXl03meddJhfPf9CnO6azjrHu2cBQIsGwEhsHabXVCB274APLdicmJI/iQ3Mi6x
         fZGQas5csUXlXBJzXzhzyDD3VKYc0LWhcyu/Sj/UfPr6Tkwdj4RvJKwq7kW8A3pbg5VH
         TEZ3VKfEf7cIkAj1bkJB5RRFK6/yOQaTjHnc3Y5CTXMIbbi90t8KbBVRHIHKJ72iA53C
         C0cA==
X-Gm-Message-State: AOAM531QztBVvOKD7xGe+Ery5XeYjEh/s84fGg0qXHR5fASKhSQ3xE0Q
        inHN4rx2kRs0RQpiitl0EgNW65H40mX3Z6RpzqQ=
X-Google-Smtp-Source: ABdhPJwLeJid7MvG7yJVOPBKSZRSXSO9f9WvLgX3nFNSH/1xkAxY/Blo2UGeR3f1hXDqXncemJtT2h1BVKNhwaRQc+A=
X-Received: by 2002:a50:9ec9:: with SMTP id a67mr13162057edf.238.1636753099232;
 Fri, 12 Nov 2021 13:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
 <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru> <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
In-Reply-To: <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Nov 2021 23:37:36 +0200
Message-ID: <CAHp75VcXia53YMyL8uZtHsNRYW9QzrbD9Cy31c4CW8jW-iNitA@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: dw: Add Synopsys Component version reading and parsing
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 11:27 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 12, 2021 at 10:52 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:

> > +       /*
> > +        * Retrieve the Synopsys component version if it hasn't been sp=
ecified
> > +        * by the platform. Note the CoreKit version ID is encoded as a=
 4bytes
> > +        * ASCII string enclosed with '*' symbol.
> > +        */
> > +       if (!dws->ver) {
> > +               u32 comp;
> > +
> > +               comp =3D dw_readl(dws, DW_SPI_VERSION);
> > +               dws->ver =3D (DW_SPI_GET_BYTE(comp, 3) - '0') * 100;
> > +               dws->ver +=3D (DW_SPI_GET_BYTE(comp, 2) - '0') * 10;
> > +               dws->ver +=3D (DW_SPI_GET_BYTE(comp, 1) - '0');
> > +
> > +               dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
> > +                       (dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB=
 ",
> > +                       dws->ver / 100, dws->ver % 100);
>
> Oh l=C3=A0 l=C3=A0, first you multiply then you divide in the same piece =
of code!
> What's wrong with fourcc (and thus keep it in ver filed as is) ? (Also
> we have %p4cc)
>
> > +       }

Have you seen this, btw?

https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250=
_dwlib.c#L93


--=20
With Best Regards,
Andy Shevchenko
