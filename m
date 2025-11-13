Return-Path: <linux-spi+bounces-11181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF04C565F6
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCAB3B8438
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A833291F;
	Thu, 13 Nov 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdjP1K45"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574F33290C;
	Thu, 13 Nov 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023910; cv=none; b=alMtmcI5j2nN7JFxNsSiSZBitFQ3stDQxfNwtrR5yCfagjCvnnsZV2D42sNsaOLtvzxNSAaxp4OjE3RmVEHN9h+Y94ZJRxn5ixDn69Kl5B7/8UzOi7FmdylkCjxpFdP5j3x7jiFbdGMF0XLTB1D9dCuEG/oogVZdce4DxHISEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023910; c=relaxed/simple;
	bh=H63NxSppjTvEdhpkW2ZiNbrZQD1ZYTG2LKogPmLbgA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGRUy9MD4sPmu4/OZo51d6UEZekBECbzoTFPMgbYlEb5ORMOmuDOz4AYTugVmZpTyRaLtqiTzHydaHnVSoOtDoq/HbMdXJRT7RWDShOq47BTsriQ09arHOWmUY5/pzvOzAOwaAVfl/nzLq9Hf0Z2heUPJxqx04JBVw1aJL3Gdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdjP1K45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F8AC19421;
	Thu, 13 Nov 2025 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763023909;
	bh=H63NxSppjTvEdhpkW2ZiNbrZQD1ZYTG2LKogPmLbgA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdjP1K45hZnYy5oVOE7A7c4o4krZZYGjqaYWY8PAj7tKXA73VCTJii4c+ikFsxoil
	 H1m9eBcwkj/V9dePKQS6i+KgP13IhewOOY3uNjOqH/M7gtD/ygVI3TRB6b9d/XgKE4
	 u+T55S8TQXTIoWU8dritCJRc6Ycj60zno7dVcavHtSH1CD6tVcm0Zqb2JeQnQbkwKk
	 YT6IVtZQOzteb88pZBu0iGtWRZUIHN/EYseP9zRTBFY2hVFxEyZVZcipF3/X2KKnZO
	 7oEMIqqMyAGWSlf2WdEYFL3KIBAA4nYqgWokYotdyl+3uYPFi6tCq15ZRewai4TqG+
	 ofR6CRrHk/lng==
Date: Thu, 13 Nov 2025 09:51:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	broonie@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	andrew@codeconstruct.com.au, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT
 schema
Message-ID: <20251113-loose-seahorse-of-endeavor-5d216e@kuoka>
References: <20251112173314.1751671-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112173314.1751671-1-tmaimon77@gmail.com>

On Wed, Nov 12, 2025 at 07:33:14PM +0200, Tomer Maimon wrote:
> +  The NPCM7XX supports three FIU modules:
> +    FIU0 and FIUx support two chip selects
> +    FIU3 supports four chip selects.
> +
> +  The NPCM8XX supports four FIU modules:
> +    FIU0 and FIUx support two chip selects
> +    FIU1 and FIU3 support four chip selects.
> +
> +  Alias convention:
> +    The '/aliases' node should define:
> +      For NPCM7xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux;
> +      For NPCM8xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux; fiu3=&fiu1;
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-fiu # Poleg NPCM7XX
> +      - nuvoton,npcm845-fiu # Arbel NPCM8XX
> +
> +  reg:
> +    minItems: 1

It wasn't flexible in the original binding. Your DTS being absolute mess
and defining one 'reg' entry but two 'reg-names' (!!!) does not help at
all.

Anyway, address space is rarely optional, so I have doubts you would
have proper justification for this change.

> +    items:
> +      - description: FIU registers
> +      - description: Memory-mapped flash contents (optional)
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: control
> +      - const: memory
> +
> +  interrupts:

Wasn't in the old binding. I asked last time - you need to explain each
changen done to the binding from pure conversion.

> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  nuvoton,spix-mode:
> +    type: boolean
> +    description: Enable SPIX mode for an expansion bus to an ASIC or CPLD.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> +    fiu3: spi@c0000000 {

Drop unused label.

> +        compatible = "nuvoton,npcm750-fiu";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0xfb000000 0x1000>,
> +              <0x80000000 0x10000000>;

Keep reg as the second property, followed by reg-names.

> +        reg-names = "control", "memory";
> +        clocks = <&clk NPCM7XX_CLK_AHB>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&spi3_pins>;

Best regards,
Krzysztof


