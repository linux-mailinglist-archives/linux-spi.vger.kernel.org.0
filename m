Return-Path: <linux-spi+bounces-3674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30191C4D3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D6F281671
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE11CB33A;
	Fri, 28 Jun 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQsModjI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E291CB30E;
	Fri, 28 Jun 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595651; cv=none; b=hvdPSqz2XLyVWuAPMV1Q61f3eyqrcmKUyrRLxhdPCsG4noEN6H8YtHSNGhp31B3F5NHiAuoqDfOas2VxkddWY3SNJE3UiitOlptOPpvxwS2W1at/7J8V/PFqlqwBwJ9Jzm9zcbQuDunBjzGS7ULy0ZD1dXDR9hIZ5QayT+BQia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595651; c=relaxed/simple;
	bh=Q5DskdWADCuQ2xeXPQnSL4j5nBWSAGYYvpt1F3enbDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX1l5ZYbEOWXCgljy/DV/YSXZOmbtyUOdgN1Yg+kHf7tguLLk148T7PE+0U8Doh+XkSRtjOE8QDMtOnhLamTfqVpzMT+5udi+viyEu1WlR9kooN46OBxybY9oqHKaFmP1yGRDVaO/RFPTt5tDWza+akEUItjTRY89Vmstj8AlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQsModjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408EC116B1;
	Fri, 28 Jun 2024 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719595651;
	bh=Q5DskdWADCuQ2xeXPQnSL4j5nBWSAGYYvpt1F3enbDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQsModjIFHVlpVG+lxZSwuoG4O6sB1sx7ZUphM3liFSO7YRnReGcybevuPEnLB4KA
	 4WZmB8uCX81edYg+LchBVedjqwptYjjKx3mIhqCDNIKoSvG/ILoxjTOh3A+8g6Uq/P
	 o5EoFKtWHyArBsE75gUBKYcO8DVJvivXRmtFKh1+Qr2nIRrWk1RSgU2HBNePrNZp8Q
	 +RrNqLeOb+72zAQACH/K+Tc9/dYxOD6oQSHD3DQrVX/mZJPdh8dJcsC3X6CvnwXBAe
	 94j7NI68qe8rHGRTubX2YRacy1qg1CK1Iv4HPUK4gjmGNoqO5Oajn2zsR4q4CASH1u
	 XISEcImp7rEJA==
Date: Fri, 28 Jun 2024 11:27:29 -0600
From: Rob Herring <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Andrew Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
Message-ID: <20240628172729.GD3143032-robh@kernel.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
 <cef08d49-a462-4167-8b9d-bf09e8aac92f@beagleboard.org>
 <70f28343-6738-47f2-97b5-6afa96f1fbcc@ti.com>
 <93cdd5c5-d54c-46c2-9055-5cd9cc79e2da@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93cdd5c5-d54c-46c2-9055-5cd9cc79e2da@beagleboard.org>

