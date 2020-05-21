Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C861DD0D7
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgEUPMH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 11:12:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39078 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgEUPMH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 11:12:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 604D98030790;
        Thu, 21 May 2020 15:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NIsANa6IA8-3; Thu, 21 May 2020 18:11:59 +0300 (MSK)
Date:   Thu, 21 May 2020 18:11:58 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
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
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Baikal-T1 System Boot SPI
 Controller binding
Message-ID: <20200521151158.f3izg2svbn5dh6hy@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-2-Sergey.Semin@baikalelectronics.ru>
 <20200518152659.GA2525@bogus>
 <20200518212703.vju456kd3telctux@mobilestation>
 <CAL_JsqLLMh1LAvVXccyjLc4SqTAaPQ5LC7Nb6Q5ib8_3a0q6Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLLMh1LAvVXccyjLc4SqTAaPQ5LC7Nb6Q5ib8_3a0q6Ow@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 08:57:10AM -0600, Rob Herring wrote:
> On Mon, May 18, 2020 at 3:27 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Mon, May 18, 2020 at 09:26:59AM -0600, Rob Herring wrote:
> > > On Fri, May 08, 2020 at 12:36:20PM +0300, Serge Semin wrote:
> > > > Baikal-T1 Boot SPI is a part of the SoC System Controller and is
> > > > responsible for the system bootup from an external SPI flash. It's a DW
> > > > APB SSI-based SPI-controller with no interrupts, no DMA, with just one
> > > > native chip-select available and a single reference clock. Since Baikal-T1
> > > > SoC is normally booted up from an external SPI flash this SPI controller
> > > > in most of the cases is supposed to be connected to a single SPI-nor
> > > > flash. Additionally in order to provide a transparent from CPU point of
> > > > view initial code execution procedure the system designers created an IP
> > > > block which physically maps the SPI flash found at CS0 to a memory region.
> > > >
> > > > Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > > > Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > > Cc: Paul Burton <paulburton@kernel.org>
> > > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > > Cc: John Garry <john.garry@huawei.com>
> > > > Cc: Chuanhong Guo <gch981213@gmail.com>
> > > > Cc: Tomer Maimon <tmaimon77@gmail.com>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: linux-mips@vger.kernel.org
> > > > Cc: linux-spi@vger.kernel.org
> > > > ---
> > > >  .../bindings/spi/baikal,bt1-sys-ssi.yaml      | 100 ++++++++++++++++++
> > > >  1 file changed, 100 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml b/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> > > > new file mode 100644
> > > > index 000000000000..d9d3257d78f4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> > > > @@ -0,0 +1,100 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/spi/baikal,bt1-sys-ssi.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Baikal-T1 System Boot SSI Controller
> > > > +
> > > > +description: |
> > > > +  Baikal-T1 System Controller includes a Boot SPI Controller, which is
> > > > +  responsible for loading chip bootup code from an external SPI flash. In order
> > > > +  to do this transparently from CPU point of view there is a dedicated IP block
> > > > +  mapping the 16MB flash to a dedicated MMIO range. The controller is based on
> > > > +  the DW APB SSI IP-core but equipped with very limited resources: no IRQ,
> > > > +  no DMA, a single native CS being necessarily connected to a 16MB SPI flash
> > > > +  (otherwise the system won't bootup from the flash), internal Tx/Rx FIFO of
> > > > +  just 8 bytes depth. Access to DW APB SSI controller registers is mutually
> > > > +  exclusive from normal MMIO interface and from physically mapped SPI Flash
> > > > +  memory. So either one or another way of using the controller functionality
> > > > +  can be enabled at a time.
> > > > +
> > > > +maintainers:
> > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: spi-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: baikal,bt1-sys-ssi
> > > > +
> > > > +  reg:
> > > > +    items:
> > > > +      - description: Baikal-T1 Boot Controller configuration registers
> > > > +      - description: Physically mapped SPI flash ROM found at CS0
> > > > +
> > > > +  reg-names:
> > > > +    items:
> > > > +      - const: config
> > > > +      - const: map
> > > > +
> > > > +  clocks:
> > > > +    description: SPI Controller reference clock source
> > >
> > > Can drop this.
> >
> > Ok.
> >
> > >
> > > > +    maxItems: 1
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: ssi_clk
> > > > +
> > > > +  num-cs:
> > > > +    const: 1
> > > > +
> > > > +patternProperties:
> > > > +  "^.*@[0-9a-f]+":
> > > > +    type: object
> > > > +    properties:
> > > > +      reg:
> > > > +        minimum: 0
> > > > +        maximum: 0
> > > > +
> > > > +      spi-rx-bus-width:
> > > > +        const: 1
> > > > +
> > > > +      spi-tx-bus-width:
> > > > +        const: 1
> > >
> > > What's the point of these 2 properties if they aren't required?
> >
> > Yes, they are optional, but this is a constraint on the bus-width parameters.
> > DW APB SSI provides a single laned Tx and Rx.
> 
> Are you just trying to keep someone from saying 'spi-tx-bus-width: 2'
> for example?

Right.

> 
> You could also say 'spi-tx-bus-width: false' here to disallow the
> property. I guess the above is fine.

Ok. If it's fine I'll leave them as is then. Right?

What about the next question you've asked:

> >
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> >
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> >
> > These 2 are required by spi-controller.yaml, so you can drop here.
> 
> Yes, "#address-cells" is required, but "#size-cells" isn't. Is this supposed to
> be like that?

As far as I can see in spi-controller.yaml, "#address-cells" is required, but
"#size-cells" isn't. Is this intentional?

-Sergey

> 
> Rob
