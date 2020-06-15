Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02E51F944B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFOKGe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOKGe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 06:06:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE4C061A0E;
        Mon, 15 Jun 2020 03:06:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j19so10546585ilk.9;
        Mon, 15 Jun 2020 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4ilhIOGf08PxKYEnKjQV/fXI0rSU5dBatEgVzDPnAc=;
        b=P0cRrsg3JH6SfJ4oLMqbykTLO/eOgi7Euj53OY7iTtxCNRxChA79rSj5NkQ2Edupqx
         N7INsfzKBCOM3rgdAyGAIDdyshNxznnV8Xz3osw7SQF6gmzqOFC5uX9LoirJnCP6U6JC
         O2AjzpCtuTlytgLZXF5kTpv3q+9IF2SrQFdsuMDSPP6G6GaDAaR7Jog8iCmO0u6hXKwp
         Y1S4ZPY0aDWg/GcIFKpoe65TJRjHAvoSf2rduaUbd1v7PpynsqSrwAhMOGcl95m0oV+B
         tgZwVsAsOQmTp2hnW18vdQXnCZ+ecuBp9aBzFXlJLNH7OG4L8xZkidwnaQBikC6pkoob
         Q9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4ilhIOGf08PxKYEnKjQV/fXI0rSU5dBatEgVzDPnAc=;
        b=EmJUct1JyPPIUVWtm6KTjPpy5k8eUmqmq15ibI4/xJ7/AzNFjeTGx9MVYvrroGMDYw
         h3gCMzSUUPbfAOqmjb/b6dQGdFUZlMr88fLWY8MLI1T6D7PQeDQchN+HX6CGe/kQuF9d
         D8LduT5pWKYZ73uEBbuXWisfSIcT2IMYZ+ZN3wEDN68O6VgoEj1cUVHZ1RLRHCEYuVSn
         DabUKfFH0I1N2/fZsn1rKao90OQMHHQkFtSNkz6XQj+iGujz3GGa0YzhDD0j3uK7LmkI
         DhdUh9jgHXchLPCjmt1+3ecX0s7lo0oGkl15nZkIbBFfzgLDDx+qgpJxEqkjgybkq3zY
         U9Jg==
X-Gm-Message-State: AOAM533ybE/JB3hMGfX06ZXrOF2vcxwukBUTQYvHJ1ZpSlGZ/a6Rthko
        nER3loQSAsLze733TsbRxhvU3n82/4T5G4NH/6I=
X-Google-Smtp-Source: ABdhPJy7MG4dIBMDcK+E97dM8L8Kkqqke6SfX/trPu5MYMPHvmU2jZK0syr68+bQImnrTKFXitAZyACYHc7TzBxR/TA=
X-Received: by 2002:a92:5bd2:: with SMTP id c79mr23408564ilg.218.1592215593037;
 Mon, 15 Jun 2020 03:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-3-git-send-email-dillon.minfei@gmail.com> <2273a168-7b14-9e28-5904-b9d2c2e2d9d3@st.com>
In-Reply-To: <2273a168-7b14-9e28-5904-b9d2c2e2d9d3@st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 15 Jun 2020 18:05:56 +0800
Message-ID: <CAL9mu0LyFPjf+RLwet43zgcEnO9zhJJ=v1BsQqN8KxYta7Q=DQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] ARM: dts: stm32: Add pin map for ltdc & spi5 on
 stm32f429-disco board
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hua Dillon <dillonhua@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 15, 2020 at 5:45 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Dillon
>
> On 5/27/20 9:27 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patch adds the pin configuration for ltdc and spi5 controller
> > on stm32f429-disco board.
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >   arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 67 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 67 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> > index 392fa143ce07..0eb107f968cd 100644
> > --- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> > @@ -316,6 +316,73 @@
> >                               };
> >                       };
> >
> > +                     ltdc_pins_f429_disco: ltdc-1 {
>
> Sorry I missed this issue during review. I changed ltdc_pins_f429_disco
> by ltdc_pins_b when I applied your patch.
Okay, thanks for reviewing.

Regrades,
Dillon,
>
>
> Regards
> alex
>
> > +                             pins {
> > +                                     pinmux = <STM32_PINMUX('C', 6,  AF14)>,
> > +                                             /* LCD_HSYNC */
> > +                                              <STM32_PINMUX('A', 4,  AF14)>,
> > +                                              /* LCD_VSYNC */
> > +                                              <STM32_PINMUX('G', 7,  AF14)>,
> > +                                              /* LCD_CLK */
> > +                                              <STM32_PINMUX('C', 10, AF14)>,
> > +                                              /* LCD_R2 */
> > +                                              <STM32_PINMUX('B', 0,  AF9)>,
> > +                                              /* LCD_R3 */
> > +                                              <STM32_PINMUX('A', 11, AF14)>,
> > +                                              /* LCD_R4 */
> > +                                              <STM32_PINMUX('A', 12, AF14)>,
> > +                                              /* LCD_R5 */
> > +                                              <STM32_PINMUX('B', 1,  AF9)>,
> > +                                              /* LCD_R6*/
> > +                                              <STM32_PINMUX('G', 6,  AF14)>,
> > +                                              /* LCD_R7 */
> > +                                              <STM32_PINMUX('A', 6,  AF14)>,
> > +                                              /* LCD_G2 */
> > +                                              <STM32_PINMUX('G', 10, AF9)>,
> > +                                              /* LCD_G3 */
> > +                                              <STM32_PINMUX('B', 10, AF14)>,
> > +                                              /* LCD_G4 */
> > +                                              <STM32_PINMUX('D', 6,  AF14)>,
> > +                                              /* LCD_B2 */
> > +                                              <STM32_PINMUX('G', 11, AF14)>,
> > +                                              /* LCD_B3*/
> > +                                              <STM32_PINMUX('B', 11, AF14)>,
> > +                                              /* LCD_G5 */
> > +                                              <STM32_PINMUX('C', 7,  AF14)>,
> > +                                              /* LCD_G6 */
> > +                                              <STM32_PINMUX('D', 3,  AF14)>,
> > +                                              /* LCD_G7 */
> > +                                              <STM32_PINMUX('G', 12, AF9)>,
> > +                                              /* LCD_B4 */
> > +                                              <STM32_PINMUX('A', 3,  AF14)>,
> > +                                              /* LCD_B5 */
> > +                                              <STM32_PINMUX('B', 8,  AF14)>,
> > +                                              /* LCD_B6 */
> > +                                              <STM32_PINMUX('B', 9,  AF14)>,
> > +                                              /* LCD_B7 */
> > +                                              <STM32_PINMUX('F', 10, AF14)>;
> > +                                              /* LCD_DE */
> > +                                     slew-rate = <2>;
> > +                             };
> > +                     };
> > +
> > +                     spi5_pins: spi5-0 {
> > +                             pins1 {
> > +                                     pinmux = <STM32_PINMUX('F', 7, AF5)>,
> > +                                             /* SPI5_CLK */
> > +                                              <STM32_PINMUX('F', 9, AF5)>;
> > +                                             /* SPI5_MOSI */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate = <0>;
> > +                             };
> > +                             pins2 {
> > +                                     pinmux = <STM32_PINMUX('F', 8, AF5)>;
> > +                                             /* SPI5_MISO */
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> >                       dcmi_pins: dcmi-0 {
> >                               pins {
> >                                       pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
> >
