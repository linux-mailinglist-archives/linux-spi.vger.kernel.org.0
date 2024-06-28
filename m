Return-Path: <linux-spi+bounces-3673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6891C442
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 19:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC291F21D5E
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8619AA4B;
	Fri, 28 Jun 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME7HKGDy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD21E878;
	Fri, 28 Jun 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594030; cv=none; b=I4YWNbXgbSk4pn3AMIyBFnlexk+WKwISGxccr8JW+rp7Kn93AKHGsYmE7pYq5sWFgtSW9+mM8jHLhQJQYFmZ93fVgwXl/hyiQU/DyAC2r6dnvPBfKlD+2OXIqWdm2vENh0RwL175Bk6M9AXQ0SlWQucD4Kqr8p6tRZ1eBrBzjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594030; c=relaxed/simple;
	bh=MxOYvKjuMI3QpMjNWfn56U4u2xBXujTyJcHf91HZg9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faZsur3odUHpktH6LOLVUsVfosa9YQQus+o4WNEoJjHk6FcuS43c2S0RTc4OjCXI5vra24hQUzxv3uqCaDy0FM5SMEeHG8b30RWTJwpc52VXjtUxm/bUrqSL3uljD3JHYoqwsY69X55p0w6GQqlq7OM79TkreiWxnZ+tIN5l/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME7HKGDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68470C2BD10;
	Fri, 28 Jun 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594029;
	bh=MxOYvKjuMI3QpMjNWfn56U4u2xBXujTyJcHf91HZg9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME7HKGDym/YY+UZq2i3/UIO4lFek7ScUa/1CjEH3iAnx8RuqdysJmZaenOzj7bl4h
	 8jkiG6/Syd7VXRrbtXvM6IqEw5I4Mjjwn4JPuZEb2L09dVbUjvyS4BYPHR1WpvHmYO
	 K1C0mRqOyTjT02LUYyp8FQrq0O6XL3knJV/JjUJN2JWXm2e4f3xN9jPMEDQAeELAif
	 X0mvcAOjBfq7mO9j77DoRunae/18l6XTw/SEAriw3CXp1Vt8IJ1LnkvP5mW2xey64X
	 T3eFGQFCPSyqwCIeCaCdkGmLrALvefWZo22ax2BIbeLPD/bkIpXHa5HA4hDOGdqkrd
	 a7jh91FWxhl7A==
Date: Fri, 28 Jun 2024 11:00:28 -0600
From: Rob Herring <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Message-ID: <20240628170028.GC3143032-robh@kernel.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
 <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>

On Thu, Jun 27, 2024 at 10:59:46PM +0530, Ayush Singh wrote:
> On 6/27/24 22:42, Michael Walle wrote:
> 
> > Hi,
> > 
> > Could you give us a DT snippet of how this should look like with a
> > board?
> > 
> > On Thu Jun 27, 2024 at 6:26 PM CEST, Ayush Singh wrote:
> > > +  board:
> > > +    description: board attached to mikrobus connector
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > Shouldn't this be a subnode of the connector?
> > 
> > i.e.
> > 
> > connector {
> > 	compatible = "mikrobus-connector";
> > 
> > 	// phandles to the parent controllers

These are per bus, so put them in the child bus nodes:

> > 
> > 	spi {

                spi-bus = <&spiN>;
                spi-cs = ...

The base DT would have the spi node and these properties. The overlay 
would still apply to the connector node, but also have the 'spi' node 
along with the devices.

Note that whatever is done here, I expect to work on any connector with 
SPI, I2C, etc. So structuring the bindings for that would be nice. There 
is also this effort which needs the same bindings[1].


> > 		temp-sensor@0 {
> > 			compatible = "maxim,max31855k";
> > 			reg = <0>;
> > 		};
> > 	};
> > 
> > 	i2c {
> > 		..
> > 	};
> > };
> > 
> > I don't think you can introduce a new
> >    compatible = "maxim,max31855k", "mikrobus,spi";
> > if there is already a binding for "maxim,max31855k". But I might be
> > wrong. Why is this compatible needed at all?
> 
> So I did consider the design you just proposed, but I was not able to solve
> a few issues.
> 
> 1. How to deal with say 2 mikrobus connectors in a single system?

I don't understand why that's a problem? It's no different than the same 
overlay working on multiple vendor's boards which I imagine you want 
too. The connector node in the base DT has to remap everything from base 
DT into a mikrobus defined number/name space. For example, host GPIO N 
is mapped to mikrobus connector GPIO 0 and so on.

There is one issue in knowing what the target node is. Standardizing the 
target path or connector node label only works for 1 connector per 
system. You can have an empty target path in the overlay and something 
else can decide the target. This is what's being done for overlays with 
the dynamic PCI nodes. For example, maybe an eeprom tells the driver 
what overlay to apply.

Rob


[1] https://lore.kernel.org/all/20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com/

