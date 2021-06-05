Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C719D39C45D
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFEA1C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 20:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEA1B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 20:27:01 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11717C061766
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 17:25:00 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id e12so3562427ual.7
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUFuRMnJeUbsvj2QDdwiuwSD5F69c4BG1mDs2axqiTs=;
        b=zM5TBVEXzzTUIEFhS1qRdHVmP1tXYlBOmQd4/VjMnJ3DmdqFFU6bkbLyfrNxxnyWa9
         blKUy6wA4j4eLX6D4rq1IoWM59ghqmVMwl0PuYuzcZRjV+Q4Rjp84cUyclR0WyP4zOzG
         vsolpHhgM0Xcwpw48NzYsTtSoedzBg7VxM7QZipwYmptd21HTQy4ujjenVI1qzBiCaep
         46wgeIFWFIed9H1Mej2xxgNiZVUdtORElQoVwE5W2SHA8EKBMNh1aLhXGxm/N3ShFfzk
         c4CE/7gCakEjXeOM9aOcaOSO2Rx9LnqHKnQByJsVJfV9PXN+OTkq5V8kNAvBaboI25PF
         2FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUFuRMnJeUbsvj2QDdwiuwSD5F69c4BG1mDs2axqiTs=;
        b=E7XR08u15YEw08+nuC3+iZ0URb3f4N99wdD7nWha0ImH7B01Qy7hTqQL1w7zb23yYw
         8ni0Vbc0JN11dw4h1LOYQZdDTe45qgzw7t5i2rDzLibUrc8r3XNFTw/d8qUIUWgIYdkg
         szmkCuNzVJ8TScBlFiQ80xHvwIMXS3VJ0tD+gaSY5qSedC5UhqzMSSy8X82WNbfMg059
         9ZeCiUmYrFv9MQ9A7o77YfolmqU9LX2AGQAZTGHKbhxBDdhCesqRuzuyX2ZgFP55LMpS
         aHH9cpCwscsVayi4BCvsmtDuqw6XiJ/0M/ubPahM5PNgVAhb1zBwuIKPlXySCkHECZ29
         omIw==
X-Gm-Message-State: AOAM5313JbA/YSWUbcxpaxS2rI/ZPzSm9D/Cs7Pvgg6Ow3QDHDzY3pL7
        OjQB4nn6DBzROsKLXG+XjLuUXW6kpVA7cZ8A/fTJ
X-Google-Smtp-Source: ABdhPJy9MkmawDbOqXM8+0aak1zP96RnH18mtJOi8a8jw6esgtXEdnoySjtaD9YwZ/eE+42Yp3tI/fy1eEBGblAJGhA=
X-Received: by 2002:a05:6122:40e:: with SMTP id e14mr4179610vkd.20.1622852699138;
 Fri, 04 Jun 2021 17:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210531141538.721613-1-iwamatsu@nigauri.org> <20210604214608.GA3974358@robh.at.kernel.org>
In-Reply-To: <20210604214608.GA3974358@robh.at.kernel.org>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Sat, 5 Jun 2021 09:24:32 +0900
Message-ID: <CABMQnV+waVdAcnbdYJnxt8rM2JfdcTuPBnJ+XK0Pie1Twar0Fg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: convert Cadence SPI bindings to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harini Katakam <harinik@xilinx.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Thanks for your review.

2021=E5=B9=B46=E6=9C=885=E6=97=A5(=E5=9C=9F) 6:46 Rob Herring <robh@kernel.=
org>:
>
> On Mon, May 31, 2021 at 11:15:38PM +0900, Nobuhiro Iwamatsu wrote:
> > Convert spi for Cadence SPI bindings documentation to YAML.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  .../devicetree/bindings/spi/spi-cadence.txt   | 30 ---------
> >  .../devicetree/bindings/spi/spi-cadence.yaml  | 63 +++++++++++++++++++
> >  2 files changed, 63 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.t=
xt
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.txt b/Do=
cumentation/devicetree/bindings/spi/spi-cadence.txt
> > deleted file mode 100644
> > index 05a2ef945664be..00000000000000
> > --- a/Documentation/devicetree/bindings/spi/spi-cadence.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -Cadence SPI controller Device Tree Bindings
> > --------------------------------------------
> > -
> > -Required properties:
> > -- compatible         : Should be "cdns,spi-r1p6" or "xlnx,zynq-spi-r1p=
6".
> > -- reg                        : Physical base address and size of SPI r=
egisters map.
> > -- interrupts         : Property with a value describing the interrupt
> > -                       number.
> > -- clock-names                : List of input clock names - "ref_clk", =
"pclk"
> > -                       (See clock bindings for details).
> > -- clocks             : Clock phandles (see clock bindings for details)=
.
> > -
> > -Optional properties:
> > -- num-cs             : Number of chip selects used.
> > -                       If a decoder is used, this will be the number o=
f
> > -                       chip selects after the decoder.
> > -- is-decoded-cs              : Flag to indicate whether decoder is use=
d or not.
> > -
> > -Example:
> > -
> > -     spi@e0007000 {
> > -             compatible =3D "xlnx,zynq-spi-r1p6";
> > -             clock-names =3D "ref_clk", "pclk";
> > -             clocks =3D <&clkc 26>, <&clkc 35>;
> > -             interrupt-parent =3D <&intc>;
> > -             interrupts =3D <0 49 4>;
> > -             num-cs =3D <4>;
> > -             is-decoded-cs =3D <0>;
> > -             reg =3D <0xe0007000 0x1000>;
> > -     } ;
> > diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/D=
ocumentation/devicetree/bindings/spi/spi-cadence.yaml
> > new file mode 100644
> > index 00000000000000..27a7121ed0f9ae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/spi-cadence.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence SPI controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Michal Simek <michal.simek@xilinx.com>
> > +
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - cdns,spi-r1p6
> > +      - xlnx,zynq-spi-r1p6
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ref_clk
> > +      - const: pclk
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  num-cs:
> > +    description: |
> > +      Number of chip selects used. If a decoder is used,
> > +      this will be the number of chip selects after the
> > +      decoder.
> > +    minimum: 1
> > +    maximum: 4
> > +    default: 4
> > +
> > +  is-decoded-cs:
>
> Needs a type ref. Despite being called a 'flag' looks like it's an
> uint32. Presumably, it also needs:
>
> enum: [ 0, 1 ]

Yeah, this is a flag, but the driver source code uses it as u32.
So, I will add ref and enum, thanks.

>
> > +    description: |
> > +      Flag to indicate whether decoder is used or not.
> > +    default: 0

Best regards,
  Nobuhiro
