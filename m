Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8BEF47F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2019 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKEEaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 23:30:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46706 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKEEaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Nov 2019 23:30:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA54U86m020708;
        Mon, 4 Nov 2019 22:30:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572928208;
        bh=k+Xm46G90D+LUV4sRFTaoSNRP8gbMZVRqUwk2h+V8Mk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=osHdHHG7bx1sr9CrFpi/hS7cQgMXK5ShmKeydx9nPvBGx6ACSC1EcFZ0xjfLzX1LI
         fI5TDxtupEgH2tHgoBQVZGknccQ4It+lb4cbA74PiT9H0TxsiFbyCT4aub4whkTwKL
         kiPDxRgsWBV3z95ch76QhI1wav1nxxbJRjrCATBs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA54U87x045944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Nov 2019 22:30:08 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 4 Nov
 2019 22:29:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 4 Nov 2019 22:29:53 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA54U49R050727;
        Mon, 4 Nov 2019 22:30:05 -0600
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191030081155.29947-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b553b1e8-1c35-fd7c-6855-75a4c1c943fe@ti.com>
Date:   Tue, 5 Nov 2019 10:00:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030081155.29947-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 30/10/19 1:41 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
> 

The new driver being added in patch 2/2 is supposed to replace
drivers/mtd/spi-nor/cadence-quadspi.c. Therefore the bindings should be
exactly same as
Documentation/devicetree/bindings/mtd/cadence-quadspi.txt. Otherwise, it
breaks DT backward compatibility. There cannot be two different sets of
bindings for same HW IP.

Therefore please rewrite yaml schema to match existing bindings at
Documentation/devicetree/bindings/mtd/cadence-quadspi.txt.
And then include a patch dropping older bindings.


> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence,qspi.yaml      | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> new file mode 100644
> index 000000000000..295501f01e5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cadence,qspi.yaml#"
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
> +  Add support for the Cadence QSPI controller,This controller is
> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
> +  has been tested On Intel's LGM SoC.
> +
> +properties:
> +  compatible:
> +    const: cadence,qspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clocks-names:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +examples:
> +  - |
> +    spi@ec000000 {
> +          compatible = "cadence,qspi";
> +          reg = <0xec000000 0x100>;
> +          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
> +          clock-names = "qspi";
> +          resets = <&rcu0 0x10 1>;
> +          reset-names = "qspi";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          flash: flash@1 {
> +              compatible = "spi-nand", "jedec, spi-nor";

s/"jedec, spi-nor"/"jedec,spi-nor" (i.e no space after comma)

> +              reg = <1>;
> +              spi-max-frequency = <10000000>;
> +          };
> +    };
> +
> 

-- 
Regards
Vignesh
