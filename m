Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B620F2906FE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 16:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406069AbgJPOOE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 10:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395282AbgJPOOD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 10:14:03 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7339321527;
        Fri, 16 Oct 2020 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602857642;
        bh=/Wy1dqxW7oC6Qye976pyOHB3NEyzVajEMIVxWnNoiWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GvfirHosPoQlrZ9dHvK/MiR7ld0pnZ1gIqpgnPDdlppchrxHv71dL73zET/FkkRbX
         tpqynbY8hwuhIjWFSMFkHjBO9r32xo2deIPkDs7E/9OfxpB5pjmz47kNzImHNVhmWP
         Gky4SSBzFgYnYuDePGs3dGZiWfdwrzyOS730N2ug=
Received: by mail-oi1-f180.google.com with SMTP id h10so2597082oie.5;
        Fri, 16 Oct 2020 07:14:02 -0700 (PDT)
X-Gm-Message-State: AOAM5332Zt9j9+/2e3ssCOcDCWxTZ2BFwwWZRU0xSKaHVO8SRA8RNBNQ
        it5k5E9hTlDFu4inXIjklq1Mv4BeEcGzLm2SBg==
X-Google-Smtp-Source: ABdhPJwvkvemmhvQLSwCQm4gpIYMftfka7WMIAmWLyZGAJSnJ52MchXcPRDmVK7L+Va3qkbuIITfwhAYwzEjNkMAFBA=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr2691947oia.147.1602857641568;
 Fri, 16 Oct 2020 07:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-7-thunder.leizhen@huawei.com> <bda5f620-7140-51fb-fadd-6ebd3c0db935@ti.com>
 <4f5f9b55-9fad-9318-82d4-6b258643738b@huawei.com> <20201014135019.GA1563910@bogus>
 <49b680f8-d7d7-8ea3-894c-73cbfacc5ba4@huawei.com>
In-Reply-To: <49b680f8-d7d7-8ea3-894c-73cbfacc5ba4@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Oct 2020 09:13:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJKOeZybxnu+Z2ugaGwebrnbtmJ8n0st-=n3NbAf9_pyw@mail.gmail.com>
Message-ID: <CAL_JsqJKOeZybxnu+Z2ugaGwebrnbtmJ8n0st-=n3NbAf9_pyw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 14, 2020 at 10:23 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/10/14 21:50, Rob Herring wrote:
> > On Wed, Oct 14, 2020 at 09:29:26AM +0800, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2020/10/14 1:32, Dan Murphy wrote:
> >>> Zhen
> >>>
> >>> On 10/13/20 11:08 AM, Zhen Lei wrote:
> >>>> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
> >>>> cmd-gpio.
> >>>>
> >>>> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
> >>>> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
> >>>>
> >>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>> ---
> >>>>   Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
> >>>>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> >>>> index b3c45c046ba5e37..c7a06a9650db2ed 100644
> >>>> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> >>>> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> >>>> @@ -24,7 +24,7 @@ properties:
> >>>>     compatible:
> >>>>       const: olpc,xo1.75-ec
> >>>>   -  cmd-gpios:
> >>>> +  cmd-gpio:
> >>>
> >>> Preference is gpios not gpio. But Rob H accept or reject
> >>
> >> Look at the search result below. It seems that the driver have not been merged into mainline.
> >
> > Yes, in drivers/platform/olpc/olpc-xo175-ec.c.
> >
> > Your mistake is the gpiod api takes just 'cmd' as the GPIO core handles
> > both forms.
>
> OK, thanks for your information. I have found that it defined by gpio_suffixes[].
>
> >
> >> But the property name is really used as cmd-gpio at mmp2-olpc-xo-1-75.dts:235, I don't think
> >> the mmp2-olpc-xo-1-75.dts can make a mistake. Otherwise, the driver will not work properly.
> >> Meanwhile, Both names cmd-gpios and cmd-gpio seem to be in use. But I prefer cmd-gpio, after
> >> all, only one gpio is assigned now. The motorola,cmd-gpios add "s" because it contains 3 gpio.
> >
> > The preference is it is always '-gpios' just like it's always
> > 'interrupts' or 'clocks'.
> >
> > However, whether to change this is really up to the OLPC folks. Given
> > the driver has always supported both forms, it should be okay to change
> > the dts. Though there could be other users besides the kernel.
>
> If both "cmd-gpios" and "cmd-gpio" are supported, should we use enum to list both
> of them in yaml? or use patternProperties?

No, we pick one or the other. Given Lubomir is okay with a dts change,
we should use just 'cmd-gpios'.

Rob
