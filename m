Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42074BF2D1
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfIZMV6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 08:21:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42450 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZMV6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 08:21:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so1856539oif.9;
        Thu, 26 Sep 2019 05:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j92yBWpsApqNGriuRGCqtENz0+Kfgx9dM50H4SPtORk=;
        b=XZKpvGz6bUH0knYdQv8SjiMH9tUYuEbgWWEhDCNW2J/q8TUWdRdunmroj8UaGi6jcn
         kWHx0xR/j+qDZSi5Ru2XNBtKS/Ko6M6JDyl+kjwmVcCyNCyY7jzWV391aiY5jyB9rOt/
         hKIbDxSx9LgYIIjusX47Pc3hGSsiFBHSuRal4Qpl5s5LuuUww0uVJv4SCHai4F+BkLMm
         rKNi0i8a1IU2k3vTftbgjYGKZY2DU3MgvI0R9baOwkmSaWBH9cRqsSamWsUWfD5CnUwf
         XXpft65rN4EJ4vYUcPM1Cl2pRONVPnwticKS7L/quSp1PkvE980GU6h/TV8NiJOzWZwK
         Dq7g==
X-Gm-Message-State: APjAAAWwuoBx+MzkzoGr52ixbbEX1OE5jcSCMDsXMGM+3blRI+LBtAp+
        zsTp0rxOStrNWk8hdHaLJ7F3PKDHf0sG8BzIVVA=
X-Google-Smtp-Source: APXvYqx+FxmUmJby7V1uHy9Kg9yhfbA9OpM/S+Z0ztTo02qPebYEVuQBHgakFilaxLedm2hXT899aUNcsXX/RmNwUYc=
X-Received: by 2002:aca:cdc7:: with SMTP id d190mr2329805oig.148.1569500517341;
 Thu, 26 Sep 2019 05:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHirDJ_gtrjL_nq0T2qvn_kv9-UweL+=bc7EBLrTfNfNkVn0QA@mail.gmail.com>
 <20190924175036.GA2036@sirena.org.uk>
In-Reply-To: <20190924175036.GA2036@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 14:21:46 +0200
Message-ID: <CAMuHMdXbRQXarvV=86rssSiRnuKMSFWJLRbU3VH9tcCV_FeOGQ@mail.gmail.com>
Subject: Re: State of spidev from devicetree
To:     Mark Brown <broonie@kernel.org>
Cc:     Claus Stovgaard <claus.stovgaard@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 26, 2019 at 12:50 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 24, 2019 at 02:52:59PM +0200, Claus Stovgaard wrote:
>
> > What is yours response to the idea of creating a custom-hardware binding
> > for spidev, intended to be used for programmable hardware unknown at the
> > devicetree time.
>
> You should use a device tree overlay to describe whatever
> hardware you've instantiated on your FPGA then load the overlay
> along with your FPGA image.

And after that, you can bind spidev to the device in the overlay using
sysfs, cfr. commit 5039563e7c25eccd ("spi: Add driver_override SPI device
attribute").

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
