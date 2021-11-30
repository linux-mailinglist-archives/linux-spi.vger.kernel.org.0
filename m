Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79C3463F94
	for <lists+linux-spi@lfdr.de>; Tue, 30 Nov 2021 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbhK3VEL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Nov 2021 16:04:11 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41980 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbhK3VCu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Nov 2021 16:02:50 -0500
Received: by mail-ot1-f42.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so32015692otl.8;
        Tue, 30 Nov 2021 12:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=svwr0vs5VT0Q8CjflnZ+WVv0gkwSlvUflUqNPItWZlI=;
        b=gKB0VRA7pUQ7tf7h5SHvavPXrrmYqcU4+/RjVFAzmK2c+IxcLogS1KKS0MV4w7m8HG
         gIPBadm2dMcem3GzOJp0Rlk+Z71ZeFgezpVVoI4KuM8G5g4cSie6bSbmexcYguooiQO6
         nchi4E7xjuz/anRvR4m7jrmWlcvXsDIlLISstvkjgikcYDMgShSy2w9XYkW3ooK7Jv7i
         AUPaCh2jtY1IChbTfwEau0XHxiX/wjjrAPMeMSdm6rDLCgGOr54wB55vW9+/MQz1Tykz
         kfUiLMqdjmgEDTiEtyjKanuKNVWnHcczprhgaSTQRGXG2Wki1LzdmYoqpl9nx1GnwktO
         7s/Q==
X-Gm-Message-State: AOAM531Q6vxHQ5WwxAM/nHxlS0QF25pnKHHDEOA0bzMKXD8O2oIhVD1/
        JroxIeJlkWzeTeLw50/k0RlBXvQJ6Q==
X-Google-Smtp-Source: ABdhPJxoHxWUEqLpDX8XbzPAmWWaHH+g+kzebw3LdX+tSOJ6OAmyuKgSbxivNbf0gnBcww0kIxAfzQ==
X-Received: by 2002:a05:6830:2692:: with SMTP id l18mr1549382otu.353.1638305968633;
        Tue, 30 Nov 2021 12:59:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t13sm4134963oiw.30.2021.11.30.12.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:59:28 -0800 (PST)
Received: (nullmailer pid 3003102 invoked by uid 1000);
        Tue, 30 Nov 2021 20:59:27 -0000
Date:   Tue, 30 Nov 2021 14:59:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: socfpga: change qspi to
 "intel,socfpga-qspi"
Message-ID: <YaaQr6RmTC0BMeV+@robh.at.kernel.org>
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

'intel,socfpga-qspi' is not a DT property. It's a value for 
'compatible'.

Is this change going to stable? That would at least fix old kernels 
with new DT (assuming they get stable updates). But new kernels with old 
DT are still broken. Not a great story here.

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

Obviously not tested.


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
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0xff8d2000 0x100>,
> -- 
> 2.25.1
> 
> 
