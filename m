Return-Path: <linux-spi+bounces-3648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA591AF57
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899B52856A3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E2199EA9;
	Thu, 27 Jun 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pRmI6T64"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED91BF40;
	Thu, 27 Jun 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514449; cv=none; b=AwVHmMmaoMlNP81Z3f4CW+IokU+9DdxPvhabpEeEdjaSQTkxNg1odWWJAlt7Jf2DLzKm9Ey/RB+G1ByuHLyaURJyAMZa/de4a1S6U/RNnxqIBmzUfDDnCfTe9+zs3+F+35xyseAztyuOHgEF5CwsoA7ZoHSXd7fouJQPybumlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514449; c=relaxed/simple;
	bh=qqJuWDqgU1d2pzn5L3V2x4FZCNkPm8iX43xFx3zpmkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sova/1YK3kAHcZWNaHgBYCFch++a8lCjoutGZqDrcYNjAvKIA53nRpZkrVXOYogyliwFmwjIEq/y2EGsVPgW8JPS8N2hE4b6nVDm+61Mi/wTZVgrSchZfPZegPmaIh5nECuwN37d9XvmdHPeqZwxSCEK9gllx8csHcTEpgM6TC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pRmI6T64; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pKvqSGLfcwX/x9spD289lXQYDSmIZJJ94YFu8au6w54=; b=pRmI6T64rhmuSiqJu5QmZBCp2Z
	enKLABPtVqOOri45SLyrekDLX6eJdbd8C/pd2dgY1JhTxaw/yc+BP6HwEqVvM7cvUdBucK3Q8Cqqt
	I+mQg59XkPLlfVe+cZ9a9Q52QvBZ6PSwIKHF9A1efwhpIntlkF/Jw8+rQ4XIgUAClBz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMuFq-001CUa-Tk; Thu, 27 Jun 2024 20:53:58 +0200
Date: Thu, 27 Jun 2024 20:53:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Andrew Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>,
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
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
Message-ID: <9c5263b4-fcda-4678-95ce-c2611af82bc2@lunn.ch>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93cdd5c5-d54c-46c2-9055-5cd9cc79e2da@beagleboard.org>

> Can you suggest how something similar will be possible if the board node is
> a child of the connector node? Maybe it is possible to take a generic dt
> overlay and change the name of parent node on it or something?

Maybe that answers my question on an earlier patch.

So the parent node of the overlay is embedded inside the overlay?

Making a guess without looking at the code... The code loading an
overlay must first parse the overlay and find that node name. It then
must somehow traverses the graph, and find that node. It then must
apply the overlay at that point.

Could you not take this code apart, so you can pass it the name of the
node you want to apply the overlay to, rather than read it from the
overlay itself? The connector should known its own node in the
graph. So it can find the overlay, load it, and then ask for it to be
applied over itself.

	Andrew

