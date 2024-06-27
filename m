Return-Path: <linux-spi+bounces-3647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DED91AF3A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 20:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EE91C224F6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9509119AA7D;
	Thu, 27 Jun 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Uzowu7IA"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7C19A29A;
	Thu, 27 Jun 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513861; cv=none; b=QwczktehRetLG88n1GvB86Ff2or5+umDx/pBU9brCustXtp8hvdyVod/XdOOML7ZLKjzsEWi9OUJTHe2IQ/wWb6wxQntTniczdFJsEorMttQsUewxRKuB8CLSjolDcqIVSq7b8jMSqGSZaQ9eAjnGhnA34mP07mc90ykw2SVdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513861; c=relaxed/simple;
	bh=prKsNYynAn4EuntaQK+Kbr3lWJAwny9CQumzc8DtOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGLsVnYZfFo87/hgTCC9WnpL9RkpfQUIDkPQJ6sxyjgxPEXtLDclSFIPvL8r9v+9hApn+/r8FFNBUB2w90pdKoeOTtX+RTniGcejtXxzRewMdCZ0KTRi+vKX7qTBgxTQdy1css8X6/BO4lO4RpadiOX6gk/amqnsQ5lYiBFtAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Uzowu7IA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zX2UQ3N1Uf7aQKhs/DniErwInCojUqhpjcn2XavO7UM=; b=Uzowu7IAMepyjlQ9RgsUcoSgEU
	dScZnGJ0eyy3N/s3glMIVqZBdUi+Zqt38LINZ4AdwnF6TJQva6f15G/RUrz1msaRn9rJE6GP3RyaK
	2oaordsiGXkHKEHeWmn5iJELK+dWvyQrm/tCo2/RkMJiXPcUztMAsbdsSsP50+pornW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMu6E-001CRi-9K; Thu, 27 Jun 2024 20:44:02 +0200
Date: Thu, 27 Jun 2024 20:44:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Message-ID: <936ec654-b055-4549-87fb-5a60e2a5ccd2@lunn.ch>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
 <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
 <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org>

> That's then per board, per click board. right?
> 
> >
> > ```
> >
> >
> > The problem with making it children is that each connector will require 
> > seperate overlays for board configs.
> 
> Right.

For somebody who has not used overlays, could you expand on that.

Is it not possible to say "Overlay this DT fragment on point X of the
tree". So you populate children on a node. It should not matter if you
have the same children somewhere else, they have different parents?

     Andrew


