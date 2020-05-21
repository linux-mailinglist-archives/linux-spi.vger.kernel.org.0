Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82E11DD091
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 16:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgEUO5X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 10:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbgEUO5X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 10:57:23 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6475207F7;
        Thu, 21 May 2020 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590073042;
        bh=lgOxpOJ5sU8yqys8g5ambGaF0QmdRr3L7ntmSbYBhYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/rhkdMU8Pum1xeUeLrXhIfuxjNiq1UyCP6EhTkw+cd/pmV6gVYq19SkSUB4x/BXC
         QpvcB1hzt+BMDNVTg7RsAm/THW/bQCUYM0YpmAMCUxPwXZngwR4shG9an7JmkPeIqU
         OqgLJDepcxNjFVLvTo05puJ6wxQoP4gi7y7XQIr4=
Received: by mail-oi1-f174.google.com with SMTP id z9so1587498oid.2;
        Thu, 21 May 2020 07:57:21 -0700 (PDT)
X-Gm-Message-State: AOAM532n3kKXynIKYqUHi6gUTWZH5UlzVpAyDCun13mJpVRJ2FcAOox9
        T81+u9Dw3HVCuXieiI+t3y4ILs0wb+Tz+f6OYA==
X-Google-Smtp-Source: ABdhPJz+0dKyJKUEfkNpCpRC7JhR6WPGEySbldXcqVYkedpLV4fENm918lH+so/d3rtJ6/6p0yYtjQ25q68y2oJ8AEw=
X-Received: by 2002:aca:f084:: with SMTP id o126mr1036512oih.106.1590073041174;
 Thu, 21 May 2020 07:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-2-Sergey.Semin@baikalelectronics.ru>
 <20200518152659.GA2525@bogus> <20200518212703.vju456kd3telctux@mobilestation>
In-Reply-To: <20200518212703.vju456kd3telctux@mobilestation>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 May 2020 08:57:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLLMh1LAvVXccyjLc4SqTAaPQ5LC7Nb6Q5ib8_3a0q6Ow@mail.gmail.com>
Message-ID: <CAL_JsqLLMh1LAvVXccyjLc4SqTAaPQ5LC7Nb6Q5ib8_3a0q6Ow@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Baikal-T1 System Boot SPI
 Controller binding
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 3:27 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Mon, May 18, 2020 at 09:26:59AM -0600, Rob Herring wrote:
> > On Fri, May 08, 2020 at 12:36:20PM +0300, Serge Semin wrote:
> > > Baikal-T1 Boot SPI is a part of the SoC System Controller and is
> > > responsible for the system bootup from an external SPI flash. It's a DW
> > > APB SSI-based SPI-controller with no interrupts, no DMA, with just one
> > > native chip-select available and a single reference clock. Since Baikal-T1
> > > SoC is normally booted up from an external SPI flash this SPI controller
> > > in most of the cases is supposed to be connected to a single SPI-nor
> > > flash. Additionally in order to provide a transparent from CPU point of
> > > view initial code execution procedure the system designers created an IP
> > > block which physically maps the SPI flash found at CS0 to a memory region.
> > >
> > > Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > > Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > Cc: Paul Burton <paulburton@kernel.org>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: John Garry <john.garry@huawei.com>
> > > Cc: Chuanhong Guo <gch981213@gmail.com>
> > > Cc: Tomer Maimon <tmaimon77@gmail.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: linux-mips@vger.kernel.org
> > > Cc: linux-spi@vger.kernel.org
> > > ---
> > >  .../bindings/spi/baikal,bt1-sys-ssi.yaml      | 100 ++++++++++++++++++
> > >  1 file changed, 100 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml b/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> > > new file mode 100644
> > > index 000000000000..d9d3257d78f4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> > > @@ -0,0 +1,100 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/spi/baikal,bt1-sys-ssi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Baikal-T1 System Boot SSI Controller
> > > +
> > > +description: |
> > > +  Baikal-T1 System Controller includes a Boot SPI Controller, which is
> > > +  responsible for loading chip bootup code from an external SPI flash. In order
> > > +  to do this transparently from CPU point of view there is a dedicated IP block
> > > +  mapping the 16MB flash to a dedicated MMIO range. The controller is based on
> > > +  the DW APB SSI IP-core but equipped with very limited resources: no IRQ,
> > > +  no DMA, a single native CS being necessarily connected to a 16MB SPI flash
> > > +  (otherwise the system won't bootup from the flash), internal Tx/Rx FIFO of
> > > +  just 8 bytes depth. Access to DW APB SSI controller registers is mutually
> > > +  exclusive from normal MMIO interface and from physically mapped SPI Flash
> > > +  memory. So either one or another way of using the controller functionality
> > > +  can be enabled at a time.
> > > +
> > > +maintainers:
> > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: spi-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: baikal,bt1-sys-ssi
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: Baikal-T1 Boot Controller configuration registers
> > > +      - description: Physically mapped SPI flash ROM found at CS0
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: config
> > > +      - const: map
> > > +
> > > +  clocks:
> > > +    description: SPI Controller reference clock source
> >
> > Can drop this.
>
> Ok.
>
> >
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: ssi_clk
> > > +
> > > +  num-cs:
> > > +    const: 1
> > > +
> > > +patternProperties:
> > > +  "^.*@[0-9a-f]+":
> > > +    type: object
> > > +    properties:
> > > +      reg:
> > > +        minimum: 0
> > > +        maximum: 0
> > > +
> > > +      spi-rx-bus-width:
> > > +        const: 1
> > > +
> > > +      spi-tx-bus-width:
> > > +        const: 1
> >
> > What's the point of these 2 properties if they aren't required?
>
> Yes, they are optional, but this is a constraint on the bus-width parameters.
> DW APB SSI provides a single laned Tx and Rx.

Are you just trying to keep someone from saying 'spi-tx-bus-width: 2'
for example?

You could also say 'spi-tx-bus-width: false' here to disallow the
property. I guess the above is fine.

Rob
