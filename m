Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839E2126EFD
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2019 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLSUiW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Dec 2019 15:38:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35152 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLSUiW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Dec 2019 15:38:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so3688934oik.2;
        Thu, 19 Dec 2019 12:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvcWgSs9CsFC10Off4IxnD7dpuy8j7JrLycgYVcspt0=;
        b=X9RHNnr4pPvAblRReJl7bH4TK0QS0ApYlqHEvdz5b9cexw/lVNNHvufv/kVNxTj1Oy
         3aAoJlWlaruijp7OwYiH/ES3iNUqLWvnEILuJIARSL+alfks+YSEMGRyb3DhQhFIBkkj
         ERJg80mxXh563onKBU76Jk1JjWUQ/3ND1s6Yph7D/IpvBuKsgx99CJjBLvYhVDkqvIUZ
         Pl2LpMe31l8a1B+pQH/9ZHSy/Uij2wrLhzJ+QWxLn85dANiRfZe0dmUIAFWdSfz41/iN
         Lvz5WeORjZJxUHFtkoMHOD1BXcIlOM8nwI5QlqYF8H2ucQb/e8io+ce57h1/d9uSNelK
         uXKw==
X-Gm-Message-State: APjAAAWYMMCGJccsbiD9fuJEVlL8dWfV8XWe4QgQFuZTtKL4SMIVx3l1
        ALYAHA27Kq1r4OrWYK88Nf8G/GbCyg==
X-Google-Smtp-Source: APXvYqw09TK+NgOVuSVlbNn3H/Uxf/mxAUrMwkfyQV/yAj9AZMiSAnScKaiMt6kmtIUSKyuB74tCHA==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr3123999oif.100.1576787901767;
        Thu, 19 Dec 2019 12:38:21 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id b3sm2340330oie.25.2019.12.19.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:38:21 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:38:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
Message-ID: <20191219203742.GA27539@bogus>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <bd2c82fa-b0f0-9274-8c69-d13f7cddefc5@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2c82fa-b0f0-9274-8c69-d13f7cddefc5@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 10, 2019 at 10:37:34PM +0300, Sergei Shtylyov wrote:
> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
> HyperFlash connected to the SoC to be accessed via the external address
> space read mode or the manual mode.
> 
> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
> gen3 SoCs.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt |   52 ++++++++++
>  1 file changed, 52 insertions(+)

Please convert to DT schema.

> 
> Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
> ===================================================================
> --- /dev/null
> +++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
> @@ -0,0 +1,52 @@
> +Renesas Reduced Pin Count Interface (RPC-IF)
> +--------------------------------------------
> +
> +Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
> +be accessed via the external address space read mode or the manual mode.
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc-if" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77980-rpc-if" (R-Car V3H),
> +		"renesas,r8a77995-rpc-if" (R-Car D3).
> +- reg: should list 3 register areas:
> +	1st for the RPC-IF registers,
> +	2nd for the direct mapping read mode,
> +	3rd for the write buffer area.
> +- reg-names: should contain "regs", "dirmap", and "wbuf".
> +- clocks: should contain the clock phandle/specifier pair for the module clock.
> +- power-domains: should contain the power domain phandle/specifier pair.
> +- resets: should contain the reset controller phandle/specifier pair.
> +- #address-cells: should be 1.
> +- #size-cells: should be 0.
> +
> +The flash chip itself should be represented by a subnode of the RPC-IF node.
> +The flash interface is selected based on the "compatible" property of this
> +subnode:
> +- if it contains "jedec,spi-nor", then SPI is used;
> +- if it contains "cfi-flash", then HyperFlash is used.
> +
> +Example:
> +
> +	rpc: spi@ee200000 {
> +		compatible = "renesas,r8a77995-rpc-if",
> +			     "renesas,rcar-gen3-rpc-if";
> +		reg = <0 0xee200000 0 0x200>,
> +		      <0 0x08000000 0 0x4000000>,
> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "wbuf";
> +		clocks = <&cpg CPG_MOD 917>;
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
