Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422E39DDDC
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFGNmt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 09:42:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGNms (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 09:42:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157DelfA065132;
        Mon, 7 Jun 2021 08:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623073247;
        bh=XIRhjm6c/H5np6FKJM7OWMRS5z/xWNTKW2NoHX5pFUI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hjrdjGA4/mkgRgErxkgA2WbdfJpaYYWTf4X8uwNvMU4pHOmBxmA41kpQmxR3A8q23
         4dLEFWqc1WTQ8D1NlphXCOH/t7vE3CLlpZI5sgLI/heahqpOtC0wp6qqZafd3rjd9l
         ipSqo9w48mfKlyb4JXBrvsDqumxXQ+KchqU5bn9U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157DelkS087488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 08:40:47 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 08:40:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 08:40:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157DeleB040758;
        Mon, 7 Jun 2021 08:40:47 -0500
Date:   Mon, 7 Jun 2021 08:40:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in
 property with dt-shema
Message-ID: <20210607134047.isfuedgjxpubpcb5@ungloved>
References: <20210602123416.20378-1-a-govindraju@ti.com>
 <20210602123416.20378-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210602123416.20378-4-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18:04-20210602, Aswath Govindraju wrote:
> ti,pindir-d0-out-d1-in property is expected to be of type boolean.
> Therefore, fix the property accordingly.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
No need for Fixes?

Also please split up the patches per maintainer so that we are'nt
confused on who should pick what etc..

> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index f4ec9ed52939..23d51b6a9cf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -575,7 +575,7 @@
>  
>  	#address-cells = <1>;
>  	#size-cells= <0>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  };
>  
>  &tscadc0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index eddb2ffb93ca..1b947e2c2e74 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -299,7 +299,7 @@
>  	pinctrl-0 = <&main_spi0_pins_default>;
>  	#address-cells = <1>;
>  	#size-cells= <0>;
> -	ti,pindir-d0-out-d1-in = <1>;
> +	ti,pindir-d0-out-d1-in;
>  
>  	flash@0{
>  		compatible = "jedec,spi-nor";
> -- 
> 2.17.1
> 


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
