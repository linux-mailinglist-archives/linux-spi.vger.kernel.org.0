Return-Path: <linux-spi+bounces-11973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09CCC5614
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 23:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E774D3030DAF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2633F8B1;
	Tue, 16 Dec 2025 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gEz+VZQ6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A832E15B;
	Tue, 16 Dec 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765924863; cv=none; b=rI1trSDfC+NvOfRusw16V50Jqnb75g12Elz1dtEWq2j3Aeoy4rnRmT3EwRoHKDF2X3t6asixsKcGr762aGWGlPIGfqVOBg24CQ047FBpNYfvUij8YynBJFpZ/H8z+N1iJGisVzUd+PnT/emgBvfpbfR6tKTO7HsGpsfaDq05mpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765924863; c=relaxed/simple;
	bh=F4nBlBidqUY4wHY3UGyVfOGJUkba0Ns3cRLyrEueVek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs0qznhrVTuogcAOaNG3gaJ2MIf2cvfS/XR46kEiQoJqDxNTIr+hwhXIlzsC1CjlZNaQEWfDzU6I35FhdTZUwem04t5MV5KrvPYt5vf2JQTvyHWHnS9HSkKG7Wl9yCdyNch8n2Jrhb5Yo9e0tRg5Td7CS8O+7k161WUr/9uSYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gEz+VZQ6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 60DA54E41C41;
	Tue, 16 Dec 2025 22:40:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 209CB6071C;
	Tue, 16 Dec 2025 22:40:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02EF2102F01D0;
	Tue, 16 Dec 2025 23:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765924853; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p40JSqlhbKdTItQZ+N/qAEwTU4k0uQat5nJYxSbGhm4=;
	b=gEz+VZQ6ruzh1HRxC6RBi7LjHCvppYTRhjSCI+zapFY1BzdKjLykGIsoA+5dBrQxDW8p3m
	OO1KwL8BA9dUrfh/AdzYfd9Y0GtQTaE7Qx9epEG776yjviUNFaOmfXz0auLuvfgyGfZBs4
	jg8UrJJR7F8+UxRR9S+lpyS5W0Lo9j+3mteypwPXsIov4vyid4eYLE1VneqbZCqE4y9mir
	O9MX7eg1GKbkCaKcv88nJ1IEgNOswmDwo9Eb6quJhGj+1ooWoNYiiC50Dnga3zaMrim7JD
	qqxuFChNMU86OjnuZ0tHCLLnG2SD3rpM14oOugDkAu14dGdUJzv2QVmksSuuqg==
Date: Tue, 16 Dec 2025 23:40:46 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, vkoul@kernel.org, linux@roeck-us.net,
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linusw@kernel.org, olivia@selenic.com, radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	richardcochran@gmail.com, wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com, kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org, mwalle@kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH v2 04/19] dt-bindings: arm: move AT91 to generic
 Microchip binding
Message-ID: <2025121622404642e6f789@mail.local>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-4-robert.marko@sartura.hr>
 <202512161628415e9896d1@mail.local>
 <CA+HBbNFG+xNokn5VY5G6Cgh41NZ=KteRi0D9c0B15xb77mzv8w@mail.gmail.com>
 <202512161726449fe42d71@mail.local>
 <20251216-underarm-trapped-626f16d856f5@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216-underarm-trapped-626f16d856f5@spud>
X-Last-TLS-Session-Version: TLSv1.3

On 16/12/2025 19:21:27+0000, Conor Dooley wrote:
> On Tue, Dec 16, 2025 at 06:26:44PM +0100, Alexandre Belloni wrote:
> > On 16/12/2025 17:56:20+0100, Robert Marko wrote:
> > > On Tue, Dec 16, 2025 at 5:29 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > On 15/12/2025 17:35:21+0100, Robert Marko wrote:
> > > > > Create a new binding file named microchip.yaml, to which all Microchip
> > > > > based devices will be moved to.
> > > > >
> > > > > Start by moving AT91, next will be SparX-5.
> > > >
> > > > Both lines of SoCs are designed by different business units and are
> > > > wildly different and while both business units are currently owned by
> > > > the same company, there are no guarantees this will stay this way so I
> > > > would simply avoid merging both.
> > > 
> > > Hi Alexandre,
> > > 
> > > The merge was requested by Conor instead of adding a new binding for LAN969x [1]
> > > 
> > > [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251203122313.1287950-2-robert.marko@sartura.hr/
> > > 
> > 
> > I would still keep them separate, SparX-5 is closer to what is
> > devicetree/bindings/mips/mscc.txt than to any atmel descended SoCs.
> 
> If you don't want the sparx-5 stuff in with the atmel bits, that's fine,
> but I stand over my comments about this lan969x stuff not getting a file
> of its own.
> Probably that means putting it in the atmel file, alongside the lan966x
> boards that are in there at the moment.

I'm fine with this.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

