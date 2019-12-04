Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C94112575
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 09:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDIlJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 03:41:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46190 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfLDIlJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 03:41:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so6074146oii.13;
        Wed, 04 Dec 2019 00:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdH7qTtZf1EWXzHyucbdWpqxN++s9yx5fEkVuEPj9rY=;
        b=GqjDYSpk7/8zKD8lYJbu83XrZXclde0jhdYI8ZR5FlXt/zvK66QB0mrMGmv4BiVwRr
         AZxYVMWLZxfTLtHsxdNSf8nXIdMwZB6ptEE/lx9GLbVX4Z9JccluIk0bCK1GzneTTYzY
         xB+WVHSz8NhZ3K6tRiCqraBwdUlaA0t751wJlb/+1F4xnMUbdegmWdc+2nKE1Ij2QTnf
         AGXwZ0HdxdKGeN7ncDwgK7Gc0KD9ddBE5QAUI7NjCf5ZW7b4lRquvg37OFrXavR1Zct6
         qb75uA5or38pRCHfkK8zcpZT0l6atmgttBId7BVvchIIYGiJd2xg7acQaf8iBrv4Kawm
         S4Ig==
X-Gm-Message-State: APjAAAXN7w4mWgDC6Tf5sVrLVs8cIwaSvT9brTTZITLqg9Rxqb+8gtnn
        bQNHBSt4pbhhcSoeJVvPY7TGOXTEiJ04Vbp59HQ=
X-Google-Smtp-Source: APXvYqzVU71ZSwcCNz6Z7HOJglmUdD+vS5+BMYSIN0rSyT1OeO2Im8TBsts5Xyi79Z2W7dlY7dDYlBUw1n6tYQbznM8=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr1549842oia.131.1575448868441;
 Wed, 04 Dec 2019 00:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com> <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
In-Reply-To: <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 09:40:56 +0100
Message-ID: <CAMuHMdWtzb5OFEko+6WfrS+72pRT1iyoVZxLGo7A1uFC=FJknQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Chris Brandt <chris.brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 3, 2019 at 9:39 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Dec 3, 2019 at 7:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Once you have added basic Runtime PM support to
> drivers/mtd/maps/physmap-core.c:physmap_flash_probe(), the module clock
> should be kept enabled through the clock domain when using direct mapped
> mode (hmm, as the driver currently lacks this, it means the FLASH on
> ape6evm must rely on the bsc module clock being kept enabled through the
> Ethernet controller connected to the same bsc module?).

JFTR, this is indeed broken: after removing the Ethernet node from
r8a73a4-ape6evm.dts, accessing the FLASH crashes the system with an
imprecise external abort.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
