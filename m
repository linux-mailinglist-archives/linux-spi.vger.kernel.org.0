Return-Path: <linux-spi+bounces-10244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF4B981BE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 05:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59513B4156
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA121D3C9;
	Wed, 24 Sep 2025 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="IGbBHPks"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4220296E;
	Wed, 24 Sep 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683487; cv=none; b=Lmag2MzPaqbt+rpqyezTuok2ZENa5fwGD/4xmsLHCqoEWLujXWgfJMjE9JnOo4CF5Q8HGv0LawO2YXaw+SMTT5kkIoAZBJeCdSTWD5xfLrOCH3HlAsPDmGQ3N7dBYr2UsrAKMy4b4+JgK5QPGh8ehvXNTUPzH8/KIt/EPF2CjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683487; c=relaxed/simple;
	bh=vH8bRAAAeNwt95lyr05jkhbdpez5LI3XSYx8WUp52Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAI9B8Z1G90hPsgFmIli8msRKCfVMSFPLvvTOFO5HozHx8Zklago3w1M5/Zu+fGpmAnIw673b1gVXtA3a4Z467/jxxjxeFSqeiacf1gan3kOhv7BEh87OOVdGWoEQiz77EfE/uFRQL+N/B20wDJaUpTEYLKAC7f71TSBKlpYcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=IGbBHPks; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758683417;
	bh=Jjv11R9aDZY3HkfGigCrmCIN/cryRhO5uSzQW7puPAU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=IGbBHPksHmyo7HGMGpYIRxvv1yQHUUEGLaTjQCjs9hGwgPPqXM3E21ozilYY3HE1W
	 Qwz3AbnIwpx1kpgHmlMPJh7pRhCqXU5xFCUD3JIx5qg8X80A9Axg3WLNZvE8U1HSB0
	 cN67sCRL2MMGYkq69V0AGlH6durb4cofcOM/gbzI=
X-QQ-mid: zesmtpip3t1758683415te22064f3
X-QQ-Originating-IP: yaxed/vfNqQ91O3loxchB2e5ZjRmDPdUjsPhX4ETg3c=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 11:10:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3107347898178425822
EX-QQ-RecipientCnt: 18
Date: Wed, 24 Sep 2025 11:10:06 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <78FF4A33F1D1916E+aNNhDuW28Ia6o8gm@troy-wujie14pro-arch>
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-4-elder@riscstar.com>
 <20250923001930-GYB1303776@gentoo.org>
 <ED4C67FD136DEB19+aNINJJVYbNnT87va@LT-Guozexi>
 <1aa28123-cfa4-415a-9d1b-4d9edd62489b@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1aa28123-cfa4-415a-9d1b-4d9edd62489b@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MKbitA53r7aLonQEbgqrpF7ztfkJgkvnuvhdf1wmMZ5nBRRn+9sSuoSO
	0XVjrg8FIenKij+Qe65Gq+sKYXu0ft/S9xFm3145jOh/uH/59f1hg7kRGFIQ9tPMvJdHK5L
	sHaBcMFzjGOxJbR6BHIbLqB4pgTxR2e4grbjBn8tBEwJfucDl6VD0CxdA15CKTjkkzyk2uX
	IzYSlHAKd6+4O3Gz0ipWYUvbOFR6IuYGWI7lRYu+geyRNhPc8OvwTK2wWuDMuS2CIusMfVW
	G8CQEuuLSaBTIK39E/0ilGNSusUkIiIs1sdjM/jroyIc4moo5GJgSIexDbMD1uZXV2I1/Y6
	wQrzwlp8+mILcR7Nkevb1U1BmHMrSwgkSioDU9EDgm1S6liROC/7bSEQd1a/675PyIkPtKt
	kjP6V4a0tbzCVZ0jDS0TbqnlcJMxxQGqqUEMKhdK8r0mfwWrCq+I+OWNWU9HkIHKgZIsmyS
	MZV0hQl720cBquFJINtdip9l1jOSMqBSHuyBv7B4PfWUf5k/dVLnOzD6jjqOSVMiSfWYZBG
	2ewlbV5BjaGJkMp07JU+sRjOsj5XK8Rrj2TNEWaC1mBAbyRJQ+zTJj/Htjsq6fd4ceJHOmI
	9rIiUQcMtL0+ED/Rmigahjqn22L2eIBDjSfN8vrSP/5jjCnWMMbPSS5TW9G2t1p1mkqsDzO
	H7OfaP0ur+4bPG3aHI7jmvRcKDUINNe0PocCUH3GQMcVBEMB+1dyWUPA7EbLjg/MyEhxu2O
	l/Dc3Xtkm+67JZfcLC1uLSc5xXLNyJSXW3jnbkTIFCMAFwHfQ7BAwP28LrJMXQwu5YL4hr5
	oUcfqZh5SXPm+JD+dyL0YHkhODNkJPDnJMSTAp8xTemOAioXkju5Bg3/Zy8BuP6xDxifmAr
	rSt7/6IUrVYfNytDZYFq44GMDxPK872ajqnNa2+YP8fZ/p55icw13fFXlJ9jJ8qd0jZTYy9
	QJ0B57q4FhxH9UhZZeL6kAS1vgadmT5pU/UoL9FMZgwGq5KMKldG/cwTng4KLBQ9MNEk+lB
	GyFq7M9+ul0xfvIPiWAAuPjBvcG5LlgWeWmxW9breeYPAj8/gwBeJLvg3zT/3NlAY0upVBS
	GTl3Jv4sNQ47gC6Lo577OgJ0rfhXP0cTsLZBd2tKLfH
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Sep 23, 2025 at 07:49:34AM -0500, Alex Elder wrote:
> On 9/22/25 9:59 PM, Troy Mitchell wrote:
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
> 
> Note that the pin numbers I'm mentioning above are the numbers
> (1-26) on the 26-pin GPIO header on the BPI-F3 board.
> 
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
> 
> It is an index, and it seems arbitrary but it is based on the
> order in which they occur in a spreadsheet that defines a set
> of possible pin configurations.
> 
> For example, SPI3 lists 2 possible pin combinations:
> SCLK	GPIO[75] function 2	GPIO[59] function 2
> FRM	GPIO[76] function 2	GPIO[60] function 2
> TXD	GPIO[77] function 2	GPIO[61] function 2
> RXD	GPIO[78] function 2	GPIO[62] function 2
> 
> > If it’s an index, should it start from 0 or 1?
> 
> It starts with 0.
> 
> > The starting point seems inconsistent across pwm/spi/uart.
> > If it’s supposed to be the function number,
> > then the spi and pwm parts look incorrect.
> 
> The first one (index 0) shows up earlier (lower line number) in
> the spreadsheet, even though the GPIO numbers used are higher
> than those in the second one.  They're grouped, and the first
> one is in GPIO group 2 and the second is in GPIO group 5.
Thanks! It makes sense.

                - Troy

