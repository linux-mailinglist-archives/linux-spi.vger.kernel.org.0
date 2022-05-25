Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2983E534617
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 23:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiEYVzG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiEYVzF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 17:55:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33E11A3D
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 14:55:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so56560wms.3
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oBh+Znbc88NiDeYaHpcLs3NJcAFoy3MCBRZMNMGpQw=;
        b=arfvwNzDDLgge/qyXCYs6mi8SFh5fASF9WAvA3CMnMWaUtgiy3QFHT7IU6lKDS2BVh
         WrL/CARwCWxnEYK5zRUId/2SUMGApf4e7UBK+Zdn3lso/PvChAqUP9DhzLZq2s/6ZgoD
         7mVF2DH4324yfM97di0AzI26SutPzq4Md+/+M8nW55zkuz+c1CrrYJII0V/mjGbxhM+k
         TTm4lUAXyVT4A0fFNZA+IKbEmdamDebiDlU6MnFM2Nw4SFeK4zcsDKm4Tyda/deXw34G
         fHwUjAUPL/WKKTXeekwmgsvqPXjsSnqJnZO1cJ0qoQ2xA501AnbsFOJueL4csev4WMj4
         Jorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oBh+Znbc88NiDeYaHpcLs3NJcAFoy3MCBRZMNMGpQw=;
        b=myR9P2pJeXX1Aog2FRTy2VOQo1vHb0J1OxAkcedO9rqsrKjGdsyrKpT1u0Anh9albC
         E0tKiFYAma7EECMAfjd//AytM+fzzPVDnmqOX915JC5SsFC0MVM1Z1F/24riPTw5fhM9
         CbXSN54JBGxz3ZQhdYxjmFX88hmtpl7zdKs63c1X3tFw/x+UY87ESvjOLfPiofD4kDYl
         XODCs3mffhX5AJUJDUw82aGZOsLFkvTiw+ue6QLMPJNOoLq0UYa4nNsUD03IfUk/eyr+
         Zz3R+ihnwesiFBIGMIHbXg0QSDuyFFaCpUCrRn5o3GU7MfCuRup1kUKaHSK+Yp3eooMU
         DP1w==
X-Gm-Message-State: AOAM5339Lu59ehPzruwaOd4Ls7DoQnmphOwfksoPAkoareeen+EMoDLJ
        QPhx6GrgLuQ5y2enyZWkxTJ0IbgMak3X7Ar1qtnFww==
X-Google-Smtp-Source: ABdhPJwEdTcOuaFFxDw66wiF82VdkmXZa5C+ZdHZn9Ask4eKJm/UyqU4NfEyal57N8Yt5HepbbE1akxgZF/HJ+Ov6SQ=
X-Received: by 2002:a1c:e903:0:b0:397:36b8:795a with SMTP id
 q3-20020a1ce903000000b0039736b8795amr10328612wmc.98.1653515698905; Wed, 25
 May 2022 14:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-11-brad@pensando.io>
 <20220412110622.2xsk3k63dafqxib5@mobilestation>
In-Reply-To: <20220412110622.2xsk3k63dafqxib5@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 14:54:47 -0700
Message-ID: <CAK9rFnzp0+80dX_-NYidfVXWJ1sru5mNk1vgVDzoV7VeEekpwQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] spi: dw: Add support for Pensando Elba SoC
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
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

Hi Sergey,

On Tue, Apr 12, 2022 at 4:06 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> > +static void elba_spics_set_cs(struct dw_spi_elba *dwselba, int cs, int enable)
> > +{
> > +     regmap_update_bits(dwselba->regmap, dwselba->reg, ELBA_SPICS_MASK(cs),
> > +                        ELBA_SPICS_SET(cs, enable));
> > +}
> > +
> > +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
>
> The methods naming is ambiguous. Moreover it breaks this module naming
> convention. Could you change them to something like:
> dw_spi_elba_override_cs()
> and
> dw_spi_elba_set_cs()
> ?

Yes, changed elba_spics_set_cs() -> dw_spi_elba_override_cs()

> > +     /* deassert cs */
>
> > +     elba_spics_set_cs(dwselba, 0, 1);
> > +     elba_spics_set_cs(dwselba, 1, 1);
>
> What if the CS lines are of the active-high type? In that case basically
> you get to do the opposite to what you claim in the comment here.
>
> Note the CS setting into the deactivated state is done in the spi_setup()
> method anyway, at the moment of the peripheral SPI device registration
> stage (see its calling the spi_set_cs() function). Thus what you are doing
> here is redundant.

Yes this is a redundant initialization and is removed.  For Elba these CS lines
are active-low only.

Regards,
Brad
