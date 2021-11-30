Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D7463F9E
	for <lists+linux-spi@lfdr.de>; Tue, 30 Nov 2021 22:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbhK3VJa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Nov 2021 16:09:30 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:47045 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhK3VJ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Nov 2021 16:09:29 -0500
Received: by mail-ot1-f47.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so1824455oto.13;
        Tue, 30 Nov 2021 13:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNGtXujFQD58NXv8jcekWW8P2vmfD3L7taqVXsPr+KI=;
        b=f18I0OFf7vQ4smJ6Z+Us+22YHTY0WhnO8rnnpMh0v56Eyg5po/dslr3uFx5yP1FRt/
         d+YxYXh89vdaj/XMirOU3vEvNfqTRl9oZOnfzyDNVffjzosIYLqolTCpvhBrCAPEAXne
         z4ZGxPHTHs1VttTQsTkbWZurtpVOeUrc9kZd/HaWWGry6t46QGAt5TYK4qoi0O6fhxrh
         3bRLLnL1htPo35schxlQQPDlQ9/RY94hhhSwt7TdWwnOXhYhU2cNTwN9UDpedHFYewyL
         kel7oE0YHeaRj9JbC2z6Vwv+DL/QyR+YaDBERgA+wlfYKBD/omW1Pu3pbqWP6Xr6tYHp
         6hwQ==
X-Gm-Message-State: AOAM531QAZ7kAEyI+4rwXRO2R4HggAYVzprQzhwjtqeqBv4KfMqRK0lo
        uLE52IiqO6njbgIzp7lnuhapBgX24g==
X-Google-Smtp-Source: ABdhPJyNcSN7GDvvk6HnphChTh1EOpfM2TVLdfw5MQ06e8tSxilgg+c6ksf6tj2HdDlNsdtKhY2nwQ==
X-Received: by 2002:a9d:5d7:: with SMTP id 81mr1581707otd.283.1638306369563;
        Tue, 30 Nov 2021 13:06:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i3sm2917218ooq.39.2021.11.30.13.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:06:08 -0800 (PST)
Received: (nullmailer pid 3011632 invoked by uid 1000);
        Tue, 30 Nov 2021 21:06:08 -0000
Date:   Tue, 30 Nov 2021 15:06:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: socfpga: change qspi to
 "intel,socfpga-qspi"
Message-ID: <YaaSQBhzCbanp8E3@robh.at.kernel.org>
References: <20211122160427.2808342-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122160427.2808342-1-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 10:04:26AM -0600, Dinh Nguyen wrote:
> Because of commit 9cb2ff111712 ("spi: cadence-quadspi: Disable Auto-HW polling"),
> which does a write to the CQSPI_REG_WR_COMPLETION_CTRL register
> regardless of any condition. Well, the Cadence QuadSPI controller on
> Intel's SoCFPGA platforms does not implement the
> CQSPI_REG_WR_COMPLETION_CTRL register, thus a write to this register
> results in a crash!
> 
> So starting with v5.16, I introduced the patch
> 98d948eb833 ("spi: cadence-quadspi: fix write completion support"),
> which adds the dts property "intel,socfpga-qspi" that is specific for
> the QSPI on SoCFPGA that doesn't have the CQSPI_REG_WR_COMPLETION_CTRL
> register implemented.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm/boot/dts/socfpga.dtsi                    | 2 +-
>  arch/arm/boot/dts/socfpga_arria10.dtsi            | 2 +-
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 +-
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 0b021eef0b53..108c3610bf52 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -782,7 +782,7 @@ ocram: sram@ffff0000 {
>  		};
>  
>  		qspi: spi@ff705000 {
> -			compatible = "cdns,qspi-nor";
> +			compatible = "intel,socfpga-qpsi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0xff705000 0x1000>,
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index a574ea91d9d3..e1a70f3a641d 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -756,7 +756,7 @@ usb0-ecc@ff8c8800 {
>  		};
>  
>  		qspi: spi@ff809000 {
> -			compatible = "cdns,qspi-nor";
> +			compatible = "intel,socfpga-qspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0xff809000 0x100>,
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index d301ac0d406b..d391153c9e6d 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -594,7 +594,7 @@ emac0-tx-ecc@ff8c0400 {
>  		};
>  
>  		qspi: spi@ff8d2000 {
> -			compatible = "cdns,qspi-nor";
> +			compatible = "intel,socfpga-qspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0xff8d2000 0x100>,
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 163f33b46e4f..de6dd2189e74 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -628,7 +628,7 @@ sdmmca-ecc@ff8c8c00 {
>  		};
>  
>  		qspi: spi@ff8d2000 {
> -			compatible = "cdns,qspi-nor";
> +			compatible = "intel,socfpga-qspi";

A few more comments...

Now instead of reusing the same generic compatible, you are reusing the 
same compatible across 4 different SoCs and setting yourself up for the 
same compatibility breakage again if there is some difference among 
these SoCs.

Also, keep "cdns,qspi-nor" as a fall back and you will solve the new DT 
+ old kernel combination and the schema errors.

Rob

