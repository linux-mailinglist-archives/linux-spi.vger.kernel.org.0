Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE66017930C
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgCDPNK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 10:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgCDPNJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 10:13:09 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698DB21775;
        Wed,  4 Mar 2020 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583334788;
        bh=6nHkKIgF1vsNZMlc30HiQy8/oHhvCgNZjVYENzB1bhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPLQE7kLkIYLoHDSVo9HJW6lzcb6Xpbkvj6Zlza0tl/i2imebXMGmhs4ZjKsILPy4
         92hwY3MoXIkBms8WGPQFxq8otGURHcqiHBgDaK3pAK8bXyhVeWA3NOgvUbeMxuCUsB
         0YzE4pxX9vnEvkCDdbMAJi82JM4bfxGdStDaBBLo=
Received: by mail-qt1-f176.google.com with SMTP id t13so1594998qto.3;
        Wed, 04 Mar 2020 07:13:08 -0800 (PST)
X-Gm-Message-State: ANhLgQ1opzT3Dbnr+o/0Cm1VEpyr4jS0dGMGYJyD04bHylwzYBalDVn6
        vJHhnCO/+9TELx0qelnMgYf4E3RxolnK7aA47A==
X-Google-Smtp-Source: ADFU+vsrisSxpdfCxVHVTsRHNqfoOTZdjiFvfSdN1ZN87TkLYBvb8wR+oVW+bts6vXbefL5Ibwlc+/rZ10p1FfkB2ME=
X-Received: by 2002:aed:2344:: with SMTP id i4mr2875858qtc.136.1583334787520;
 Wed, 04 Mar 2020 07:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20200303094522.23180-1-geert+renesas@glider.be>
 <20200303094522.23180-2-geert+renesas@glider.be> <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg@mail.gmail.com>
 <CAMuHMdUBTVZGNtdc0dhUz5d+P2_Fr89MvBCz8=9oQK1EOi7s2w@mail.gmail.com>
In-Reply-To: <CAMuHMdUBTVZGNtdc0dhUz5d+P2_Fr89MvBCz8=9oQK1EOi7s2w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Mar 2020 09:12:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLw4yvkmU+imifQX4XSwd21ofaDVm=0LawH9oK-_ym8ng@mail.gmail.com>
Message-ID: <CAL_JsqLw4yvkmU+imifQX4XSwd21ofaDVm=0LawH9oK-_ym8ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: spi-controller: Fix
 #address-cells for slave mode
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 4, 2020 at 6:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Mar 3, 2020 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Mar 3, 2020 at 3:45 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Currently, the DT bindings for an SPI controller specify that
> > > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > > controller in master mode only.  When running in SPI slave mode,
> > > "#address-cells" should be zero.
> > >
> > > Fix this making the value of "#address-cells" dependent on the presence
> > > of "spi-slave".
> > >
> > > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v2:
> > >   - Use "enum: [0, 1]" instead of min/max limit,
> > >   - use "- spi-slave" instead of "[ spi-slave ]".
> > >
> > > As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
> > > 'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
> > > upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.
> > >
> > > However, when using "#address-cells = <0>" with W=1:
> > >
> > >     Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> >
> > What was the point in having #address-cells in the first place for
> > slaves?
>
> I don't know, commit a8830cb19cfea04e ("spi: Document DT bindings for
> SPI controllers in slave mode") doesn't require any #address-cells for
> slave mode.
>
> Perhaps because node_addr_cells() in dtc defaults to 2?
> Or because of_bus_n_addr_cells() walks up the parent chain and thus
> defaults to the first found parent value?
>
> > Seems like we should make it mutually exclusive with 'spi-slave'.
>
> Sounds like a good idea. How to express that in yaml?

oneOf:
  - required:
      - "#address-cells"
  - required:
      - spi-slave

Rob