On Thu, Jun 27, 2024 at 11:46:31PM +0530, Ayush Singh wrote:
> 
> On 6/27/24 23:20, Andrew Davis wrote:
> > On 6/27/24 12:16 PM, Ayush Singh wrote:
> > > 
> > > On 6/27/24 22:37, Andrew Davis wrote:
> > > > On 6/27/24 11:26 AM, Ayush Singh wrote:
> > > > > DONOTMERGE
> > > > > 
> > > > > Add mikroBUS connector and some mikroBUS boards support for
> > > > > Beagleplay.
> > > > > The mikroBUS boards node should probably be moved to a more
> > > > > appropriate
> > > > > location but I am not quite sure where it should go since it is not
> > > > > dependent on specific arch.
> > > > > 
> > > > > Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> > > > > ---
> > > > >   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 94
> > > > > +++++++++++++++++++++++---
> > > > >   1 file changed, 86 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > > > > b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > > > > index 70de288d728e..3f3cd70345c4 100644
> > > > > --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > > > > +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > > > > @@ -38,6 +38,7 @@ aliases {
> > > > >           serial2 = &main_uart0;
> > > > >           usb0 = &usb0;
> > > > >           usb1 = &usb1;
> > > > > +        mikrobus0 = &mikrobus0;
> > > > >       };
> > > > >         chosen {
> > > > > @@ -227,6 +228,56 @@ simple-audio-card,codec {
> > > > >           };
> > > > >       };
> > > > >   +    mikrobus0: mikrobus-connector {
> > > > > +        compatible = "mikrobus-connector";
> > > > > +        pinctrl-names = "default", "pwm_default", "pwm_gpio",
> > > > > +                "uart_default", "uart_gpio", "i2c_default",
> > > > > +                "i2c_gpio", "spi_default", "spi_gpio";
> > > > > +        pinctrl-0 = <&mikrobus_gpio_pins_default>;
> > > > > +        pinctrl-1 = <&mikrobus_pwm_pins_default>;
> > > > > +        pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
> > > > > +        pinctrl-3 = <&mikrobus_uart_pins_default>;
> > > > > +        pinctrl-4 = <&mikrobus_uart_pins_gpio>;
> > > > > +        pinctrl-5 = <&mikrobus_i2c_pins_default>;
> > > > > +        pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
> > > > > +        pinctrl-7 = <&mikrobus_spi_pins_default>;
> > > > > +        pinctrl-8 = <&mikrobus_spi_pins_gpio>;
> > > > > +
> > > > > +        mikrobus-gpio-names = "pwm", "int", "rx", "tx", "scl", "sda",
> > > > > +                      "mosi", "miso", "sck", "cs", "rst", "an";
> > > > > +        mikrobus-gpios = <&main_gpio1 11 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 24 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 22 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 7 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 14 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 12 GPIO_ACTIVE_HIGH>,
> > > > > +                 <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
> > > > > +
> > > > > +        spi-controller = <&main_spi2>;
> > > > > +        spi-cs = <0>;
> > > > > +        spi-cs-names = "default";
> > > > > +
> > > > > +        board = <&lsm6dsl_click>;
> > > > > +    };
> > > > > +
> > > > > +    mikrobus_boards {
> > > > > +        thermo_click: thermo-click {
> > > > > +            compatible = "maxim,max31855k", "mikrobus-spi";
> > > > 
> > > > I might be missing something, but your solution cannot possibly be
> > > > to list every click board that could be connected (all 1500+ of them)
> > > > to every mikroBUS connector on every device's DT file..
> > > 
> > > 
> > > I think you missed something. `mikrobus-boards` is not a child node
> > > of `mikrobus0`. See the `board` property in `mikrobus0`. That is
> > > what selects the board attached to the connector.
> > > 
> > 
> > That seems even worse.. That means the board file needs to know about the
> > attached board, which is not how DT works. It describes hardware in a
> > hierarchical/acyclic graph. For instance, take an I2C device, its node
> > is a child of the I2C bus, and has phandle pointers to the IRQ it uses
> > (or whatever else provider it needs). What you have here is like the
> > I2C bus node phandle pointing to the connected child devices.
> > 
> > > The `mikcrobus-boards` node itself should be moved to some
> > > independent location and included from a system that wants to
> > > support mikrobus boards. The connector will only have a phandle to
> > > the board (or boards in case a single mikroBUS board has 1 i2c and 1
> > > spi sensor or some combination).
> > > 
> > 
> > How about providing the full/final example then (this series should be
> > marked
> > as RFC as it is now has missing parts). Move the click board node into a
> > DTSO
> > file and put that in a common location (click boards are common to all
> > boards
> > right, so lets say in drivers/of/click for now just for the RFC).
> > 
> > > 
> > > > 
> > > > Each click board should have a single DTSO overlay file to describe the
> > > > click board, one per click board total. And then that overlay should
> > > > apply cleanly to any device that has a mikroBUS interface.
> > > 
> > > 
> > > Yes, that is the goal.
> > > 
> > > 
> > > > 
> > > > Which means you have not completely solved the fundamental problem of
> > > > abstracting the mikroBUS connector in DT. Each of these click
> > > > device child
> > > > nodes has to be under the parent connector node. Which means a phandle
> > > > to the parent node, which is not generically named. For instance
> > > > if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
> > > > the click board's overlay would look like this:
> > > > 
> > > > /dts-v1/;
> > > > /plugin/;
> > > > 
> > > > &mikrobus0 {
> > > >     status = "okay";
> > > > 
> > > >     mikrobus_board {
> > > >         thermo-click {
> > > >             compatible = "maxim,max31855k", "mikrobus-spi";
> > > >             spi-max-frequency = <1000000>;
> > > >             pinctrl-apply = "spi_default";
> > > >         };
> > > >     };
> > > > };
> > > 
> > > 
> > > No, it will look as follows:
> > > 
> > > ```
> > > 
> > > &mikrobus0 {
> > 
> >           ^^^
> > So same issue, what if I want to attach this click board
> > to the second mikrobus connector on my board (i.e. mikrobus1),
> > I'd have to modify the overlay.. Or have an overlay for every
> > possible connector instance number.
> 
> 
> The plan is to have a sysfs `new_device` and `delete_device` entry like I2C
> has where the board name is passed. The driver can then create a dt
> changeset apply to live tree. In the current dt, the changeset is to add a
> `board` property with the phandle of a board (if found).
> 
> Can you suggest how something similar will be possible if the board node is
> a child of the connector node? Maybe it is possible to take a generic dt
> overlay and change the name of parent node on it or something?

You need to describe the problem(s) to solve first, and then a solution.
You're just giving us a solution to review.

Let's start with you have an add-on board and an overlay for that board. 
No one wants N overlays for N base board for a single physical board. 
One board, one overlay. Any solution must provide that.

Who knows when a board is connected and what board it is? Each one 
could be the OS or the user. Worst case is nothing is detected and it is 
just the user knows "I've connected board X to connector A" and has to 
tell the OS that. Or the OS can detect a board and figure out what board 
via EEPROM with no user intervention. In between is OS detects a board, 
but needs the user to say which one. The detecting everything case is 
easy. The connector driver knows which connector it is and which 
overlay. You just need to define how you select the overlay file based 
on EEPROM data. The others will need some sort of interface for 
the user to provide the information.

Rob

