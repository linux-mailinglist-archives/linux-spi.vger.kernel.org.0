Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93092350F03
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDAG31 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 02:29:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50188 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDAG3P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 02:29:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1316T3vt127344;
        Thu, 1 Apr 2021 01:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617258543;
        bh=KgBDGJ0sBNbDZTEK8XA9+PiWEA3UFuwSnVfZ41ihSig=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=XJDBSvBTZwj1fFiNU1DZ0BKx/+xgT1/U1Cs+c61RuuuKXXmO6l3hrqsch+snfOU3T
         jQRgwd7M06cBmve6HCi71eSfZrnHgWi68qq2w775LmBg0I1hCO8hLeDp6i5er32gPI
         D+kh1gPMW7TXY3lhNPzUZm0N8FaD4cgOG8Gp9imU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1316T2v8061277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 01:29:03 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 01:29:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 01:29:02 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1316SxlP017070;
        Thu, 1 Apr 2021 01:29:00 -0500
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j7200-mcu: Fix ospi compatible
To:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-3-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9e63fa94-d313-b8f3-8cb9-3ca8fe6b4e16@ti.com>
Date:   Thu, 1 Apr 2021 11:58:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326130034.15231-3-p.yadav@ti.com>
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

>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 5408ec815d58..2ab5a7a15bd5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -271,7 +271,7 @@ hbmc: hyperbus@47034000 {
>  		};
>  
>  		ospi0: spi@47040000 {
> -			compatible = "ti,am654-ospi";
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>  			reg = <0x0 0x47040000 0x0 0x100>,
>  			      <0x5 0x00000000 0x1 0x0000000>;
>  			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> 
