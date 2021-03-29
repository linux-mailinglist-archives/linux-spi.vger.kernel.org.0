Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1234D6F1
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 20:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhC2SXS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 14:23:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35496 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhC2SXP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 14:23:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12TIN0Ox067572;
        Mon, 29 Mar 2021 13:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617042180;
        bh=Jxihftcf2cWN5Q6+IVWtEeFM6HzI0GBtBGxvWSWY1QU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dNmQqLqMbVGHeJMUOX/cuz+Nfy/wkmsCSDJeDPSLzBWaI4dZLwg/HFHbsI+62/TQn
         HGYWUT8GIT2kRRDwj1Iae5Bv/v1b/XGORXgFsWk+2xWzUxYzg3QqQXWzd4IjjuaW1s
         Z4BkYr2kf/4WFIxdRO8+0a2Kip9EIXsRfdGrNX4E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12TIN0Yl008057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Mar 2021 13:23:00 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 29
 Mar 2021 13:23:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 29 Mar 2021 13:23:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12TIMxeb105726;
        Mon, 29 Mar 2021 13:23:00 -0500
Date:   Mon, 29 Mar 2021 23:52:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210329182256.q4zhss6lezj3s44a@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-5-p.yadav@ti.com>
 <20210327183628.GA345487@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210327183628.GA345487@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/03/21 12:36PM, Rob Herring wrote:
> On Fri, Mar 26, 2021 at 06:30:34PM +0530, Pratyush Yadav wrote:
> > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > 
> > There is no way as of now to have a parent or bus defining properties
> > for child nodes. For now, avoid it in the example to silence warnings on
> > dt_schema_check. We can figure out how to deal with actual dts files
> > later.
> > 
> > Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > [p.yadav@ti.com: Fix how compatible is defined, make reset optional, fix
> > minor typos, remove subnode properties in example, update commit
> > message.]
> > ---
> >  .../bindings/spi/cadence-quadspi.txt          |  68 ---------
> >  .../bindings/spi/cdns,qspi-nor.yaml           | 143 ++++++++++++++++++
> >  2 files changed, 143 insertions(+), 68 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> >  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> 
> 
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > new file mode 100644
> > index 000000000000..0e7087cc8bf9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > @@ -0,0 +1,143 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence Quad SPI controller
> > +
> > +maintainers:
> > +  - Pratyush Yadav <p.yadav@ti.com>
> > +
> > +allOf:
> > +  - $ref: spi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - ti,k2g-qspi
> > +              - ti,am654-ospi
> > +              - intel,lgm-qspi
> > +          - const: cdns,qspi-nor
> > +      - const: cdns,qspi-nor
> > +
> > +  reg:
> > +    items:
> > +      - description: the controller register set
> > +      - description: the controller data area
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  cdns,fifo-depth:
> > +    description:
> > +      Size of the data FIFO in words.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    enum: [ 128, 256 ]
> > +    default: 128
> > +
> > +  cdns,fifo-width:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Bus width of the data FIFO in bytes.
> > +    default: 4
> 
> I assume there's some constraints on this?

IIUC this is a matter of how the peripheral is implemented and there are 
no clear constraints. Different implementations can use different bus 
widths for the SRAM bus but I don't see any mention of minimum or 
maximum values. FWIW, all users in the kernel use a 4 byte bus.

> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

> 
> > +
> > +  cdns,trigger-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      32-bit indirect AHB trigger address.
> > +
> > +  cdns,is-decoded-cs:
> > +    type: boolean
> > +    description:
> > +      Flag to indicate whether decoder is used to select different chip select
> > +      for different memory regions.
> > +
> > +  cdns,rclk-en:
> > +    type: boolean
> > +    description:
> > +      Flag to indicate that QSPI return clock is used to latch the read
> > +      data rather than the QSPI clock. Make sure that QSPI return clock
> > +      is populated on the board before using this property.
> > +
> > +  resets:
> > +    maxItems: 2
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      enum: [ qspi, qspi-ocp ]
> > +
> > +# subnode's properties
> > +patternProperties:
> > +  "@[0-9a-f]+$":
> > +    type: object
> > +    description:
> > +      Flash device uses the below defined properties in the subnode.
> > +
> > +    properties:
> > +      cdns,read-delay:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Delay for read capture logic, in clock cycles.
> > +
> > +      cdns,tshsl-ns:
> > +        description:
> > +          Delay in nanoseconds for the length that the master mode chip select
> > +          outputs are de-asserted between transactions.
> > +
> > +      cdns,tsd2d-ns:
> > +        description:
> > +          Delay in nanoseconds between one chip select being de-activated
> > +          and the activation of another.
> > +
> > +      cdns,tchsh-ns:
> > +        description:
> > +          Delay in nanoseconds between last bit of current transaction and
> > +          deasserting the device chip select (qspi_n_ss_out).
> > +
> > +      cdns,tslch-ns:
> > +        description:
> > +          Delay in nanoseconds between setting qspi_n_ss_out low and
> > +          first bit transfer.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - cdns,fifo-depth
> > +  - cdns,fifo-width
> > +  - cdns,trigger-address
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    qspi: spi@ff705000 {
> > +      compatible = "cdns,qspi-nor";
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      reg = <0xff705000 0x1000>,
> > +            <0xffa00000 0x1000>;
> > +      interrupts = <0 151 4>;
> > +      clocks = <&qspi_clk>;
> > +      cdns,fifo-depth = <128>;
> > +      cdns,fifo-width = <4>;
> > +      cdns,trigger-address = <0x00000000>;
> > +      resets = <&rst 0x1>, <&rst 0x2>;
> > +      reset-names = "qspi", "qspi-ocp";
> > +
> > +      flash@0 {
> > +              compatible = "jedec,spi-nor";
> > +              reg = <0x0>;
> > +      };
> > +    };
> > -- 
> > 2.30.0
> > 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
