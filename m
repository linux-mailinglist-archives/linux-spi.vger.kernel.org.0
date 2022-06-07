Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BCA53476C
	for <lists+linux-spi@lfdr.de>; Thu, 26 May 2022 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbiEZATv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 20:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344734AbiEZATu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 20:19:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B89A500D
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 17:19:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so203180wms.3
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvyRm5Q/r/S5AC3OCiGwFo1KyIi4GmHKo/WvAYlzwmY=;
        b=h/FkCqpobe35YJc146CKhRO71JljnxwQBGwvYvsR9DljgVXTXTpKwLVSMwywDv+1tS
         Dmc8XCASYU8zmDisPay1AFEHLY3+Z43QB46x1QJO+TJ0mpDDLSfutSKEBeoMSOGdPlzs
         5M6rpvi548zAECvIetFq8EGO/OutGXBhFJiEqkedkBQypY5HQUENyYB1vkxfqjcJ9gxO
         Ej9Q0TmI8VT+gXtLkNZ5rxcoq4xqlUDFPbyx2fPGoi+wCkGcbM50nGLE0tiymF+0sDBE
         QZplrGXTII8qid0zqJiJN/4fjt1WKzFAouk6dfki3ttE0jdPWSDpTTxktrvueHJBKNAx
         HSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvyRm5Q/r/S5AC3OCiGwFo1KyIi4GmHKo/WvAYlzwmY=;
        b=vjDLdF/0vnxSOkfeh+mTEPZkRlb4z1sOVJ9vThjBJSlS7FqrHjSfdyqZ0wMgkOaS72
         heFfRMtfOSoOQCdbdBtmHaWsQ440WqV25+xdXPHPpUhoLb0GJgEgTDhgMjj709CM+2gp
         vgQa4XgxbScrUwPjBprkR9Gd6yumHiN4/sL73tTDTVeTKj5KFZ6u4mf5814GnVqb+8Hn
         v5aIocMlRwaVzCHwNII7TPluEntsqIn9cRqc96ZESd90Angd8pgEqCkQRiBkL8Fci9aI
         K9vebwMTCMo7fNEG2N051hcj1k9N35NFW3mihNsM4RfYy6ZexC/DGqfLdBEkj96Ah/du
         iztA==
X-Gm-Message-State: AOAM532U1Dl+1UtumemTh/gK9CuDyU50vq9LgrcUXlQMbjZXJSeyEwu2
        qyTj1g0PjzqriAJgsuOjNWJgJVgjBWBOaW98W3utDw==
X-Google-Smtp-Source: ABdhPJy/dRDyn+Keu4U0c9gK7VXdr+BW11BU+IY+GQAiAKGDy36VrSwz2Mg+0dYg+MNRP78khenZHfMasXMazGY+SKQ=
X-Received: by 2002:a05:600c:3515:b0:394:8c7e:fbde with SMTP id
 h21-20020a05600c351500b003948c7efbdemr10219880wmq.165.1653524385886; Wed, 25
 May 2022 17:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-12-brad@pensando.io>
 <eed2f337-3d5a-3440-d19e-c5ff032409ab@linaro.org>
In-Reply-To: <eed2f337-3d5a-3440-d19e-c5ff032409ab@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 17:19:34 -0700
Message-ID: <CAK9rFnzPEq1_zOnHYzTDyOOU9xRsuP-KBEFnc84cRoyfAve+Jg@mail.gmail.com>
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 12:06 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> > Add Pensando common and Elba SoC specific device nodes
> >
> > +&spi0 {
> > +     num-cs = <4>;
> > +     cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> > +                <&porta 7 GPIO_ACTIVE_LOW>;
> > +     status = "okay";
> > +     spi0_cs0@0 {
>
> Generic node name needed matching the class of a devicxe.

The device on this spi bus is a FPGA with 4 functions and looking at
other projects I've changed it to a resource-controller node name.  On
cs0 there is a sub-device reset-controller added in the upcoming
patchset to enable hardware reset of the eMMC device.

> > +             compatible = "semtech,sx1301";  /* Enable spidev */
>
> This comment is a bit odd... did you just use random compatible from
> spidev instead of defining proper compatible?

Yes, because adding a compatible was nacked.  We have a driver added
(two actually, mfd and reset driver) for the next patch update.

> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
>
> Why address/size cells?

Removed where not needed

> > +             spi-max-frequency = <12000000>;
> > +             reg = <0>;
>
> Please put reg just after compatible. It's the most common pattern.

Yes, moved reg to be right after compatible

> > +     };
> > +
> > +     spi0_cs1@1 {
> > +             compatible = "semtech,sx1301";
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             spi-max-frequency = <12000000>;
> > +             reg = <1>;
> > +     };
> > +
 (...)
> > +
> > +             mssoc: mssoc@307c0000 {
>
> Generic node name.

Changed to syscon

> > +                     compatible = "syscon", "simple-mfd";
>
> This does not look correct. Syscon is okay, but why do you need
> simple-mfd (there are no children here)?

Yes, removed "simple-mfd"

Regards,
Brad
