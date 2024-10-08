Return-Path: <linux-spi+bounces-5150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85F995232
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1006287D62
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F81DF755;
	Tue,  8 Oct 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHX7Gz28"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FB17578;
	Tue,  8 Oct 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398786; cv=none; b=dMVn4g2wrmMMcwPyMuxwUvCVdE0pcBZgabvYbl1nyJUI3slFwljC8RGLv/fllZuWDjSabFSAv8yE3Jwqq1YRhYZiFDuJn6Z6lxqDpXET92096gGMUOjNmMn7ElPYR1VzWZZBE4nT8uBBxi3EKdNKQg6eqgANa8wX2dOtPYucdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398786; c=relaxed/simple;
	bh=34eqIgIEnAmFyyXITKqyE+kOFUPFQy1pHLd7ZIEbyRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJlZ8NI2MtVD7dbF+M+PLumgfwXzhDh6rUi4eRQzebBJMvAM/OeXwjcr6qNC2OORAHRa1LWJA977wTEtaQwN1P+/inITn76CYinzNwcx+QfdVjNWkpA/htsIc6ByMMcwYI+exXSR9T5ldbXxuqYiDlDu5TLb/3oxsDjo6/fZsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHX7Gz28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8ACC4CEC7;
	Tue,  8 Oct 2024 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398785;
	bh=34eqIgIEnAmFyyXITKqyE+kOFUPFQy1pHLd7ZIEbyRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHX7Gz28VlZTtH8hoqdyWY5BbrD5MRLwvmxo6OHs8nXaqO0BEbGxdCFFQAacPFn/L
	 9ciAsNJSm7F5b5UadxRwssoWv3fg57Xk6PPkuL5mcfB6kTBKpGIwm8IoufsQjrUZvE
	 fBOr5B4Mp6mkGTzQh/GTy+50oC62fgeB5uk3J9SS1gh0lgPeMf7ticTMWww3J1kiDf
	 +R1aprCRA05SpweeE06vDIIj0MKaMDKSxeaRCpM5RaedD6sotIgIdYd23yLC42BahE
	 5NYuch1XbvY6+DRNxbCRsUHV4NYMN1r2lE1zdAeiaR5D8Pj2R5wvYBT8FA1S+TFsNB
	 71dBTfnbPCGdw==
Date: Tue, 8 Oct 2024 09:46:24 -0500
From: Rob Herring <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Message-ID: <20241008144624.GA1284425-robh@kernel.org>
References: <20241008002308.1149983-1-chris.packham@alliedtelesis.co.nz>
 <20241008002308.1149983-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008002308.1149983-2-chris.packham@alliedtelesis.co.nz>

On Tue, Oct 08, 2024 at 01:23:05PM +1300, Chris Packham wrote:
> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
> controller supports
>  * Serial/Dual/Quad data with
>  * PIO and DMA data read/write operation
>  * Configurable flash access timing
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - Add clocks
>     - For now I've kept realtek,rtl9300-snand to identify the IP block used
>       in the various rtl930x chips. If the consensus is to drop this I can
>       send a v3 with an updated driver to add the chip specific complatibles.
> 
>  .../bindings/spi/realtek,rtl9300-snand.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> new file mode 100644
> index 000000000000..2d01464e85e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/realtek,rtl9300-snand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +description:
> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It supports
> +  typical SPI-NAND page cache operations in single, dual or quad IO mode.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - realtek,rtl9301-snand
> +          - realtek,rtl9302b-snand
> +          - realtek,rtl9302c-snand
> +          - realtek,rtl9303-snand
> +      - const: realtek,rtl9300-snand
> +
> +  reg:
> +    items:
> +      - description: SPI NAND controller registers address and size

Just 'maxItems: 1'. The description is fairly obvious.

> +
> +  interrupts:
> +    items:
> +      - description: SPI NAND controller interrupt

Same here.

> +
> +  clocks:
> +    items:
> +      - description: SPI NAND controller reference clock

And here.

> +
> +  clock-names:
> +    items:
> +      - const: spi
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@1a400 {
> +      compatible = "realtek,rtl9302c-snand", "realtek,rtl9300-snand";
> +      reg = <0x1a400 0x44>;
> +      interrupt-parent = <&intc>;
> +      interrupts = <19>;
> +      clocks = <&lx_clk>;
> +      clock-names = "spi";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +        compatible = "spi-nand";
> +        reg = <0>;
> +      };
> +    };
> -- 
> 2.46.2
> 

