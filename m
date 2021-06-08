Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAE3A00AE
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhFHSqD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 14:46:03 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42515 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhFHSmg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 14:42:36 -0400
Received: by mail-ed1-f46.google.com with SMTP id i13so25722537edb.9;
        Tue, 08 Jun 2021 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/V7ksUiiZB58zMxMRkULUFDegQBYCL2IF/rhUEMXHc=;
        b=IJbqV6FUUfi7qCArMillGRxl4VycBJhs5gYs1Lf0mMvJYu5kw345uaLWVcikHjOxiy
         TFJQhy70+KtzUmpSPBAGITjsAaU9yHpuRah8PWUPx3giAgGmLDxqxAxGFPEvIjWZjadh
         /XjD+XNLZrd1n4PDsyvZtPLrlI1pJCUtfwVXSCJ8CiAXMFZFYxladyIDH8tGjl30wMkf
         vtr/ZiqQVcAVouktL/hMNvpZFd06DgNsv1ovNfmfLhFR4HIfRNfViVNesEUjSkCN7EZV
         pNso+09KKYl9bWgGxOaRKlV2AfV7pPF7LZelGToKFJmpdo8SJ2CMdKHVVOa5ZFr1TDSi
         +4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/V7ksUiiZB58zMxMRkULUFDegQBYCL2IF/rhUEMXHc=;
        b=GFGF6Xkp/7aqtHEYmokIbaHLRxFmlZFj70DLZsZXpQXaoI+aAWIrqyRNuTGruk1zs/
         PQNm8YCD9hlS7+a5lPf4FgFIMS8YKaFUs6QXZGrg/T7MwONmmdAO+WfbHIzdlBYgOVTT
         vcJjGrBuGZXddPv+q6hW1MD9yqRR0Caj7nzhRMVcscDB2P2cmPEtQS1daFJcE9G1MIqR
         mdxpnOaDFHpONejmhTU+TE2ty4gCT5pgHHif0kmG4XtDXMv89tOjMmwy8Vpz22r2wlRO
         OvA5RAgPrZlcMF0sUfsBoOHj3gf0XCeu7rIQ0B0XPwnLy2NogbDk+6GP5ZDT3WDbth1I
         ds9w==
X-Gm-Message-State: AOAM533uTpn2LR4Zk5tqDwN0soQrS/BUootlVlHP/f5cVoZ+knD5iAGo
        EXeeKV3VzX3A3Jl8E7WyYDm76RNVs6VPCg==
X-Google-Smtp-Source: ABdhPJxi/SXwX8f6NHTk5beJ5dr9fZw0669BTAJnkBXZ5K/oYpH7fAlpLbYQC+bUjrsGqeChFLoUQw==
X-Received: by 2002:a50:8dc6:: with SMTP id s6mr27186109edh.50.1623177566310;
        Tue, 08 Jun 2021 11:39:26 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z7sm174358ejm.122.2021.06.08.11.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:39:25 -0700 (PDT)
Subject: Re: [PATCH v6 5/8] arm: dts: rockchip: Add SFC to RK3036
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20210608022644.21074-1-jon.lin@rock-chips.com>
 <20210608023305.25371-1-jon.lin@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <b5f29e1c-f4ec-7a08-a97c-8a516ba6649a@gmail.com>
Date:   Tue, 8 Jun 2021 20:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608023305.25371-1-jon.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/8/21 4:33 AM, Jon Lin wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add a devicetree entry for the Rockchip SFC for the RK3036 SOC.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  arch/arm/boot/dts/rk3036.dtsi | 42 +++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index e24230d50a78..e7faf815ca74 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -206,6 +206,17 @@
>  		status = "disabled";
>  	};
>  
> +	sfc: spi@10208000 {
> +		compatible = "rockchip,rk3036-sfc";
> +		reg = <0x10208000 0x4000>;
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
> +		clock-names = "hclk_sfc", "clk_sfc";
> +		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
> +		pinctrl-names = "default";
> +		status = "disabled";
> +	};
> +
>  	sdmmc: mmc@10214000 {
>  		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x10214000 0x4000>;
> @@ -684,6 +695,37 @@
>  			};
>  		};
>  

> +		serial_flash {

sfc {

Nodes are sort alphabetically.
Sort other patches with sfc nodes in this serie as well.
Maybe rename nodename consistent with sfc label?
Similar to nfc nodes?

> +			sfc_bus4: sfc-bus4 {
> +				rockchip,pins =

> +					<1 RK_PD0 3 &pcfg_pull_none>,
> +					<1 RK_PD1 3 &pcfg_pull_none>,
> +					<1 RK_PD2 3 &pcfg_pull_none>,
> +					<1 RK_PD3 3 &pcfg_pull_none>;

Keep align with the rest in the pinctrl node.
Check that in other sfc patches as well.

> +			};
> +
> +			sfc_bus2: sfc-bus2 {
> +				rockchip,pins =

> +					<1 RK_PD0 3 &pcfg_pull_none>,
> +					<1 RK_PD1 3 &pcfg_pull_none>;

dito

> +			};
> +
> +			sfc_cs0: sfc-cs0 {
> +				rockchip,pins =

> +					<2 RK_PA2 3 &pcfg_pull_none>;

dito

> +			};
> +
> +			sfc_cs1: sfc-cs1 {
> +				rockchip,pins =

> +					<2 RK_PA3 3 &pcfg_pull_none>;

dito

> +			};
> +
> +			sfc_clk: sfc-clk {
> +				rockchip,pins =

> +					<2 RK_PA4 3 &pcfg_pull_none>;

dito

> +			};
> +		};
> +
>  		emac {
>  			emac_xfer: emac-xfer {
>  				rockchip,pins = <2 RK_PB2 1 &pcfg_pull_default>, /* crs_dvalid */
> 
