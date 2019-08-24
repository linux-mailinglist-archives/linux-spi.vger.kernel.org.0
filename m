Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152F69BF4B
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2019 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfHXShB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 24 Aug 2019 14:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfHXShB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 24 Aug 2019 14:37:01 -0400
Received: from X250 (cm-84.211.118.175.getinternet.no [84.211.118.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6CDA21897;
        Sat, 24 Aug 2019 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566671820;
        bh=bLkoRt7V89o7Y8hLjEcVFDgB9HJCyvuoCmSBCtHCiZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/+6hlkQsxLxo1bC5JbDLWChN6zVVaUVuQh4NYCkjq548G6w75qBXCP+mURI6l1PW
         70cYDFfFMrbF3gO8n1ambm1lSjNh25A0ThGMSB7MH1Vy2Es+w/08HH+hstc8hgDfrP
         P69sYlzls8gzc8W9xXKJPKZJHs819q6qjPlCkB9k=
Date:   Sat, 24 Aug 2019 20:36:48 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: dts: ls1088a: Add the DSPI controller node
Message-ID: <20190824183647.GC14936@X250>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
 <20190801083105.30102-2-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801083105.30102-2-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 01, 2019 at 04:31:04PM +0800, Chuanhua Han wrote:
> This patch adds the DSPI controller node for ls1088a boards.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index dacd8cf..fe8f1bd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -252,6 +252,19 @@
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		dspi: spi@2100000 {
> +			compatible = "fsl,ls1088a-dspi",
> +						"fsl,ls1021a-v1.0-dspi";

I fixed the indent to have two compatible strings aligned on same
column when applying.

Shawn

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2100000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "dspi";
> +			clocks = <&clockgen 4 1>;
> +			spi-num-chipselects = <6>;
> +			status = "disabled";
> +		};
> +
>  		duart0: serial@21c0500 {
>  			compatible = "fsl,ns16550", "ns16550a";
>  			reg = <0x0 0x21c0500 0x0 0x100>;
> -- 
> 2.9.5
> 
