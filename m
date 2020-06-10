Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC91F5BE8
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgFJTSd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 15:18:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33472 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgFJTSd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Jun 2020 15:18:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id i74so3168219oib.0;
        Wed, 10 Jun 2020 12:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErXcEjIZKZYMaE59Cy6bDtnAUpYGTLxXbrJ7gEcXNDc=;
        b=T1efMlPg5p9fArLib6fjKcbVH3eyprpN6Xs0haKDKGRWhjNtZ6zaYk+swHrHAtyOAC
         3RbWuD+2DDIdwaTp23MXQgjTXTSwNEYmgCMcf0K7imSTIqYaVFIlB2JZJSklfy12ro3i
         FdPXkriod3sdFauQXebTDoTRMsaN/hbCCmx9fjYRN3RjgSAq4CpggiMBr3smhM2LCJs8
         0wZR/Mc74nhEk9OMBSeDQN1mIq1RaKLkIegxyyRC1MZ1LfPc62r2kBr88liYjyLIfNLs
         bH7tTn8t94Jk2sUuicxGSazi5NfireKeaY6XEw4KtiDAYAcQ73SyaG33csJt47RCb0Jo
         sdbQ==
X-Gm-Message-State: AOAM532A+830pgbpsGiZPXeFAr4JQg6w6QUcBLcbHqi+QnPlEuNhkCJ/
        LtD9M+JUOgfFqgg1iOSzH7u3zovmmyllgB3Iza9UjA==
X-Google-Smtp-Source: ABdhPJymxTtbYTmYawt/pTShhavObY6hVr557ohX3IrthN4BEWlvV2X3v47f8s9bka+iLbtA8D3ab99N2grmmxoL/7s=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr3745370oia.54.1591816711902;
 Wed, 10 Jun 2020 12:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200610110810.GD5005@sirena.org.uk> <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
 <20200610164928.GJ5005@sirena.org.uk>
In-Reply-To: <20200610164928.GJ5005@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Jun 2020 21:18:19 +0200
Message-ID: <CAMuHMdUNo0tMxWsnXi4q8NwubPWHqTvzGOA-0hOr7oo2cRvvUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742 support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Wed, Jun 10, 2020 at 6:49 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 10, 2020 at 01:59:24PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Jun 10, 2020 at 1:08 PM Mark Brown <broonie@kernel.org> wrote:
> > > To repeat my previous feedback I'd expect a driver update as well.
>
> > No driver update is needed.
>
> > Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml says:
>
> I'm much more comfortable explicitly listing the new compatible so that
> even if someone makes a DT that doesn't bother listing the fallbacks
> things will work.

Adding all of them would cause even more churn when adding support for
a new SoC... There are already more than 700 "renesas," compatible
values documented that are not directly matched by drivers.
Nowadays we have "make dtbs_check", so if a DTS doesn't conform to the
binding, it will be flagged.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
