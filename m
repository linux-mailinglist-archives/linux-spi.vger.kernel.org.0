Return-Path: <linux-spi+bounces-3198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2471D8D843A
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D151F22254
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260F12E1CA;
	Mon,  3 Jun 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrVLPgLC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791912DD91;
	Mon,  3 Jun 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422085; cv=none; b=qAdRlizbaGdT5YyPXz/X3lUGSV+6Is9TGsk6UL2/0z+qBuIdsJFOb8aPP/DJ5wTx5PCrIxE2zRd8JNcDWjXp0lswn0ZKqrmrtWwtEXyKZQ5uL3wWl4GEgopq2oYfbl60bDi6T43VH6NvI3H7Xjkr2VEP26zk3QQDYGo2veR0ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422085; c=relaxed/simple;
	bh=xJc0AqiQQy29me8ABZmN4bLw9qKXRmQk/m23w3aMWzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuqoFmDzkdj3e0DxbYJEfATV2FgxmqkP/v9NYo+U9yq0Xbde38xB9ffQgiz8NBrw7PTv5tqHQ+qGnZSjQnTywF9PmgNAqki1O7ZLHx+5G2kbqRiKMnwaC1DYR7niv2SDUrBDla9kNkj+azh9vYp0Do2LumRS6DX5wQ6KmtCLOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrVLPgLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC77C32781;
	Mon,  3 Jun 2024 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422084;
	bh=xJc0AqiQQy29me8ABZmN4bLw9qKXRmQk/m23w3aMWzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrVLPgLC5HvIM6QZDKMEmG2pQz6gMGTRQCTff9vNcCCNSJXylXLt3Gv6xP5sO+7Ks
	 8P1Q9ERz0Xvf4zWFziee5N4XdHSvaRVJQ9Y0/0MNXScCpBEsYHHuMO1ZFTH1j4CjS6
	 K3HnlWV5VqFdod/imHOqV2U9SPGlr/WhdYmOOt8m6BNfmnHVblKYjMlZCrN3LTteFx
	 EwnfAqGe/lVTWeiLNguwOOBkENiY7RpjU95yZ3OE1him7TZWVpqGHNytWrVA6lsspF
	 vts19f5E9lahhL/yFdFdiKY8Nn9sTnf8Moz7KTCylek4wevly8MyUkUkOK0lx1rQ+P
	 g782GKVj+0SIg==
Date: Mon, 3 Jun 2024 08:41:21 -0500
From: Rob Herring <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v3] dt-bindings: spi: brcm,bcm2835-spi: convert to
 dtschema
Message-ID: <20240603134121.GA168897-robh@kernel.org>
References: <20240531122941.3524-1-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531122941.3524-1-kanakshilledar111@protonmail.com>

On Fri, May 31, 2024 at 05:59:37PM +0530, Kanak Shilledar wrote:
> From: Kanak Shilledar <kanakshilledar@gmail.com>
> 
> Convert the Broadcom BCM2835 SPI0 controller to newer DT
> schema. Created DT schema based on the .txt file which had
> `comaptible`, `reg`, `interrupts`, `clocks` as required
> properties.
> Added GPL-2.0 OR BSD-2-Clause License
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>

You forgot Conor's Reviewed-by tag.

> ---
> Changes in v3:
> - Updated DCO email address
> Changes in v2:
> - Updated the maintainers
> ---
>  .../bindings/spi/brcm,bcm2835-spi.txt         | 23 ---------
>  .../bindings/spi/brcm,bcm2835-spi.yaml        | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
> deleted file mode 100644
> index 3d55dd64b1be..000000000000
> --- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Broadcom BCM2835 SPI0 controller
> -
> -The BCM2835 contains two forms of SPI master controller, one known simply as
> -SPI0, and the other known as the "Universal SPI Master"; part of the
> -auxiliary block. This binding applies to the SPI0 controller.
> -
> -Required properties:
> -- compatible: Should be one of "brcm,bcm2835-spi" for BCM2835/2836/2837 or
> -  "brcm,bcm2711-spi" for BCM2711 or "brcm,bcm7211-spi" for BCM7211.
> -- reg: Should contain register location and length.
> -- interrupts: Should contain interrupt.
> -- clocks: The clock feeding the SPI controller.
> -
> -Example:
> -
> -spi@20204000 {
> -	compatible = "brcm,bcm2835-spi";
> -	reg = <0x7e204000 0x1000>;
> -	interrupts = <2 22>;
> -	clocks = <&clk_spi>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> new file mode 100644
> index 000000000000..94da68792194
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 SPI0 controller
> +
> +maintainers:
> +  - Florian Fainelli <florian.fainelli@broadcom.com>
> +  - Kanak Shilledar <kanakshilledar111@protonmail.com>
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-spi
> +      - brcm,bcm2711-spi
> +      - brcm,bcm7211-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@20204000 {
> +        compatible = "brcm,bcm2835-spi";
> +        reg = <0x7e204000 0x1000>;
> +        interrupts = <2 22>;
> +        clocks = <&clk_spi>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> -- 
> 2.34.1
> 

