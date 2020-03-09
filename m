Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119CC17E813
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 20:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCITGe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 15:06:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38155 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgCITGe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 15:06:34 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D9C6D23EDA;
        Mon,  9 Mar 2020 20:06:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583780791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdVZVnFbpfoFLdQOqIrp0CLvmnfwSC3yBcsX83MdnRo=;
        b=ZolYOmg50XSId6PGMI1a5HwOx8vJiqGhFgbhFA6YwWsKizEEuI4/r/LJz9iaPpfoFZhGxD
        5w/gHNisa3uHqP+nfIxPVrFma/nM9VIaZISuGAnZRlHzZ8ab434Fz9a5k4ZBsDNbEyp/BH
        RrmkgRkxgeYzj2TB/3ZEC2uUoga6NPw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 20:06:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the
 DSPI controllers
In-Reply-To: <20200309145624.10026-6-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-6-olteanv@gmail.com>
Message-ID: <83af52172a3cabd662de1ed9574e4247@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: D9C6D23EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.388];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> LS1028A has a functional connection to the eDMA module. Even if the
> spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the 
> slots
> in the DMAMUX for connecting the eDMA channels to the 3 DSPI
> controllers.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 515e0a1b934f..18155273a46e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -298,6 +298,8 @@
>  			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "dspi";
>  			clocks = <&clockgen 4 1>;
> +			dmas = <&edma0 0 62>, <&edma0 0 60>;
> +			dma-names = "tx", "rx";

minor nit. Other nodes specified the dma channels as

dma-names = "tx", "rx";
dmas = <&edma0 0 62>,
        <&edma0 0 60>;

-michael

>  			spi-num-chipselects = <4>;
>  			little-endian;
>  			status = "disabled";
> @@ -311,6 +313,8 @@
>  			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "dspi";
>  			clocks = <&clockgen 4 1>;
> +			dmas = <&edma0 0 58>, <&edma0 0 56>;
> +			dma-names = "tx", "rx";
>  			spi-num-chipselects = <4>;
>  			little-endian;
>  			status = "disabled";
> @@ -324,6 +328,8 @@
>  			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "dspi";
>  			clocks = <&clockgen 4 1>;
> +			dmas = <&edma0 0 54>, <&edma0 0 2>;
> +			dma-names = "tx", "rx";
>  			spi-num-chipselects = <3>;
>  			little-endian;
>  			status = "disabled";
