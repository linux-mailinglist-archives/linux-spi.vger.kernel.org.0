Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5F34E622
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhC3LNU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 07:13:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53974 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhC3LM6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 07:12:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UBCjWB121772;
        Tue, 30 Mar 2021 06:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617102765;
        bh=0jsNhfSoifLEWewqdcDh7xBYegM4KuhxB82BTLmVoVo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cjna9/KcnapfdqfPLrvwkD6j4MjVFD3XEV/FNBoJ017JJZTqil+fNY7myyIctc48e
         4CiR3WZr9npN+y6hplMahkPO1XBGlSWjQ777xUGTKf+dcXFeNbp2EFilcwXQqlVtIk
         jT0ewhPx900xQKrBJSNT4vjB3hKhDnptsXJi0RAg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UBCjOa028187
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 06:12:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 06:12:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 06:12:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UBCilE054537;
        Tue, 30 Mar 2021 06:12:44 -0500
Date:   Tue, 30 Mar 2021 16:42:43 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Brad Larson <brad@pensando.io>
CC:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <broonie@kernel.org>, <fancer.lancer@gmail.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <olof@lixom.net>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] dt-bindings: spi: cadence-qspi: Add support for
 Pensando Elba SoC
Message-ID: <20210330111243.ne23j7ycsvy634rw@ti.com>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-11-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-11-brad@pensando.io>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Brad,

On 28/03/21 06:59PM, Brad Larson wrote:
> Add new vendor Pensando Systems Elba SoC compatible
> string and convert to json-schema.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../bindings/spi/cadence-quadspi.txt          |  68 --------
>  .../bindings/spi/cadence-quadspi.yaml         | 153 ++++++++++++++++++
>  2 files changed, 153 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> deleted file mode 100644
> index 8ace832a2d80..000000000000
> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -* Cadence Quad SPI controller
> -
> -Required properties:
> -- compatible : should be one of the following:
> -	Generic default - "cdns,qspi-nor".
> -	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> -	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> -	For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
> -- reg : Contains two entries, each of which is a tuple consisting of a
> -	physical address and length. The first entry is the address and
> -	length of the controller register set. The second entry is the
> -	address and length of the QSPI Controller data area.
> -- interrupts : Unit interrupt specifier for the controller interrupt.
> -- clocks : phandle to the Quad SPI clock.
> -- cdns,fifo-depth : Size of the data FIFO in words.
> -- cdns,fifo-width : Bus width of the data FIFO in bytes.
> -- cdns,trigger-address : 32-bit indirect AHB trigger address.
> -
> -Optional properties:
> -- cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
> -- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
> -  the read data rather than the QSPI clock. Make sure that QSPI return
> -  clock is populated on the board before using this property.
> -
> -Optional subnodes:
> -Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
> -custom properties:
> -- cdns,read-delay : Delay for read capture logic, in clock cycles
> -- cdns,tshsl-ns : Delay in nanoseconds for the length that the master
> -                  mode chip select outputs are de-asserted between
> -		  transactions.
> -- cdns,tsd2d-ns : Delay in nanoseconds between one chip select being
> -                  de-activated and the activation of another.
> -- cdns,tchsh-ns : Delay in nanoseconds between last bit of current
> -                  transaction and deasserting the device chip select
> -		  (qspi_n_ss_out).
> -- cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
> -                  and first bit transfer.
> -- resets	: Must contain an entry for each entry in reset-names.
> -		  See ../reset/reset.txt for details.
> -- reset-names	: Must include either "qspi" and/or "qspi-ocp".
> -
> -Example:
> -
> -	qspi: spi@ff705000 {
> -		compatible = "cdns,qspi-nor";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xff705000 0x1000>,
> -		      <0xffa00000 0x1000>;
> -		interrupts = <0 151 4>;
> -		clocks = <&qspi_clk>;
> -		cdns,is-decoded-cs;
> -		cdns,fifo-depth = <128>;
> -		cdns,fifo-width = <4>;
> -		cdns,trigger-address = <0x00000000>;
> -		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
> -		reset-names = "qspi", "qspi-ocp";
> -
> -		flash0: n25q00@0 {
> -			...
> -			cdns,read-delay = <4>;
> -			cdns,tshsl-ns = <50>;
> -			cdns,tsd2d-ns = <50>;
> -			cdns,tchsh-ns = <4>;
> -			cdns,tslch-ns = <4>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> new file mode 100644
> index 000000000000..94d631045153
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/cadence-quadspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence Quad SPI controller
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +  - Brad Larson <brad@pensando.io>
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - cdns,qspi-nor       # Generic default
> +        - ti,k2g-qspi         # TI 66AK2G SoC
> +        - ti,am654-ospi       # TI AM654 SoC
> +        - intel,lgm-qspi      # Intel LGM SoC
> +        - pensando,cdns-qspi  # Pensando Elba SoC

Wouldn't this allow any combination of all 5 strings? So for example 
this would allow "ti,am654-ospi", "pensando,cdns-qspi" which is 
obviously not correct.

I sent a patch recently [0] that does this correctly and it has gotten 
Rob's blessing. So I suggest you build your patch on top of that.

[...]

[0] https://patchwork.kernel.org/project/spi-devel-general/patch/20210326130034.15231-5-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
