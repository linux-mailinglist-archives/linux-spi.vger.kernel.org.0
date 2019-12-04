Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E885113828
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 00:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLDX1y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 18:27:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37631 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfLDX1y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 18:27:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so948708lfc.4
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2019 15:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHQVhXEdwiBmbkFOI/t2rAMKEMxdwczYwcvTARuZwPA=;
        b=kdU4pIGwHdUVh3EhGFkzT9GgYsragPKcs7FuwTMlbtLJvttXZfLZUfPXm6aB3Jr+RU
         38MrZ6hymBPgkwUXIBkSpd1J0WPLDweyQBU8s7KUeAX151uIYB1I1kTEiLtOLC6zk3wd
         fr3a4MEoLHiRL3ZiFXBTqWRV9euJoRLUvIpVVsCIBGXM9OxRNiPbDh47Ie3oKbB+MseA
         KYzkWEThxoPnMgEcDGnO/5T0bfLRXagokoliB0cWecFbz4ka+fBNLkA4FoPY8pcE9Jun
         6Kv3/OQbEaisRLh3xAbhwSydMVaM8iqPiKS79yNeq2YBiRAOwB2wy8+fBDwb3ERMc9Ap
         KsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHQVhXEdwiBmbkFOI/t2rAMKEMxdwczYwcvTARuZwPA=;
        b=OB+u7n5fn5h33HExecO3WtkZjsMhRhtrV2n6Tl9UxVHpxsgHMt4FodDc54ZtmgF+te
         mC7SKZxSE26y32oGrgpSwh4oP6l5hh+wUV5qBg8ZAAwOS4l/MSxIap1ycpZHDnR19hXQ
         NYF29XtDO5c+nLIbuVe4zFumXXW8Rrwdv8QDFZyx9OJMRF77GXrEVgyzTvcs3I+xAh0S
         qr9fdxhpNeBUEP2kCQDz1SoemDgeLWD/R3V5Qn/bQxMWocuseRZaNUCAX7SJChEEeGN8
         PrUs/V8NvQ9nOpdBdg+UDCGDwDUghvmXpkiyE7AM/Nf7ErrsR49eaO4LC8fuXCIi28o9
         ZDQg==
X-Gm-Message-State: APjAAAUqg/WwuDin1mzfwaIUsX8LsY15+FBiSydgDfuku/WRU0JMuJUr
        kgYibRS4nSZBl1t5cd6+1Vnx/jy9iuje1aFrMYdqWw==
X-Google-Smtp-Source: APXvYqz+t++AT2vtWuUK2EhvNZZZKqqY0BgVWoCr/oGj7/IbXngXHuX7q9WugxKvSj/W+txcIm060a0gJxVkUTIpKx0=
X-Received: by 2002:a19:2389:: with SMTP id j131mr2752925lfj.86.1575502072281;
 Wed, 04 Dec 2019 15:27:52 -0800 (PST)
MIME-Version: 1.0
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk> <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk> <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
In-Reply-To: <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Dec 2019 00:27:40 +0100
Message-ID: <CACRpkdaxXKMqL4Y8yFu+U7WhpXgq6Yr+hx4rYd3aDzc+-dLDFw@mail.gmail.com>
Subject: Re: Side effect of SPI GPIO descriptor usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Phil Elwell <phil@raspberrypi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 4, 2019 at 3:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> I looked it over and most are devices like board files and RTC
> clocks that enforce SPI_CS_HIGH. They seem to be native
> chip selects so it will work as expected but I will look it over so
> I haven't broken any of them.

I looked all over:

drivers/mfd/ezx-pcap.c
Enforces SPI_CS_HIGH if platform data PCAP_CS_AH is
set. Nothing (no board file) in the kernel sets it.
No action.

drivers/mfd/mc13xxx-spi.c
drivers/mfd/motorola-cpcap.c
Hardcodes both SPI_MODE_0 and SPI_CS_HIGH.
Should be patched to |= SPI_MODE_0 and
^= SPI_CS_HIGH. I sent patches.

drivers/rtc/rts-ds1302.c
drivers/rtc/rts-ds1305.c
drivers/rtc/rtc-pcf2123.c
These just have some text comments on the importance of using
an active high chip select. That then gets defined in the boardfile or
the device tree which is fine. Any GPIO lines used for this can be
flagged as active high or low appropriately.

drivers/rtc/rtc-ds1343.c:
Hardcodes SPI_CS_HIGH, has no in-tree users (bo board files
refer to it), does not support device tree. So there is no way
to break it. Sent a patch anyways.

drivers/rtc/rtc-rx6110.c
Prints a warning if not flagged SPI_CS_HIGH, wil print
that warning if used with a GPIO chip select from device
tree. No regression, also no in-tree users.

drivers/staging/fb_uc1611.c
drivers/staging/fb_watterott.c
A staging driver hardcoding SPI_CS_HIGH, sent a patch
for this too so we don't gain any bad examples.

Yours,
Linus Walleij
