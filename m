Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D5B1D347D
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgENPIK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgENPII (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 11:08:08 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECDC061A0C;
        Thu, 14 May 2020 08:08:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 79so3358454iou.2;
        Thu, 14 May 2020 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gbex69XR4ZtBuJoqVeoYUx9nyFHm1kZR6S5jk554FrE=;
        b=FJPRMdQokqht7U+y1ela4OESMPvwo+hnpZbq+e01yT4sc7YmX6KhRapTLoooJGnaer
         no8q5/+yTTtmbVYURRxBEfQhhZ9J+LhKOFz0bqgGBx4PJ2Bw2ftahjLfUzXNEEvP8ccI
         2pAP6Y2aYPKnolxMJQZEZL2TjJA9jwPSwcgeBX6VoDfVfbkeZdHE4f3iGkIRzsuBERI3
         b0XGSa3ns7gvk1VcwnfVu1eKrphDamt+YQi9Z3l0nVtOAJFrtU66CW6UaoIx+NrhyDWG
         bpqevwejD/G29RpG/FpMT46mNvKB9gZs0esEtTpKHnxOjUpQp/TrM51cnY7zblKAAa2T
         Tr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gbex69XR4ZtBuJoqVeoYUx9nyFHm1kZR6S5jk554FrE=;
        b=M3wnIGSuqEf/qElsJ2WUpn2RRaXc3cntoA1CwXzU51tnS1ApY+QV+CVJDqaY0/SbaS
         UeEGqmvBlTpzPbXxysWj5Xo0HEw5lzkMSDI1BcrkwkWDvWNAgyPp5nAO3lEJKnPBktOz
         X3bZMiEtf+0RX5LRWSG57/+o9lgeDy+8DT9PPCea2lwKpMZ9CYxJEWEigp5rhVo6HUIO
         vH1Y3uB76cV/FXU4ymPHjk1VipvTtH+rImpeOOGoddhgNtIwmPOZ8bejzzt5sErQnhld
         YsIKFi4oJx7x6uIJQ92bNry1nRHlxBoS/8KUkf4oJreeKD8R5QWdpZh9HCilYIzigmHP
         nozQ==
X-Gm-Message-State: AOAM5300q5phDhsOdufNkig62F0I6Oz8vysH8qLAPGztnqR8yo7D4Gwf
        LF8YfkYG3NGflJqKS5rerIUELXd5FAZCMTFLSeo=
X-Google-Smtp-Source: ABdhPJxG7GXTkoxbTPKumJL1X0BkUdzHfDr7LxNY1mkd2t1RPi+rTYGSq8vStSCW40203NqyVRJ+wEEs4doBgLVXPhg=
X-Received: by 2002:a5d:8b8e:: with SMTP id p14mr4506860iol.110.1589468887821;
 Thu, 14 May 2020 08:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
 <1589269010-18472-3-git-send-email-dillon.minfei@gmail.com> <da9fbb80-571d-1217-4028-e413a0c7db84@st.com>
In-Reply-To: <da9fbb80-571d-1217-4028-e413a0c7db84@st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 14 May 2020 15:07:32 +0800
Message-ID: <CAL9mu0KJ0j6Rxf7YjKxVWKz_d+B6vrwqqxJM-fmzG=NonLeDYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>, p.zabel@pengutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hua Dillon <dillonhua@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alexandre,

Alexandre Torgue <alexandre.torgue@st.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=88=
14=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:10=E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hi Dillon
>
> On 5/12/20 9:36 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > L3gd20, st mems motion sensor, 3-axis digital output gyroscope,
> > connect to stm32f429 via spi5
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >
> > Hi Alexandre,
> >
> > V2:
> >      1, insert blank line at stm32f420-disco.dts line 143
> >      2, add more description about l3gd20 in commit message
> >
> > V1:
> >      enable l3gd20 dts binding on stm32f429-disco
> >
> > thanks.
> >
> > dillon,
> >
> >   arch/arm/boot/dts/stm32f429-disco.dts | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/=
stm32f429-disco.dts
> > index 30c0f67..1bfb903 100644
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
> >       model =3D "STMicroelectronics STM32F429i-DISCO board";
> > @@ -127,3 +129,26 @@
> >       pinctrl-names =3D "default";
> >       status =3D "okay";
> >   };
> > +
> > +&spi5 {
> > +     status =3D "okay";
> > +     pinctrl-0 =3D <&spi5_pins>;
> > +     pinctrl-names =3D "default";
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
> > +     cs-gpios =3D <&gpioc 1 GPIO_ACTIVE_LOW>;
> > +     dmas =3D <&dma2 3 2 0x400 0x0>,
> > +            <&dma2 4 2 0x400 0x0>;
> > +     dma-names =3D "rx", "tx";
> > +
>
> You added this spi5 node in this patch but also in the display series. I
> will have issue to merge. Even if I could fix it easily, as you are
> going to resend, the good practice could be to have several patches in
> one series: one patch for spi5 controller, another for gyro and another
> for display.
>
> And also same remark than Linus did in display series move DMA to soc
> dtsi file please.

Sure, how about this patch sequence:
1 add spi5 dma to soc (stm32f429.dtsi)
2 add pin map for spi5 (stm32f4-pinctrl.dtsi)
3 add spi5 controller with gyro (stm32f429-disco.dts)
4 add spi modification to support gyro (spi-stm32.c)

5 add ltdc pin map for stm32f429-disco board (stm32f4-pinctrl.dtsi)
6 add ilitek-ili9341 dts bindings for disco (stm32f429-disco.dts,
depends on above step 3)
7 add yaml document about ilitek-ili9341 (ilitek,ili9341.yaml)
8 add clk changes to support ltdc driver (clk-stm32f4.c)

so, i will combine gyro and display two patches to one patchset next
time. right ?

thanks.
>
>
> > +     l3gd20: l3gd20@0 {
> > +             compatible =3D "st,l3gd20-gyro";
> > +             spi-max-frequency =3D <10000000>;
> > +             st,drdy-int-pin =3D <2>;
> > +             interrupt-parent =3D <&gpioa>;
> > +             interrupts =3D <1 IRQ_TYPE_EDGE_RISING>,
> > +                             <2 IRQ_TYPE_EDGE_RISING>;
> > +             reg =3D <0>;
> > +             status =3D "okay";
> > +     };
> > +};
> >
