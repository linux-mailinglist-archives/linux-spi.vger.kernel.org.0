Return-Path: <linux-spi+bounces-7481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACEA81EAF
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F253B1DC6
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB51DD9AD;
	Wed,  9 Apr 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU9G9DO/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25189259C;
	Wed,  9 Apr 2025 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185173; cv=none; b=QIx1xgzKQDoswznqvduArCQz04e2KtsYMi0TZpV1lkZo0n9WJnEYDRyBftdCB6AxNalAT7X17EXZ4ndgBU08C3EVq1jwJ0c89RfEuY8SWUrAHgy93DdSXk9/WmzlAIsJ6xmVFXesg8Glg0mst3/EWRtHIncABmxxh3/2ZQVGGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185173; c=relaxed/simple;
	bh=XjAKn4aDznWhBOaqEoB9bXhZFVhxOdYJJPaXIpo77zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf2davA4MmUJq3Log0On81MAjTyuFbIcOgqqbm/ffiEZRipR4tCtsbXCWIBvkm3aR6l2EhPAo52c3onBqFrx6GxswVxihwToR7Npvn4DDNoYLMTOP3oO6AUvde8zkfoLMrTjMNdetQw3Pf1pqm2/18IWBZvY2dAH4g3oRPaK7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU9G9DO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE36C4CEE3;
	Wed,  9 Apr 2025 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744185172;
	bh=XjAKn4aDznWhBOaqEoB9bXhZFVhxOdYJJPaXIpo77zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sU9G9DO/fROyMfqlpzDHMTPzJtcZtuh73c4/hx6JY4ntTgETXl5pVnYebOrdn0Iz6
	 WBo8htxQ73LcrAOWbQ/0dEFhb+EFWDab7zuEe6M7PAzRohgB1BCUwxMusSVHdFkzxt
	 DykxPGdgngfGNEk5IOl7Br2OoRIcN66WZqE2rU7glaGfz7AB03oph6JZ3LJkla9XzV
	 b04VY+KYo3oRYkMW9ST1cazdrbmvXu9yXEyHkG3VTfeO5KTsFEzHqItQLYXF6EchQo
	 RdNrnK4dOFw9VCqFZrAf11I1J4YsWiiDD2u3KIhkngnJBJB1oUefDeebX9FlFMphvq
	 Pb6EinzZNbc+w==
Date: Wed, 9 Apr 2025 09:52:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
Message-ID: <20250409-functional-cheetah-of-honor-b9d9cf@shite>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
 <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
 <CAMuHMdUiO2mVzYn4PGZwUat6W_0JQjD3be7X6ThzK7vcPisKEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUiO2mVzYn4PGZwUat6W_0JQjD3be7X6ThzK7vcPisKEg@mail.gmail.com>

On Wed, Apr 09, 2025 at 09:01:22AM GMT, Geert Uytterhoeven wrote:
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        pattern: "renesas,.*-msiof"
> > > +  required:
> > > +    - compatible
> > > +    - port
> >
> > Drop entire select.
> 
> This is needed to avoid matching when using the device in SPI mode.

Which you need to avoid, so drop the select. One device, one schema.

> 
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: renesas,msiof-r8a779g0   # R-Car V4H
> >
> > Use expected format of all soc compatibles. It has been always: SoC-module.
> 
> This is a pre-existing compatible value, so it cannot be changed.
> 
> > > +      - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
> >
> > If you have duplicated compatibles then:
> > 1. It rarely makes sense because you claim that two different devices
> > are using the same compatible. Different device, different compatible.
> > 2. Or if this is really same device, then only one schema.
> 
> This the same device, but it can be used in two (actually more)
> different modes: SPI and I2S.  Hence it has two separate DT binding
> documents.  If this needs to be merged (the result is gonna be ugly):

... then next time don't post incomplete bindings. I know we do not have
time machine, but any mess is on contributors who posted some limited
scope/view of the hardware entirely ignoring the rest of interfaces.

> where to fit it in the DT binding doc hierarchy?

Does not matter, whatever fits better in overal picture/purpose of this
device.

> 
> > > +  reg:
> > > +    minItems: 1
> > > +    maxItems: 2
> >
> > Drop these two.
> >
> > > +    oneOf:
> >
> > Why is this flexible?
> 
> I am not sure where this is coming from (an old SH part?).
> The SPI bindings have the same construct.  As this binding supports
> R-Car Gen4 only, a single reg should be fine.
> 
> >
> > > +      - items:
> > > +          - description: CPU and DMA engine registers
> > > +      - items:
> > > +          - description: CPU registers
> > > +          - description: DMA engine registers
> 
> > > +  dmas:
> > > +    minItems: 2
> > > +    maxItems: 4
> >
> > Why flexible?
> >
> > > +
> > > +  dma-names:
> > > +    minItems: 2
> > > +    maxItems: 4
> > > +    items:
> > > +      enum: [ tx, rx ]
> >
> > How would that work? tx rx tx rx? And then driver requests 'tx' (by
> > name) and what is supposed to be returned?
> 
> The module may be connected to one or more DMA controllers (see below).

Yes, but how the implementation would work?

Anyway, this needs to be strictly ordered, not random rx rx tx tx or rx
rx rx rx.

> 
> > > +
> > > +    msiof1: serial@e6ea0000 {
> >
> > serial means UART controller. You need name matching the class of the
> > device.
> > Node names should be generic. See also an explanation and list of
> > examples (not exhaustive) in DT specification:
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> What is the recommend generic node name for a flexible serial device
> that can operate as (a.o.) either SPI or I2S controller?

i2s
or even not so generic msiof, but definitely not serial because that is
reserved for UART.

> 
> > > +      compatible = "renesas,msiof-r8a779g0",
> > > +                   "renesas,rcar-gen4-msiof";
> > > +      reg = <0 0xe6ea0000 0 0x0064>;
> > > +      interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> > > +      clocks = <&cpg CPG_MOD 619>;
> > > +      dmas = <&dmac0 0x43>, <&dmac0 0x42>,
> > > +             <&dmac1 0x43>, <&dmac1 0x42>;
> > > +      dma-names = "tx", "rx", "tx", "rx";
> >
> > So test it now - get DMA by name 'tx'. What do you get?
> 
> A handle to either <&dmac0 0x43> or <&dmac1 0x43>; which one is
> random. It's been working like that for ages.

Interesting. And is this expected behavior? Driver does not care which
RX and which TX it gets? Like RX from dmac0 and TX from dmac1?

Best regards,
Krzysztof


