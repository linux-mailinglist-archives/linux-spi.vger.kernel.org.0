Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C511AC55
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfELNYD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sun, 12 May 2019 09:24:03 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51907 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfELNYC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 09:24:02 -0400
Received: from xps13 (unknown [109.190.253.16])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CBA23200009;
        Sun, 12 May 2019 13:23:49 +0000 (UTC)
Date:   Sun, 12 May 2019 15:23:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmail.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 4/4] dt-bindings: mfd: Document Macronix MX25F0A
 controller bindings
Message-ID: <20190512152328.49576a0f@xps13>
In-Reply-To: <1555320234-15802-5-git-send-email-masonccyang@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-5-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 15 Apr 2019 17:23:54
+0800:

> Document the bindings used by the Macronix MX25F0A MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> new file mode 100644
> index 0000000..7f3e0f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> @@ -0,0 +1,51 @@
> +Macronix MX25F0A MultiFunction Device Tree Bindings
> +----------------------------------------------------
> +
> +MX25F0A is a MultiFunction Device with SPI and raw NAND, which
> +supports either spi host controller or raw nand controller.

Acronyms in plain English should be in upper case.

> +
> +Required properties:
> +- compatible: should be "mxic,mx25f0a"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area in SPI mode.
> +- reg-names: should contain "regs" and "dirmap"
> +- interrupts: interrupt line connected to this MFD controller
> +- SPI controller driver:
> +		- clock-names: should contain "ps_clk", "send_clk" and
> +			       "send_dly_clk"
> +		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
> +			  and "send_dly_clk" clocks
> +
> +- Raw nand controller driver.
> +		- nand-ecc-mode = "soft";
> +		- nand-ecc-algo = "bch";
> +
> +Example:
> +
> +	mxic: mx25f0a@43c30000 {
> +		compatible = "mxic,mx25f0a";
> +		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
> +		reg-names = "regs", "dirmap";
> +
> +		/* spi */
> +		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +		clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <25000000>;
> +			spi-tx-bus-width = <4>;
> +			spi-rx-bus-width = <4>;
> +		};
> +
> +		/* nand */
> +		nand-ecc-mode = "soft";
> +		nand-ecc-algo = "bch";
> +		nand-ecc-step-size = <512>;
> +		nand-ecc-strength = <8>;

Any reason to enforce 512B/8b correction? Why not letting the core
choose for you depending on the NAND chip's requirements?


Anyway, I think you can have only one or the other (NAND or SPI), not
both, and you probably should have a compatible or a property to tell
the kernel which one you are using, right?


Thanks,
Miquèl
