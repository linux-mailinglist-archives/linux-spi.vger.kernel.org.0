Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9247A350F05
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhDAG3Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 02:29:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhDAG3M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 02:29:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1316SwGl010255;
        Thu, 1 Apr 2021 01:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617258538;
        bh=83G0jg0CVCTALW/jk3X1pVsmYXT59w8rlxUSmNlwagg=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=FOz2lVVpT7wSH5QuRMgj7SJeikEmUZNaSt7qMo4eWcTeushfOjqTPiP33e8uudcIt
         9kc5mm5hie8/ayTHNU3H3MShMOkK+9Xwvlf9C6LtISdZ4IjsX24Km9W4oN0oNaV8hu
         aamgvGDr20LM0VtA1RMoCZwnkqa26HYOrcdUV9EE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1316SvsK085229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 01:28:58 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 01:28:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 01:28:57 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1316SsB7005171;
        Thu, 1 Apr 2021 01:28:55 -0500
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j721e-mcu: Fix ospi compatible
To:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-2-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <18b87b48-84b0-bae6-c5c3-6e849282302b@ti.com>
Date:   Thu, 1 Apr 2021 11:58:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326130034.15231-2-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/26/21 6:30 PM, Pratyush Yadav wrote:
> The TI specific compatible should be followed by the generic
> "cdns,qspi-nor" compatible.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 6c44afae9187..d56e3475aee7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -180,7 +180,7 @@ fss: fss@47000000 {
>  		ranges;
>  
>  		ospi0: spi@47040000 {
> -			compatible = "ti,am654-ospi";
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>  			reg = <0x0 0x47040000 0x0 0x100>,
>  				<0x5 0x00000000 0x1 0x0000000>;
>  			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> @@ -197,7 +197,7 @@ ospi0: spi@47040000 {
>  		};
>  
>  		ospi1: spi@47050000 {
> -			compatible = "ti,am654-ospi";
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>  			reg = <0x0 0x47050000 0x0 0x100>,
>  				<0x7 0x00000000 0x1 0x00000000>;
>  			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
> 
