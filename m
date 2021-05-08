Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E3037717F
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 13:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEHLrd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 May 2021 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHLrd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 May 2021 07:47:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B7C061574
        for <linux-spi@vger.kernel.org>; Sat,  8 May 2021 04:46:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so11790651wrq.6
        for <linux-spi@vger.kernel.org>; Sat, 08 May 2021 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KS2SSUCxo/oRqwcKRNSVKjvUltASRWYkf1G/23BH1DM=;
        b=nroCK84Bxv/shafXjBfwA0aIWIJ79GgZJhKXDA/PTo9G7ibQ6bfwBEkIT4NPwbWvvo
         Fjnc8TVEab82MjH7WNrQ6moKY5o74Dg8ELXSl1xPbxPt58/QPnuZ7/MreCcMxwmKXXW0
         Zfdpb/Zucg8jB/LW6tkK8H3XhfWEampwjFUYdQl7NZNX7VSAbdTAqlaE63+FCsKProvn
         TqzGbFdOBM9DASdY7Xa/A1qRY4USwCe/le6rfqRaw2wef9GP0VmkniE3iIjIqxtyiMqt
         16FLwFYvirmkVGwJyg2j4tmRejv9emn0EfgBLrthVyDk3nn3zqsrcU5cPuqFmREWNqIc
         nYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KS2SSUCxo/oRqwcKRNSVKjvUltASRWYkf1G/23BH1DM=;
        b=te2JrOG5qmSDU6karHlqOfDhfh8ay/RACgOUUlEkaoWnA5oCwADojOJ7bzx5gUgSFX
         C1us0wneNRQpiKMwW5Q3ZP/icxtInJho1Uw27BumZmMbjAvdMMEpMDELE0EIIe7W1aQy
         t/GeTiTgjXUcUW3J+oysrMw7NW3qtEW+CTapIbebYxJkMVJu7fMtV3FaG+DKAMZ6HfhR
         fnCT4HHklha0KWcuT3GwM2eKj9iiasYNgYS7+iiQPEpbJIyT5xl7/5AJDv6YDGWJ8R6i
         UEnr0bS9CNBZl87Nf6kov98vnLC6tnLs5hO+hQUs1mfz9Dg3r4R0UOg+m+FRx8+c4Sc/
         uQvA==
X-Gm-Message-State: AOAM532uVkwibZnIybdNHbAfosicDJSqfS8STXOHRfcHdCNRK2+KPcPT
        b0rL4gGL6iGciNc0UGFSWCyE6isXPmepMLmYbgE=
X-Google-Smtp-Source: ABdhPJxdAJyzVSHNDgOmovALTUsr7WoX5knjupJ2H4GSNVFmSdY8oiZOb4rOKEjmbPqsAPwc8Kt1fOh7/iJZbC+jocU=
X-Received: by 2002:adf:d215:: with SMTP id j21mr19240036wrh.251.1620474385141;
 Sat, 08 May 2021 04:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
 <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com> <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com>
In-Reply-To: <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 8 May 2021 07:46:13 -0400
Message-ID: <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Sat, May 8, 2021 at 3:38 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>>
>> 2. Drive the gpiod chip select using the raw value, ignoring the
>> built-in polarity, which treats it the same as a gpio_xxx. Nice!
>>
>
> Looks nice (if for now don=E2=80=99t take into account the zillion of dri=
vers to be changed), but IIRC last time discussions about this piece of cod=
e, the problem also in DT itself, you may not break boards with already coo=
ked DTs. If you are sure about this, go ahead!

Yes, you're absolutely right, the zillion of drivers to be changed is
a serious problem. I'm definitely not trying to sweep that under the
carpet...

The rule table seems to indicate that the gpio's second devicetree
flag is ignored when it's used as a SPI gpio. So changing where the
polarity is stored, should not break DT? It may have repercussions
elsewhere though, not sure.

(I hope the formatting will come out ok here. If not, use the link below)
      device node     | cs-gpio       | CS pin state active | Note
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D
      spi-cs-high     | -             | H                   |
      -               | -             | L                   |
      spi-cs-high     | ACTIVE_HIGH   | H                   |
      -               | ACTIVE_HIGH   | L                   | 1
      spi-cs-high     | ACTIVE_LOW    | H                   | 2
      -               | ACTIVE_LOW    | L                   |


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/spi/spi-controller.yaml?h=3Dv5.12#n54
