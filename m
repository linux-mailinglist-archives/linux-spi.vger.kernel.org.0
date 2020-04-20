Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3531B0EA1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgDTOil (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 10:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbgDTOik (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Apr 2020 10:38:40 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B845020735;
        Mon, 20 Apr 2020 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587393519;
        bh=+DGLsi3SfobUu4UEs06d75/bKEBz2SreRY+kidIQn6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgYrxMMOkdMkrfa20rx8C0mXWLlrggN53mVav7oRmEA41sLboek5srPajPXqshBDm
         J92HLUex8je+lvGyjhV/zvab3y5j9/KaFqrpZilQPXW1oNTtPBpWwGQGxyXk/nl9f1
         QsL3g3BpeEUkwHdl+glra55mcKph9rRjFuqZllCI=
Date:   Mon, 20 Apr 2020 22:38:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, eha@deif.com,
        angelo@sysam.it, andrew.smirnov@gmail.com, gustavo@embeddedor.com,
        weic@nvidia.com, mhosny@nvidia.com, michael@walle.cc,
        peng.ma@nxp.com
Subject: Re: [PATCH v5 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for
 the mikroBUS
Message-ID: <20200420143831.GB32419@dragon>
References: <20200318001603.9650-1-olteanv@gmail.com>
 <20200318001603.9650-13-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318001603.9650-13-olteanv@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 18, 2020 at 02:16:03AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> For debugging, it is useful to have access to the DSPI controller
> signals. On the reference design board, these are exported to either the
> mikroBUS1 or mikroBUS2 connector (according to the CPLD register
> BRDCFG3[SPI3]).
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Changes in v5:
> None.
> 
> Changes in v4:
> None.
> 
> Changes in v3:
> None.
> 
> Changes in v2:
> Change compatible string for spidev node.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 6d05b76c2c7a..0d27b5667b8c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -83,6 +83,20 @@
>  	};
>  };
>  
> +&dspi2 {
> +	bus-num = <2>;
> +	status = "okay";
> +
> +	/* mikroBUS1 */
> +	spidev@0 {
> +		compatible = "rohm,dh2228fv";

Is the compatible documented?

Shawn

> +		spi-max-frequency = <20000000>;
> +		fsl,spi-cs-sck-delay = <100>;
> +		fsl,spi-sck-cs-delay = <100>;
> +		reg = <0>;
> +	};
> +};
> +
>  &esdhc {
>  	sd-uhs-sdr104;
>  	sd-uhs-sdr50;
> -- 
> 2.17.1
> 
