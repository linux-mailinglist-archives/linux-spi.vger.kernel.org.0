Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8E2CDE05
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 19:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgLCSu5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLCSu5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 13:50:57 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D20C061A4E;
        Thu,  3 Dec 2020 10:50:17 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b12so1651080pjl.0;
        Thu, 03 Dec 2020 10:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ctpCj7P2N5pzu+fYpWrqNY9UojjAbaSvtU9KocPQxw=;
        b=lzbZQHAeImJ0w49ZMV6seVpjt0BMMh7VykbsywQGdlNL4xOPD0rWhhxg33853scsN3
         o+CO7ucqRf7dMXrqIPqEtcbuvIP9zYScC0YxQk7XoWPzdoCCYJhjzxh8H/kapeY8YOH4
         xbbofxUq/v5RTED/GHzjiQia2Lz7ht7HZPb0gkTB0zRv4jI5Vd38NW/49lptNTgG4Qp8
         Zy9c/WE7b726xJXDo3Kwc1nbXRHljljjmVICo+XsG/AGLxutP2potFcqnBhUxHVmu6JM
         uuUjzu8fp158WDYDAT0WArfrgHcukgRqLBVGFy3fVy2vQilpZfFnU5G3cig2xX8modIb
         zHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ctpCj7P2N5pzu+fYpWrqNY9UojjAbaSvtU9KocPQxw=;
        b=knY77jgna14HFLUsG4whXVaMLeh8Lj1JXhHhw2ywDqbE0O6LuJnnMBnYdrCk79/rq7
         8ZK97Fy63EeUZdU+HWk+3i+E0UkQYB0vdQyL+UIhwZ/u7QGSLZ5KFzkM1CoarhJqY8EY
         eYXZPSCb+vQmeD7+W7LUW9bPx7ajKANsjfGM89TFhEJSK9+EdGe/GwgiAIJ8Lf3sO4g+
         O2zq7rFGGeFb8QIdKERASv9pYKS//JWEEI5dzv4wyesf4JhDA14kp2jZMbGaCjXAvGXm
         n3BtYIydVHeMWXFcopJJhghsWHe1m71gWFL0Z/2ei+9YIXyvRVEu2wcmJ4wlEIOL39bq
         NrmA==
X-Gm-Message-State: AOAM5329+9/ytPPu1Cmh17Q0tCN7kD/rfWQVBHGn1gF+pCVDwx0dK1Qr
        K08D0QyNYdoiCnbwCu8ZSyhC1qAIdriPRZxNYfk=
X-Google-Smtp-Source: ABdhPJw3uaQiAD4jl7qanldOYLTQVY2F1Ew1N2Vl5CpR0dnbn2Mmc2v+Oipvc6q5cQgDJo2YLjaBMX1Tec02DxLqc/c=
X-Received: by 2002:a17:902:ab83:b029:d8:d979:f083 with SMTP id
 f3-20020a170902ab83b02900d8d979f083mr340719plr.84.1607021415167; Thu, 03 Dec
 2020 10:50:15 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgQPDqV1tB6v0sA0imwfZGkoG_j84NZCehOT1pf8MTuCA@mail.gmail.com>
 <20201203175024.hzivclydoxp6txir@skbuf>
In-Reply-To: <20201203175024.hzivclydoxp6txir@skbuf>
From:   Maksim Kiselev <bigunclemax@gmail.com>
Date:   Thu, 3 Dec 2020 21:50:04 +0300
Message-ID: <CALHCpMgmdfScVhWKhhtisZ=-rf0wS8CujDoVWBJ8qkL_OXGu1g@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Kochetkov <fido_max@inbox.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vladimir, thanks for the answer!

I must have missed these. In any case, I would like to add
functionality for using GPIO as CS. Because I have a board which
actually uses this. I'II check your solution and modify my patch.

=D1=87=D1=82, 3 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 20:50, Vladimir Olt=
ean <olteanv@gmail.com>:
>
> Hi Maxim,
>
> On Thu, Dec 03, 2020 at 08:12:19PM +0300, =D0=9C=D0=B0=D0=BA=D1=81=D0=B8=
=D0=BC =D0=9A=D0=B8=D1=81=D0=B5=D0=BB=D1=91=D0=B2 wrote:
> > From: Maxim Kiselev <bigunclemax@gmail.com>
> > Date: Thu, 3 Dec 2020 18:56:12 +0300
> > Subject: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support
> >
> > This patch allows use of GPIO for the chip select.
> > Because dSPI controller can't send transactions without hardware chip
> > selects, so first unused native CS will be set in SPI_PUSHR_CMD_PCS
>
> Are you sure?
>
> From the reference manual:
>
> SPIx_PUSHR bits 10=E2=80=9315 PCS:
> Select which PCS signals are to be asserted for the transfer. Refer to
> the chip-specific SPI information for the number of PCS signals used in
> this chip.
> 0 Negate the PCS[x] signal.
> 1 Assert the PCS[x] signal.
>
> And the definition is:
>
> #define SPI_PUSHR_CMD_PCS(x)            (BIT(x) & GENMASK(5, 0))
>
> Notice the BIT(x).
>
> I expect that you can set the PCS to 0 and no hard chip select will
> assert.