> 
> 					-Alex
> 
> > Could you clarify this? Yixun.
> > 
> >                  - Troy
> > > 
> > > > +			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
> > > > +				 <K1_PADCONF(77, 2)>,	/* MOSI  */
> > > > +				 <K1_PADCONF(78, 2)>;	/* MISO */
> > > > +
> > > > +			bias-disable;
> > > > +			drive-strength = <19>;
> > > > +			power-source = <3300>;
> > > > +		};
> > > > +
> > > > +		ssp3-0-frm-pins {
> > > > +			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
> > > > +
> > > > +			bias-pull-up = <0>;
> > > > +			drive-strength = <19>;
> > > > +			power-source = <3300>;
> > > > +		};
> > > > +	};
> > > >   };
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > index 6cdcd80a7c83b..eb8a14dd72ea4 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > @@ -797,6 +797,22 @@ uart9: serial@d4017800 {
> > > >   				status = "disabled";
> > > >   			};
> > > > +			spi3: spi@d401c000 {
> > > > +				compatible = "spacemit,k1-spi";
> > > > +				reg = <0x0 0xd401c000 0x0 0x30>;
> > > > +				#address-cells = <1>;
> > > > +				#size-cells = <0>;
> > > > +				clocks = <&syscon_apbc CLK_SSP3>,
> > > > +					 <&syscon_apbc CLK_SSP3_BUS>;
> > > > +				clock-names = "core", "bus";
> > > > +				resets = <&syscon_apbc RESET_SSP3>;
> > > > +				interrupts = <55>;
> > > ..
> > > > +				dmas = <&pdma 20>,
> > > > +				       <&pdma 19>;
> > > can we also squash the dmas into one line? but, do split if there are too many..
> > > 
> > > yes, it's simply a style change that I'd like to keep them consistent at DT level,
> > > besides you might also want to adjust dt-binding examples to align with them here..
> > > 
> > > thanks
> > > 
> > > > +				dma-names = "rx", "tx";
> > > > +				status = "disabled";
> > > > +			};
> > > > +
> > > >   			/* sec_uart1: 0xf0612000, not available from Linux */
> > > >   		};
> > > > -- 
> > > > 2.48.1
> > > > 
> > > > 
> > > 
> > > -- 
> > > Yixun Lan (dlan)
> > > 
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 

