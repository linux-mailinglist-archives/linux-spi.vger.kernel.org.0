Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3C6A2C7
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2019 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfGPHTs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 16 Jul 2019 03:19:48 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50989 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfGPHTs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jul 2019 03:19:48 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4582860017;
        Tue, 16 Jul 2019 07:19:34 +0000 (UTC)
Date:   Tue, 16 Jul 2019 09:19:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Ensure child nodes are of type 'object'
Message-ID: <20190716091933.39db956e@xps13>
In-Reply-To: <20190715230457.3901-1-robh@kernel.org>
References: <20190715230457.3901-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Mon, 15 Jul 2019 17:04:57 -0600:

> Properties which are child node definitions need to have an explict
> type. Otherwise, a matching (DT) property can silently match when an
> error is desired. Fix this up tree-wide. Once this is fixed, the
> meta-schema will enforce this on any child node definitions.
> 
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. I will take this via the DT tree.
> 
> Rob
> 
>  .../devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml       | 1 +
>  .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml      | 1 +
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml     | 1 +
>  .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml          | 3 +++
>  .../devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml       | 1 +
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml       | 1 +
>  6 files changed, 8 insertions(+)
> 

[...]

> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index 199ba5ac2a06..d261b7096c69 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@ -40,6 +40,7 @@ properties:
>  
>  patternProperties:
>    "^nand@[a-f0-9]$":
> +    type: object
>      properties:
>        reg:
>          description:

For the mtd .yaml:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
