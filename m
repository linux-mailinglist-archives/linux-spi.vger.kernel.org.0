Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A94268CC
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfEVRFZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 13:05:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41217 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfEVRFY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 13:05:24 -0400
Received: by mail-vs1-f67.google.com with SMTP id w19so1845049vsw.8;
        Wed, 22 May 2019 10:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa2H7HOwgmbPDyBFCAXArUfFpSb35dh7+aA9tzdnkR8=;
        b=eX9aUT56Ut/iusoGNP6Eg/85T7kecb9Au96hM/ECol5S+zHIRHFFZ9zxYGo0UUR8GB
         i7YHfTmywz0Roa53TGbPeysiZ+1ciVpjB1GYukk4xNxdycwphK26wj9esRKsOwZNy90d
         dQ/0CY1GId6Ya8I7whlX0EqQkPSHUHRu03CLdggols0VZXq58KrHVohbQW3ELAQBeENB
         JvwnjLJGIrh8hGheqIAk+4rs33sxcSUQlHJgKArFT0A2CJFGWY9AW2IFboIlU3qFeWVJ
         bAYBxGCcpx9IMDaP78xZAqSQcg5iEgTSf20gWOCgvZDPwe8VhG07oqqyKSN/S2OJCUbX
         SKsg==
X-Gm-Message-State: APjAAAW7Qqbc7bdG13WCERsWd/0godGi5TWuUW+OH4kmCWrASpop5VAM
        LPhm3FinloWLKrwi0OnFT9LcTtH0xR18T4/MSaI=
X-Google-Smtp-Source: APXvYqx2NgO2idz7AKv2FdUyCj/XJ8SKzQxkwfRaaOgEUuiwe7RbG6Gs5Z/jg4JxOpHqZQwLjStg8vF2Ff7KxRvV1iQ=
X-Received: by 2002:a67:770f:: with SMTP id s15mr35188198vsc.11.1558544723492;
 Wed, 22 May 2019 10:05:23 -0700 (PDT)
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
 <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw> <5e718d9f-3aeb-c2ef-0723-400497b2b98f@cogentembedded.com>
In-Reply-To: <5e718d9f-3aeb-c2ef-0723-400497b2b98f@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 May 2019 19:05:11 +0200
Message-ID: <CAMuHMdUWNqkZz5DEWFJsoHLmC86ziLjWKHpz=A-EmvMDDgnSNQ@mail.gmail.com>
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

On Wed, May 22, 2019 at 6:32 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/20/2019 10:23 AM, masonccyang@mxic.com.tw wrote:
> > +- clocks: should contain 1 entries for the module's clock
>
>    1 entry (clock node phandle and specifier).

Doesn't "specifier" mean "phandle + optional arguments"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
