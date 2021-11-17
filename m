Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DC454312
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhKQI7F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 03:59:05 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:44595 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhKQI6m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 03:58:42 -0500
Received: by mail-ua1-f50.google.com with SMTP id p2so4209506uad.11;
        Wed, 17 Nov 2021 00:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sW49Xr+1bOjDY12omUEsih/dwouIC8EM4gaLxaa8Zd4=;
        b=aX44Aq9zh6MZlNHWKQTujDEsbqxvJE83QUva+jIqI+awNHS5WyLTkx37oLRB8x9+z0
         VpGAmWaMw365lusquN5LxjxxRId1yoKs04U0nbDqVsTWeYSZlnmwJFSwl855vWq8AwfI
         N9KOg5csKiaw+sSEyo+VgA0BhX5m/u4qDSJPKxdC3jOx/edBN5Gs6tc+bVYvmMhGCSWg
         Vb5iwraj6BXgnLOGI9Bgdng2AWgVLTcMA2di7YIP90Vbq3begDt/dFbrgsAV2NRh5vkI
         Ba23kZ2NRPyh0Uyu5eXZHzMkcbv8RCqHRReNm7ASwJEj3eCGaaXhU4EJyYGrYQGN3YX+
         tWXQ==
X-Gm-Message-State: AOAM531PUSnRtxiG+85YWrmNudL6j+BVRi6twp+fosDN+sgNvAraZ41I
        9VazASocAHcPWOT+6Ju4UOnB+XudYle7zg==
X-Google-Smtp-Source: ABdhPJzEESxBNj9TsDxlC2s7TdE2CvCu3VT2w+erwjKi1xgg1OnDDysmrodk3XhwvUbk8/1tMvI5LQ==
X-Received: by 2002:a05:6102:6d6:: with SMTP id m22mr68523953vsg.30.1637139343578;
        Wed, 17 Nov 2021 00:55:43 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id u14sm12669762vsi.2.2021.11.17.00.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:55:43 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id v3so4226800uam.10;
        Wed, 17 Nov 2021 00:55:42 -0800 (PST)
X-Received: by 2002:a67:af0a:: with SMTP id v10mr65640282vsl.35.1637139342767;
 Wed, 17 Nov 2021 00:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211117010527.27365-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211117010527.27365-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Nov 2021 09:55:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPuHQEEyyDC9iR1hePPs7ZexRJ_Vf=rZDN=CiTSLZtnQ@mail.gmail.com>
Message-ID: <CAMuHMdUPuHQEEyyDC9iR1hePPs7ZexRJ_Vf=rZDN=CiTSLZtnQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: spi-rspi: Add support to deassert/assert reset line
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 17, 2021 at 2:05 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> On RZ/G2L SoC we need to explicitly deassert the reset line
> for the device to work, use this opportunity to deassert/assert
> reset line in spi-rspi driver.
>
> This patch adds support to read the "resets" property (if available)
> from DT and perform deassert/assert when required.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
