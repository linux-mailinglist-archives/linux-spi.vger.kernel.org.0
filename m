Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C04BC8CD
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiBSOMB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 09:12:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiBSOMA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 09:12:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2DB3631F;
        Sat, 19 Feb 2022 06:11:40 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c18so8356611ioc.6;
        Sat, 19 Feb 2022 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khEKiFmlxsxiqTtZYX/qTk1TpXtOYU/3OblqSoDUfW0=;
        b=ZObrfqYotJuDphjyiBMB/p7l1RjWwBi7KwVByx0fZsy5G7MwhhOgTKtBx1YSVnd36F
         wwKzz6FUpJ714wLF2d+DjM+j/DuyFrSoOf38xJAQ0r2AcC41mFdnU8M4YoRBQzw3e+oJ
         45f8OQ5pM7KJ3CiNhWqMlOKJSVfimH7yjaqq/aW4E9XGzvCgqr0vC7YspFQtAYt81jph
         Xi5+lcHwDA9scIGPe4j+BD8vLIR4cgKJJbITBBnShSx5eyiQQQwb3bSLt3AvNWma4Q50
         HvFnrE3DlEPXIYW0shbg/lZj38hziCQKP9T6h0by4YcguyQneSBEtK9oowyEp1BkbF0V
         5URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khEKiFmlxsxiqTtZYX/qTk1TpXtOYU/3OblqSoDUfW0=;
        b=HQgcWlZLlU7ZgebjghFEEX96AaB9Ob/SrMRzcGWn++IG2XNNCZtuaXsQwLD9rxW1ZA
         FBp+UgAyKBLtXvsuy2Mf/1u+cIE/DAqLi6g2/rlCkRMPZETVTJL/phGkSD8+mWDmhY+G
         HQb0X8DzKh74W6Ilosr2O3xM5X4XKNP4oUJYycOAOyjt7ir6HxzbfgZ6yaN+eK53kB+c
         m6q5JxlwuqiZ4ef0HfaZ+0UbBzIhMKFFhkWVKpIfR+EqZ7oABW+pnceO1l049d3QaEmG
         brHq/bxaKId68h7kES1VrFa6/+aze3vARAfVr6B0hImRUkY8IOgVSe+QPaWIzU1xcQgV
         DoMQ==
X-Gm-Message-State: AOAM5311Gdg1r/Ub46Tr/w6nZ9V9OFKvXOZMrVXzSHGNWOpy0fRRjSmX
        D+tKdgZgvbwR2mHKr2RQHNZwkxGUvwdEwJ9J2fA=
X-Google-Smtp-Source: ABdhPJx5eE3sAx403go1Z2XHoeZZ5Xc3sz8vW4aQ9/eP501nK+eXQOuYg1aMlzYNe9DLkA7BIIff8QBau4zCr9ehHag=
X-Received: by 2002:a02:6d5c:0:b0:30c:a4da:d47d with SMTP id
 e28-20020a026d5c000000b0030ca4dad47dmr8712134jaf.308.1645279900228; Sat, 19
 Feb 2022 06:11:40 -0800 (PST)
MIME-Version: 1.0
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com> <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
In-Reply-To: <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Feb 2022 15:11:29 +0100
Message-ID: <CANiq72=+richkEREEdxkgxfuosN1rUfzcg0=0Z6CzHSH28HnLw@mail.gmail.com>
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Feb 19, 2022 at 2:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> I didn't find an explicit reason, but I suppose Pavel sees this driver as
> one that makes use of the LED subsystem, but doesn't belong to it.
> In the following mail he's expressing his opinion that the driver should
> be best placed under auxdisplay.

Ah, OK -- thanks!

Cheers,
Miguel
