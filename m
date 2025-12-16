Return-Path: <linux-spi+bounces-11974-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409ECC5670
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 23:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 122503031CCE
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476B33F362;
	Tue, 16 Dec 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UtJIEklL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4642E92B3;
	Tue, 16 Dec 2025 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925404; cv=none; b=Pbo/6Hz56fvRvpXOtFos76OTERJAZyRXa9bfZWR4QAbkGln77S6MKjVjQXPcFJoS5PbQD2NEXwXafufWkVLHnt0vW42NwFuYWW68m3eTlvOUc+UpLlc41LyCnV535MfqwQNzmP/lpK9NnU8BtdajkHRvsgd3xCFp2z7m6THQ8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925404; c=relaxed/simple;
	bh=SFPOamL0cQPXqkLhodBhCDXvus3KxGNWMnm+9DocSlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME0J/ODmGrNQS1QoXY+UNv0O+ZC6mrpW8HJIQ2khfAAuJq5Ne6Iro8waYBofp2cpUdgWQP180aM8RnG/oudcDjhLxz0Y2psoM6trjaOxJZVeoG7oFr+7KPu7910mHjYppMtfabeVbWdQfh3Bq3C0EKX8JO/y28bQFEjt0LDFMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UtJIEklL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4EBE11A221C;
	Tue, 16 Dec 2025 22:40:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19F146071C;
	Tue, 16 Dec 2025 22:40:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 331B8102F01D0;
	Tue, 16 Dec 2025 23:40:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765924813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YjySOHXxChpeAIXP7WiviiCVM3iOHIkW8SnbIAyhMbg=;
	b=UtJIEklL707ymXV/8HCjyKT+EobGjo9ZqL/vbQfvhhbRyudL/xWnk2Mv+F8druWzsb494W
	cAmzshRPqJbM87ZkegTVdkAF+kU0MP8ZKGR+jKn2V1G7n2aqLHnh8yafzrJVDXwf/veoBk
	eYMp4u61D4wTi1PjSEGEi5NBxjyfP3SaP+OKlRRy+/+FdG3sDT2neGe0O9iwWwk7hmi0zV
	9ar5gz1PnvOx5hBjGQYpUJWnpW97kiCMulKZZMkCFVa8ZlHmkfOQghjw74oEjWm9wUmZMK
	JfDi9BzBOBDMLQ0ddmoVO4T2fyd6QhWUN2EQUglFcqDbXV7XKtEaiL2/RtkmWg==
Date: Tue, 16 Dec 2025 23:40:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: Conor Dooley <conor@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	linux@roeck-us.net, andi.shyti@kernel.org, lee@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linusw@kernel.org, olivia@selenic.com,
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com, romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com, lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
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
Message-ID: <202512162240006f3ddfdf@mail.local>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-4-robert.marko@sartura.hr>
 <202512161628415e9896d1@mail.local>
 <CA+HBbNFG+xNokn5VY5G6Cgh41NZ=KteRi0D9c0B15xb77mzv8w@mail.gmail.com>
 <202512161726449fe42d71@mail.local>
 <20251216-underarm-trapped-626f16d856f5@spud>
 <CA+HBbNFq=+uWp05YD08EQtaOhrN9FCBAtnOAsOJc4dNfoJRfxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNFq=+uWp05YD08EQtaOhrN9FCBAtnOAsOJc4dNfoJRfxA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 16/12/2025 20:35:49+0100, Robert Marko wrote:
> Hi Conor,
> What do you think about renaming the SparX-5 binding and adding LAN969x to that?
> Cause both are from the current Microchip and from the same UNG
> business unit, with
> probably more generations to follow.
> 
> LAN969x does not really belong in Atmel bindings to me, but I am flexible.
> 

On the contrary, this is the one that is based on the "previously atmel"
BU SoCs. It is a sama7 with a microchip UNG switch while SparX-5 looks
more like a microsemi chip with ARM64 cores instead of mips.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

