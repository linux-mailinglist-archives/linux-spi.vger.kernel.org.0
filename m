Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF114A581
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2020 14:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgA0N4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jan 2020 08:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA0N4Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jan 2020 08:56:24 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E581214DB;
        Mon, 27 Jan 2020 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580133384;
        bh=KFdI1sxRWI/2dtuDU11fPSoWr08vmKPYeU9ITQQ9ZIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hmMAFYI47H7UB2oHw1uvUHdzYfFag5mnHsqxphBqSAxmL8StKnfVnAzwCDe4jPdp3
         eqZQu1TiReU0t6WKHz5YGXumNxqwetImsY2BOuCRhbQmigjuJt81RO/vExa54m1UBV
         vI60xLhAVYD+SkZmse5ohM2knL1HLrJnKq5Mi6vM=
Received: by mail-qk1-f181.google.com with SMTP id s187so9624210qke.8;
        Mon, 27 Jan 2020 05:56:24 -0800 (PST)
X-Gm-Message-State: APjAAAXJYQKGdvoU9TnNbjpEA5ETMbElJnFqQloj6plmHCw4tUcNmRmn
        K3yHW0hcxaFf0gtgVSkGTZw+3dqL0+lrOhoyWw==
X-Google-Smtp-Source: APXvYqzIhu1/LOnm7n6ODE3yUi0ivUKcaHREkhij1unVeO3mXUrUJz8/Fh93k2W+bAJvuLutueErXRU/tajZTDUPFs8=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr16781000qkg.152.1580133383359;
 Mon, 27 Jan 2020 05:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz>
 <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
 <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com> <651803fbdea412ecde7cd352b080d41d9f0a2a33.camel@alliedtelesis.co.nz>
In-Reply-To: <651803fbdea412ecde7cd352b080d41d9f0a2a33.camel@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jan 2020 07:56:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHYwH28jkg4h0GivOz=GywxFkGpxLywt9HEqKy3pdVRQ@mail.gmail.com>
Message-ID: <CAL_JsqJHYwH28jkg4h0GivOz=GywxFkGpxLywt9HEqKy3pdVRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jan 26, 2020 at 2:24 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> On Thu, 2020-01-23 at 07:51 -0600, Rob Herring wrote:
> > On Wed, Jan 22, 2020 at 7:24 PM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > >
> > > Add binding documentation for the spi-mux driver. This allows a generic
> > > multiplexer to be used to provide access to multiple SPI devices.
> > >
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > >
> > > Notes:
> > >     Changes in v2:
> > >     - update license
> > >     - make dt_binding_check clean
> >
> > Sure about that?
> >
>
> I was when I wrote that, but now I think I need to consult my spell
> book.
>
> It appears the incantation I should be using is
>
>   make ARCH=arm defconfig
>   make ARCH=arm dt_binding_check \
>      DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-mux.yaml

Note that you need to run this also without DT_SCHEMA_FILES set so the
example is checked against all schema. With that, the 'spi' node is
going to need #address-cells and #size-cells.

>
> I can see the simple failures (not sure how I missed them). But one
> that remains is:
>
> Warning (spi_bus_bridge): /example-0/spi/spi-mux@0: node name for SPI
> buses should be 'spi'
>
> I could fix that by having
>
>  spi {
>     spi@0 {
>        compatible = "spi-mux";
>     };
>  };
>
> Is that what we want? Or should I be adding awareness of spi-muxes to
> dtc?

We should probably relax dtc, but for now I'd just use 'spi'.

Rob
