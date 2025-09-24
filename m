Return-Path: <linux-spi+bounces-10245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A05B981CA
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 05:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFC1F4E0276
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 03:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2621D3C9;
	Wed, 24 Sep 2025 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="uGruRJUG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94C1F4C83;
	Wed, 24 Sep 2025 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683589; cv=none; b=s5okTtVDzh9KFobXHOd/bSgpQOgVs+ttpQ30UW4B0JCrlNPHGBDEa5fyhaMUjHnVcCT8pdcybX1QFYz6gDrvMzpMW13Ef9OVynDiL7+tjbiw/DE3uFc8B8qsrVzggtBYqura2YVA4i2TIQcwPWHFiGf1HZGQSQYNESrqDVubsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683589; c=relaxed/simple;
	bh=npVmB5SLZ5mcabM6YImEdPIjplSnQ/qCDGhwE3YzDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDOe/YDB7hTs3kH7omXFGxg6LOU91K8XbfQgyLB8XnyIihqqFYxJhgMxKXfdaoK8tAGrvYxvUEoRzNGjJAB0RyuKyp4bE6aP60lUY0E/rxfL0NN4HgmCDYJmshlp8fbUxL0nn3yBERZtBINJNpMh4I35/66mqaiv927TiGAAMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=uGruRJUG; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758683531;
	bh=wyZnq1brHXp0eEo0IcKGDfiavTz/KfAQPMcIkigjxZU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=uGruRJUGnrfoarV+40U4CZTZb3Mt+ts+ZqG07Kmxzkue0ghbpK4F7VwW/OjJvq9F4
	 KNiJ+kUBt+AC0eRr6R+913+Qp+lVR8f3qYS5V2XdoqIJCcng2PdD70vJ1jJICXVGab
	 b4555MzF9ea8+XQ8UNOfmzw36fUOX4+hpXgWqrp4=
X-QQ-mid: zesmtpip2t1758683524t33056b91
X-QQ-Originating-IP: bWui7aEgfFXT5ttQPtbdeAfhB/8ClfNTxNloyvrmXlY=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 11:11:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12855521764817172808
EX-QQ-RecipientCnt: 19
Date: Wed, 24 Sep 2025 11:11:56 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <BA5C7E3F6EED54EF+aNNhfO5CHCLVbpBR@troy-wujie14pro-arch>
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-4-elder@riscstar.com>
 <20250923001930-GYB1303776@gentoo.org>
 <ED4C67FD136DEB19+aNINJJVYbNnT87va@LT-Guozexi>
 <a9054501-03ce-4db2-a753-81741c6237b6@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9054501-03ce-4db2-a753-81741c6237b6@pigmoral.tech>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mc0T/2CU44J06AmmZ6n6NH5ur7RhYISe+F6L33WKaD+lgmVRX3Evh53j
	Z6A3IZQQdZPezcbaPjbw/hqe5AfhVFREdauE1flFX/uAOcXxT19kLCYwjLkoV/slqe+Nz9d
	x/LVcpT0IxrabfotuUt9+eEbjJkghg2uZVjkhyW2C3tSGkjR6zPmhQlgTRNK4YQptj2KVHk
	loZ8mnFhRsUYQvN8OmX4NY536bJtSKZqd8RwwLW+rHz/AfvPEcr/aJvjdHkHxVkQFw/iCh7
	AJf7430rPucnDHMEa8ujQ1i+FyWDjs7DWM/0155lmu8ey4OpBBcviYLyrK/MSvvqRpE1w3z
	8WkML7hdaib0uSk2pRQ/yGf5dQ1NZxL79jx36nOOfXbJAF9DyjYf1mj3xE4Odg16Cr+CRvQ
	8M2k1MFEos3Lzwrrm+Pm0My6j+YJQeluhBfvXvuVOU4fnlBZwqdpU3zMBFTuOTpFaoO/wvb
	ipFwEQ7GAaGF9ojbU6We5v+F6/S0n0rwHkv7XAbyex/zXN2IljSNrxGaRXSPB9S7HdTzuVQ
	cudD8by90KpnSPQpDnVVC/uGEL5fFaoacdD8FbO8Os7Hsgjk6TdKoUAuJO70s/7EqDv98Pp
	kaiC2KPvLMiDMNdcFKPa49cP2sms7tjiS5zJg4POFmaKhD2PW2Z9FEnr/447S+r2SokgfxI
	iSJ4/oAiGZ5kZgkz3G/S+HuKi1qkPdBHkZPpquCU2byl9YZSzBay4659WjaTFesiIa9VqGb
	B+HN0QzeWBj41hjbzgJBylYg/GIAsPsie69U5i6NhXGX/s/fxJeLr4X6f81ZZI8cQXHui8J
	B8prGKJYlFuhyKhMSwoGkHM34XIsU7oDOCtDhpmKbcU/zw0aFRbA/SCzhlkL+y/khy8cL19
	zhvPFAqqxUmHi4B1lKtOVGRRQqwonx2/molDksOr4hskqVWisep/6cv5zYNH4Kx+5XsIcT/
	pg7vI0E1GUmpUVNd5X5OdyMBlYy9nauSgyAFyvj1eXCO2beLJLDVSE9ejhyCstkpWl4m4TN
	/nCWT08QXS5OocaL3z810kgiscHWbK7okI2nF0mOV6oULR+fQwNJDn2LEss9/ylLPPO/Eke
	+9hjmvPrKHmb7VmC18VP/FrgkVxvC31GA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Sep 23, 2025 at 02:31:31PM +0800, Junhui Liu wrote:
