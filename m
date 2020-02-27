Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57431723A3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgB0Qko (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:40:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42357 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgB0Qkn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:40:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id l12so2595022oil.9;
        Thu, 27 Feb 2020 08:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCYsGMCW0SwZkIyBJuFeCwKSJseDitgI487QueGROLA=;
        b=Gf9/qRg5YVJ95kp1jBd5ls2HFfW/I/pX+q9rJGHWaPe4DgYhjxL1hJyeF2ohiDM4wB
         Ju8465+NYrjs5t5qnXgWQuZ7lkO9bhmR13dQoBWoc/2kNVPkPGuLlLJyeiPx0B5zuVjB
         4jv4ebLpWXUH5MsRO/qlZkMJOmhAg7GgZ95M7rmtRHv0BAR+luy/8eMd3BlUcRIDBE0o
         5Tx1KmXVSGyGVXOu+IQ6Yo0I1bTlWc11FsZ61pA+TL3VnP2bfsIoSAhPIMj3Aa0JMF7D
         ejYK29AFOH6GsLhr/+dMTJOmalOBbpFQSdRUXZWKRDiY/djbWxTEXzTH6MbfjeCRLcIQ
         wWew==
X-Gm-Message-State: APjAAAXDu+X4Z30GNTy8w0mehXZ5Cobf/iL3CZxAcP3g8uoLmr8Vdwr2
        +N6/3mDIvG+qdbONwNESUxPa+LNFXXYmzE5bkrY=
X-Google-Smtp-Source: APXvYqxi2lBXElKfDVk3UZlxPINmCFgsVAPQF8DUTRsAPVQr2KdIUt1ieiiCMdPs4JqAaaMjFiUborT+0iUnPUYglQs=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr3967588oif.131.1582821642630;
 Thu, 27 Feb 2020 08:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20200226093703.19765-1-p.yadav@ti.com> <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com> <20200227162842.GE4062@sirena.org.uk>
In-Reply-To: <20200227162842.GE4062@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 17:40:31 +0100
Message-ID: <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
To:     Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 27, 2020 at 05:11:47PM +0100, Boris Brezillon wrote:
> > Pratyush Yadav <p.yadav@ti.com> wrote:
>
> > > Allow spi devices to express DTR receive and transmit capabilities via
> > > the properties "spi-rx-dtr" and "spi-tx-dtr".
>
> > Is the RX/TX granularity really useful?
>
> It's what we do for other properties, and if this is anything like the
> other things adding extra wiring you can't assume that the ability to
> use the feature for TX implies RX.

Double Transfer Rate uses the same wire.
But as you sample at both the rising and the falling edges of the clock, this
makes the cpha setting meaningless for such transfers, I think ;-)

However, as the future may bring us QDR, perhaps this should not be a
boolean flag, but an integer value?
Cfr. spi-tx-bus-width vs. the original spi-tx-dual/spi-tx-quad proposal.

What would be a good name (as we only need one)? spi-data-phases?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
