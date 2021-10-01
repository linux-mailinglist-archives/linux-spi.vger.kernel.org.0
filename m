Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C741E8A7
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 10:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352655AbhJAIGC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352638AbhJAIGB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 04:06:01 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19800C06177E;
        Fri,  1 Oct 2021 01:04:02 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s64so15739451yba.11;
        Fri, 01 Oct 2021 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UkTV/Hx+0kC37e1L6jOI1Y69QnSHLaF5uOLMErL9pfc=;
        b=GS/7MMG8VG3EwqT0c2Lm/gYv66cowtYEkkkYVz/u6kPeC85dCTVJAaINucv6NV4anJ
         WURJMEJYRdpMlrz5j94NWwQ9/h9EsNPPOMQvJYZ/h/FlUfACMlzAtPB4tr9KyJt3RlFC
         YvVoNPusNVvTpMoSapP6s7iwHvUzyQSBmWCLJCOgbXBSkgiBw2X63DYEPPypHsNUc5ZQ
         9uz4yJSK5+fgUrG+aCQhPejDp4ryP21GSG7OvVhTHXA/AGGZog8GcSnuFzwzgdNQ5XOt
         Ba7c5OqWgWTBtS6Z0zPcD6WMIiAxOhuNYRCFLz40gs0oMj90477929zEcOZ01xc04Mqz
         s0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UkTV/Hx+0kC37e1L6jOI1Y69QnSHLaF5uOLMErL9pfc=;
        b=SP3sgJa7laiLqbGRcm+9VYW2E739i2VWUZ+gMv8ak6kGbEFt1KguzNTTzu8bWcLvZj
         5JxoUEelvzmE0icslGFVLe4cTkNMxFwhjCJh8XQZOelIhzDfRdfkcp5erRBh05TbyFFm
         Gtf2CjPJzHmB3Iy4QBlgeLCoTq6+jnu7Uj729L074piqR+CLx0Qvof/Px0G+w4O6jFjj
         at68RtzSFC7LBRUvpeTiNEiM/Q9Lw65bh6P61j0GBZQipIdzFga3zjX+zyqvAwFdNLX+
         iQI9n/DRx+DQkWt9v0y8+IKR7cg+htGR6YWUqow65fwE/NdINRMVs5T2Z/mcJJq8CkAA
         +vCA==
X-Gm-Message-State: AOAM5331lOGkyMCLoR3vJNOE8MK5BDo8hY8nBQV2/n2krq02WF5dxKyL
        oE6go1byJOFyYE5EFefZ5ON9H+nZ+/3zKm8W/do=
X-Google-Smtp-Source: ABdhPJy4j6EHmIy0MQOCvwAUhMRlGC9OoRrjR5IIMh88aRHWKguGjBgt+bJrkUsVhzvBNTkQVHOU9teoh/blCdQzwzE=
X-Received: by 2002:a25:b7c6:: with SMTP id u6mr4323825ybj.16.1633075441369;
 Fri, 01 Oct 2021 01:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YVXRZNxrgmfROlJy@shikoro>
In-Reply-To: <YVXRZNxrgmfROlJy@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Oct 2021 09:03:35 +0100
Message-ID: <CA+V-a8vKogydunptYaWVBq_UUQ98UUTp-n2-T+WH8thTRL8M4Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add SPI Multi I/O Bus Controller support for RZ/G2L
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

On Thu, Sep 30, 2021 at 4:01 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > This patch series adds a couple of fixes for rpc-if driver and
> > adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
> > is identical to the RPC-IF block found on R-Car Gen3 SoC's.
>
> I did some basic testing on the Falcon board with a Renesas R-Car V3U
> SoC and did not find a regression, so:
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
Thank you for testing this, I will include the Tested-by tag along
with the RB tags.

Cheers,
Prabhakar
