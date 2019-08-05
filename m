Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D618170A
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2019 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfHEK3c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 06:29:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36754 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEK3c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Aug 2019 06:29:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so78856451ljj.3
        for <linux-spi@vger.kernel.org>; Mon, 05 Aug 2019 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgQS0RVhrSHQQR06ywIE1zI7rR3vFUB6ECm2IurTYyo=;
        b=TJhyTIrKmge5lMJkKhRDhrf0usgOVPRIyssINJZl9KhrEAjHwotzV+X21lZDDYjC0M
         P5pVYNVHlNLwMG3LHRidN3jSvU8cYH8mYP/HTeo8EPKiSj/OHOwF2Zwyoh2thRu68rI6
         L6f9lF1QgFORxs4MHrtWAchdW/d96ikEcF+nWE2Vkl7i1/HeViHAUcYXzQMVIfltapDE
         FgEiiihR9xs6jdYn3JmiKcqLTRBUvgTAnT6c/pBWxNLXPr0jmin9OJyi+v+k+lwBAeW/
         Z/2QzPXTscDPB1xCTgCTXbL1xI5xl7zlaawW4GmILlyuBUEu1F/RnYhe5TJO7H6vyzE/
         bcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgQS0RVhrSHQQR06ywIE1zI7rR3vFUB6ECm2IurTYyo=;
        b=D3xpLCC7W19ylsTHwuX0LVOsAxfUXnbZsQqzRhqeMADXzHU9A3GnGgbk4N00pKBJwz
         MaGpeGChcFob9pkQ2cj8oalKVqdjutkbVQkj3I4sluy+edRP+CpG99JdNTSMh0kPm7A9
         uC1fI70ZjfDh35u55jpThdO8BNSZPhvGrYpaQznU8id8LYwKK1UCyG/+nVdaZNw3LHGq
         DLb+OrFwQmR4Jg0RtmVgfaxtt7b7LaHrsWSuchFtpakmdx4LSR6qjB16q2wQOehjVqsV
         vHvcjYoMZM3Zck0q0go9YSJdoKldsUPoalZA3/+tRQNl3lcYNqW20pLMWkIvTFets5BP
         NbAA==
X-Gm-Message-State: APjAAAUWUFzLeItPrWIqi1EWvIuPIU3X9gLNOCvk68VaVKVc3V9C7V+x
        gZUIIToNSs8bH6oSdebxMtP1DnTs/Gsmh5y04CD4kofleGk=
X-Google-Smtp-Source: APXvYqwiNvI+PlbXBDdXFR2b7KDlreAp73XJI0KzmpIJ2V9t3xStoSZeInn1tp918uDCSC1a31ftyr1FKdpYYFKfQjE=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr13784957ljo.69.1565000970574;
 Mon, 05 Aug 2019 03:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562597164.git.hns@goldelico.com> <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
 <20190724194259.GA25847@bogus> <2EA06398-E45B-481B-9A26-4DD2E043BF9C@goldelico.com>
 <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:29:19 +0200
Message-ID: <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to make
 display work again
To:     Rob Herring <robh@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 26, 2019 at 12:43 AM Rob Herring <robh@kernel.org> wrote:
> On Thu, Jul 25, 2019 at 12:23 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> > I tried to convince Linus that this is the right way but he convinced
> > me that a fix that handles all cases does not exist.
> >
> > There seem to be embedded devices with older DTB (potentially in ROM)
> > which provide a plain 0 value for a gpios definition. And either with
> > or without spi-cs-high.
> >
> > Since "0" is the same as "GPIO_ACTIVE_HIGH", the absence of
> > spi-cs-high was and must be interpreted as active low for these
> > devices. This leads to the inversion logic in code.
> >
> > AFAIR it boils down to the question if gpiolib and the bindings
> > should still support such legacy devices with out-of tree DTB,
> > but force in-tree DTS to add the legacy spi-cs-high property.
> >
> > Or if we should fix the 2 or 3 cases of in-tree legacy cases
> > and potentially break out-of tree DTBs.
>
> If it is small number of platforms, then the kernel could handle those
> cases explicitly as needed.
>
> > IMHO it is more general to keep the out-of-tree DTBs working
> > and "fix" what we can control (in-tree DTS).
>
> If we do this, then we need to not call spi-cs-high legacy because
> we're stuck with it forever.

I agree. The background on it is here:
https://lkml.org/lkml/2019/4/2/4

Not using the negatively defined (i.e. if it is no there, the line is
by default active low) spi-cs-high would break
PowerPC, who were AFAICT using this to ship devices.

Yours,
Linus Walleij
