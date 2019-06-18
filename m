Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7949EFB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfFRLMT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 18 Jun 2019 07:12:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42428 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLMT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 07:12:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so8926183lfh.9
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 04:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LA73LFXA8kT+iMCX0CVf0WxBB7EVdW67wDF0JGCv8Tc=;
        b=Nbicb6AeN05PSs1GEpPm8fKbyLD7TWgVdWy0MMqVB+10/c41ku+bu6kQbxe6k/5fj3
         3iOBmU/FUX+mNq2+S2ZEs+Zl1R45c6ri3t3v1RHPVnrIhE22hfeA+M36tq35j3SSfBWI
         Jc4/qAbfIgJgpElykB4PkNS7Vy/2zE1BDDQPAuZCS7GcDd7OjzFH9tHU9zEqUoXWckFV
         pOk38tbOSO+0mCU1wErZCkzOobS0Rno28wHcJPiEvx3tqP0S8SeV8zaztw3Bc0GzolSo
         CfoAWfnLZQfWSo8Ww7XAe2rLlqa53RQ/fP9n7DQEg63MzFjCASP73fpdSpQMZWOP+9hT
         5NgA==
X-Gm-Message-State: APjAAAWYfH6Vn74HFFnU+FNiBPhzbgMrBpT4DKDuaCStr5d4MjT4+duA
        aY4KK6Rknj350qTifC4YQdSMzsWyEl0Aacie0CE=
X-Google-Smtp-Source: APXvYqwRuygEnyyMvR3pFNzXEfFOo8BRWr3AwFGw6CoUW1J4uCdnDjeycelPMouBeaoAElC9Pu4vnmSa2OzWlEJGc3Q=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr34681371lfn.23.1560856337483;
 Tue, 18 Jun 2019 04:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com> <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com> <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell> <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
In-Reply-To: <20190618095741.GA18371@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jun 2019 13:12:05 +0200
Message-ID: <CAMuHMdX829_CFGt53fS4nd9=qdS479OvJXYY3++DZ=4fLmp62w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lee,

On Tue, Jun 18, 2019 at 11:57 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:
> > On Tue, Jun 18, 2019 at 11:20 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > So is an RPC-IF a real hardware device.  Can you share the datasheet?
> >
> > Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
> > not yet public.
>
> When will it be public?

Dunno. RZ/G1 documentation became public a few months after the SoC
release.

> Do you have access to it?

Yes I do.

> > However, a very similar hardware block is present in the RZ/A2M SoC.
> > Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
> > User’s Manual: Hardware", which you can download from
> > https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents
>
>   "The SPI multi I/O bus controller enables the direct connection of
>    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
>    devices to this LSI chip.
>
>    This module allows the connected serial flash, OctaFlashTM, XccelaTM
>    flash, or HyperFlashTM memory devices to be accessed by reading the
>    external address space, or using Manual mode to transmit and receive
>    data."
>
> Looks like a flash device to me.

The external address space is a small window.

> Can the SPI portion be used to connect generic SPI devices?

I'll defer that to the people who worked on the driver...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
