Return-Path: <linux-spi+bounces-5995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9F9EB6F2
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 17:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9795C1889ABE
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE42234985;
	Tue, 10 Dec 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY1bMSAM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E623DE93;
	Tue, 10 Dec 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849200; cv=none; b=uDc1eg+rMVNGy2N7pn4TgwlxOdMXmGOfBdjcrh8REjEw2YakdBPcYE/7Q8E+7NbJgD9ne1UU7ErC7tSCxvgTAue9x1qyTTKY30qANluD8IlwRefkbdHXqFUvojc1yZDM3AU3zik6IEsQhpJqnvu9zbO//Tp8zsEw4YgybT8oL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849200; c=relaxed/simple;
	bh=xgERl4/Z/66jiwMWRjWIFEY1SmEy62AiuwqklbX6Mh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsN37qA8jfBeDJiTtwYr1lZbw8KtEjajw9dVM5FMt8YklAOYEewS5MBUOltAZf46WufhL2+WyrC2zsdp1pnTZGMz7IpHQq+vnNgwpeH3JfztFdYBX6dDdQXSewvq+Jm2YmeC6bDOrLkpqR+h4p5dFz0oKl1k1BXavRTsXgUHXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY1bMSAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED50C4CED6;
	Tue, 10 Dec 2024 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733849200;
	bh=xgERl4/Z/66jiwMWRjWIFEY1SmEy62AiuwqklbX6Mh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jY1bMSAMUj5wxQYYb0Yj0ZX+3F46nKMK2ZGNKWWZVadFmPgEGv44gw0mKheU91h/0
	 RDIJUe2w4VwuV/uAQcleLsaWnIQr0R9CLsX9L2A2T9YD1/YGpHEFxs2drB/oKkTXth
	 DZ2QWNZdhhE/K3aeNbkRVJICsY8UG+j2kc6ZPZCQ15Yku23bAPJTexPwYE/PSpgt1v
	 J2vaQG1wTnUypGJkZjkT4PdETR5g/5mP6nRwXaJxJuQ06vrXvIPvK01A8iPQN0V+7D
	 q/gVdUDjoJIXzQRZ9j90ZNdnkQIyPUvPiXSmO2TuywSd41Cwjh+PSk8sMqk6WH8APT
	 bgRJp5mM8+73A==
Date: Tue, 10 Dec 2024 10:46:38 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
	dharma.b@microchip.com, mihai.sain@microchip.com,
	romain.sioen@microchip.com, varshini.rajendran@microchip.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible
 string
Message-ID: <20241210164638.GA3770349-robh@kernel.org>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>

On Fri, Dec 06, 2024 at 12:59:52PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
> since the SAMA7D65 PMC shares the same properties and clock requirements
> as the SAMA7G5.
> 
> Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
> the clocks property for sama7d65 SoC.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Missing Conor's ack.

