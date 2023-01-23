Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99539677872
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jan 2023 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjAWKGl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Jan 2023 05:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAWKGl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Jan 2023 05:06:41 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9566A7A
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 02:06:40 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4a2f8ad29d5so164241867b3.8
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 02:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VicuVzYu4s6fn4J013oQR8HfGltLPxIwfCDN/KofZV4=;
        b=Y6ClXDCRtaM0NFUm2exFLL9k/94ruQcZKAH6AGrXv44azxyMt5YFlavlrXbinR0jop
         DU1fhE18zgcsGj0kmkI7OSQG0EO9+VmIZkKZKxAS8wXy8sjQvRsgvTKwT7m3D2FCvglL
         /ecwm2GbkU4KzTay2o7Wd8BbgsXxXmBnjks0x1u0tI3kWXpz26bluupkbvQJ0jPZjHgW
         mLdP3xYta2Xv/cnV2L7H7nWAJCnqiXx7CxqSgj/LFGP6HO33lWP5jO1eS4ToRmEbZ9Ff
         XNcfYlfwf3Pt2yTdGcISpX9AQTPWMF9p+ZUTYaEdhthXOTtNnHcMJgzXA1vWJ92BdEvg
         qbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VicuVzYu4s6fn4J013oQR8HfGltLPxIwfCDN/KofZV4=;
        b=x33yWDIqn5uUfRXgJJijNxh6+kpXzYe8qD8SfxKg6pZCfj66NOVorfCu1mrrwsOyIx
         2DwZkEXALskE8pUAqi/53Cr+TkdtqIeGrh4XADcWrR7O3ZVZ/PAuHnejVu/li8JgzuoU
         HvMkhUAg8T1eEyDnT40comA5SK4L2gYteAKXgLCJg1hp38Uo94hl+8CYt3xwKlOaiGrX
         SaTr9cjF3iNtUHftn0dXGq8wWCzJl060jdeNQ0ZuRhXweOCOnG+mtiA6PtG6E6C2K63j
         vQLRT7GW7fFSiWTkTOw1KJRazjrSY0BDhLi3SpJt31/Jz3bw/Xw0VRV+1lAU+QEMhu5V
         dU4Q==
X-Gm-Message-State: AFqh2kogerXe+/2FQV+i/oj0nOqs464ixNgzE2lYqDM6FUI8z3KJ9W89
        kCAIKnI7mEDqH92LbXhVoYNm6fGjqkF/cxAMm33LKw==
X-Google-Smtp-Source: AMrXdXu00x2BMrHmuqKFdmwf8soxBKobdwtYbxJRewGUxxnrJfPYQTlkT0upDkADd3uCyDg9kDJIpyrZS/Q3hl4Q2C8=
X-Received: by 2002:a81:4006:0:b0:46b:c07c:c1d9 with SMTP id
 l6-20020a814006000000b0046bc07cc1d9mr827028ywn.56.1674468399283; Mon, 23 Jan
 2023 02:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
 <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
 <60766c7b-abb2-3afb-aa16-0e1385b88a73@linaro.org> <CAFGrd9rtO0B2XWEEU6gtv39PndjdjLL6tbRWimWT3RvLu1GFrQ@mail.gmail.com>
 <259d738b-5717-8fda-22f0-c61db4660e95@linaro.org>
In-Reply-To: <259d738b-5717-8fda-22f0-c61db4660e95@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Jan 2023 11:06:27 +0100
Message-ID: <CAFGrd9qENTZV2fs52HPv291=AJdcBHpd2L_uoc9PhbO1vcKw=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

 Because there are no logical order:
    { .compatible =3D "rohm,dh2228fv", .data =3D &spidev_of_check },
    { .compatible =3D "lineartechnology,ltc2488", .data =3D &spidev_of_chec=
k },
    { .compatible =3D "semtech,sx1301", .data =3D &spidev_of_check },
    { .compatible =3D "lwn,bk4", .data =3D &spidev_of_check },
    { .compatible =3D "dh,dhcom-board", .data =3D &spidev_of_check },
    { .compatible =3D "menlo,m53cpld", .data =3D &spidev_of_check },
    { .compatible =3D "cisco,spi-petra", .data =3D &spidev_of_check },
    { .compatible =3D "micron,spi-authenta", .data =3D &spidev_of_check },
    { .compatible =3D "mediatek,genio", .data =3D &spidev_of_check },

I can put it first then before "rohm", or before
"micron,spi-authenta" you prefer.

I can also introduce another patch in my serie to re-order everything.

Le ven. 20 janv. 2023 =C3=A0 08:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>
> On 19/01/2023 20:18, Alexandre Mergnat wrote:
> > Le jeu. 19 janv. 2023 =C3=A0 17:49, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> a =C3=A9crit :
> >>
> >> On 19/01/2023 17:28, Alexandre Mergnat wrote:
> >>>       { .compatible =3D "micron,spi-authenta", .data =3D &spidev_of_c=
heck },
> >>> +     { .compatible =3D "mediatek,genio", .data =3D &spidev_of_check =
},
> >>
> >> Please run scripts/checkpatch.pl and fix reported warnings.
> >
> > Actually I did.
> > I saw: "WARNING: DT compatible string "mediatek,genio" appears
> > un-documented -- check ./Documentation/devicetree/bindings/"
> > But there are no bindings for spidev. I've made some grep on already
> > supported compatible devices like "micron,spi-authenta", but I didn't
> > find documentation to add "mediatek,genio".
>
> Another point - why is this after "micron"? Don't add entries to the end
> but in order.
>
> Best regards,
> Krzysztof
>
