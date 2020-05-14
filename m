Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33A1D2A33
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgENIb6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726322AbgENIb0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 04:31:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE5C061A0F
        for <linux-spi@vger.kernel.org>; Thu, 14 May 2020 01:31:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so2588751ljo.0
        for <linux-spi@vger.kernel.org>; Thu, 14 May 2020 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ch5Lo0qUlNLfqqdr8oPDugFIwsbkUAsTV/pjrrFuHLo=;
        b=xHi/CO+kw7Zb1AKTwwXYOr5rqnL21pX27PIcAoZpAyWED1KbMsgJJ+aHzrEV/Isbwh
         cCj8ce0L7btUVbF3US3EeioBiXXi2iCdmOyXoxSJCWosyCfLczsKK9alpmOGav2v80w+
         vuDG2+aAvxzcOE2K3TrrYIvY0mqmBU/BMbT7IEB1scIBSlpp8HiBHlfn8UCnFVtjjBns
         DbfLyYIf6KoVVieHkBEAcyIGtiD44sr1xCf8Lwsd64ayvLqSzC2AAnY/k71w+wMolPqK
         JyDlDZKYHbrozYowGa+UzXmNfLBfNgsdCqJb+BahKwZn8S+ATnRlB96BNNSEyPU6wjca
         s33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch5Lo0qUlNLfqqdr8oPDugFIwsbkUAsTV/pjrrFuHLo=;
        b=oNvR1zM5A/t18yVr+zu+nW+gee8WrDbHM5OfPYZrv2qPvcNB7oBQUM/S+kqvlkKNkH
         4zQhTof9ssS4npmhcaXDRLvBj+O+kmy1O2Xm/2bIMptARJLMOcqIy2ZFTnX6chojCJsX
         TOlmPTg4/ROA1kzLr2KyZJ//28jxpHvH7XAL7xKi5NQy9OJBND4ACvTkjozl4iYa8c7w
         ES4YBRt8b3BiIuLbbTjBBAIvyN9CTdzzU07O9pbD02Fj7V1IhH7Hp52yNv55iID3ycCJ
         7GAmYK33TZY04ZQ0uWrwAEitf7MC5qvTMZeO9yakEgPctdCeyk8dAo0LR9ypz+haCbbD
         2hQg==
X-Gm-Message-State: AOAM533i5U9a6+Q7b/EPDsDjWhNIagJA5m0hiDkGtLg9dc9/LgbS7LsP
        1812MTO5SShBeakdCJf7pwO1qnZC4EIJB4HowcZu9A==
X-Google-Smtp-Source: ABdhPJxYkw641+rzOfo0jk8kZqtPycWY4TTgsg+FJ176sdZrmEbUxUP61n/P+mU74fyLtp+Q1AgVt3G79WECR07lQH0=
X-Received: by 2002:a2e:b609:: with SMTP id r9mr1982744ljn.125.1589445084550;
 Thu, 14 May 2020 01:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
 <CACRpkdY=wkgnYPcqSzyzNpS6ckJZs-9kXfTfdwa1E+POzOBQGA@mail.gmail.com> <20200513001347.dyt357erev7vzy3l@mobilestation>
In-Reply-To: <20200513001347.dyt357erev7vzy3l@mobilestation>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 May 2020 10:31:13 +0200
Message-ID: <CACRpkdZTH1DNHvi4r48nLNWp4rqyYDZTzT12hw0eTNcYmgSr3Q@mail.gmail.com>
Subject: Re: [PATCH 11/17] spi: dw: Fix native CS being unset
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 2:13 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:

> > This is the correct fix now but I an afraid not correct before
> > commit 3e5ec1db8bfe.
>
> Sorry, but that's "enable" flag propagation from basic spi_set_cs() to the HW CS
> setting callback is a nightmare. In Russia there is a common saying for such
> cases, which can be translated as "you can't figure it out without a bottle of
> vodka".)
>
> Actually the fix is correct no matter whether commit 3e5ec1db8bfe is applied or
> not. At least I don't see a connection between them.

OK that seems to hold given the resoning below so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> > What I can't help but asking is: can the native chip select even
> > handle active high chip select if not backed by a GPIO?
> > Which register would set that polarity?
>
> No. DW APB SSI doesn't support active-high mode of the native CS's.

We had some related discussion what to do with this case
when a controller can support active high CS if and only if
it is using a GPIO instead of the native CS. We didn't really
figure it out, I suppose ideally we should use two flags in the
master but that exercise is for another day.

Yours.
Linus Walleij
