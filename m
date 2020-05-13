Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF181D0A38
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgEMHtH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 03:49:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49114 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgEMHtH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 03:49:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D7n4Le097562;
        Wed, 13 May 2020 02:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589356144;
        bh=wtW22k3rGw5O3JPO++YwPMQIM+B/57xeHXQmnyUUzLU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GxtA4sBWJkP7z72g3cMS/CWNj2rGfz81ocUu96x7f8aPdI2kjvyEsk9W1pGTtP8c6
         6pl8fol2DAfch3SJZaxNxODQzvvHyNtt957q1GfZ2tFMJ6tmQFfgTLAzMwHjN/QChO
         jHhyQ4UFWygDXEKKxZ8GrT5raQWR+m+wnDmSBVKw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D7n4am077526
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 02:49:04 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 02:49:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 02:49:04 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D7n0k3005183;
        Wed, 13 May 2020 02:49:01 -0500
Subject: Re: [PATCH 3/5] dt-bindings: ufs: ti: Fix address properties handling
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
 <20200512204543.22090-3-robh@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <503c62d9-d85d-ea14-8659-8a18ba47932e@ti.com>
Date:   Wed, 13 May 2020 13:19:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512204543.22090-3-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 13/05/20 2:15 am, Rob Herring wrote:
> The ti,j721e-ufs schema and example have a couple of problems related to
> address properties. First, the default #size-cells and #address-cells
> are 1 for examples, so they need to be overriden with a bus node.
> Second, address translation for the child ufs node is broken because
> 'ranges', '#address-cells', and '#size-cells' are missing from the
> schema.
> 
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> Please ack, dependency for patch 5.
> 
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml | 57 ++++++++++++-------
>  1 file changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> index c8a2a92074df..b503b1a918a5 100644
> --- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> @@ -25,6 +25,14 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
>  required:
>    - compatible
>    - reg
> @@ -44,25 +52,32 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> -    ufs_wrapper: ufs-wrapper@4e80000 {
> -       compatible = "ti,j721e-ufs";
> -       reg = <0x0 0x4e80000 0x0 0x100>;
> -       power-domains = <&k3_pds 277>;
> -       clocks = <&k3_clks 277 1>;
> -       assigned-clocks = <&k3_clks 277 1>;
> -       assigned-clock-parents = <&k3_clks 277 4>;
> -       #address-cells = <2>;
> -       #size-cells = <2>;
> -
> -       ufs@4e84000 {
> -          compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
> -          reg = <0x0 0x4e84000 0x0 0x10000>;
> -          interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -          freq-table-hz = <19200000 19200000>;
> -          power-domains = <&k3_pds 277>;
> -          clocks = <&k3_clks 277 1>;
> -          assigned-clocks = <&k3_clks 277 1>;
> -          assigned-clock-parents = <&k3_clks 277 4>;
> -          clock-names = "core_clk";
> -       };
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        ufs-wrapper@4e80000 {
> +            compatible = "ti,j721e-ufs";
> +            reg = <0x0 0x4e80000 0x0 0x100>;
> +            power-domains = <&k3_pds 277>;
> +            clocks = <&k3_clks 277 1>;
> +            assigned-clocks = <&k3_clks 277 1>;
> +            assigned-clock-parents = <&k3_clks 277 4>;
> +
> +            ranges = <0x0 0x0 0x0 0x4e80000 0x0 0x14000>;
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +
> +            ufs@4000 {
> +                compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
> +                reg = <0x0 0x4000 0x0 0x10000>;
> +                interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +                freq-table-hz = <19200000 19200000>;
> +                power-domains = <&k3_pds 277>;
> +                clocks = <&k3_clks 277 1>;
> +                assigned-clocks = <&k3_clks 277 1>;
> +                assigned-clock-parents = <&k3_clks 277 4>;
> +                clock-names = "core_clk";
> +            };
> +        };
>      };
> 
