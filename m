Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6132C67C5
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 15:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgK0OWw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 09:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbgK0OWw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 09:22:52 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91BDC0613D1;
        Fri, 27 Nov 2020 06:22:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so4479276pgb.4;
        Fri, 27 Nov 2020 06:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJts5wluJiBEaxB7Ztt7ndMRPjti6kLXkg//zytMNbc=;
        b=rWnXfdMYvvCo4dPYTLeZwozP2G3PeJzqwNOIINXOk2fYFFmKsbqZxN7GJuM4cqs7An
         E94+kJE9azUr18AZpbev1qK8rg4aow0tePKyatJHw56e6SxkyyYqOAAia97h0+aCKCvw
         GQecPXi28Trtogoe7Kwe2yoE6MAO+fircNe+gHNvSqsVwa/lXHKJwG7hcIq4q/x+3YBG
         W/nsTlJlYO7gPi15ifTTz8y8WMFOSDkr35GFuZ7MXo1mGoj19fe522NzVU+fLZ+1B5Cm
         LRGEo3O8dBJLpLKn3O3gW8z2LOX/uZthWQXuDOVY8fd2erwFYLOzV5IOmNoZhlkqkOdx
         fgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJts5wluJiBEaxB7Ztt7ndMRPjti6kLXkg//zytMNbc=;
        b=JyK0KVmTRwnkIz84pgvKMmSuRtYPo7QJ3ZrhSKIHWuUQyz1a5dD3DPyu4wq2LyrXa7
         360zPze5UR/yvoKliSxEzPFEN+5p3hk4M1414mhppDHn/zAAEwkiYrF/RTsbAJmZflrG
         OnfWgVj+kS/UpI9KqlprlcbXHDt2foxjo8wKz7GmL59syS5+FgoxMipz209EWPyTQLB0
         xQw3fCFZQIqy4TedBIA1Jog5Aaan41LsQ0bNzPPZanU6T/mn5iLE+gX82AczIPYHko+t
         vFxFLGOGkqlZMUn5BTGTtpk1iEiblHzcraB4CF4IIF0258JZ+oqM9fvN2QyC54zDQRAW
         L93w==
X-Gm-Message-State: AOAM533KH7c1zboUfYhdnDVzkkHjwuN6J+4/mETJ7Jti3zQmzXZwMqWx
        JCZrJYwyLn9nXB+fae5YUwwVInLXK5SITknor5TaCO2r2MA=
X-Google-Smtp-Source: ABdhPJymB9Dr1Yxeg9S/fXL3MVR0uUvGNDz9wBXLX2MKbj1D/KcWVCpa7CDlbK1CNTlRdyZKTY0fT4N5nqLhCxr/pTY=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr10062134pjf.181.1606486971566;
 Fri, 27 Nov 2020 06:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
 <20201127130834.136348-2-alexandru.ardelean@analog.com> <CAHp75Vcd4t=RqC31S-b1PXMtd=8sypSLhTrSgRD9hbpSqOphoQ@mail.gmail.com>
In-Reply-To: <CAHp75Vcd4t=RqC31S-b1PXMtd=8sypSLhTrSgRD9hbpSqOphoQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Nov 2020 16:23:40 +0200
Message-ID: <CAHp75VctXhpyBVB7Zw+SB5LiGcj6r850x+ehL7u2H0R4=y5rVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 27, 2020 at 4:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 27, 2020 at 3:08 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:

...

> > --- a/include/uapi/linux/spi/spi.h
> > +++ b/include/uapi/linux/spi/spi.h
> > @@ -43,5 +43,7 @@
> >  #define        SPI_TX_OCTAL            0x2000          /* transmit with 8 wires */
> >  #define        SPI_RX_OCTAL            0x4000          /* receive with 8 wires */
> >  #define        SPI_3WIRE_HIZ           0x8000          /* high impedance turnaround */
> > +#define        SPI_NO_TX               0x10000         /* no transmit wire */
> > +#define        SPI_NO_RX               0x20000         /* no receive wire */
>
> Is it really material for uAPI?
> Perhaps we may have something like
> SPI_MODE_USER_MASK in uAPI and
> in internal headers
>
> SPI_MODE_KERNEL_MASK with
> static_assert(_USER_MASK & _KERNEL_MASK); // check conditional
>
> ?

And logically start bits for the kernel from the end (31, 30, ...).

-- 
With Best Regards,
Andy Shevchenko
