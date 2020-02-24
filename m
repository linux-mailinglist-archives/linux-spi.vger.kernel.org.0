Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F7016AA86
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBXPyf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 10:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgBXPyf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Feb 2020 10:54:35 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26D02084E;
        Mon, 24 Feb 2020 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582559673;
        bh=+NGn+M0mQlE0yNIAvBGOmMokk3RrII5dt6NR04Viuk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qJHXRsaVKHk9CuZA+efz3G+gUQmSxAkC3EBTNrUn8zbD8aqgFUqFr3ycr2YD4Gei5
         HYtC/KVFCEwF8BTw2p4MT8L/OJeEZ/4ay2GLmM9i1wIIdQRaGZcyeXOJHull8RFDoY
         qMpZ+wVEQVJSveIhBVa5RGiJFt/qDGa5wVr6wccI=
Received: by mail-qt1-f176.google.com with SMTP id w47so6866631qtk.4;
        Mon, 24 Feb 2020 07:54:33 -0800 (PST)
X-Gm-Message-State: APjAAAU1U50JEX/tPMtPcfrhFYzUTzIaUobmvoPy34ozDODKwAmWhN72
        a+KQy5Zsik8Ev30mwTa5G3MtW6hGwAUMq7DTcg==
X-Google-Smtp-Source: APXvYqyMKJLH+j5eVS9viFKlt3W2mYzOAoyxDH5OJofoD++97zqPB/P4eo5ARGbFFlAcZ73HXI1GVprro5ZuxzAcZRI=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr49128250qtj.300.1582559672693;
 Mon, 24 Feb 2020 07:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 24 Feb 2020 09:54:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
Message-ID: <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        simon.k.r.goldschmidt@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        tien.fong.chee@intel.com,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 18, 2020 at 8:29 PM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Cc the DT list if you want this reviewed.

>
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> new file mode 100644
> index 000000000000..1a4d6e8d0d0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence QSPI Flash Controller support
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  Binding Documentation for Cadence QSPI controller,This controller is
> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
> +  has been tested On Intel's LGM SoC.
> +
> +  - compatible : should be one of the following:
> +        Generic default - "cdns,qspi-nor".
> +        For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> +        For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> +        For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +           - ti,k2g-qspi
> +        - const: cdns,qspi-nor
> +
> +      - items:
> +        - enum:
> +           - ti,am654-ospi
> +        - const: cdns,qspi-nor
> +
> +      - items:
> +        - enum:
> +           - intel,lgm-qspi
> +        - const: cdns,qspi-nor
> +
> +      - items:
> +        - const: cdns,qspi-nor
> +
> +  reg:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  cdns,fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the data FIFO in words.

A 4GB fifo is valid? Add some constraints.

> +
> +  cdns,fifo-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bus width of the data FIFO in bytes.

Add some constraints.

> +
> +  cdns,trigger-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      32-bit indirect AHB trigger address.
> +
> +  cdns,rclk-en:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Flag to indicate that QSPI return clock is used to latch the read data
> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
> +      on the board before using this property.
> +
> +# subnode's properties
> +patternProperties:
> +  "^.*@[0-9a-fA-F]+$":
> +    type: object
> +    description:
> +      flash device uses the subnodes below defined properties.
> +
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay for read capture logic, in clock cycles.

4 billion clock delay is valid?

> +
> +  cdns,tshsl-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32

You can drop this, anything with a standard unit suffix already has a type.

> +    description: |
> +      Delay in nanoseconds for the length that the master mode chip select
> +      outputs are de-asserted between transactions.

Constraints...?

> +
> +  cdns,tsd2d-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds between one chip select being de-activated
> +      and the activation of another.
> +
> +  cdns,tchsh-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).
> +
> +  cdns,tslch-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds between setting qspi_n_ss_out low and
> +      first bit transfer.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - cdns,fifo-depth
> +  - cdns,fifo-width
> +  - cdns,trigger-address
> +
> +examples:
> +  - |
> +    qspi: spi@ff705000 {
> +          compatible = "cdns,qspi-nor";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <0xff705000 0x1000>,
> +                <0xffa00000 0x1000>;
> +          interrupts = <0 151 4>;
> +          clocks = <&qspi_clk>;
> +          cdns,fifo-depth = <128>;
> +          cdns,fifo-width = <4>;
> +          cdns,trigger-address = <0x00000000>;
> +
> +          flash0: n25q00@0 {
> +              compatible = "jedec,spi-nor";
> +              reg = <0x0>;
> +              cdns,read-delay = <4>;
> +              cdns,tshsl-ns = <50>;
> +              cdns,tsd2d-ns = <50>;
> +              cdns,tchsh-ns = <4>;
> +              cdns,tslch-ns = <4>;
> +          };
> +    };
> +
> --
> 2.11.0
>
