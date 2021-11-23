Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE37B45A1ED
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhKWLx5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 06:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhKWLxy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 06:53:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5959560ED4;
        Tue, 23 Nov 2021 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637668246;
        bh=Y9EfOe4Irn7HwH6lIBBbNKCpKL4rE4qPfeY7yu04H1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DePDGVnFWcEQpAUP2W0wujH/cZObujnvkocsLa29FI930gyrL++OaoaM1YrJE+Y9Q
         OWRko61bLH61VEwzD3dnu58R5s6+7M9gxipUKP6shUjOo8LsBfDQKWBtXXruGMiOMV
         Mf10rhHxvPB6icyY//2/RTJ25Zi1gYw2327FbYNeqC2Q5k4bAJmEJdTAZNXpfSpKbR
         MrEUNAiMyJaehi+a4VafU5nGlVYEMfhrJAoRdfzZoslIwAZSZF1gZNLLRlI5oW1ekn
         m7kUE6HlZjCFndZ4HQtebbLFrG0gkGXtRgw8Gf3O+3axQbuo3ARBRsbsZjqiOvibv7
         VcWWGlN3ozIow==
Date:   Tue, 23 Nov 2021 19:50:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, aisheng.dong@nxp.com, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org, broonie@kernel.org, linux@roeck-us.net,
        wim@linux-watchdog.org, linux@rempel-privat.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 8/9] arm64: dts: imx8ulp: Add the basic dtsi file for
 imx8ulp
Message-ID: <20211123115032.GA4216@dragon>
References: <20211112082930.3809351-1-peng.fan@oss.nxp.com>
 <20211112082930.3809351-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112082930.3809351-9-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 04:29:29PM +0800, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add the basic dtsi support for i.MX8ULP.
