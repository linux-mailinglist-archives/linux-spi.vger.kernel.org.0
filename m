Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E1133F89
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 11:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgAHKp3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 05:45:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39234 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgAHKp2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jan 2020 05:45:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so1948071wmj.4;
        Wed, 08 Jan 2020 02:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWNocU7eA9+Wp59TtXNSPoHKPg/gQFuCfBlz6EP4IJM=;
        b=XL4fjlnoCxTK5zuVeOatSIA0QPobR9ogTd6FCkUDTguco9kcRi9Tbnhk/6Vceo4ZRo
         jar35VEPwdo1p2/UGuWCkf22+E/TvJ2RGq1aHs9TUQHytq9JhAgi/QSsTYzpvaNXM1uH
         YtAXDpIYKRMyvRU7wONZ2e/Us8z48GwassZeYBUak8x3TTPT3hl5/PUrJCbNlweOhwNm
         l2DlBC+QW9aCGTwb02ek/YJauLcmN0emIq4z8/76Y2jnJVpouUB0JpfsZ8AdmR7GtDG+
         SqXmjRY9xY7BB4V7pz6oHGSo6xD0eXICGBijwUrM1evNAgt5o9JMAB0o/lBkl5ux0wGT
         DTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWNocU7eA9+Wp59TtXNSPoHKPg/gQFuCfBlz6EP4IJM=;
        b=WNLozMzGWrMzDCov+te+kh9rbghLwU7r1QfdPlnGw5x7IvKxhSsLWJjAdTNTq+/SVy
         2HLK/ZTKXlmi5M6DLVQ3H4DwQD0RN/uGdARkYuAlQqb9vnIZwXpMOgBDiuaUMsyeKEYn
         GAl9cJxwhpRwvktS3/Spf536947kx/nY4FoT9ClFEtPjOHti1wDHsRJd2QUUMp2/TvnN
         cQ03rGV5VzMOBG3FoLobdNzO8907QzYhoNK7WJIE25QVzQ2JDOm3l0imYt43F+BDY80u
         8Zg3J/iGF1fEmw/hyTNDL6AhKfmA6u1imrSOQisCtgfrZCYvE7N7vrzviClGNMX+cIKI
         b7ew==
X-Gm-Message-State: APjAAAUvgfI7/vzgty/hieDAbGT5N86jIy/o7wrFNPvxw7kvTHRXEUQf
        80T2ORTRj4ltuvK8WZHLCjstyE0z4+oDzGpJYb0=
X-Google-Smtp-Source: APXvYqxCEiSVPvqEPV1TYN+VTi6zRgss5wzhXYoBJ7RLBYKSCj5Cw8CA6v+eMTnefLxFNeJid/0wFmP3UfzNj91cJPQ=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr3018534wmb.81.1578480326589;
 Wed, 08 Jan 2020 02:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20200108101006.150706-1-andre.przywara@arm.com> <20200108101006.150706-2-andre.przywara@arm.com>
In-Reply-To: <20200108101006.150706-2-andre.przywara@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 8 Jan 2020 11:45:15 +0100
Message-ID: <CAJiuCccSWR4oMF5x67eUVMFL6YhRMJVo_r0VfCUVVRtAJ9uR2w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI
 controllers nodes and pinmuxes
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andre,

On Wed, 8 Jan 2020 at 11:10, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
> but with the added capability of 3-wire and 4-wire operation modes.
> For now the driver does not support those, but the SPI registers are
> fully backwards-compatible, just adding bits and registers which were
> formerly reserved. So we can use the existing driver for the "normal" SPI
> modes, for instance to access the SPI NOR flash soldered on the PineH64
> board.
> We use an H6 specific compatible string in addition to the existing H3
> string, so when the driver later gains Quad SPI support, it should work
> automatically without any DT changes.
>
> Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> connecting another SPI flash to the SPI1 header pins.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3329283e38ab..40835850893e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -338,6 +338,30 @@
>                                 bias-pull-up;
>                         };
>
> +                       /omit-if-no-ref/
> +                       spi0_pins: spi0-pins {
> +                               pins = "PC0", "PC2", "PC3";
> +                               function = "spi0";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi0_cs_pin: spi0-cs-pin {
> +                               pins = "PC5";
> +                               function = "spi0";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi1_pins: spi1-pins {
> +                               pins = "PH4", "PH5", "PH6";
> +                               function = "spi1";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi1_cs_pin: spi1-cs-pin {
> +                               pins = "PH3";
> +                               function = "spi1";
> +                       };
> +
>                         spdif_tx_pin: spdif-tx-pin {
>                                 pins = "PH7";
>                                 function = "spdif";
> @@ -504,6 +528,36 @@
>                         #size-cells = <0>;
>                 };
>
> +               spi0: spi@5010000 {
> +                       compatible = "allwinner,sun50i-h6-spi",
> +                                    "allwinner,sun8i-h3-spi";

You need to document this compatible in the dt-bindings to avoid any warnings.

Regards,
Clement




> +                       reg = <0x05010000 0x1000>;
> +                       interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +                       clock-names = "ahb", "mod";
> +                       dmas = <&dma 22>, <&dma 22>;
> +                       dma-names = "rx", "tx";
> +                       resets = <&ccu RST_BUS_SPI0>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
> +               spi1: spi@5011000 {
> +                       compatible = "allwinner,sun50i-h6-spi",
> +                                    "allwinner,sun8i-h3-spi";
> +                       reg = <0x05011000 0x1000>;
> +                       interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> +                       clock-names = "ahb", "mod";
> +                       dmas = <&dma 23>, <&dma 23>;
> +                       dma-names = "rx", "tx";
> +                       resets = <&ccu RST_BUS_SPI1>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
>                 emac: ethernet@5020000 {
>                         compatible = "allwinner,sun50i-h6-emac",
>                                      "allwinner,sun50i-a64-emac";
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200108101006.150706-2-andre.przywara%40arm.com.
