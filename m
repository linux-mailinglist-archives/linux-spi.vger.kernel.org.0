Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E752345A191
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 12:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhKWLjA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 06:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbhKWLjA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Nov 2021 06:39:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8402C061574
        for <linux-spi@vger.kernel.org>; Tue, 23 Nov 2021 03:35:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2286417wme.4
        for <linux-spi@vger.kernel.org>; Tue, 23 Nov 2021 03:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eAAW0gxyL3spMyvFzNZU55TiEHcEGOqrLOJJuSa53K4=;
        b=4DcfipfNqoq+i8lFBnrntKi3GtNw6X6goztOuq6ZWKhQSuytROlnv18WHcqZhYeh7c
         GVU/3OFgl1BHcS7c/eSK80Hd36UAWzHFaJQ7HvRGjxLRLvpehVgy/qTdPSxdV6jRIKiv
         KUBmhXNq4YZ4w4kuOliUyM4YnBMkn32OaZgo2ZnT5yRTOGg+SKtgVsnOrk+YNVJYy4lD
         7TEDEgB7kTo/0ZPFJUO/BGCiAWb/fgXgFHc2FALVFLl/gTQYgATMGes7lqe/uUECmQQU
         R5HUDVzCCKPG4/3yDD7kX7/tYF3JE3XCuXq1TzyesuDP+b2eYPrk/jOyI/1Nqgi6l4DO
         DWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eAAW0gxyL3spMyvFzNZU55TiEHcEGOqrLOJJuSa53K4=;
        b=6GMUjNUKmC2l8kOIzcCwsbfmmkKq5JsszV3o+jFmvCBCI2gq+5AhlYxh/p2pIcRrou
         IRhJttChbakjd69c9jRPOFNBVGIqodckE9dn8e4BbWDyi+PIRBzmzXpwg0tjXKVgtVRr
         pdktZ5yTZCvhzm0OQ5byiGWki3nK5JZhuxmBZe9nYc+lMeVdVaJlUvMweNfqgrZbHVhV
         PFGA8f4scrWb1LEVys2GBOkikKt0nYSoxzqTvIHaoN3Z9kCWIrv9IQJ6w23GJp7ASBHm
         ABGm/VHEDD+AZQg9XX5s52wCOUKqqYzApcrMvmp8CR4HkM5sFjoe9V6WqqtB54IK4fCC
         6qVw==
X-Gm-Message-State: AOAM5306ccdIrdYcyqQJ+CzhYsGR7pn1xjRbM8/El8WErwncEi7yBl3q
        tz0J0gNupE0/MiExaw3Fp+QxUVtjqj3LxUDmdSgd8w==
X-Google-Smtp-Source: ABdhPJyDTgRgvUuV98CyCHfOL5hAURr2qDU4kKqY5aPJ10aLAJMLU+4E45XfCOWPhiTSevTsW28+O1m1n9x86/UMTho=
X-Received: by 2002:a7b:c017:: with SMTP id c23mr2193327wmb.137.1637667350407;
 Tue, 23 Nov 2021 03:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20211108150554.4457-1-conor.dooley@microchip.com>
 <20211108150554.4457-2-conor.dooley@microchip.com> <272946671.hFph3VMliC@diego>
In-Reply-To: <272946671.hFph3VMliC@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 23 Nov 2021 17:05:38 +0530
Message-ID: <CAAhSdy2yr+a7=7Crk7s3pAVbVcYjTdOtRfAaQXBkTVsUpfG20g@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: interrupt-controller: create a header
 for RISC-V interrupts
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        jassisinghbrar@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lewis.hanly@microchip.com, conor.dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Atish Patra <atish.patra@wdc.com>, ivan.griffin@microchip.com,
        linux-gpio@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        krzysztof.kozlowski@canonical.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 23, 2021 at 4:38 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 8. November 2021, 16:05:42 CET schrieb conor.dooley@microchip.=
com:
> > From: Ivan Griffin <ivan.griffin@microchip.com>
> >
> > Provide named identifiers for device tree for RISC-V interrupts.
> >
> > Licensed under GPL and MIT, as this file may be useful to any OS that
> > uses device tree.
> >
> > Signed-off-by: Ivan Griffin <ivan.griffin@microchip.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../interrupt-controller/riscv-hart.h         | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 include/dt-bindings/interrupt-controller/riscv-hart=
.h
> >
> > diff --git a/include/dt-bindings/interrupt-controller/riscv-hart.h b/in=
clude/dt-bindings/interrupt-controller/riscv-hart.h
> > new file mode 100644
> > index 000000000000..e1c32f6090ac
> > --- /dev/null
> > +++ b/include/dt-bindings/interrupt-controller/riscv-hart.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/*
> > + * Copyright (C) 2021 Microchip Technology Inc.  All rights reserved.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_RISCV_HART_H
> > +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_RISCV_HART_H
> > +
> > +#define HART_INT_U_SOFT   0
> > +#define HART_INT_S_SOFT   1
> > +#define HART_INT_M_SOFT   3
> > +#define HART_INT_U_TIMER  4
> > +#define HART_INT_S_TIMER  5
> > +#define HART_INT_M_TIMER  7
> > +#define HART_INT_U_EXT    8
> > +#define HART_INT_S_EXT    9
> > +#define HART_INT_M_EXT    11
>
> (1) From checking clic doc [0] I see an additional
>         12   CLIC software interrupt
> defined.

Local IRQ #12 is for S-mode guest external interrupts as-per
the ratified H-extension specification.

I guess CLIC spec needs to be updated.

Regards,
Anup

>
> (2) The doc states that the ordering is a recommendation and
>         "not mandatory in all incarnations of the CLIC"
> Is that clarified somewhere else that this more than recommended?
>
> Thanks
> Heiko
>
>
> [0] https://github.com/riscv/riscv-fast-interrupt/blob/master/clic.adoc
>
> > +
> > +#endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_RISCV_HART_H */
> >
>
>
>
>
