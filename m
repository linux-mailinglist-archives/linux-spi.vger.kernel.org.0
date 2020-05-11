Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462F91CD474
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEKJGB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJGA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 05:06:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0E0C061A0C;
        Mon, 11 May 2020 02:06:00 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r2so7709249ilo.6;
        Mon, 11 May 2020 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXPQ8oL1xKkz5N/1TA82hvXaOeCuVTJr1m04oqy4j94=;
        b=QQCg4mUX+wQSt9HJ5j0qgOn36rHY+87ZROvttm9Pa4pxhRgqIoB+DGF613qUhKHRQt
         H7L2MAbI9i0x6oxqXk8aB9lVAJuhwZPxftcdY+6+Hxe3SF9yVatTdtd5zdBTcAiYpEZ7
         0cXXftjo38Hv1w15ZeWjTTLAKEtl6DQVyksD1tXQ5u8lO86y9szmheVmCsODRIQXUfQb
         ssgeZsR+jpJd9xGQALPQg/ZzfnATi+JPXIqUidFbf3WSZDHQ3MCybXqws+iEsv1rS4wW
         Os+41ItdlZu00mg0xVudeuIg834QhX9wM4Q+DCodtzjvjTjlAryTAJduavjzUy44zZib
         +UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXPQ8oL1xKkz5N/1TA82hvXaOeCuVTJr1m04oqy4j94=;
        b=oz/YdI+1fkIG+SsXvVxWcp/QbBAgSl6En3C3oKBGZaQ/S2C4kCa03LbXldpt/Ir7ia
         PsUY1M8HVCv6pAVmV2wKoLpTu4nIf/6fy+dS0KG3eq/6XOQpiUalnoq2wUw9mBh0LUnD
         81amw3NSBj+vTcMXyJsEEyzThDeWAQAH4L6svMet6Xa/E1YWLfezna91qdE0Pr/p7kyH
         5GpMUu2D8OK3IPW7jkO7monOC3d8QwDWM80b8SL/m81D8eMks/S2Z4M9lMdcSbdWpZ4w
         jXQMaxVsIEvwV3svhjt4aNUFBD3s0pQJG8AokJjk1+PXIc9dS1mBR0dHHVKdBcj5wxyu
         iMTA==
X-Gm-Message-State: AGi0PubLAiCPATRE6Nt1jVpfrmz+enhvDNwxHpGLqGLoB6LvyAEW3TuC
        qYi3el3d9V/2GwCYOg0yjffuFfvQo35RmDYJSLc=
X-Google-Smtp-Source: APiQypLnjwDCTOoTp7cg995FVjGSfRMddjPCiRtwufCtIHvwd/5nPCOyL6yw+XfWN/gd71cdELN5CvnqJnAptBslxQQ=
X-Received: by 2002:a92:607:: with SMTP id x7mr13744092ilg.218.1589187959912;
 Mon, 11 May 2020 02:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
 <1589007503-9523-3-git-send-email-dillon.minfei@gmail.com> <404e7f47-9c0f-44b1-aedb-a8d3af832d40@st.com>
In-Reply-To: <404e7f47-9c0f-44b1-aedb-a8d3af832d40@st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 11 May 2020 17:05:23 +0800
Message-ID: <CAL9mu0+5T3q8V8Ng_1jfPGfBxDWzgd7T1hzcdUXj23-rEtOgfg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        Mark Brown <broonie@kernel.org>, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hua Dillon <dillonhua@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Alexandre,

Thanks for review.

On Mon, May 11, 2020 at 3:17 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi
>
> On 5/9/20 8:58 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > Enable l3gd20 on stm32429-disco board.
>
> You could add some words about l3gd20
ok, thanks, i will add some description about l3gd20.
>
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >   arch/arm/boot/dts/stm32f429-disco.dts | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> > index 30c0f67..d365358 100644
> > --- a/arch/arm/boot/dts/stm32f429-disco.dts
> > +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> > @@ -49,6 +49,8 @@
> >   #include "stm32f429.dtsi"
> >   #include "stm32f429-pinctrl.dtsi"
> >   #include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/gpio/gpio.h>
> >
> >   / {
> >       model = "STMicroelectronics STM32F429i-DISCO board";
> > @@ -127,3 +129,25 @@
> >       pinctrl-names = "default";
> >       status = "okay";
> >   };
> > +
> > +&spi5 {
> > +     status = "okay";
> > +     pinctrl-0 = <&spi5_pins>;
> > +     pinctrl-names = "default";
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     cs-gpios = <&gpioc 1 GPIO_ACTIVE_LOW>;
> > +     dmas = <&dma2 3 2 0x400 0x0>,
> > +            <&dma2 4 2 0x400 0x0>;
> > +     dma-names = "rx", "tx";
>
> Insert blank line here.
ok
>
> > +     l3gd20: l3gd20@0 {
> > +             compatible = "st,l3gd20-gyro";
> > +             spi-max-frequency = <10000000>;
> > +             st,drdy-int-pin = <2>;
> > +             interrupt-parent = <&gpioa>;
> > +             interrupts = <1 IRQ_TYPE_EDGE_RISING>,
> > +                             <2 IRQ_TYPE_EDGE_RISING>;
> > +             reg = <0>;
> > +             status = "okay";
> > +     };
> > +};
> >