> Hi Troy,
> 
> On 9/23/25 10:59 AM, Troy Mitchell wrote:
> > On Tue, Sep 23, 2025 at 08:19:30AM +0800, Yixun Lan wrote:
> > > Hi Alex,
> > > 
> > > On 11:17 Mon 22 Sep     , Alex Elder wrote:
> > > > Define a node for the fourth SoC SPI controller (number 3) on
> > > > the SpacemiT K1 SoC.
> > > > 
> > > > Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> > > > via its GPIO block:
> > > >    GPIO PIN 19:  MOSI
> > > >    GPIO PIN 21:  MISO
> > > >    GPIO PIN 23:  SCLK
> > > >    GPIO PIN 24:  SS (inverted)
> > > > 
> > > > Define pincontrol configurations for the pins as used on that board.
> > > > 
> > > > (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> > > > 
> > > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > > ---
> > > > v3: - Moved the SPI controller into the dma-bus memory region
> > > > 
> > > >   .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
> > > >   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
> > > >   arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
> > > >   3 files changed, 43 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > index 2aaaff77831e1..d9d865fbe320e 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > @@ -14,6 +14,7 @@ aliases {
> > > >   		ethernet0 = &eth0;
> > > >   		ethernet1 = &eth1;
> > > >   		serial0 = &uart0;
> > > > +		spi3 = &spi3;
> > > >   	};
> > > >   	chosen {
> > > > @@ -92,6 +93,12 @@ &pdma {
> > > >   	status = "okay";
> > > >   };
> > > > +&spi3 {
> > > > +	pinctrl-0 = <&ssp3_0_cfg>;
> > > > +	pinctrl-names = "default";
> > > > +	status = "okay";
> > > > +};
> > > > +
> > > >   &uart0 {
> > > >   	pinctrl-names = "default";
> > > >   	pinctrl-0 = <&uart0_2_cfg>;
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > index aff19c86d5ff3..205c201a3005c 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > @@ -76,4 +76,24 @@ pwm14-1-pins {
> > > >   			drive-strength = <32>;
> > > >   		};
> > > >   	};
> > > > +
> > > > +	ssp3_0_cfg: ssp3-0-cfg {
> > > ..
> > > > +		ssp3-0-no-pull-pins {
> > > I'd prefer not to enforce "pull" info inside the name, you can't embed
> > > all property info, besides, what's if you want to change/override later?
> > > 
> > > how about just name it as ssp3-0-defaul-pins or simply ssp3-0-pins?
> > uart: uart0_2_cfg and function is 2.
> > pwm: pwm14_1_cfg and function is 4
> > spi: ssp3_0_cfg and function is 2
> > 
> > I’m a bit confused about the meaning of the second number here.
> > Is it intended to be an index, or the function number?
> > 
> > If it’s an index, should it start from 0 or 1?
> > The starting point seems inconsistent across pwm/spi/uart.
> > If it’s supposed to be the function number,
> > then the spi and pwm parts look incorrect.
> > 
> > Could you clarify this? Yixun.
> 
> I think the second number represents the index of the pin group available
> for this device.
> 
> Take pwm14 as an example: according to the manual, the first pin group
> (index 0) available for pwm14 is GPIO6 with function 3, while the second
> group (index 1) is GPIO44 with function 4.
Thanks. Junhui.
with the hints from you and Alex, it’s now much clearer to me.

                    - Troy
> 
> >                  - Troy
> 
> -- 
> Best regards,
> Junhui Liu
> 
> 

