Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4334DF47
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 05:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhC3D2B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 23:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhC3D1x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 23:27:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A94C0613D8
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 20:27:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jy13so22609661ejc.2
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1Mep0NDTZqgj41CwSzTV/L+FLNZGsP0ABu2o9b8U30=;
        b=3iJ6rnxNoJ1aTUrQb8MBityRh32IAoO48UjECVfi4BfI7/zw8eIa5QZsOXEdPj0Ult
         Ty+5a/+z0tH9MGN4pMs0E1CwVUioqhcepi7Lu84N7r0PBy5kF9ickSommc4x+k/a2Q7B
         5E293VfrAtZ/le8pjgcG94Y36E9PUx/WExrGl7fcifPHy0mLzvlaUp7FheK3iZx4EuNi
         xLS+LonWNrdG4ZdbOnJAxJSrspZk93opFaXsRh4zZX/Fj+TzE1GWOpuunFDm3ojdS1fg
         kI34Wh6qDZgX/BJt7lnSbqWQ9Hr7UdJ4czc18A6HG2VK+wbwPnHSNukupFvn+R7FyiIC
         4ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1Mep0NDTZqgj41CwSzTV/L+FLNZGsP0ABu2o9b8U30=;
        b=Cn2OG+gwiCYGEd75Iv/1sDKfK//kOWuTbj36sqj0SZVZPL0PvvTCbbCot8Pul9AsSQ
         SEXwmkThrqwmC6q12Xts/4NWdO8kWJLdjSr3VWId1FZjzj4dD1poUQB7J+wgIh3uh6m9
         QVmdW6daus70LJ4PGli21yoJ8ZKPw6A3Z+t6CU0wCL1j40Zvmb+LciwXjl0Xac6HMlgz
         ycPjg2KdRb5XCy0ZDu4K4Xtup9qjNBkkWevEKN/aNlP5aMLgmx72/krCtEkuK4bi8qG/
         f33PeqSotB7KeBwSs2hFa075rV/FhWgFdpbsaNHErwLSf9OetSJEStXIJ2v2DpejZsn1
         jWvg==
X-Gm-Message-State: AOAM533E6lpswvbhGBDYZWSN/+yjEP2tPwQwk2eEjCKqEyrdNygtMD+E
        mVCh78VYShFBWmfUR38QqNm1N1HyhA7HASQfdDiRcQ==
X-Google-Smtp-Source: ABdhPJxJVT4ikpn8Ll3+BLlxrg5DXp62plos3RcvXhSBKDJOAEk7g5/fDnEiJIF4vigHrmnSsJ9PwiqWINiWEhcCWS8=
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr30956801ejb.444.1617074870919;
 Mon, 29 Mar 2021 20:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-5-brad@pensando.io>
 <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
In-Reply-To: <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 20:27:40 -0700
Message-ID: <CAK9rFnxO6AUjjihZ3Y+tspUZqCWhNa5BH5EhK2x4mk8FJv0k7w@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] spidev: Add Pensando CPLD compatible
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 29, 2021 at 3:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
> >
> > Pensando Elba SoC platforms have a SPI connected CPLD
> > for platform management.
>
> And? It's not a good justification to spread the (debugging only)
> spidev interface.
>
> What tool is going to use it? Why can't you have a driver for that in
> the kernel?

The driver is in userspace and we need to instantiate /dev/spi0.N
in the /dev directory.  The CPLD includes a device id and version
id that userspace applications use to differentiate functionality on
different boards.  It wouldn't really be appropriate to use one of
the existing entries.

For example even with high pin count SoCs we are offloading
low speed functionality into the CPLD connected over SPI.  The
elba-asic-common.dtsi file shows a compatible string of
"pensando,cpld-rd1173" which does have a kernel driver we
intend to contribute later if there is interest.  This IP in the CPLD
is readily available from Lattice which provides two I2C Masters
which in our case we use for access to the network port transceivers.
What was missing in the kernel was a bridge driver that exposes
what looks like a standard I2C device to userspace where the
drivers/i2c/busses/i2c-rd1173.c handles the spi transfers to the
Lattice IP in the CPLD.

>
> --
> With Best Regards,
> Andy Shevchenko
