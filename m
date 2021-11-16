Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA272452F54
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhKPKnu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 05:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhKPKnc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 05:43:32 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901BC061570;
        Tue, 16 Nov 2021 02:40:35 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g17so55999990ybe.13;
        Tue, 16 Nov 2021 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eacFzYG4y/pmaSwfOMyeXjG9lV8APV1lD0PKm7xyB/I=;
        b=ngwEN5TVA0svBcjJzzGL3O55/UcHEaakrj43No/oa9ntWIMLYsEhfed8sbkStcQWPF
         mg2pG3j1UkaSqg/kJkmcuNx+G9pPLSPBoy/ei0/rXFe+9vVyJ9GoJ5tRffF71YzpIuyT
         e5azrTImutlNzMLBHObvpiQBqkI5W0r8kwKaBEpdaBv6NBk1WFNb1sl4+JlE4rN+VhKo
         V2qJG+l5lDVJHsluuO7KfGwWJBQEtYtU318jcreBbEloKsGX1Be32f4o8Y0VZhuqVjJB
         O7tc+UIYF0c9f5ZAjStsKrxP3v8vXPQQZ7UpYQCp44J1JjCWaHfL+Ri9cOx/SQdho+Qo
         c77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eacFzYG4y/pmaSwfOMyeXjG9lV8APV1lD0PKm7xyB/I=;
        b=qDaZxl1vfwxQ0kd6QUXOd/A+Dtb2gHyfAtXlaoPdehJrkQEV8nrw208PdHc+Yo4epy
         fqICSQzsIKeLk/mS8ciShGulNYXiN0gryfA2zNyvphy8ocNdkKi71eOtySW5YciWBAXr
         yqxpTzcXjdJeZQtzUJZEY9Smjj8qToLAVmgRoUtDzVguZw5AtW08zI55tmFmTsxZZSYd
         NKB9XUuSayqMFcwoQ3NHHnNs747T277CLntqAWJOrqe82HBq25K2kDglasyeNcmpYXgu
         yqAmA7Irts6t9TsH1zSAeWb0OJli3Rb10v0jJy2STgjnWG0X0+kXyEz9iqw36P12/yks
         WQrA==
X-Gm-Message-State: AOAM530SbYM3tE9OubAyeQ7a8M7PPzOvyox8CfxX6egEZ31yzIluOh/w
        vUYMj6QRlKureyOlTe3TwfR3thN/GzzAs7U3YZ4=
X-Google-Smtp-Source: ABdhPJxQlTsxuIuK8DAfcNTrc65rpOtrU8od9nVzHXcfzD8nb+05xUlyFaZ6Ir0Ny/pG8KtbRieCnOZ3Z7a/mNeCAJ8=
X-Received: by 2002:a25:c792:: with SMTP id w140mr6655608ybe.131.1637059234773;
 Tue, 16 Nov 2021 02:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <a8b126e6-62e7-7979-01cb-b7a1ce4ae8d1@canonical.com>
In-Reply-To: <a8b126e6-62e7-7979-01cb-b7a1ce4ae8d1@canonical.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 16 Nov 2021 10:40:08 +0000
Message-ID: <CA+V-a8t=JsMJ=w9dDpeUfdTUwFhnHrZ-eWdpTmvOxC0uvOz4Wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add SPI Multi I/O Bus Controller support for RZ/G2L
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 16, 2021 at 10:33 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 25/10/2021 22:56, Lad Prabhakar wrote:
> > Hi All,
> >
> > This patch series adds a couple of fixes for rpc-if driver and
> > adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
> > is identical to the RPC-IF block found on R-Car Gen3 SoC's.
> >
> > Cheers,
> > Prabhakar
> >
> > Changes for v2:
> > * Rebased the patches on linux-next
> > * Split patch 5 from v1
> > * Included RB tags
> > * Fixed review comments pointed by Wolfram
> >
> > v1:
> > https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> > 20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Lad Prabhakar (7):
> >   dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
> >   dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
> >   spi: spi-rpc-if: Check return value of rpcif_sw_init()
> >   mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
> >   memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
> >     fails
> >   memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
> >   memory: renesas-rpc-if: Add support for RZ/G2L
> >
>
> Applied parts 1, 2, 5 and 6. I think 7 is going to have a new version
> due to Wolfram's comments?
>
Thank you for queuing up the patches, wrt patch 7/7 this can also be
picked up, after the internal discussion it was clear that we cannot
use the R-car hw manual for RZ/G2L (we will have to live with magic
values). Wolfram has agreed on this and has already Acked patch 7/7.

Cheers,
Prabhakar

>
> Best regards,
> Krzysztof
