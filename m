Return-Path: <linux-spi+bounces-10122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A4B85468
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45101587730
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBB305061;
	Thu, 18 Sep 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YEWrKUzS"
X-Original-To: linux-spi@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6D30B531;
	Thu, 18 Sep 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206056; cv=none; b=KXdYO8KHhjwmuDuOaFJx5XLbWYc4KTte7cJcMDHHn/wqSCIwpReXw/+yM3XWcqaTnNRHqC4FG/HWwfp5HR4ygEnPXCpRhv9TLuu10xvBCW/L7BRIcx3nws9kPsVF+ly93FydFCUBrYCh1v8N0MFguDllzp+JFthxW7ZloyGMERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206056; c=relaxed/simple;
	bh=OJ/iqE0vvbz18E6GMkIrxbTsaF2vnkeSqVJuU7BblCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXK886d6YteddNUlyHEVNWuS9wV+jYK7pZ69PB6r/cr+7Ryun8ndWvsoI1RA6TwLfLSguovbKj26FMJ8BmBoNSjgJwq/fC+mf+z9nKXwATxTO79OcbSD+o18lvzgZ7F1/6+OZCSE2P1nDOZo9uQy8T/5163dTHeadREYy2ZNG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YEWrKUzS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CFC7826210;
	Thu, 18 Sep 2025 16:34:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykOANX01JFbL; Thu, 18 Sep 2025 16:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758206043; bh=OJ/iqE0vvbz18E6GMkIrxbTsaF2vnkeSqVJuU7BblCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YEWrKUzSsCSY/6lIet+LJXfrbqvxxgBxu6EEaX8WOASNrM38vUChMCZrBB90JUeZr
	 PYE4avyLNpvtfF3gMXoo/oN4PzmqZRuq3zKlh6TIzhiqSezN8/ZUxp5MzRdt+aXPqZ
	 C878VW1nj0rQliDJ4fSM76NUg9MIMxlTihpAKWpybl0tWvALkOrBbqexPFr5o1qXpg
	 3rmhgnenssdkNeC17OKLvMoWxS8IBGORgKww22AU2aqImLklkm8lEnnTRsKEVVhN9q
	 nZUmKMgCaje+iGZkQ6UF4F3mNjEudmMO9W4ifJ7wT9WeOdKg5wkOLfMUHye9TgosOc
	 qQn2tknU207Yg==
Date: Thu, 18 Sep 2025 14:33:40 +0000
From: Yao Zi <ziyao@disroot.org>
To: Yixun Lan <dlan@gentoo.org>, Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <aMwYRGjTdbQCJf3S@pie>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
 <20250918133209-GYB1273705@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918133209-GYB1273705@gentoo.org>

On Thu, Sep 18, 2025 at 09:32:09PM +0800, Yixun Lan wrote:
> Hi Alex,
> 
> On 17:07 Wed 17 Sep     , Alex Elder wrote:
> > Define a node for the fourth SoC SPI controller (number 3) on
> > the SpacemiT K1 SoC.
> > 
> > Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> > via its GPIO block:
> >   GPIO PIN 19:  MOSI
> >   GPIO PIN 21:  MISO
> >   GPIO PIN 23:  SCLK
> >   GPIO PIN 24:  SS (inverted)
> > 
> > Define pincontrol configurations for the pins as used on that board.
> > 
> > (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> > 
> > Signed-off-by: Alex Elder <elder@riscstar.com>
> > ---
> >  .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
> >  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
> >  arch/riscv/boot/dts/spacemit/k1.dtsi          | 19 ++++++++++++++++++
> >  3 files changed, 45 insertions(+)

...

> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > index 66b33a9110ccd..a826cc1ac83d5 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -834,6 +834,25 @@ storage-bus {
> >  			#size-cells = <2>;
> >  			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
> >  
> > +			spi3: spi@d401c000 {
> > +				compatible = "spacemit,k1-spi";
> > +				reg = <0x0 0xd401c000 0x0 0x30>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				clocks = <&syscon_apbc CLK_SSP3>,
> > +					 <&syscon_apbc CLK_SSP3_BUS>;
> ..
> > +				clock-names = "core",
> > +					      "bus";
> can you simply put them together in one line? it's kind of tedious to split..
> > +				resets = <&syscon_apbc RESET_SSP3>;
> > +				interrupts-extended = <&plic 55>;
> why use interrupts-extended?
> > +				spacemit,k1-ssp-id = <3>;
> > +				dmas = <&pdma 20>,
> > +				       <&pdma 19>;
> .. em, so the SPI will use pdma, then probably you should also adjust Kconfig to
> select PDMA driver?

The driver seems to depend on the generic DMA engine API only, IOW,
theoretically it should work with other DMA controller as well. And it's
even capable to operate without DMA (see k1_spi_dma_setup()).

Dependency to PDMA really doesn't seem something should be enforced in
Kconfig: it doesn't exist in code level, and the driver is actually more
flexible.

Best regards,
Yao Zi

> > +				dma-names = "rx",
> > +					    "tx";
> > +				status = "disabled";
> > +			};
> > +
> >  			emmc: mmc@d4281000 {
> >  				compatible = "spacemit,k1-sdhci";
> >  				reg = <0x0 0xd4281000 0x0 0x200>;
> > -- 
> > 2.48.1
> > 
> > 
> 
> -- 
> Yixun Lan (dlan)
> 

