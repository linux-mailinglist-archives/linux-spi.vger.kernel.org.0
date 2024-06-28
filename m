Return-Path: <linux-spi+bounces-3664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4B91BFF9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CFA1C21598
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555D1BE250;
	Fri, 28 Jun 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g0dOOupc"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2E15D5A1;
	Fri, 28 Jun 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582773; cv=none; b=egafKc/11zY4uPxC1SB2M5aM6PdRJWuKFfNyybaZ/t+FMC8cQpIJulOsejfSe6mk4ja5hN++XVPLSgcPh3dxXCRN3IZ8BVLjlchZksbh8OK4eY8HULP6814o7I1xMChTFy08fUqE7cRD6rTt97R+I/CD7hmjq/dpYKvE2yKH1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582773; c=relaxed/simple;
	bh=U1TAumktn6Sm4R3ZOj65CqP7axdosB/bF8DF4p0HZNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeBzv8zTeB7pP0nAO1tzR0jTqUooIl/0NyDcvpEZgASiAwijJpdEq2KM7K3Q+rdeuPbvUPgeLthZje7GoBRkY47k9hQK8mFG19vn7w2c7D5Eih7nokjvkjxD6TjiWeaJAQSuBwjH76cyPoatGDCVG7iYYTJgJGqfxEYDxcTAZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g0dOOupc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WHiUc3wKGhPy/FKSmZsZ6rm8aSzCPZ4IGMmq7c4bAes=; b=g0
	dOOupcZ55sAyN6G38x64E/X2Z8qIMZ2bH6OYpgM/Ya94338pkjUOwkXxKbFURbqfs6PFAQlPOg8Oq
	92YM3qqT72yS0tgUk77y6MykBOJn7W2poFEF+ZLBdPjxPamqZ62X92/Lgo9vNr1lsBx5VKSc5T/nH
	YM4eN+MVhTvqgNo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNC1o-001HoU-Vt; Fri, 28 Jun 2024 15:52:40 +0200
Date: Fri, 28 Jun 2024 15:52:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ayush Singh <ayushdevel1325@gmail.com>
Subject: Re: [PATCH v5 0/7] misc: Add mikroBUS driver
Message-ID: <54c18009-40c6-4c92-852e-6b7117e706a2@lunn.ch>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <1edcfd98-e73c-477e-a4ce-98cb41e66ab6@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1edcfd98-e73c-477e-a4ce-98cb41e66ab6@beagleboard.org>

> 3. Allowing creation of sysfs entries `new_device` and `delete_device`
> similar to what already exists for I2C, etc.

On the I2C bus, these operate at the device level, you instantiate a
new I2C device.  I assume here you are actually talking about board
level operations? So they would be 'new_board', and 'delete_board'
files in sysfs?

> 
> 4. Allow using 1-wire-eeprom in a fashion that allows automatic board
> discovery.
> 
> 
> Let me now introduce the 2 architectures we will be discussing:
> 
> 1. mikrobus-connector has phandle to mikrobus-board:
> 
> ```
> 
> \ {
> 
>     connector1 {
> 
>         board = <&board1>;
> 
>     };
> 
> 
>     mikrobus_boards {
> 
>         board1 {
> 
>             ...
> 
>         };
> 
>     };
> 
> };
> 
> ```
> 
> 
> 2. mikrobus board is a child node of mikrobus-connector:
> 
> ```
> 
> \ {
> 
>     connector1 {
> 
>         ...
> 
>         spi {

So there would actually be multiple child nodes, one per bus, and then
maybe a simple-bus for nodes which do not correspond to a bus,
e.g. gpio-key, gpio-leds, etc.,

> 
>             board1 {
> 
>                 ...
> 
>             };
> 
>         };
> 
>     };
> 
> };
> 
> ```
> 
> 
> I will now go over how each of these goals might look like in both of the
> architecture.
> 
> 1. Keeping the device tree properties upstream in a system independent way:
> 
> a. mikrobus-connector has phandle to mikrobus-board
> 
> It is possible to create an overlay as follows which will work with any
> system that defines the `mikrobus_boards` node. This node is completely
> independent of mikroBUS connector and thus does not need to be rewritten (or
> generated) for each board. There are no problems for system with more than 1
> mikrobus connector.
> 
> ```
> 
> &mikrobus_boards {
> 
>     board2 {
> 
>         ...
> 
>     };
> 
> 
>     board3 {
> 
>         ...
> 
>     };
> 
> };

So by default, you have an empty mikrobus_boards node? You then use DT
overlay to load the needed board into this node, and then update the
phandle in the connection node to point to the newly loaded node?

> b. mikrobus board is a child node of mikrobus-connector:
> 
> Not sure how to do something similar here. The overlay needs to be rewritten
> (or generated) for each board.

It would be good to explain why...

> Systems with multiple mikrobus connectors
> will need multiple overlays adding the boards as child node of each
> connector (with status = "disabled").

Why? Just load the one overlay actually required.

> &connector1 {
> 
>     spi = {
> 
>         board 2 {
> 
>             ...
> 
>         };
> 
>         board 3 {
> 
>             ...
> 
>         };
> 
>     };
> 
> };

I don't actually understand this description. I was expecting more
like:

connector1: {

	spi =  {
	    /* Optional TI TSC2046 touchscreen controller */
            opt_touch: touchscreen@0 {
                    compatible = "ti,tsc2046";
                    spi-max-frequency = <2500000>;
                    reg = <0>;
                    pinctrl-0 = <&pmx_gpio_13>;
                    pinctrl-names = "default";
                    interrupts-extended = <&gpio0 13 IRQ_TYPE_EDGE_FALLING>;
            };
	};

	i2c = {
	        opt_audio: audio@1a {
                compatible = "ti,tlv320aic23";
                reg = <0x1a>;
        };

	the_rest = {
        	gpio_keys {
                    compatible = "gpio-keys";
                    #address-cells = <1>;
                    #size-cells = <0>;
                    pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
                    pinctrl-names = "default";
    
                    copy {
                            label = "USB Copy";
                            linux,code = <KEY_COPY>;
                            gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
                    };
                    reset {
                            label = "Reset";
                            linux,code = <KEY_RESTART>;
                            gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
                    };
            };

This is completely made up. You probably should use an example of a
real complex board using multiple busses.

So for each actual bus on Mikrobus, you have a bus node, and then a
node for everything which is not bus orientated, like gpio-keys.

So the overlay would simply populate these child nodes.

> Maybe it is possible to have special behavior for mikrobus-connector nodes
> in dt overlay but that will break compatibility with exisiting
> infrastructure which isn't great.

You have not explain what special behaviour is actually needed.

	Andrew