> 
> i.MX 8ULP is part of the ULP family with emphasis on extreme
> low-power techniques using the 28 nm fully depleted silicon on
> insulator process. Like i.MX 7ULP, i.MX 8ULP continues to be
> based on asymmetric architecture, however will add a third DSP
> domain for advanced voice/audio capability and a Graphics domain
> where it is possible to access graphics resources from the
> application side or the realtime side.
> 
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
>   - v4
>    Fix build error after rebase
>    Drop usb nodes and alias, drop fec node
> 
>   - v3 changes:
>     no
>  
>   - v2 changes:
>     update the license
>     update the compatible property for usb related node
> 
>  .../boot/dts/freescale/imx8ulp-pinfunc.h      | 978 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 396 +++++++
>  2 files changed, 1374 insertions(+)
>  create mode 100755 arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
> new file mode 100755
> index 000000000000..b204ac79b449
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
> @@ -0,0 +1,978 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#ifndef __DTS_IMX8ULP_PINFUNC_H
> +#define __DTS_IMX8ULP_PINFUNC_H
> +
> +/*
> + * The pin function ID is a tuple of
> + * <mux_reg input_reg mux_mode input_val>
> + */
> +#define MX8ULP_PAD_PTD0__PTD0                                        0x0000 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD0__I2S6_RX_BCLK                                0x0000 0x0B44 0x7 0x1
> +#define MX8ULP_PAD_PTD0__SDHC0_RESET_B                               0x0000 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD0__FLEXSPI2_B_DQS                              0x0000 0x0974 0x9 0x1
> +#define MX8ULP_PAD_PTD0__CLKOUT2                                     0x0000 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD0__EPDC0_SDCLK_B                               0x0000 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD0__LP_APD_DBG_MUX_0                            0x0000 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD0__CLKOUT1                                     0x0000 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD0__DEBUG_MUX0_0                                0x0000 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD0__DEBUG_MUX1_0                                0x0000 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD1__PTD1                                        0x0004 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD1__I2S6_RX_FS                                  0x0004 0x0B48 0x7 0x1
> +#define MX8ULP_PAD_PTD1__SDHC0_CMD                                   0x0004 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD1__FLEXSPI2_B_DATA7                            0x0004 0x0970 0x9 0x1
> +#define MX8ULP_PAD_PTD1__EPDC0_SDCLK                                 0x0004 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD1__DPI0_PCLK                                   0x0004 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD1__LP_APD_DBG_MUX_1                            0x0004 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD1__DEBUG_MUX0_1                                0x0004 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD1__DEBUG_MUX1_1                                0x0004 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD2__PTD2                                        0x0008 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD2__I2S6_RXD0                                   0x0008 0x0B34 0x7 0x1
> +#define MX8ULP_PAD_PTD2__SDHC0_CLK                                   0x0008 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD2__FLEXSPI2_B_DATA6                            0x0008 0x096C 0x9 0x1
> +#define MX8ULP_PAD_PTD2__EPDC0_SDLE                                  0x0008 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD2__DPI0_HSYNC                                  0x0008 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD2__LP_APD_DBG_MUX_2                            0x0008 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD2__DEBUG_MUX0_2                                0x0008 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD2__DEBUG_MUX1_2                                0x0008 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD3__PTD3                                        0x000C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD3__I2S6_RXD1                                   0x000C 0x0B38 0x7 0x1
> +#define MX8ULP_PAD_PTD3__SDHC0_D7                                    0x000C 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD3__FLEXSPI2_B_DATA5                            0x000C 0x0968 0x9 0x1
> +#define MX8ULP_PAD_PTD3__EPDC0_GDSP                                  0x000C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD3__DPI0_VSYNC                                  0x000C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD3__LP_APD_DBG_MUX_3                            0x000C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD3__DEBUG_MUX0_3                                0x000C 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD3__DEBUG_MUX1_3                                0x000C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD4__PTD4                                        0x0010 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD4__EXT_AUD_MCLK3                               0x0010 0x0B14 0x4 0x1
> +#define MX8ULP_PAD_PTD4__SDHC0_VS                                    0x0010 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTD4__TPM8_CH5                                    0x0010 0x0B2C 0x6 0x1
> +#define MX8ULP_PAD_PTD4__I2S6_MCLK                                   0x0010 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD4__SDHC0_D6                                    0x0010 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD4__FLEXSPI2_B_DATA4                            0x0010 0x0964 0x9 0x1
> +#define MX8ULP_PAD_PTD4__EPDC0_SDCE0                                 0x0010 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD4__DPI0_DE                                     0x0010 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD4__LP_APD_DBG_MUX_4                            0x0010 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD4__DEBUG_MUX0_4                                0x0010 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD4__DEBUG_MUX1_4                                0x0010 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD5__PTD5                                        0x0014 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD5__SDHC0_CD                                    0x0014 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTD5__TPM8_CH4                                    0x0014 0x0B28 0x6 0x1
> +#define MX8ULP_PAD_PTD5__I2S6_TX_BCLK                                0x0014 0x0B4C 0x7 0x1
> +#define MX8ULP_PAD_PTD5__SDHC0_D5                                    0x0014 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD5__FLEXSPI2_B_SS0_B                            0x0014 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD5__FLEXSPI2_B_SCLK_B                           0x0014 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD5__EPDC0_D0                                    0x0014 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD5__DPI0_D0                                     0x0014 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD5__LP_APD_DBG_MUX_5                            0x0014 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD5__DEBUG_MUX0_5                                0x0014 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD5__DEBUG_MUX1_5                                0x0014 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD6__PTD6                                        0x0018 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD6__SDHC0_WP                                    0x0018 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTD6__TPM8_CH3                                    0x0018 0x0B24 0x6 0x1
> +#define MX8ULP_PAD_PTD6__I2S6_TX_FS                                  0x0018 0x0B50 0x7 0x1
> +#define MX8ULP_PAD_PTD6__SDHC0_D4                                    0x0018 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD6__FLEXSPI2_B_SCLK                             0x0018 0x0978 0x9 0x1
> +#define MX8ULP_PAD_PTD6__EPDC0_D1                                    0x0018 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD6__DPI0_D1                                     0x0018 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD6__LP_APD_DBG_MUX_6                            0x0018 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD6__DEBUG_MUX0_6                                0x0018 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD6__DEBUG_MUX1_6                                0x0018 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD7__PTD7                                        0x001C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD7__TPM8_CH2                                    0x001C 0x0B20 0x6 0x1
> +#define MX8ULP_PAD_PTD7__I2S6_TXD0                                   0x001C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD7__SDHC0_D3                                    0x001C 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD7__FLEXSPI2_B_DATA3                            0x001C 0x0960 0x9 0x1
> +#define MX8ULP_PAD_PTD7__EPDC0_D2                                    0x001C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD7__DPI0_D2                                     0x001C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD7__LP_APD_DBG_MUX_7                            0x001C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD7__DEBUG_MUX0_7                                0x001C 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD7__DEBUG_MUX1_7                                0x001C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD8__PTD8                                        0x0020 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD8__TPM8_CH1                                    0x0020 0x0B1C 0x6 0x1
> +#define MX8ULP_PAD_PTD8__I2S6_TXD1                                   0x0020 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD8__SDHC0_D2                                    0x0020 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD8__FLEXSPI2_B_DATA2                            0x0020 0x095C 0x9 0x1
> +#define MX8ULP_PAD_PTD8__EPDC0_D3                                    0x0020 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD8__DPI0_D3                                     0x0020 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD8__LP_APD_DBG_MUX_8                            0x0020 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD8__DEBUG_MUX1_8                                0x0020 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD9__PTD9                                        0x0024 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD9__TPM8_CLKIN                                  0x0024 0x0B30 0x6 0x1
> +#define MX8ULP_PAD_PTD9__I2S6_TXD2                                   0x0024 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD9__SDHC0_D1                                    0x0024 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD9__FLEXSPI2_B_DATA1                            0x0024 0x0958 0x9 0x1
> +#define MX8ULP_PAD_PTD9__EPDC0_D4                                    0x0024 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD9__DPI0_D4                                     0x0024 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD9__LP_APD_DBG_MUX_9                            0x0024 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD9__DEBUG_MUX1_9                                0x0024 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD10__PTD10                                      0x0028 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD10__TPM8_CH0                                   0x0028 0x0B18 0x6 0x1
> +#define MX8ULP_PAD_PTD10__I2S6_TXD3                                  0x0028 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD10__SDHC0_D0                                   0x0028 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD10__FLEXSPI2_B_DATA0                           0x0028 0x0954 0x9 0x1
> +#define MX8ULP_PAD_PTD10__EPDC0_D5                                   0x0028 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD10__DPI0_D5                                    0x0028 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD10__LP_APD_DBG_MUX_10                          0x0028 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTD10__DEBUG_MUX1_10                              0x0028 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD11__PTD11                                      0x002C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD11__TPM8_CH5                                   0x002C 0x0B2C 0x6 0x2
> +#define MX8ULP_PAD_PTD11__I2S6_RXD2                                  0x002C 0x0B3C 0x7 0x1
> +#define MX8ULP_PAD_PTD11__SDHC0_DQS                                  0x002C 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD11__FLEXSPI2_B_SS0_B                           0x002C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD11__FLEXSPI2_A_SS1_B                           0x002C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD11__EPDC0_D6                                   0x002C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD11__DPI0_D6                                    0x002C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD11__LP_APD_DBG_MUX_11                          0x002C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD12__PTD12                                      0x0030 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD12__USB0_ID                                    0x0030 0x0AC8 0x5 0x1
> +#define MX8ULP_PAD_PTD12__SDHC2_D3                                   0x0030 0x0AA4 0x6 0x1
> +#define MX8ULP_PAD_PTD12__I2S7_RX_BCLK                               0x0030 0x0B64 0x7 0x1
> +#define MX8ULP_PAD_PTD12__SDHC1_DQS                                  0x0030 0x0A84 0x8 0x1
> +#define MX8ULP_PAD_PTD12__FLEXSPI2_A_SS0_B                           0x0030 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD12__FLEXSPI2_B_SS1_B                           0x0030 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD12__EPDC0_D7                                   0x0030 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD12__DPI0_D7                                    0x0030 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD12__LP_APD_DBG_MUX_12                          0x0030 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD13__PTD13                                      0x0034 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD13__SPDIF_IN3                                  0x0034 0x0B80 0x4 0x1
> +#define MX8ULP_PAD_PTD13__USB0_PWR                                   0x0034 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTD13__SDHC2_D2                                   0x0034 0x0AA0 0x6 0x1
> +#define MX8ULP_PAD_PTD13__I2S7_RX_FS                                 0x0034 0x0B68 0x7 0x1
> +#define MX8ULP_PAD_PTD13__SDHC1_RESET_B                              0x0034 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTD13__FLEXSPI2_A_SCLK                            0x0034 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD13__CLKOUT2                                    0x0034 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD13__EPDC0_D8                                   0x0034 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD13__DPI0_D8                                    0x0034 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD13__CLKOUT1                                    0x0034 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD13__LP_APD_DBG_MUX_13                          0x0034 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD14__PTD14                                      0x0038 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD14__SPDIF_OUT3                                 0x0038 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTD14__USB0_OC                                    0x0038 0x0AC0 0x5 0x1
> +#define MX8ULP_PAD_PTD14__SDHC2_D1                                   0x0038 0x0A9C 0x6 0x1
> +#define MX8ULP_PAD_PTD14__I2S7_RXD0                                  0x0038 0x0B54 0x7 0x1
> +#define MX8ULP_PAD_PTD14__SDHC1_D7                                   0x0038 0x0A80 0x8 0x1
> +#define MX8ULP_PAD_PTD14__FLEXSPI2_A_DATA3                           0x0038 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD14__TRACE0_D7                                  0x0038 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD14__EPDC0_D9                                   0x0038 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD14__DPI0_D9                                    0x0038 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD14__LP_APD_DBG_MUX_14                          0x0038 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD15__PTD15                                      0x003C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD15__SPDIF_IN2                                  0x003C 0x0B7C 0x4 0x1
> +#define MX8ULP_PAD_PTD15__SDHC1_VS                                   0x003C 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTD15__SDHC2_D0                                   0x003C 0x0A98 0x6 0x1
> +#define MX8ULP_PAD_PTD15__I2S7_TX_BCLK                               0x003C 0x0B6C 0x7 0x1
> +#define MX8ULP_PAD_PTD15__SDHC1_D6                                   0x003C 0x0A7C 0x8 0x1
> +#define MX8ULP_PAD_PTD15__FLEXSPI2_A_DATA2                           0x003C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD15__TRACE0_D6                                  0x003C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD15__EPDC0_D10                                  0x003C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD15__DPI0_D10                                   0x003C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD15__LP_APD_DBG_MUX_15                          0x003C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD16__PTD16                                      0x0040 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD16__FXIO1_D31                                  0x0040 0x08A0 0x2 0x1
> +#define MX8ULP_PAD_PTD16__LPSPI4_PCS1                                0x0040 0x08F8 0x3 0x1
> +#define MX8ULP_PAD_PTD16__SPDIF_OUT2                                 0x0040 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTD16__SDHC1_CD                                   0x0040 0x0A58 0x5 0x1
> +#define MX8ULP_PAD_PTD16__SDHC2_CLK                                  0x0040 0x0A90 0x6 0x1
> +#define MX8ULP_PAD_PTD16__I2S7_TX_FS                                 0x0040 0x0B70 0x7 0x1
> +#define MX8ULP_PAD_PTD16__SDHC1_D5                                   0x0040 0x0A78 0x8 0x1
> +#define MX8ULP_PAD_PTD16__FLEXSPI2_A_DATA1                           0x0040 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD16__TRACE0_D5                                  0x0040 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD16__EPDC0_D11                                  0x0040 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD16__DPI0_D11                                   0x0040 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD16__LP_APD_DBG_MUX_16                          0x0040 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD17__PTD17                                      0x0044 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD17__FXIO1_D30                                  0x0044 0x089C 0x2 0x1
> +#define MX8ULP_PAD_PTD17__LPSPI4_PCS2                                0x0044 0x08FC 0x3 0x1
> +#define MX8ULP_PAD_PTD17__EXT_AUD_MCLK3                              0x0044 0x0B14 0x4 0x2
> +#define MX8ULP_PAD_PTD17__SDHC1_WP                                   0x0044 0x0A88 0x5 0x1
> +#define MX8ULP_PAD_PTD17__SDHC2_CMD                                  0x0044 0x0A94 0x6 0x1
> +#define MX8ULP_PAD_PTD17__I2S7_TXD0                                  0x0044 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD17__SDHC1_D4                                   0x0044 0x0A74 0x8 0x1
> +#define MX8ULP_PAD_PTD17__FLEXSPI2_A_DATA0                           0x0044 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD17__TRACE0_D4                                  0x0044 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD17__EPDC0_D12                                  0x0044 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD17__DPI0_D12                                   0x0044 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD17__LP_APD_DBG_MUX_17                          0x0044 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD18__PTD18                                      0x0048 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD18__FXIO1_D29                                  0x0048 0x0894 0x2 0x1
> +#define MX8ULP_PAD_PTD18__LPSPI4_PCS3                                0x0048 0x0900 0x3 0x1
> +#define MX8ULP_PAD_PTD18__SPDIF_CLK                                  0x0048 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTD18__EXT_AUD_MCLK3                              0x0048 0x0B14 0x5 0x3
> +#define MX8ULP_PAD_PTD18__TPM8_CH0                                   0x0048 0x0B18 0x6 0x2
> +#define MX8ULP_PAD_PTD18__I2S7_MCLK                                  0x0048 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD18__SDHC1_D3                                   0x0048 0x0A70 0x8 0x1
> +#define MX8ULP_PAD_PTD18__FLEXSPI2_A_DQS                             0x0048 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD18__TRACE0_D3                                  0x0048 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD18__EPDC0_D13                                  0x0048 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD18__DPI0_D13                                   0x0048 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD18__LP_APD_DBG_MUX_18                          0x0048 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD19__PTD19                                      0x004C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD19__FXIO1_D28                                  0x004C 0x0890 0x2 0x1
> +#define MX8ULP_PAD_PTD19__SPDIF_IN0                                  0x004C 0x0B74 0x4 0x1
> +#define MX8ULP_PAD_PTD19__TPM8_CH1                                   0x004C 0x0B1C 0x6 0x2
> +#define MX8ULP_PAD_PTD19__I2S6_RXD3                                  0x004C 0x0B40 0x7 0x1
> +#define MX8ULP_PAD_PTD19__SDHC1_D2                                   0x004C 0x0A6C 0x8 0x1
> +#define MX8ULP_PAD_PTD19__FLEXSPI2_A_DATA7                           0x004C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD19__TRACE0_D2                                  0x004C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD19__EPDC0_D14                                  0x004C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD19__DPI0_D14                                   0x004C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD19__LP_APD_DBG_MUX_19                          0x004C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD20__PTD20                                      0x0050 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD20__FXIO1_D27                                  0x0050 0x088C 0x2 0x1
> +#define MX8ULP_PAD_PTD20__LPSPI4_SIN                                 0x0050 0x0908 0x3 0x1
> +#define MX8ULP_PAD_PTD20__SPDIF_OUT0                                 0x0050 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTD20__TPM8_CLKIN                                 0x0050 0x0B30 0x6 0x2
> +#define MX8ULP_PAD_PTD20__I2S7_RXD1                                  0x0050 0x0B58 0x7 0x1
> +#define MX8ULP_PAD_PTD20__SDHC1_D1                                   0x0050 0x0A68 0x8 0x1
> +#define MX8ULP_PAD_PTD20__FLEXSPI2_A_DATA6                           0x0050 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD20__TRACE0_D1                                  0x0050 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD20__EPDC0_D15                                  0x0050 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTD20__DPI0_D15                                   0x0050 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD20__LP_APD_DBG_MUX_20                          0x0050 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD21__PTD21                                      0x0054 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD21__FXIO1_D26                                  0x0054 0x0888 0x2 0x1
> +#define MX8ULP_PAD_PTD21__LPSPI4_SOUT                                0x0054 0x090C 0x3 0x1
> +#define MX8ULP_PAD_PTD21__SPDIF_IN1                                  0x0054 0x0B78 0x4 0x1
> +#define MX8ULP_PAD_PTD21__USB1_PWR                                   0x0054 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTD21__TPM8_CH2                                   0x0054 0x0B20 0x6 0x2
> +#define MX8ULP_PAD_PTD21__I2S7_TXD1                                  0x0054 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD21__SDHC1_D0                                   0x0054 0x0A64 0x8 0x1
> +#define MX8ULP_PAD_PTD21__FLEXSPI2_A_DATA5                           0x0054 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD21__TRACE0_D0                                  0x0054 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD21__DPI0_D16                                   0x0054 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD21__WDOG5_RST                                  0x0054 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTD21__LP_APD_DBG_MUX_21                          0x0054 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD22__PTD22                                      0x0058 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD22__FXIO1_D25                                  0x0058 0x0884 0x2 0x1
> +#define MX8ULP_PAD_PTD22__LPSPI4_SCK                                 0x0058 0x0904 0x3 0x1
> +#define MX8ULP_PAD_PTD22__SPDIF_OUT1                                 0x0058 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTD22__USB1_OC                                    0x0058 0x0AC4 0x5 0x1
> +#define MX8ULP_PAD_PTD22__TPM8_CH3                                   0x0058 0x0B24 0x6 0x2
> +#define MX8ULP_PAD_PTD22__I2S7_TXD2                                  0x0058 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD22__SDHC1_CLK                                  0x0058 0x0A5C 0x8 0x1
> +#define MX8ULP_PAD_PTD22__FLEXSPI2_A_DATA4                           0x0058 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD22__TRACE0_CLKOUT                              0x0058 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD22__DPI0_D17                                   0x0058 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD22__LP_APD_DBG_MUX_22                          0x0058 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTD23__PTD23                                      0x005C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTD23__FXIO1_D24                                  0x005C 0x0880 0x2 0x1
> +#define MX8ULP_PAD_PTD23__LPSPI4_PCS0                                0x005C 0x08F4 0x3 0x1
> +#define MX8ULP_PAD_PTD23__USB1_ID                                    0x005C 0x0ACC 0x5 0x1
> +#define MX8ULP_PAD_PTD23__TPM8_CH4                                   0x005C 0x0B28 0x6 0x2
> +#define MX8ULP_PAD_PTD23__I2S7_TXD3                                  0x005C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTD23__SDHC1_CMD                                  0x005C 0x0A60 0x8 0x1
> +#define MX8ULP_PAD_PTD23__FLEXSPI2_A_SS0_B                           0x005C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTD23__FLEXSPI2_A_SCLK_B                          0x005C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTD23__DPI0_D18                                   0x005C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTD23__LP_APD_DBG_MUX_23                          0x005C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE0__PTE0                                        0x0080 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE0__FXIO1_D23                                   0x0080 0x087C 0x2 0x1
> +#define MX8ULP_PAD_PTE0__SPDIF_IN3                                   0x0080 0x0B80 0x3 0x2
> +#define MX8ULP_PAD_PTE0__LPUART4_CTS_B                               0x0080 0x08DC 0x4 0x1
> +#define MX8ULP_PAD_PTE0__LPI2C4_SCL                                  0x0080 0x08C8 0x5 0x1
> +#define MX8ULP_PAD_PTE0__TPM8_CLKIN                                  0x0080 0x0B30 0x6 0x3
> +#define MX8ULP_PAD_PTE0__I2S7_RXD2                                   0x0080 0x0B5C 0x7 0x1
> +#define MX8ULP_PAD_PTE0__SDHC2_D1                                    0x0080 0x0A9C 0x8 0x2
> +#define MX8ULP_PAD_PTE0__FLEXSPI2_B_DQS                              0x0080 0x0974 0x9 0x2
> +#define MX8ULP_PAD_PTE0__ENET0_CRS                                   0x0080 0x0AE8 0xa 0x1
> +#define MX8ULP_PAD_PTE0__DBI0_WRX                                    0x0080 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE0__DPI0_D19                                    0x0080 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE0__WUU1_P0                                     0x0080 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE0__DEBUG_MUX0_8                                0x0080 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE0__DEBUG_MUX1_11                               0x0080 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE1__PTE1                                        0x0084 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE1__FXIO1_D22                                   0x0084 0x0878 0x2 0x1
> +#define MX8ULP_PAD_PTE1__SPDIF_OUT3                                  0x0084 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTE1__LPUART4_RTS_B                               0x0084 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTE1__LPI2C4_SDA                                  0x0084 0x08CC 0x5 0x1
> +#define MX8ULP_PAD_PTE1__TPM8_CH0                                    0x0084 0x0B18 0x6 0x3
> +#define MX8ULP_PAD_PTE1__I2S7_RXD3                                   0x0084 0x0B60 0x7 0x1
> +#define MX8ULP_PAD_PTE1__SDHC2_D0                                    0x0084 0x0A98 0x8 0x2
> +#define MX8ULP_PAD_PTE1__FLEXSPI2_B_DATA7                            0x0084 0x0970 0x9 0x2
> +#define MX8ULP_PAD_PTE1__ENET0_COL                                   0x0084 0x0AE4 0xa 0x1
> +#define MX8ULP_PAD_PTE1__DBI0_CSX                                    0x0084 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE1__DPI0_D20                                    0x0084 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE1__WUU1_P1                                     0x0084 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE1__DEBUG_MUX0_9                                0x0084 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE1__DEBUG_MUX1_12                               0x0084 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE2__PTE2                                        0x0088 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE2__FXIO1_D21                                   0x0088 0x0874 0x2 0x1
> +#define MX8ULP_PAD_PTE2__SPDIF_IN2                                   0x0088 0x0B7C 0x3 0x2
> +#define MX8ULP_PAD_PTE2__LPUART4_TX                                  0x0088 0x08E4 0x4 0x1
> +#define MX8ULP_PAD_PTE2__LPI2C4_HREQ                                 0x0088 0x08C4 0x5 0x1
> +#define MX8ULP_PAD_PTE2__TPM8_CH1                                    0x0088 0x0B1C 0x6 0x3
> +#define MX8ULP_PAD_PTE2__EXT_AUD_MCLK3                               0x0088 0x0B14 0x7 0x4
> +#define MX8ULP_PAD_PTE2__SDHC2_CLK                                   0x0088 0x0A90 0x8 0x2
> +#define MX8ULP_PAD_PTE2__FLEXSPI2_B_DATA6                            0x0088 0x096C 0x9 0x2
> +#define MX8ULP_PAD_PTE2__ENET0_TXER                                  0x0088 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE2__DBI0_DCX                                    0x0088 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE2__DPI0_D21                                    0x0088 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE2__LP_HV_DBG_MUX_0                             0x0088 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE2__DEBUG_MUX0_10                               0x0088 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE2__DEBUG_MUX1_13                               0x0088 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE3__PTE3                                        0x008C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE3__FXIO1_D20                                   0x008C 0x0870 0x2 0x1
> +#define MX8ULP_PAD_PTE3__SPDIF_OUT2                                  0x008C 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTE3__LPUART4_RX                                  0x008C 0x08E0 0x4 0x1
> +#define MX8ULP_PAD_PTE3__TPM8_CH2                                    0x008C 0x0B20 0x6 0x3
> +#define MX8ULP_PAD_PTE3__I2S6_MCLK                                   0x008C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE3__SDHC2_CMD                                   0x008C 0x0A94 0x8 0x2
> +#define MX8ULP_PAD_PTE3__FLEXSPI2_B_DATA5                            0x008C 0x0968 0x9 0x2
> +#define MX8ULP_PAD_PTE3__ENET0_TXCLK                                 0x008C 0x0B10 0xa 0x1
> +#define MX8ULP_PAD_PTE3__DBI0_RWX                                    0x008C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE3__DPI0_D22                                    0x008C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE3__WUU1_P2                                     0x008C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE3__DEBUG_MUX0_11                               0x008C 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE3__DEBUG_MUX1_14                               0x008C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE4__PTE4                                        0x0090 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE4__FXIO1_D19                                   0x0090 0x0868 0x2 0x1
> +#define MX8ULP_PAD_PTE4__SPDIF_CLK                                   0x0090 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTE4__LPUART5_CTS_B                               0x0090 0x08E8 0x4 0x1
> +#define MX8ULP_PAD_PTE4__LPI2C5_SCL                                  0x0090 0x08D4 0x5 0x1
> +#define MX8ULP_PAD_PTE4__TPM8_CH3                                    0x0090 0x0B24 0x6 0x3
> +#define MX8ULP_PAD_PTE4__I2S6_RX_BCLK                                0x0090 0x0B44 0x7 0x2
> +#define MX8ULP_PAD_PTE4__SDHC2_D3                                    0x0090 0x0AA4 0x8 0x2
> +#define MX8ULP_PAD_PTE4__FLEXSPI2_B_DATA4                            0x0090 0x0964 0x9 0x2
> +#define MX8ULP_PAD_PTE4__ENET0_TXD3                                  0x0090 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE4__DBI0_E                                      0x0090 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE4__DPI0_D23                                    0x0090 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE4__WUU1_P3                                     0x0090 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE4__DEBUG_MUX0_12                               0x0090 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE4__DEBUG_MUX1_15                               0x0090 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE5__PTE5                                        0x0094 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE5__FXIO1_D18                                   0x0094 0x0864 0x2 0x1
> +#define MX8ULP_PAD_PTE5__SPDIF_IN0                                   0x0094 0x0B74 0x3 0x2
> +#define MX8ULP_PAD_PTE5__LPUART5_RTS_B                               0x0094 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTE5__LPI2C5_SDA                                  0x0094 0x08D8 0x5 0x1
> +#define MX8ULP_PAD_PTE5__TPM8_CH4                                    0x0094 0x0B28 0x6 0x3
> +#define MX8ULP_PAD_PTE5__I2S6_RX_FS                                  0x0094 0x0B48 0x7 0x2
> +#define MX8ULP_PAD_PTE5__SDHC2_D2                                    0x0094 0x0AA0 0x8 0x2
> +#define MX8ULP_PAD_PTE5__FLEXSPI2_B_SS0_B                            0x0094 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTE5__ENET0_TXD2                                  0x0094 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE5__DBI0_D0                                     0x0094 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE5__LP_HV_DBG_MUX_1                             0x0094 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE5__DEBUG_MUX0_13                               0x0094 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE5__DEBUG_MUX1_16                               0x0094 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE6__PTE6                                        0x0098 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE6__FXIO1_D17                                   0x0098 0x0860 0x2 0x1
> +#define MX8ULP_PAD_PTE6__SPDIF_OUT0                                  0x0098 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTE6__LPUART5_TX                                  0x0098 0x08F0 0x4 0x1
> +#define MX8ULP_PAD_PTE6__LPI2C5_HREQ                                 0x0098 0x08D0 0x5 0x1
> +#define MX8ULP_PAD_PTE6__TPM8_CH5                                    0x0098 0x0B2C 0x6 0x3
> +#define MX8ULP_PAD_PTE6__I2S6_RXD0                                   0x0098 0x0B34 0x7 0x2
> +#define MX8ULP_PAD_PTE6__SDHC2_D4                                    0x0098 0x0AA8 0x8 0x1
> +#define MX8ULP_PAD_PTE6__FLEXSPI2_B_SCLK                             0x0098 0x0978 0x9 0x2
> +#define MX8ULP_PAD_PTE6__ENET0_RXCLK                                 0x0098 0x0B0C 0xa 0x1
> +#define MX8ULP_PAD_PTE6__DBI0_D1                                     0x0098 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE6__LP_HV_DBG_MUX_2                             0x0098 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE6__WDOG5_RST                                   0x0098 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE6__DEBUG_MUX0_14                               0x0098 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE6__DEBUG_MUX1_17                               0x0098 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE7__PTE7                                        0x009C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE7__FXIO1_D16                                   0x009C 0x085C 0x2 0x1
> +#define MX8ULP_PAD_PTE7__SPDIF_IN1                                   0x009C 0x0B78 0x3 0x2
> +#define MX8ULP_PAD_PTE7__LPUART5_RX                                  0x009C 0x08EC 0x4 0x1
> +#define MX8ULP_PAD_PTE7__LPI2C6_HREQ                                 0x009C 0x09B4 0x5 0x1
> +#define MX8ULP_PAD_PTE7__TPM4_CLKIN                                  0x009C 0x081C 0x6 0x1
> +#define MX8ULP_PAD_PTE7__I2S6_RXD1                                   0x009C 0x0B38 0x7 0x2
> +#define MX8ULP_PAD_PTE7__SDHC2_D5                                    0x009C 0x0AAC 0x8 0x1
> +#define MX8ULP_PAD_PTE7__FLEXSPI2_B_DATA3                            0x009C 0x0960 0x9 0x2
> +#define MX8ULP_PAD_PTE7__ENET0_RXD3                                  0x009C 0x0B04 0xa 0x1
> +#define MX8ULP_PAD_PTE7__DBI0_D2                                     0x009C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE7__EPDC0_BDR1                                  0x009C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE7__WUU1_P4                                     0x009C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE7__DEBUG_MUX0_15                               0x009C 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE7__DEBUG_MUX1_18                               0x009C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE8__PTE8                                        0x00A0 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE8__FXIO1_D15                                   0x00A0 0x0858 0x2 0x1
> +#define MX8ULP_PAD_PTE8__LPSPI4_PCS1                                 0x00A0 0x08F8 0x3 0x2
> +#define MX8ULP_PAD_PTE8__LPUART6_CTS_B                               0x00A0 0x09CC 0x4 0x1
> +#define MX8ULP_PAD_PTE8__LPI2C6_SCL                                  0x00A0 0x09B8 0x5 0x1
> +#define MX8ULP_PAD_PTE8__TPM4_CH0                                    0x00A0 0x0804 0x6 0x1
> +#define MX8ULP_PAD_PTE8__I2S6_RXD2                                   0x00A0 0x0B3C 0x7 0x2
> +#define MX8ULP_PAD_PTE8__SDHC2_D6                                    0x00A0 0x0AB0 0x8 0x1
> +#define MX8ULP_PAD_PTE8__FLEXSPI2_B_DATA2                            0x00A0 0x095C 0x9 0x2
> +#define MX8ULP_PAD_PTE8__ENET0_RXD2                                  0x00A0 0x0B00 0xa 0x1
> +#define MX8ULP_PAD_PTE8__DBI0_D3                                     0x00A0 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE8__EPDC0_BDR0                                  0x00A0 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE8__LP_HV_DBG_MUX_3                             0x00A0 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE8__DEBUG_MUX1_19                               0x00A0 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE9__PTE9                                        0x00A4 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE9__FXIO1_D14                                   0x00A4 0x0854 0x2 0x1
> +#define MX8ULP_PAD_PTE9__LPSPI4_PCS2                                 0x00A4 0x08FC 0x3 0x2
> +#define MX8ULP_PAD_PTE9__LPUART6_RTS_B                               0x00A4 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTE9__LPI2C6_SDA                                  0x00A4 0x09BC 0x5 0x1
> +#define MX8ULP_PAD_PTE9__TPM4_CH1                                    0x00A4 0x0808 0x6 0x1
> +#define MX8ULP_PAD_PTE9__I2S6_RXD3                                   0x00A4 0x0B40 0x7 0x2
> +#define MX8ULP_PAD_PTE9__SDHC2_D7                                    0x00A4 0x0AB4 0x8 0x1
> +#define MX8ULP_PAD_PTE9__FLEXSPI2_B_DATA1                            0x00A4 0x0958 0x9 0x2
> +#define MX8ULP_PAD_PTE9__ENET0_1588_TMR3                             0x00A4 0x0AE0 0xa 0x1
> +#define MX8ULP_PAD_PTE9__DBI0_D4                                     0x00A4 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE9__EPDC0_VCOM1                                 0x00A4 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE9__LP_HV_DBG_MUX_4                             0x00A4 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE9__DEBUG_MUX1_20                               0x00A4 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE10__PTE10                                      0x00A8 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE10__FXIO1_D13                                  0x00A8 0x0850 0x2 0x1
> +#define MX8ULP_PAD_PTE10__LPSPI4_PCS3                                0x00A8 0x0900 0x3 0x2
> +#define MX8ULP_PAD_PTE10__LPUART6_TX                                 0x00A8 0x09D4 0x4 0x1
> +#define MX8ULP_PAD_PTE10__I3C2_SCL                                   0x00A8 0x08BC 0x5 0x1
> +#define MX8ULP_PAD_PTE10__TPM4_CH2                                   0x00A8 0x080C 0x6 0x1
> +#define MX8ULP_PAD_PTE10__I2S6_TX_BCLK                               0x00A8 0x0B4C 0x7 0x2
> +#define MX8ULP_PAD_PTE10__SDHC2_DQS                                  0x00A8 0x0AB8 0x8 0x1
> +#define MX8ULP_PAD_PTE10__FLEXSPI2_B_DATA0                           0x00A8 0x0954 0x9 0x2
> +#define MX8ULP_PAD_PTE10__ENET0_1588_TMR2                            0x00A8 0x0ADC 0xa 0x1
> +#define MX8ULP_PAD_PTE10__DBI0_D5                                    0x00A8 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE10__EPDC0_VCOM0                                0x00A8 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE10__LP_HV_DBG_MUX_5                            0x00A8 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTE10__DEBUG_MUX1_21                              0x00A8 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE11__PTE11                                      0x00AC 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE11__FXIO1_D12                                  0x00AC 0x084C 0x2 0x1
> +#define MX8ULP_PAD_PTE11__SPDIF_OUT1                                 0x00AC 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTE11__LPUART6_RX                                 0x00AC 0x09D0 0x4 0x1
> +#define MX8ULP_PAD_PTE11__I3C2_SDA                                   0x00AC 0x08C0 0x5 0x1
> +#define MX8ULP_PAD_PTE11__TPM4_CH3                                   0x00AC 0x0810 0x6 0x1
> +#define MX8ULP_PAD_PTE11__I2S6_TX_FS                                 0x00AC 0x0B50 0x7 0x2
> +#define MX8ULP_PAD_PTE11__FLEXSPI2_B_SCLK_B                          0x00AC 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTE11__FLEXSPI2_B_SS0_B                           0x00AC 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTE11__ENET0_1588_TMR1                            0x00AC 0x0AD8 0xa 0x1
> +#define MX8ULP_PAD_PTE11__DBI0_D6                                    0x00AC 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE11__EPDC0_PWRCTRL0                             0x00AC 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE11__LP_HV_DBG_MUX_6                            0x00AC 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE12__PTE12                                      0x00B0 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE12__FXIO1_D11                                  0x00B0 0x0848 0x2 0x1
> +#define MX8ULP_PAD_PTE12__LPSPI4_SIN                                 0x00B0 0x0908 0x3 0x2
> +#define MX8ULP_PAD_PTE12__LPUART7_CTS_B                              0x00B0 0x09D8 0x4 0x1
> +#define MX8ULP_PAD_PTE12__LPI2C7_SCL                                 0x00B0 0x09C4 0x5 0x1
> +#define MX8ULP_PAD_PTE12__TPM4_CH4                                   0x00B0 0x0814 0x6 0x1
> +#define MX8ULP_PAD_PTE12__I2S6_TXD0                                  0x00B0 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE12__SDHC2_RESET_B                              0x00B0 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTE12__FLEXSPI2_B_SS1_B                           0x00B0 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTE12__ENET0_1588_TMR0                            0x00B0 0x0AD4 0xa 0x1
> +#define MX8ULP_PAD_PTE12__DBI0_D7                                    0x00B0 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE12__EPDC0_PWRCTRL1                             0x00B0 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE12__WUU1_P5                                    0x00B0 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE13__PTE13                                      0x00B4 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE13__FXIO1_D10                                  0x00B4 0x0844 0x2 0x1
> +#define MX8ULP_PAD_PTE13__LPSPI4_SOUT                                0x00B4 0x090C 0x3 0x2
> +#define MX8ULP_PAD_PTE13__LPUART7_RTS_B                              0x00B4 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTE13__LPI2C7_SDA                                 0x00B4 0x09C8 0x5 0x1
> +#define MX8ULP_PAD_PTE13__TPM4_CH5                                   0x00B4 0x0818 0x6 0x1
> +#define MX8ULP_PAD_PTE13__I2S6_TXD1                                  0x00B4 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE13__SDHC1_WP                                   0x00B4 0x0A88 0x8 0x2
> +#define MX8ULP_PAD_PTE13__ENET0_1588_CLKIN                           0x00B4 0x0AD0 0xa 0x1
> +#define MX8ULP_PAD_PTE13__DBI0_D8                                    0x00B4 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE13__EPDC0_PWRCTRL2                             0x00B4 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE13__LP_HV_DBG_MUX_7                            0x00B4 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE14__PTE14                                      0x00B8 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE14__FXIO1_D9                                   0x00B8 0x08B8 0x2 0x1
> +#define MX8ULP_PAD_PTE14__LPSPI4_SCK                                 0x00B8 0x0904 0x3 0x2
> +#define MX8ULP_PAD_PTE14__LPUART7_TX                                 0x00B8 0x09E0 0x4 0x1
> +#define MX8ULP_PAD_PTE14__LPI2C7_HREQ                                0x00B8 0x09C0 0x5 0x1
> +#define MX8ULP_PAD_PTE14__TPM5_CLKIN                                 0x00B8 0x0838 0x6 0x1
> +#define MX8ULP_PAD_PTE14__I2S6_TXD2                                  0x00B8 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE14__SDHC1_CD                                   0x00B8 0x0A58 0x8 0x2
> +#define MX8ULP_PAD_PTE14__ENET0_MDIO                                 0x00B8 0x0AF0 0xa 0x1
> +#define MX8ULP_PAD_PTE14__DBI0_D9                                    0x00B8 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE14__EPDC0_PWRCTRL3                             0x00B8 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE14__LP_HV_DBG_MUX_8                            0x00B8 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE15__PTE15                                      0x00BC 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE15__FXIO1_D8                                   0x00BC 0x08B4 0x2 0x1
> +#define MX8ULP_PAD_PTE15__LPSPI4_PCS0                                0x00BC 0x08F4 0x3 0x2
> +#define MX8ULP_PAD_PTE15__LPUART7_RX                                 0x00BC 0x09DC 0x4 0x1
> +#define MX8ULP_PAD_PTE15__I3C2_PUR                                   0x00BC 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTE15__TPM5_CH0                                   0x00BC 0x0820 0x6 0x1
> +#define MX8ULP_PAD_PTE15__I2S6_TXD3                                  0x00BC 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE15__MQS1_LEFT                                  0x00BC 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTE15__ENET0_MDC                                  0x00BC 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE15__DBI0_D10                                   0x00BC 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE15__EPDC0_PWRCOM                               0x00BC 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE15__WUU1_P6                                    0x00BC 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE16__PTE16                                      0x00C0 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE16__FXIO1_D7                                   0x00C0 0x08B0 0x2 0x1
> +#define MX8ULP_PAD_PTE16__LPSPI5_PCS1                                0x00C0 0x0914 0x3 0x1
> +#define MX8ULP_PAD_PTE16__LPUART4_CTS_B                              0x00C0 0x08DC 0x4 0x2
> +#define MX8ULP_PAD_PTE16__LPI2C4_SCL                                 0x00C0 0x08C8 0x5 0x2
> +#define MX8ULP_PAD_PTE16__TPM5_CH1                                   0x00C0 0x0824 0x6 0x1
> +#define MX8ULP_PAD_PTE16__MQS1_LEFT                                  0x00C0 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE16__MQS1_RIGHT                                 0x00C0 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTE16__USB0_ID                                    0x00C0 0x0AC8 0x9 0x2
> +#define MX8ULP_PAD_PTE16__ENET0_TXEN                                 0x00C0 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE16__DBI0_D11                                   0x00C0 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE16__EPDC0_PWRIRQ                               0x00C0 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE16__WDOG3_RST                                  0x00C0 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE16__LP_HV_DBG_MUX_9                            0x00C0 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE17__PTE17                                      0x00C4 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE17__FXIO1_D6                                   0x00C4 0x08AC 0x2 0x1
> +#define MX8ULP_PAD_PTE17__LPSPI5_PCS2                                0x00C4 0x0918 0x3 0x1
> +#define MX8ULP_PAD_PTE17__LPUART4_RTS_B                              0x00C4 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTE17__LPI2C4_SDA                                 0x00C4 0x08CC 0x5 0x2
> +#define MX8ULP_PAD_PTE17__MQS1_RIGHT                                 0x00C4 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE17__SDHC1_VS                                   0x00C4 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTE17__USB0_PWR                                   0x00C4 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTE17__ENET0_RXER                                 0x00C4 0x0B08 0xa 0x1
> +#define MX8ULP_PAD_PTE17__DBI0_D12                                   0x00C4 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE17__EPDC0_PWRSTAT                              0x00C4 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE17__LP_HV_DBG_MUX_10                           0x00C4 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE18__PTE18                                      0x00C8 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE18__FXIO1_D5                                   0x00C8 0x08A8 0x2 0x1
> +#define MX8ULP_PAD_PTE18__LPSPI5_PCS3                                0x00C8 0x091C 0x3 0x1
> +#define MX8ULP_PAD_PTE18__LPUART4_TX                                 0x00C8 0x08E4 0x4 0x2
> +#define MX8ULP_PAD_PTE18__LPI2C4_HREQ                                0x00C8 0x08C4 0x5 0x2
> +#define MX8ULP_PAD_PTE18__I2S7_TX_BCLK                               0x00C8 0x0B6C 0x7 0x2
> +#define MX8ULP_PAD_PTE18__USB0_OC                                    0x00C8 0x0AC0 0x9 0x2
> +#define MX8ULP_PAD_PTE18__ENET0_CRS_DV                               0x00C8 0x0AEC 0xa 0x1
> +#define MX8ULP_PAD_PTE18__DBI0_D13                                   0x00C8 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE18__EPDC0_PWRWAKE                              0x00C8 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE18__LP_HV_DBG_MUX_11                           0x00C8 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE19__PTE19                                      0x00CC 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE19__FXIO1_D4                                   0x00CC 0x08A4 0x2 0x1
> +#define MX8ULP_PAD_PTE19__LPUART4_RX                                 0x00CC 0x08E0 0x4 0x2
> +#define MX8ULP_PAD_PTE19__LPI2C5_HREQ                                0x00CC 0x08D0 0x5 0x2
> +#define MX8ULP_PAD_PTE19__I3C2_PUR                                   0x00CC 0x0000 0x6 0x0
> +#define MX8ULP_PAD_PTE19__I2S7_TX_FS                                 0x00CC 0x0B70 0x7 0x2
> +#define MX8ULP_PAD_PTE19__USB1_PWR                                   0x00CC 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTE19__ENET0_REFCLK                               0x00CC 0x0AF4 0xa 0x1
> +#define MX8ULP_PAD_PTE19__DBI0_D14                                   0x00CC 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE19__EPDC0_GDCLK                                0x00CC 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE19__WUU1_P7                                    0x00CC 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE20__PTE20                                      0x00D0 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE20__FXIO1_D3                                   0x00D0 0x0898 0x2 0x1
> +#define MX8ULP_PAD_PTE20__LPSPI5_SIN                                 0x00D0 0x0924 0x3 0x1
> +#define MX8ULP_PAD_PTE20__LPUART5_CTS_B                              0x00D0 0x08E8 0x4 0x2
> +#define MX8ULP_PAD_PTE20__LPI2C5_SCL                                 0x00D0 0x08D4 0x5 0x2
> +#define MX8ULP_PAD_PTE20__I2S7_TXD0                                  0x00D0 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE20__USB1_OC                                    0x00D0 0x0AC4 0x9 0x2
> +#define MX8ULP_PAD_PTE20__ENET0_RXD1                                 0x00D0 0x0AFC 0xa 0x1
> +#define MX8ULP_PAD_PTE20__DBI0_D15                                   0x00D0 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTE20__EPDC0_GDOE                                 0x00D0 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE20__LP_HV_DBG_MUX_12                           0x00D0 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE21__PTE21                                      0x00D4 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE21__FXIO1_D2                                   0x00D4 0x086C 0x2 0x1
> +#define MX8ULP_PAD_PTE21__LPSPI5_SOUT                                0x00D4 0x0928 0x3 0x1
> +#define MX8ULP_PAD_PTE21__LPUART5_RTS_B                              0x00D4 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTE21__LPI2C5_SDA                                 0x00D4 0x08D8 0x5 0x2
> +#define MX8ULP_PAD_PTE21__TPM6_CLKIN                                 0x00D4 0x0994 0x6 0x1
> +#define MX8ULP_PAD_PTE21__I2S7_TXD1                                  0x00D4 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE21__USB1_ID                                    0x00D4 0x0ACC 0x9 0x2
> +#define MX8ULP_PAD_PTE21__ENET0_RXD0                                 0x00D4 0x0AF8 0xa 0x1
> +#define MX8ULP_PAD_PTE21__EPDC0_GDRL                                 0x00D4 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE21__WDOG4_RST                                  0x00D4 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE21__LP_HV_DBG_MUX_13                           0x00D4 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE22__PTE22                                      0x00D8 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE22__FXIO1_D1                                   0x00D8 0x0840 0x2 0x1
> +#define MX8ULP_PAD_PTE22__LPSPI5_SCK                                 0x00D8 0x0920 0x3 0x1
> +#define MX8ULP_PAD_PTE22__LPUART5_TX                                 0x00D8 0x08F0 0x4 0x2
> +#define MX8ULP_PAD_PTE22__I3C2_SCL                                   0x00D8 0x08BC 0x5 0x2
> +#define MX8ULP_PAD_PTE22__TPM6_CH0                                   0x00D8 0x097C 0x6 0x1
> +#define MX8ULP_PAD_PTE22__I2S7_TXD2                                  0x00D8 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE22__EXT_AUD_MCLK3                              0x00D8 0x0B14 0x9 0x5
> +#define MX8ULP_PAD_PTE22__ENET0_TXD1                                 0x00D8 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE22__EPDC0_SDOED                                0x00D8 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE22__CLKOUT2                                    0x00D8 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE22__LP_HV_DBG_MUX_14                           0x00D8 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTE23__PTE23                                      0x00DC 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTE23__FXIO1_D0                                   0x00DC 0x083C 0x2 0x1
> +#define MX8ULP_PAD_PTE23__LPSPI5_PCS0                                0x00DC 0x0910 0x3 0x1
> +#define MX8ULP_PAD_PTE23__LPUART5_RX                                 0x00DC 0x08EC 0x4 0x2
> +#define MX8ULP_PAD_PTE23__I3C2_SDA                                   0x00DC 0x08C0 0x5 0x2
> +#define MX8ULP_PAD_PTE23__TPM6_CH1                                   0x00DC 0x0980 0x6 0x1
> +#define MX8ULP_PAD_PTE23__I2S7_TXD3                                  0x00DC 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTE23__EXT_AUD_MCLK2                              0x00DC 0x0800 0x9 0x1
> +#define MX8ULP_PAD_PTE23__ENET0_TXD0                                 0x00DC 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTE23__EPDC0_SDOEZ                                0x00DC 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTE23__CLKOUT1                                    0x00DC 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTE23__LP_HV_DBG_MUX_15                           0x00DC 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF0__PTF0                                        0x0100 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF0__FXIO1_D0                                    0x0100 0x083C 0x2 0x2
> +#define MX8ULP_PAD_PTF0__LPUART6_CTS_B                               0x0100 0x09CC 0x4 0x2
> +#define MX8ULP_PAD_PTF0__LPI2C6_SCL                                  0x0100 0x09B8 0x5 0x2
> +#define MX8ULP_PAD_PTF0__I2S7_RX_BCLK                                0x0100 0x0B64 0x7 0x2
> +#define MX8ULP_PAD_PTF0__SDHC1_D1                                    0x0100 0x0A68 0x8 0x2
> +#define MX8ULP_PAD_PTF0__ENET0_RXD1                                  0x0100 0x0AFC 0x9 0x2
> +#define MX8ULP_PAD_PTF0__USB1_ID                                     0x0100 0x0ACC 0xa 0x3
> +#define MX8ULP_PAD_PTF0__EPDC0_SDOE                                  0x0100 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF0__DPI0_D23                                    0x0100 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF0__WUU1_P8                                     0x0100 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF1__PTF1                                        0x0104 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF1__FXIO1_D1                                    0x0104 0x0840 0x2 0x2
> +#define MX8ULP_PAD_PTF1__LPUART6_RTS_B                               0x0104 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTF1__LPI2C6_SDA                                  0x0104 0x09BC 0x5 0x2
> +#define MX8ULP_PAD_PTF1__I2S7_RX_FS                                  0x0104 0x0B68 0x7 0x2
> +#define MX8ULP_PAD_PTF1__SDHC1_D0                                    0x0104 0x0A64 0x8 0x2
> +#define MX8ULP_PAD_PTF1__ENET0_RXD0                                  0x0104 0x0AF8 0x9 0x2
> +#define MX8ULP_PAD_PTF1__LP_HV_DBG_MUX_16                            0x0104 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF1__EPDC0_SDSHR                                 0x0104 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF1__DPI0_D22                                    0x0104 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF1__WDOG3_RST                                   0x0104 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF1__DEBUG_MUX0_16                               0x0104 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF1__DEBUG_MUX1_22                               0x0104 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF2__PTF2                                        0x0108 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF2__FXIO1_D2                                    0x0108 0x086C 0x2 0x2
> +#define MX8ULP_PAD_PTF2__LPUART6_TX                                  0x0108 0x09D4 0x4 0x2
> +#define MX8ULP_PAD_PTF2__LPI2C6_HREQ                                 0x0108 0x09B4 0x5 0x2
> +#define MX8ULP_PAD_PTF2__I2S7_RXD0                                   0x0108 0x0B54 0x7 0x2
> +#define MX8ULP_PAD_PTF2__SDHC1_CLK                                   0x0108 0x0A5C 0x8 0x2
> +#define MX8ULP_PAD_PTF2__ENET0_TXD1                                  0x0108 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF2__USB0_ID                                     0x0108 0x0AC8 0xa 0x3
> +#define MX8ULP_PAD_PTF2__EPDC0_SDCE9                                 0x0108 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF2__DPI0_D21                                    0x0108 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF2__LP_HV_DBG_MUX_17                            0x0108 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF2__DEBUG_MUX0_17                               0x0108 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF2__DEBUG_MUX1_23                               0x0108 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF3__PTF3                                        0x010C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF3__FXIO1_D3                                    0x010C 0x0898 0x2 0x2
> +#define MX8ULP_PAD_PTF3__LPUART6_RX                                  0x010C 0x09D0 0x4 0x2
> +#define MX8ULP_PAD_PTF3__LPI2C7_HREQ                                 0x010C 0x09C0 0x5 0x2
> +#define MX8ULP_PAD_PTF3__I2S7_RXD1                                   0x010C 0x0B58 0x7 0x2
> +#define MX8ULP_PAD_PTF3__SDHC1_CMD                                   0x010C 0x0A60 0x8 0x2
> +#define MX8ULP_PAD_PTF3__ENET0_TXD0                                  0x010C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF3__USB0_PWR                                    0x010C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF3__EPDC0_SDCE8                                 0x010C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF3__DPI0_D20                                    0x010C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF3__WUU1_P9                                     0x010C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF3__DEBUG_MUX1_24                               0x010C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF4__PTF4                                        0x0110 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF4__FXIO1_D4                                    0x0110 0x08A4 0x2 0x2
> +#define MX8ULP_PAD_PTF4__LPSPI4_PCS1                                 0x0110 0x08F8 0x3 0x3
> +#define MX8ULP_PAD_PTF4__LPUART7_CTS_B                               0x0110 0x09D8 0x4 0x2
> +#define MX8ULP_PAD_PTF4__LPI2C7_SCL                                  0x0110 0x09C4 0x5 0x2
> +#define MX8ULP_PAD_PTF4__TPM7_CLKIN                                  0x0110 0x09B0 0x6 0x1
> +#define MX8ULP_PAD_PTF4__I2S7_RXD2                                   0x0110 0x0B5C 0x7 0x2
> +#define MX8ULP_PAD_PTF4__SDHC1_D3                                    0x0110 0x0A70 0x8 0x2
> +#define MX8ULP_PAD_PTF4__ENET0_TXEN                                  0x0110 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF4__USB0_OC                                     0x0110 0x0AC0 0xa 0x3
> +#define MX8ULP_PAD_PTF4__EPDC0_SDCE7                                 0x0110 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF4__DPI0_D19                                    0x0110 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF4__WUU1_P10                                    0x0110 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF4__DEBUG_MUX1_25                               0x0110 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF5__PTF5                                        0x0114 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF5__FXIO1_D5                                    0x0114 0x08A8 0x2 0x2
> +#define MX8ULP_PAD_PTF5__LPSPI4_PCS2                                 0x0114 0x08FC 0x3 0x3
> +#define MX8ULP_PAD_PTF5__LPUART7_RTS_B                               0x0114 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTF5__LPI2C7_SDA                                  0x0114 0x09C8 0x5 0x2
> +#define MX8ULP_PAD_PTF5__TPM7_CH0                                    0x0114 0x0998 0x6 0x1
> +#define MX8ULP_PAD_PTF5__I2S7_RXD3                                   0x0114 0x0B60 0x7 0x2
> +#define MX8ULP_PAD_PTF5__SDHC1_D2                                    0x0114 0x0A6C 0x8 0x2
> +#define MX8ULP_PAD_PTF5__ENET0_RXER                                  0x0114 0x0B08 0x9 0x2
> +#define MX8ULP_PAD_PTF5__USB1_PWR                                    0x0114 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF5__EPDC0_SDCE6                                 0x0114 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF5__DPI0_D18                                    0x0114 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF5__LP_HV_DBG_MUX_18                            0x0114 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF5__DEBUG_MUX0_18                               0x0114 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF5__DEBUG_MUX1_26                               0x0114 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF6__LP_HV_DBG_MUX_19                            0x0118 0x0000 0x0 0x0
> +#define MX8ULP_PAD_PTF6__PTF6                                        0x0118 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF6__FXIO1_D6                                    0x0118 0x08AC 0x2 0x2
> +#define MX8ULP_PAD_PTF6__LPSPI4_PCS3                                 0x0118 0x0900 0x3 0x3
> +#define MX8ULP_PAD_PTF6__LPUART7_TX                                  0x0118 0x09E0 0x4 0x2
> +#define MX8ULP_PAD_PTF6__I3C2_SCL                                    0x0118 0x08BC 0x5 0x3
> +#define MX8ULP_PAD_PTF6__TPM7_CH1                                    0x0118 0x099C 0x6 0x1
> +#define MX8ULP_PAD_PTF6__I2S7_MCLK                                   0x0118 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF6__SDHC1_D4                                    0x0118 0x0A74 0x8 0x2
> +#define MX8ULP_PAD_PTF6__ENET0_CRS_DV                                0x0118 0x0AEC 0x9 0x2
> +#define MX8ULP_PAD_PTF6__USB1_OC                                     0x0118 0x0AC4 0xa 0x3
> +#define MX8ULP_PAD_PTF6__EPDC0_SDCE5                                 0x0118 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF6__DPI0_D17                                    0x0118 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF6__WDOG4_RST                                   0x0118 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF6__DEBUG_MUX0_19                               0x0118 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF6__DEBUG_MUX1_27                               0x0118 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF7__PTF7                                        0x011C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF7__FXIO1_D7                                    0x011C 0x08B0 0x2 0x2
> +#define MX8ULP_PAD_PTF7__LPUART7_RX                                  0x011C 0x09DC 0x4 0x2
> +#define MX8ULP_PAD_PTF7__I3C2_SDA                                    0x011C 0x08C0 0x5 0x3
> +#define MX8ULP_PAD_PTF7__TPM7_CH2                                    0x011C 0x09A0 0x6 0x1
> +#define MX8ULP_PAD_PTF7__MQS1_LEFT                                   0x011C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF7__SDHC1_D5                                    0x011C 0x0A78 0x8 0x2
> +#define MX8ULP_PAD_PTF7__ENET0_REFCLK                                0x011C 0x0AF4 0x9 0x2
> +#define MX8ULP_PAD_PTF7__TRACE0_D15                                  0x011C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF7__EPDC0_SDCE4                                 0x011C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF7__DPI0_D16                                    0x011C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF7__WUU1_P11                                    0x011C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF7__DEBUG_MUX1_28                               0x011C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF8__PTF8                                        0x0120 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF8__FXIO1_D8                                    0x0120 0x08B4 0x2 0x2
> +#define MX8ULP_PAD_PTF8__LPSPI4_SIN                                  0x0120 0x0908 0x3 0x3
> +#define MX8ULP_PAD_PTF8__LPUART4_CTS_B                               0x0120 0x08DC 0x4 0x3
> +#define MX8ULP_PAD_PTF8__LPI2C4_SCL                                  0x0120 0x08C8 0x5 0x3
> +#define MX8ULP_PAD_PTF8__TPM7_CH3                                    0x0120 0x09A4 0x6 0x1
> +#define MX8ULP_PAD_PTF8__MQS1_RIGHT                                  0x0120 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF8__SDHC1_D6                                    0x0120 0x0A7C 0x8 0x2
> +#define MX8ULP_PAD_PTF8__ENET0_MDIO                                  0x0120 0x0AF0 0x9 0x2
> +#define MX8ULP_PAD_PTF8__TRACE0_D14                                  0x0120 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF8__EPDC0_D15                                   0x0120 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF8__DPI0_D15                                    0x0120 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF8__LP_HV_DBG_MUX_24                            0x0120 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF8__DEBUG_MUX1_29                               0x0120 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF9__PTF9                                        0x0124 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF9__FXIO1_D9                                    0x0124 0x08B8 0x2 0x2
> +#define MX8ULP_PAD_PTF9__LPSPI4_SOUT                                 0x0124 0x090C 0x3 0x3
> +#define MX8ULP_PAD_PTF9__LPUART4_RTS_B                               0x0124 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTF9__LPI2C4_SDA                                  0x0124 0x08CC 0x5 0x3
> +#define MX8ULP_PAD_PTF9__TPM7_CH4                                    0x0124 0x09A8 0x6 0x1
> +#define MX8ULP_PAD_PTF9__EXT_AUD_MCLK2                               0x0124 0x0800 0x7 0x2
> +#define MX8ULP_PAD_PTF9__SDHC1_D7                                    0x0124 0x0A80 0x8 0x2
> +#define MX8ULP_PAD_PTF9__ENET0_MDC                                   0x0124 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF9__TRACE0_D13                                  0x0124 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF9__EPDC0_D14                                   0x0124 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF9__DPI0_D14                                    0x0124 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF9__LP_HV_DBG_MUX_25                            0x0124 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF9__DEBUG_MUX1_30                               0x0124 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF10__LP_HV_DBG_MUX_26                           0x0128 0x0000 0x0 0x0
> +#define MX8ULP_PAD_PTF10__PTF10                                      0x0128 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF10__FXIO1_D10                                  0x0128 0x0844 0x2 0x2
> +#define MX8ULP_PAD_PTF10__LPSPI4_SCK                                 0x0128 0x0904 0x3 0x3
> +#define MX8ULP_PAD_PTF10__LPUART4_TX                                 0x0128 0x08E4 0x4 0x3
> +#define MX8ULP_PAD_PTF10__LPI2C4_HREQ                                0x0128 0x08C4 0x5 0x3
> +#define MX8ULP_PAD_PTF10__TPM7_CH5                                   0x0128 0x09AC 0x6 0x1
> +#define MX8ULP_PAD_PTF10__I2S4_RX_BCLK                               0x0128 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF10__SDHC1_DQS                                  0x0128 0x0A84 0x8 0x2
> +#define MX8ULP_PAD_PTF10__ENET0_1588_CLKIN                           0x0128 0x0AD0 0x9 0x2
> +#define MX8ULP_PAD_PTF10__TRACE0_D12                                 0x0128 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF10__EPDC0_D13                                  0x0128 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF10__DPI0_D13                                   0x0128 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF10__DEBUG_MUX0_20                              0x0128 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF10__DEBUG_MUX1_31                              0x0128 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF11__PTF11                                      0x012C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF11__FXIO1_D11                                  0x012C 0x0848 0x2 0x2
> +#define MX8ULP_PAD_PTF11__LPSPI4_PCS0                                0x012C 0x08F4 0x3 0x3
> +#define MX8ULP_PAD_PTF11__LPUART4_RX                                 0x012C 0x08E0 0x4 0x3
> +#define MX8ULP_PAD_PTF11__TPM4_CLKIN                                 0x012C 0x081C 0x6 0x2
> +#define MX8ULP_PAD_PTF11__I2S4_RX_FS                                 0x012C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF11__SDHC1_RESET_B                              0x012C 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTF11__ENET0_1588_TMR0                            0x012C 0x0AD4 0x9 0x2
> +#define MX8ULP_PAD_PTF11__TRACE0_D11                                 0x012C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF11__EPDC0_D12                                  0x012C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF11__DPI0_D12                                   0x012C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF11__LP_HV_DBG_MUX_27                           0x012C 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF11__DEBUG_MUX1_32                              0x012C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF12__PTF12                                      0x0130 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF12__FXIO1_D12                                  0x0130 0x084C 0x2 0x2
> +#define MX8ULP_PAD_PTF12__LPSPI5_PCS1                                0x0130 0x0914 0x3 0x2
> +#define MX8ULP_PAD_PTF12__LPUART5_CTS_B                              0x0130 0x08E8 0x4 0x3
> +#define MX8ULP_PAD_PTF12__LPI2C5_SCL                                 0x0130 0x08D4 0x5 0x3
> +#define MX8ULP_PAD_PTF12__TPM4_CH0                                   0x0130 0x0804 0x6 0x2
> +#define MX8ULP_PAD_PTF12__I2S4_RXD0                                  0x0130 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF12__SDHC2_WP                                   0x0130 0x0ABC 0x8 0x1
> +#define MX8ULP_PAD_PTF12__ENET0_1588_TMR1                            0x0130 0x0AD8 0x9 0x2
> +#define MX8ULP_PAD_PTF12__TRACE0_D10                                 0x0130 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF12__EPDC0_D11                                  0x0130 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF12__DPI0_D11                                   0x0130 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF12__LP_HV_DBG_MUX_28                           0x0130 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF12__DEBUG_MUX1_33                              0x0130 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF13__PTF13                                      0x0134 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF13__FXIO1_D13                                  0x0134 0x0850 0x2 0x2
> +#define MX8ULP_PAD_PTF13__LPSPI5_PCS2                                0x0134 0x0918 0x3 0x2
> +#define MX8ULP_PAD_PTF13__LPUART5_RTS_B                              0x0134 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTF13__LPI2C5_SDA                                 0x0134 0x08D8 0x5 0x3
> +#define MX8ULP_PAD_PTF13__TPM4_CH1                                   0x0134 0x0808 0x6 0x2
> +#define MX8ULP_PAD_PTF13__I2S4_RXD1                                  0x0134 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF13__SDHC2_CD                                   0x0134 0x0A8C 0x8 0x1
> +#define MX8ULP_PAD_PTF13__ENET0_1588_TMR2                            0x0134 0x0ADC 0x9 0x2
> +#define MX8ULP_PAD_PTF13__TRACE0_D9                                  0x0134 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF13__EPDC0_D10                                  0x0134 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF13__DPI0_D10                                   0x0134 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF13__DEBUG_MUX0_21                              0x0134 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF13__LP_HV_DBG_MUX_29                           0x0134 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF14__PTF14                                      0x0138 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF14__FXIO1_D14                                  0x0138 0x0854 0x2 0x2
> +#define MX8ULP_PAD_PTF14__LPSPI5_PCS3                                0x0138 0x091C 0x3 0x2
> +#define MX8ULP_PAD_PTF14__LPUART5_TX                                 0x0138 0x08F0 0x4 0x3
> +#define MX8ULP_PAD_PTF14__LPI2C5_HREQ                                0x0138 0x08D0 0x5 0x3
> +#define MX8ULP_PAD_PTF14__TPM4_CH2                                   0x0138 0x080C 0x6 0x2
> +#define MX8ULP_PAD_PTF14__I2S4_MCLK                                  0x0138 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF14__SDHC2_VS                                   0x0138 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTF14__ENET0_1588_TMR3                            0x0138 0x0AE0 0x9 0x2
> +#define MX8ULP_PAD_PTF14__TRACE0_D8                                  0x0138 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF14__EPDC0_D9                                   0x0138 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF14__DPI0_D9                                    0x0138 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF14__DEBUG_MUX0_22                              0x0138 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF14__LP_HV_DBG_MUX_30                           0x0138 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF15__PTF15                                      0x013C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF15__FXIO1_D15                                  0x013C 0x0858 0x2 0x2
> +#define MX8ULP_PAD_PTF15__LPUART5_RX                                 0x013C 0x08EC 0x4 0x3
> +#define MX8ULP_PAD_PTF15__TPM4_CH3                                   0x013C 0x0810 0x6 0x2
> +#define MX8ULP_PAD_PTF15__I2S4_TX_BCLK                               0x013C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF15__SDHC2_D1                                   0x013C 0x0A9C 0x8 0x3
> +#define MX8ULP_PAD_PTF15__ENET0_RXD2                                 0x013C 0x0B00 0x9 0x2
> +#define MX8ULP_PAD_PTF15__TRACE0_D7                                  0x013C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF15__EPDC0_D8                                   0x013C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF15__DPI0_D8                                    0x013C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF15__LP_HV_DBG_MUX_31                           0x013C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF16__PTF16                                      0x0140 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF16__FXIO1_D16                                  0x0140 0x085C 0x2 0x2
> +#define MX8ULP_PAD_PTF16__LPSPI5_SIN                                 0x0140 0x0924 0x3 0x2
> +#define MX8ULP_PAD_PTF16__LPUART6_CTS_B                              0x0140 0x09CC 0x4 0x3
> +#define MX8ULP_PAD_PTF16__LPI2C6_SCL                                 0x0140 0x09B8 0x5 0x3
> +#define MX8ULP_PAD_PTF16__TPM4_CH4                                   0x0140 0x0814 0x6 0x2
> +#define MX8ULP_PAD_PTF16__I2S4_TX_FS                                 0x0140 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF16__SDHC2_D0                                   0x0140 0x0A98 0x8 0x3
> +#define MX8ULP_PAD_PTF16__ENET0_RXD3                                 0x0140 0x0B04 0x9 0x2
> +#define MX8ULP_PAD_PTF16__TRACE0_D6                                  0x0140 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF16__EPDC0_D7                                   0x0140 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF16__DPI0_D7                                    0x0140 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF16__LP_HV_DBG_MUX_32                           0x0140 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF17__PTF17                                      0x0144 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF17__FXIO1_D17                                  0x0144 0x0860 0x2 0x2
> +#define MX8ULP_PAD_PTF17__LPSPI5_SOUT                                0x0144 0x0928 0x3 0x2
> +#define MX8ULP_PAD_PTF17__LPUART6_RTS_B                              0x0144 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTF17__LPI2C6_SDA                                 0x0144 0x09BC 0x5 0x3
> +#define MX8ULP_PAD_PTF17__TPM4_CH5                                   0x0144 0x0818 0x6 0x2
> +#define MX8ULP_PAD_PTF17__I2S4_TXD0                                  0x0144 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF17__SDHC2_CLK                                  0x0144 0x0A90 0x8 0x3
> +#define MX8ULP_PAD_PTF17__ENET0_RXCLK                                0x0144 0x0B0C 0x9 0x2
> +#define MX8ULP_PAD_PTF17__TRACE0_D5                                  0x0144 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF17__EPDC0_D6                                   0x0144 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF17__DPI0_D6                                    0x0144 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF17__DEBUG_MUX0_23                              0x0144 0x0000 0xe 0x0
> +#define MX8ULP_PAD_PTF17__LP_HV_DBG_MUX_33                           0x0144 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF18__PTF18                                      0x0148 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF18__FXIO1_D18                                  0x0148 0x0864 0x2 0x2
> +#define MX8ULP_PAD_PTF18__LPSPI5_SCK                                 0x0148 0x0920 0x3 0x2
> +#define MX8ULP_PAD_PTF18__LPUART6_TX                                 0x0148 0x09D4 0x4 0x3
> +#define MX8ULP_PAD_PTF18__LPI2C6_HREQ                                0x0148 0x09B4 0x5 0x3
> +#define MX8ULP_PAD_PTF18__TPM5_CLKIN                                 0x0148 0x0838 0x6 0x2
> +#define MX8ULP_PAD_PTF18__I2S4_TXD1                                  0x0148 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF18__SDHC2_CMD                                  0x0148 0x0A94 0x8 0x3
> +#define MX8ULP_PAD_PTF18__ENET0_TXD2                                 0x0148 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF18__TRACE0_D4                                  0x0148 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF18__EPDC0_D5                                   0x0148 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF18__DPI0_D5                                    0x0148 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF19__PTF19                                      0x014C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF19__FXIO1_D19                                  0x014C 0x0868 0x2 0x2
> +#define MX8ULP_PAD_PTF19__LPSPI5_PCS0                                0x014C 0x0910 0x3 0x2
> +#define MX8ULP_PAD_PTF19__LPUART6_RX                                 0x014C 0x09D0 0x4 0x3
> +#define MX8ULP_PAD_PTF19__TPM5_CH0                                   0x014C 0x0820 0x6 0x2
> +#define MX8ULP_PAD_PTF19__I2S5_RX_BCLK                               0x014C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF19__SDHC2_D3                                   0x014C 0x0AA4 0x8 0x3
> +#define MX8ULP_PAD_PTF19__ENET0_TXD3                                 0x014C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF19__TRACE0_D3                                  0x014C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF19__EPDC0_D4                                   0x014C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF19__DPI0_D4                                    0x014C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF20__PTF20                                      0x0150 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF20__FXIO1_D20                                  0x0150 0x0870 0x2 0x2
> +#define MX8ULP_PAD_PTF20__LPUART7_CTS_B                              0x0150 0x09D8 0x4 0x3
> +#define MX8ULP_PAD_PTF20__LPI2C7_SCL                                 0x0150 0x09C4 0x5 0x3
> +#define MX8ULP_PAD_PTF20__TPM5_CH1                                   0x0150 0x0824 0x6 0x2
> +#define MX8ULP_PAD_PTF20__I2S5_RX_FS                                 0x0150 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF20__SDHC2_D2                                   0x0150 0x0AA0 0x8 0x3
> +#define MX8ULP_PAD_PTF20__ENET0_TXCLK                                0x0150 0x0B10 0x9 0x2
> +#define MX8ULP_PAD_PTF20__TRACE0_D2                                  0x0150 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF20__EPDC0_D3                                   0x0150 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF20__DPI0_D3                                    0x0150 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF21__PTF21                                      0x0154 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF21__FXIO1_D21                                  0x0154 0x0874 0x2 0x2
> +#define MX8ULP_PAD_PTF21__SPDIF_CLK                                  0x0154 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTF21__LPUART7_RTS_B                              0x0154 0x0000 0x4 0x0
> +#define MX8ULP_PAD_PTF21__LPI2C7_SDA                                 0x0154 0x09C8 0x5 0x3
> +#define MX8ULP_PAD_PTF21__TPM6_CLKIN                                 0x0154 0x0994 0x6 0x2
> +#define MX8ULP_PAD_PTF21__I2S5_RXD0                                  0x0154 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF21__SDHC2_D4                                   0x0154 0x0AA8 0x8 0x2
> +#define MX8ULP_PAD_PTF21__ENET0_CRS                                  0x0154 0x0AE8 0x9 0x2
> +#define MX8ULP_PAD_PTF21__TRACE0_D1                                  0x0154 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF21__EPDC0_D2                                   0x0154 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF21__DPI0_D2                                    0x0154 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF22__PTF22                                      0x0158 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF22__FXIO1_D22                                  0x0158 0x0878 0x2 0x2
> +#define MX8ULP_PAD_PTF22__SPDIF_IN0                                  0x0158 0x0B74 0x3 0x3
> +#define MX8ULP_PAD_PTF22__LPUART7_TX                                 0x0158 0x09E0 0x4 0x3
> +#define MX8ULP_PAD_PTF22__LPI2C7_HREQ                                0x0158 0x09C0 0x5 0x3
> +#define MX8ULP_PAD_PTF22__TPM6_CH0                                   0x0158 0x097C 0x6 0x2
> +#define MX8ULP_PAD_PTF22__I2S5_RXD1                                  0x0158 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF22__SDHC2_D5                                   0x0158 0x0AAC 0x8 0x2
> +#define MX8ULP_PAD_PTF22__ENET0_COL                                  0x0158 0x0AE4 0x9 0x2
> +#define MX8ULP_PAD_PTF22__TRACE0_D0                                  0x0158 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF22__EPDC0_D1                                   0x0158 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF22__DPI0_D1                                    0x0158 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF23__PTF23                                      0x015C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF23__FXIO1_D23                                  0x015C 0x087C 0x2 0x2
> +#define MX8ULP_PAD_PTF23__SPDIF_OUT0                                 0x015C 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTF23__LPUART7_RX                                 0x015C 0x09DC 0x4 0x3
> +#define MX8ULP_PAD_PTF23__I3C2_PUR                                   0x015C 0x0000 0x5 0x0
> +#define MX8ULP_PAD_PTF23__TPM6_CH1                                   0x015C 0x0980 0x6 0x2
> +#define MX8ULP_PAD_PTF23__I2S5_RXD2                                  0x015C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF23__SDHC2_D6                                   0x015C 0x0AB0 0x8 0x2
> +#define MX8ULP_PAD_PTF23__ENET0_TXER                                 0x015C 0x0000 0x9 0x0
> +#define MX8ULP_PAD_PTF23__TRACE0_CLKOUT                              0x015C 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF23__EPDC0_D0                                   0x015C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF23__DPI0_D0                                    0x015C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF24__PTF24                                      0x0160 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF24__FXIO1_D24                                  0x0160 0x0880 0x2 0x2
> +#define MX8ULP_PAD_PTF24__SPDIF_IN1                                  0x0160 0x0B78 0x3 0x3
> +#define MX8ULP_PAD_PTF24__I3C2_SCL                                   0x0160 0x08BC 0x5 0x4
> +#define MX8ULP_PAD_PTF24__I2S5_RXD3                                  0x0160 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF24__SDHC2_D7                                   0x0160 0x0AB4 0x8 0x2
> +#define MX8ULP_PAD_PTF24__DBI0_WRX                                   0x0160 0x0000 0xa 0x0
> +#define MX8ULP_PAD_PTF24__EPDC0_SDCLK                                0x0160 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF24__DPI0_PCLK                                  0x0160 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF24__WUU1_P12                                   0x0160 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF25__PTF25                                      0x0164 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF25__FXIO1_D25                                  0x0164 0x0884 0x2 0x2
> +#define MX8ULP_PAD_PTF25__SPDIF_OUT1                                 0x0164 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTF25__I3C2_SDA                                   0x0164 0x08C0 0x5 0x4
> +#define MX8ULP_PAD_PTF25__TPM7_CH5                                   0x0164 0x09AC 0x6 0x2
> +#define MX8ULP_PAD_PTF25__I2S5_MCLK                                  0x0164 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF25__SDHC2_DQS                                  0x0164 0x0AB8 0x8 0x2
> +#define MX8ULP_PAD_PTF25__EXT_AUD_MCLK2                              0x0164 0x0800 0x9 0x3
> +#define MX8ULP_PAD_PTF25__EPDC0_GDSP                                 0x0164 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF25__DPI0_VSYNC                                 0x0164 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF25__WUU1_P13                                   0x0164 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF26__PTF26                                      0x0168 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF26__FXIO1_D26                                  0x0168 0x0888 0x2 0x2
> +#define MX8ULP_PAD_PTF26__SPDIF_IN2                                  0x0168 0x0B7C 0x3 0x3
> +#define MX8ULP_PAD_PTF26__TPM7_CLKIN                                 0x0168 0x09B0 0x6 0x2
> +#define MX8ULP_PAD_PTF26__I2S5_TX_BCLK                               0x0168 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF26__SDHC2_RESET_B                              0x0168 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTF26__EPDC0_SDLE                                 0x0168 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF26__DPI0_HSYNC                                 0x0168 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF26__WUU1_P14                                   0x0168 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF27__PTF27                                      0x016C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF27__FXIO1_D27                                  0x016C 0x088C 0x2 0x2
> +#define MX8ULP_PAD_PTF27__SPDIF_OUT2                                 0x016C 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTF27__TPM7_CH0                                   0x016C 0x0998 0x6 0x2
> +#define MX8ULP_PAD_PTF27__I2S5_TX_FS                                 0x016C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF27__SDHC2_WP                                   0x016C 0x0ABC 0x8 0x2
> +#define MX8ULP_PAD_PTF27__EPDC0_SDCE0                                0x016C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF27__DPI0_DE                                    0x016C 0x0000 0xc 0x0
> +#define MX8ULP_PAD_PTF27__WUU1_P15                                   0x016C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF28__PTF28                                      0x0170 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF28__FXIO1_D28                                  0x0170 0x0890 0x2 0x2
> +#define MX8ULP_PAD_PTF28__SPDIF_IN3                                  0x0170 0x0B80 0x3 0x3
> +#define MX8ULP_PAD_PTF28__TPM7_CH1                                   0x0170 0x099C 0x6 0x2
> +#define MX8ULP_PAD_PTF28__I2S5_TXD0                                  0x0170 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF28__SDHC2_CD                                   0x0170 0x0A8C 0x8 0x2
> +#define MX8ULP_PAD_PTF28__EPDC0_SDCLK_B                              0x0170 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF28__LP_HV_DBG_MUX_20                           0x0170 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF29__PTF29                                      0x0174 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF29__FXIO1_D29                                  0x0174 0x0894 0x2 0x2
> +#define MX8ULP_PAD_PTF29__SPDIF_OUT3                                 0x0174 0x0000 0x3 0x0
> +#define MX8ULP_PAD_PTF29__TPM7_CH2                                   0x0174 0x09A0 0x6 0x2
> +#define MX8ULP_PAD_PTF29__I2S5_TXD1                                  0x0174 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF29__SDHC2_VS                                   0x0174 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTF29__EPDC0_SDCE1                                0x0174 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF29__WDOG3_RST                                  0x0174 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF29__LP_HV_DBG_MUX_21                           0x0174 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF30__PTF30                                      0x0178 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF30__FXIO1_D30                                  0x0178 0x089C 0x2 0x2
> +#define MX8ULP_PAD_PTF30__TPM7_CH3                                   0x0178 0x09A4 0x6 0x2
> +#define MX8ULP_PAD_PTF30__I2S5_TXD2                                  0x0178 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF30__MQS1_LEFT                                  0x0178 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTF30__EPDC0_SDCE2                                0x0178 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF30__WDOG4_RST                                  0x0178 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF30__LP_HV_DBG_MUX_22                           0x0178 0x0000 0xf 0x0
> +#define MX8ULP_PAD_PTF31__PTF31                                      0x017C 0x0000 0x1 0x0
> +#define MX8ULP_PAD_PTF31__FXIO1_D31                                  0x017C 0x08A0 0x2 0x2
> +#define MX8ULP_PAD_PTF31__TPM7_CH4                                   0x017C 0x09A8 0x6 0x2
> +#define MX8ULP_PAD_PTF31__I2S5_TXD3                                  0x017C 0x0000 0x7 0x0
> +#define MX8ULP_PAD_PTF31__MQS1_RIGHT                                 0x017C 0x0000 0x8 0x0
> +#define MX8ULP_PAD_PTF31__EPDC0_SDCE3                                0x017C 0x0000 0xb 0x0
> +#define MX8ULP_PAD_PTF31__WDOG5_RST                                  0x017C 0x0000 0xd 0x0
> +#define MX8ULP_PAD_PTF31__LP_HV_DBG_MUX_23                           0x017C 0x0000 0xf 0x0
> +#define MX8ULP_PAD_BOOT_MODE0__BOOT_MODE0                            0x0400 0x0000 0x0 0x0
> +#define MX8ULP_PAD_BOOT_MODE1__BOOT_MODE1                            0x0404 0x0000 0x0 0x0
> +
> +#endif /* __DTS_IMX8ULP_PINFUNC_H */
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> new file mode 100644
> index 000000000000..fb8714379026
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8ulp-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "imx8ulp-pinfunc.h"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		gpio0 = &gpiod;
> +		gpio1 = &gpioe;
> +		gpio2 = &gpiof;
> +		mmc0 = &usdhc0;
> +		mmc1 = &usdhc1;
> +		mmc2 = &usdhc2;
> +		serial0 = &lpuart4;
> +		serial1 = &lpuart5;
> +		serial2 = &lpuart6;
> +		serial3 = &lpuart7;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		A35_0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&A35_L2>;
> +		};
> +
> +		A35_1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&A35_L2>;
> +		};
> +
> +		A35_L2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	gic: interrupt-controller@2d400000 {
> +		compatible = "arm,gic-v3";
> +		reg = <0x0 0x2d400000 0 0x10000>, /* GIC Dist */
> +		      <0x0 0x2d440000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
> +	};
> +
> +	frosc: clock-frosc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <192000000>;
> +		clock-output-names = "frosc";
> +		#clock-cells = <0>;
> +	};
> +
> +	lposc: clock-lposc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <1000000>;
> +		clock-output-names = "lposc";
> +		#clock-cells = <0>;
> +	};
> +
> +	rosc: clock-rosc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "rosc";
> +		#clock-cells = <0>;
> +	};
> +
> +	sosc: clock-sosc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "sosc";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc@0 {

Why do we need unit-address @0 here?

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x40000000>;
> +
> +		per_bridge3: bus@29000000 {
> +			compatible = "simple-bus";
> +			reg = <0x29000000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			wdog3: watchdog@292a0000 {
> +				compatible = "fsl,imx8ulp-wdt", "fsl,imx7ulp-wdt";
> +				reg = <0x292a0000 0x10000>;
> +				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_WDOG3>;
> +				assigned-clocks = <&pcc3 IMX8ULP_CLK_WDOG3>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SOSC_DIV2>;
> +				timeout-sec = <40>;
> +			};
> +
> +			cgc1: clock-controller@292c0000 {
> +				compatible = "fsl,imx8ulp-cgc1";
> +				reg = <0x292c0000 0x10000>;
> +				clocks = <&rosc>, <&sosc>, <&frosc>, <&lposc>;
> +				clock-names = "rosc", "sosc", "frosc", "lposc";
> +				#clock-cells = <1>;
> +			};
> +
> +			pcc3: clock-controller@292d0000 {
> +				compatible = "fsl,imx8ulp-pcc3";
> +				reg = <0x292d0000 0x10000>;
> +				#clock-cells = <1>;
> +			};
> +
> +			tpm5: tpm@29340000 {
> +				compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
> +				reg = <0x29340000 0x1000>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_TPM5>,
> +					 <&pcc3 IMX8ULP_CLK_TPM5>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			lpi2c4: i2c@29370000 {
> +				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x29370000 0x10000>;
> +				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>,
> +					 <&pcc3 IMX8ULP_CLK_LPI2C4>;
> +				clock-names = "per", "ipg";
> +				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
> +				assigned-clock-rates = <48000000>;
> +				status = "disabled";
> +			};
> +
> +			lpi2c5: i2c@29380000 {
> +				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x29380000 0x10000>;
> +				interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>,
> +					 <&pcc3 IMX8ULP_CLK_LPI2C5>;
> +				clock-names = "per", "ipg";
> +				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
> +				assigned-clock-rates = <48000000>;
> +				status = "disabled";
> +			};
> +
> +			lpuart4: serial@29390000 {
> +				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x29390000 0x1000>;
> +				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_LPUART4>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart5: serial@293a0000 {
> +				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x293a0000 0x1000>;
> +				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_LPUART5>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi4: spi@293b0000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx8ulp-spi", "fsl,imx7ulp-spi";
> +				reg = <0x293b0000 0x10000>;
> +				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>,
> +					 <&pcc3 IMX8ULP_CLK_LPSPI4>;
> +				clock-names = "per", "ipg";
> +				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
> +				assigned-clock-rates = <16000000>;
> +				status = "disabled";
> +			};
> +
> +			lpspi5: spi@293c0000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx8ulp-spi", "fsl,imx7ulp-spi";
> +				reg = <0x293c0000 0x10000>;
> +				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>,
> +					 <&pcc3 IMX8ULP_CLK_LPSPI5>;
> +				clock-names = "per", "ipg";
> +				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
> +				assigned-clock-rates = <16000000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		per_bridge4: bus@29800000 {
> +			compatible = "simple-bus";
> +			reg = <0x29800000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pcc4: clock-controller@29800000 {
> +				compatible = "fsl,imx8ulp-pcc4";
> +				reg = <0x29800000 0x10000>;
> +				#clock-cells = <1>;
> +			};
> +
> +			lpi2c6: i2c@29840000 {
> +				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x29840000 0x10000>;
> +				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>,
> +					 <&pcc4 IMX8ULP_CLK_LPI2C6>;
> +				clock-names = "per", "ipg";
> +				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
> +				assigned-clock-rates = <48000000>;
> +				status = "disabled";
> +			};
> +
> +			lpi2c7: i2c@29850000 {
> +				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x29850000 0x10000>;
> +				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>,
> +					 <&pcc4 IMX8ULP_CLK_LPI2C7>;
> +				clock-names = "per", "ipg";
> +				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>;
> +				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
> +				assigned-clock-rates = <48000000>;
> +				status = "disabled";
> +			};
> +
> +			lpuart6: serial@29860000 {
> +				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x29860000 0x1000>;
> +				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_LPUART6>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart7: serial@29870000 {
> +				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x29870000 0x1000>;
> +				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_LPUART7>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			iomuxc1: pinctrl@298c0000 {
> +				compatible = "fsl,imx8ulp-iomuxc1";

I know this binding is already landed.  Just curious why there is a
suffix number in the compatible.

Shawn

> +				reg = <0x298c0000 0x10000>;
> +			};
> +
> +			usdhc0: mmc@298d0000 {
> +				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x298d0000 0x10000>;
> +				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
> +					 <&cgc1 IMX8ULP_CLK_XBAR_AD_DIVPLAT>,
> +					 <&pcc4 IMX8ULP_CLK_USDHC0>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step= <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			usdhc1: mmc@298e0000 {
> +				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x298e0000 0x10000>;
> +				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
> +					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
> +					 <&pcc4 IMX8ULP_CLK_USDHC1>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step= <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			usdhc2: mmc@298f0000 {
> +				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x298f0000 0x10000>;
> +				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
> +					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
> +					 <&pcc4 IMX8ULP_CLK_USDHC2>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step= <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		gpioe: gpio@2d000000 {
> +				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
> +				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				clocks = <&pcc4 IMX8ULP_CLK_RGPIOE>,
> +					 <&pcc4 IMX8ULP_CLK_PCTLE>;
> +				clock-names = "gpio", "port";
> +				gpio-ranges = <&iomuxc1 0 32 24>;
> +		};
> +
> +		gpiof: gpio@2d010000 {
> +				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
> +				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				clocks = <&pcc4 IMX8ULP_CLK_RGPIOF>,
> +					 <&pcc4 IMX8ULP_CLK_PCTLF>;
> +				clock-names = "gpio", "port";
> +				gpio-ranges = <&iomuxc1 0 64 32>;
> +		};
> +
> +		per_bridge5: bus@2d800000 {
> +			compatible = "simple-bus";
> +			reg = <0x2d800000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			cgc2: clock-controller@2da60000 {
> +				compatible = "fsl,imx8ulp-cgc2";
> +				reg = <0x2da60000 0x10000>;
> +				clocks = <&sosc>, <&frosc>;
> +				clock-names = "sosc", "frosc";
> +				#clock-cells = <1>;
> +			};
> +
> +			pcc5: clock-controller@2da70000 {
> +				compatible = "fsl,imx8ulp-pcc5";
> +				reg = <0x2da70000 0x10000>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		gpiod: gpio@2e200000 {
> +			compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
> +			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&pcc5 IMX8ULP_CLK_RGPIOD>,
> +				 <&pcc5 IMX8ULP_CLK_RGPIOD>;
> +			clock-names = "gpio", "port";
> +			gpio-ranges = <&iomuxc1 0 0 24>;
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 
