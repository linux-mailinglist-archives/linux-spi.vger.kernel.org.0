Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF44004BC
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhICSSb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 14:18:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56784 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhICSSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Sep 2021 14:18:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 183IHQZD099054;
        Fri, 3 Sep 2021 13:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630693046;
        bh=mgtbI7z2oZMDQrpBLW1Cw/cSN6DvX0dtcfuh1Bxyu/g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dfdRy9dBprHD+AQk0gKrSCBTIZQy7S8AdCpEf6N+61yjSrb14BXcnS3FCm9Nalld2
         +CTOIsiQqgOm+5hn8rwjf2EkS+2g9PnkW9EISy5muj7+e920TLFcv5+X7urVIdGpHI
         qOo9XL+K1yVQDzxnlDD2+PqrgirEk1or1iPLpdUU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 183IHQpO055963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 13:17:26 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Sep 2021 13:17:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Sep 2021 13:17:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 183IHPI8023084;
        Fri, 3 Sep 2021 13:17:26 -0500
Date:   Fri, 3 Sep 2021 23:47:24 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Parshuram Thombare <pthombar@cadence.com>
CC:     <broonie@kernel.org>, <lukas@wunner.de>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Message-ID: <20210903181722.ukarfanyew2b7yoz@ti.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499829-20059-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1630499829-20059-1-git-send-email-pthombar@cadence.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/09/21 02:37PM, Parshuram Thombare wrote:
> Add DT binding for Cadence's XSPI controller driver.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> new file mode 100644
> index 0000000..e52d6fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020-21 Cadence
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence XSPI Controller
> +
> +maintainers:
> +  - Parshuram Thombare <pthombar@cadence.com>
> +
> +description: |
> +  The XSPI controller allows SPI protocol communication in
> +  single, dual, quad or octal wire transmission modes for
> +  read/write access to slaves such as SPI-NOR flash.

This needs to be a "subclass" of the spi-controller.yaml binding.

allOf:
  - $ref: spi-controller.yaml#

> +
> +properties:
> +  compatible:
> +    const: cdns,xspi-nor
> +
> +  reg:
> +    items:
> +      - description: address and length of the controller register set
> +      - description: address and length of the Slave DMA data port
> +      - description: address and length of the auxiliary registers
> +
> +  reg-names:
> +    items:
> +      - const: xspi-iobase
> +      - const: xspi-sdmabase
> +      - const: xspi-auxbase
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    xspi: spi@a0010000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "cdns,xspi-nor";
> +        reg = <0x0 0xa0010000 0x0 0x10000>,
> +              <0x0 0xb0000000 0x0 0x10000>,
> +              <0x0 0xa0020000 0x0 0x10000>;
> +        reg-names = "xspi-iobase", "xspi-sdmabase", "xspi-auxbase";
> +        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&gic>;
> +        mt35xu512@0 {

Node name should be flash@0.

> +            compatible = "spi-nor", "micron,mt35xu512";

These compatibles are arbitrary and undocumented. You probably just need 
"jedec,spi-nor". If you need anything else, you need to justify why.

Please run dt_binding_check, it should point this out. See [0].

> +            spi-max-frequency = <75000000>;
> +            reg = <0>;
> +        };
> +        mt35xu512@1 {
> +            compatible = "spi-nor", "micron,mt35xu512";

Same as above.

> +            spi-max-frequency = <75000000>;
> +            reg = <1>;
> +        };
> +    };
> -- 
> 2.7.4
> 

[0] https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html#testing

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
