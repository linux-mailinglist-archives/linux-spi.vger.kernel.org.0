Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75356350F0C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 08:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhDAG34 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 02:29:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41478 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhDAG33 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 02:29:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1316TPqC010563;
        Thu, 1 Apr 2021 01:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617258565;
        bh=BCWwIOZAToVB1zjc2FZJOGcDFBCSn5bED+i1Xo70h9I=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jn9qchsCgPAlq3f1WBpEs1HObw/EtqJpO2E3Bm2epJQ/WHkfAIS2OOSicgEk/eMst
         xSqrMo+vKH7vb1zQL/XqHraMw3ankNvOPNanoelIdNFvYXhqQHhVGioOBfjSL+MFpE
         bVb75dHM4l8GXK3T3xqqe91layLextrgcnHNOAxc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1316TOql076744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 01:29:24 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 01:29:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 01:29:24 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1316TLPv052307;
        Thu, 1 Apr 2021 01:29:22 -0500
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am64-main: Fix ospi compatible
To:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-4-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7c1d9ee8-ff31-31c9-d113-e16babaf464d@ti.com>
Date:   Thu, 1 Apr 2021 11:59:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326130034.15231-4-p.yadav@ti.com>
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

>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index b997d13f9ec5..3cbdd33384a0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -592,7 +592,7 @@ fss: bus@fc00000 {
>  		ranges;
>  
>  		ospi0: spi@fc40000 {
> -			compatible = "ti,am654-ospi";
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>  			reg = <0x00 0x0fc40000 0x00 0x100>,
>  			      <0x05 0x00000000 0x01 0x00000000>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> 
