Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608ED2694E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 19:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfEVRpB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 13:45:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45142 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEVRpB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 13:45:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id k187so1908506vsk.12;
        Wed, 22 May 2019 10:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYrm0bUv2G3ou+xt7BepsnZBkRyzFtIlpVXDYxrwa2Q=;
        b=KXOlc/8KKFqolD3OGK4kKqUTySf5bhzXFx/VoG34zC5623elVDu0hnNYRnr7xpGoFu
         znhCDewCEPki0tbKQNnveLQk+NLjo//mmOGFf22bi3wCRB8TeeHmu1U9vj+ZP1pS5wOH
         IBcKVcxW2UGCfNAnNizP6vejPNkk8ffiqFRWGUOX6r8vQeHOjQ1GSoU0BfQCq+RoPI6+
         dOVVBWdXFda80kxuP1Vlihlv362Iu17Ydj4WINA1SA4vbHjZZnH9Nhquz4nzXcQ769nA
         mxlcphaeEj91CcOee4yZ8lZ7/8YAAp34F4apajyfmajXP5tSC06/0qt3SLLC98KgfaMj
         Wkeg==
X-Gm-Message-State: APjAAAV2YMRnOYDUy1/YwmucUsKyaB2ukvHmceT0zkKXmddhB8ngWKxi
        1j6GI1kpTnAdRYM9f6f/7GAjTYRTU/2ZSgpxkRg=
X-Google-Smtp-Source: APXvYqzqwQrsBtqfMle90gQW8BOkmF0HFDIu/8ONkuwk3qh3X7b+zian9ggE6ZPD1Oo1QC7Wfgqqi4MKUY046NTd658=
X-Received: by 2002:a67:f589:: with SMTP id i9mr12970338vso.152.1558547100195;
 Wed, 22 May 2019 10:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com>
 <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
 <5e718d9f-3aeb-c2ef-0723-400497b2b98f@cogentembedded.com> <CAMuHMdUWNqkZz5DEWFJsoHLmC86ziLjWKHpz=A-EmvMDDgnSNQ@mail.gmail.com>
 <bba153f8-051c-9880-eacf-2ff698cc0171@cogentembedded.com>
In-Reply-To: <bba153f8-051c-9880-eacf-2ff698cc0171@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 May 2019 19:44:48 +0200
Message-ID: <CAMuHMdVBF82cUYFR3+K1bKhK16qCxNhyFXykp2c_CLffUq4i1w@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Wed, May 22, 2019 at 7:23 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/22/2019 08:05 PM, Geert Uytterhoeven wrote:
> >> On 05/20/2019 10:23 AM, masonccyang@mxic.com.tw wrote:
> >>> +- clocks: should contain 1 entries for the module's clock
> >>
> >>    1 entry (clock node phandle and specifier).
> >
> > Doesn't "specifier" mean "phandle + optional arguments"?
>
>    No.
>    E.g. when specifying the IRQs, the "interrupts" prop contains one or more
> interrupt specifiers, the phandle is specified in the "interrupt-parent"
> prop (see the DT spec).

Mea culpa, I stand corrected.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
