Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23AB2E93E5
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 12:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhADLEY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 06:04:24 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:32818 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhADLEY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 06:04:24 -0500
Received: by mail-oi1-f175.google.com with SMTP id d203so31732114oia.0;
        Mon, 04 Jan 2021 03:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4g2ziabIiExWAC+uPZxI4bCHUzg0yvflC/2YZUTTYw=;
        b=HyMgdvwxOciMkX4wU4fARIAyZoePZlquLhp4yP1mdce947Qb0csrIa9xw4VVE2qVR1
         lcavWAcWCw+1jw4d2svtLXd85/OHXXBU+KaleL+Q1wLhfRBPGN65DA5dsipLldvCySiM
         2Q2RktH7+fY8TmTFU9ley1VBcvmA8n+R47SSvK4Rfl7T/b0kDnGZ8AqbA1RQtTDri6yr
         yCDunc/l2nBMswOQ22c+/nFsZNBf6WMpaqUxfcN2Z70d5UAmy64+RnjeM6gMvH9KfLAn
         VygylsoZleZCorAbMQu8q99IFNI9jCBOuSSHO+Qsn22ZZW4VSs4eOWYM1Y28YC9FuWNf
         cIvA==
X-Gm-Message-State: AOAM532jYz3TAwNoyAtBAg/6qjWpa1miT8aOJ5TMZtCqJ33X47n4vtGx
        2r087tc6f96/3+icwVcvGLZkgVEmjRx18rd4Wig=
X-Google-Smtp-Source: ABdhPJzQr50t0WHB88K558MBAbgwFJoNsl8lbYFg8e/pADpO56kYAHzxhvPPsT4G5DDEC+RJARzSFgyPj/Wb7/hBB+w=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr17555957oia.54.1609758223078;
 Mon, 04 Jan 2021 03:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20210102115412.3402059-1-aford173@gmail.com> <20210102115412.3402059-3-aford173@gmail.com>
In-Reply-To: <20210102115412.3402059-3-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 12:03:32 +0100
Message-ID: <CAMuHMdU5tYFisn-vco=ML2aoOaL7JcVn7_Rma4GU9RTnwVFKwA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] spi: renesas rpc-if: Update Add RZ/G2 to Kconfig description
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 2, 2021 at 12:54 PM Adam Ford <aford173@gmail.com> wrote:
> The SPI driver for the Renesas RPC-IF is present on the RZ/G2

s/is/as/

> Series.  Add that to the description.
>
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
