Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9BB33ABC9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Mar 2021 07:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhCOGry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Mar 2021 02:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhCOGrj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Mar 2021 02:47:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 753D061481;
        Mon, 15 Mar 2021 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615790859;
        bh=tbpcL/ugwKzj1S4GzRvx9tIUZ5PMxmhUXJW+GqVkm38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9wxdEN3AYMiwTYJBk+vOVyAzfBfEK4QSkQOUJZyQNVLJCNyA32bJy2nULPByxYR/
         ivYVX3DWQqBNKsoNrBAjcvHjCNKGuHwgf5n8KqD/v6Usl17oQPt1doCcjB4ul9hK9Z
         n5GudCSdLvpnuNqWNJDWzedYpzkT4/esev8yhZQ9El7YCZr+Hmg2U8yctJTFhc+rQr
         r5W3d05skDhrAF72IgXegExiT6UniW1xYTjK44IGHpINeS/wYTHPaNcFW0DoiNdQcR
         pm72xo/VIsZLBK9AJz8PP3jQqz+nmok7BWA0ptpZhwn18jOXF/Z2e5M/BXWa+Z04nb
         Ghlm0hLuDJZ6A==
Date:   Mon, 15 Mar 2021 14:47:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Teresa Remmet <t.remmet@phytec.de>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] enable flexspi support on imx8mp
Message-ID: <20210315064731.GL11246@dragon>
References: <20210309053116.1486347-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309053116.1486347-1-hs@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 09, 2021 at 06:31:12AM +0100, Heiko Schocher wrote:
> 
> This series enables support for the SPI NOR on the
> imx8mp based phyboard-pollux-rdk board.
> 
> Patches new in v2:
> "spi: fspi: enable fspi driver for on imx8mp"
> which adds own compatible entry for imx8mp
> 
> and seperate in own patch the documentation entry in
> patch "dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller"
> as checkpatch says:
> 
> warning: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> 
> 
> Changes in v2:
> - work in comments from Marco
>   add own compatible entry for imx8mp
> - work in comments from Marco
>   - add own compatible entry "nxp,imx8mp-fspi"
>   - reworked order of properties as Marco mentioned
> - work in comments from Marco and Teresa
>   - rename node into "'som_flash: flash@0 { }"
>   - compatible is now first entry
>   - removed #size-cells and #address-cells
>     as no child node. If bootloader adds them bootloader
>     can add them too.
> 
> Heiko Schocher (4):
>   spi: fspi: enable fspi driver for on imx8mp
>   dt-bindings: spi: add compatible entry for imx8mp in FlexSPI
>     controller
>   arm64: dts: imx8mp: add flexspi node
>   arm64: imx8mp: imx8mp-phycore-som enable spi nor

Two DTS patch look good.  Ping me when driver and bindings changes are
accepted.

Shawn
