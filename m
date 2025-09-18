Return-Path: <linux-spi+bounces-10153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB0B86CB0
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EB2562803
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328003074BE;
	Thu, 18 Sep 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYazTVQ3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375A2D249E;
	Thu, 18 Sep 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225446; cv=none; b=pd9+srgTcefgbKLZt7imVoZ/P2vxcA4MBegmhL+nbISood19R1PVpuoZERlznt/+HsbXojyhdi/tanR99ALHiaJUoavoHdXtMUPTBt81uV+3Efo5IqXBztFmMB96/MskyONvOwMkSAJXQ006dc79lk8HV9RzAoeDGbnhhkEwHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225446; c=relaxed/simple;
	bh=mm1gEryd3OdYL9qRPSiR7N0OmJPd7syrgp/Mbp7JgJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NroGFVPhucq5a4JfIff/04Bw0QioQ0yYOhoduL2KxnzPDrB7yb6FJdnjiJuATb2Yi5UXkWvXDcg/DrmJRpQruesb/XieJkIhTqyo1SPtAXCFapx/cwa/2ghrsnUrkEd5hP6NxUoQ4m7AphZXU0ZgpU+Gy0KbX8t6fV/0NFHbAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYazTVQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9913C4CEF0;
	Thu, 18 Sep 2025 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225445;
	bh=mm1gEryd3OdYL9qRPSiR7N0OmJPd7syrgp/Mbp7JgJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYazTVQ3FHABUPeeroHTguX3M7ItH4BTfzvcRwMIzdCwakVrYVsST1FB+zOvVi0jl
	 Pmhr5hOOY6kyhTxgnao8676c7MQU9HHhb2TgotogsyOD1AtwP7M+oX1whUQCr21sY+
	 5OfPF3wFGLze//KJ6QxcmURMKKF823gqP08Ox3adQIDDBHxijNE6GmiEcLe/FGZfdE
	 Rq+/1yzWgZTjHFciFmgb7RyP+AsV6pBV1p2PwwDXd2rHCYSF1z8UaW/PkIML4uJDc3
	 YPWRmzP9wTKB3gR3R/lNGt5oKE/+Y393DFnU2Y/WXJ71IdZ42DfTyBOQ/GyOuaRjDI
	 6jERCg0fTXHCA==
Date: Thu, 18 Sep 2025 14:57:16 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <20250918195716.GA2521514-robh@kernel.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
 <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>

On Wed, Sep 17, 2025 at 06:40:31PM -0500, Alex Elder wrote:
> On 9/17/25 6:15 PM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > On 17:07 Wed 17 Sep     , Alex Elder wrote:
> > > Add support for the SPI controller implemented by the SpacemiT K1 SoC.
> > > 
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
> > >   1 file changed, 94 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> > > new file mode 100644
> > > index 0000000000000..5abd4fe268da9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> > > @@ -0,0 +1,94 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
> > > +
> > > +maintainers:
> > > +  - Alex Elder <elder@kernel.org>
> > > +
> > > +description:
> > > +  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
> > > +  FIFOs, for transmit and receive.  Details are currently available in
> > > +  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
> > > +  K1 Documentation[1].  The controller transfers words using PIO.  DMA
> > > +  transfers are supported as well, if both TX and RX DMA channels are
> > > +  specified,
> > > +
> > > +  [1] https://developer.spacemit.com/documentation
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - spacemit,k1-spi
> > one enum is effectively equal to const..
> 
> OK.  That's an easy fix.
> 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Core clock
> > > +      - description: Bus clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: core
> > > +      - const: bus
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  dmas:
> > > +    items:
> > > +      - description: RX DMA channel
> > > +      - description: TX DMA channel
> > > +
> > > +  dma-names:
> > > +    items:
> > > +      - const: rx
> > > +      - const: tx
> > > +
> > > +  spacemit,k1-ssp-id:
> > > +    description: SPI controller number
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > could you explain a little bit why this vendor specific property should
> > be introduced? I took a look at the code, and didn't get the reason
> > behind.. or what's the problem of simply using "pdev->id"?
> 
> This property was carried over from the vendor code.  It is
> optional, and if it isn't specified, the platform device ID (-1)
> will be used.  It's just intended to provide a well-defined ID
> for a particular SPI controller.
> 
> > we should really be careful to introduce vendor specific property..
> 
> If there were a standard way of doing this I'd love to use it.

The standard way is we don't define made up device indices in DT. Well, 
except /aliases allows you to do that.

Rob

