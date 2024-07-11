Return-Path: <linux-spi+bounces-3837-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371792F25F
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 00:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1C0B21A7D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0681A0712;
	Thu, 11 Jul 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA7thgnN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24D1A01B3;
	Thu, 11 Jul 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738651; cv=none; b=AGDW18bBBxZUS2vYWzA1YI+mIno7sK5ieYw8nBY03oqQlneLdjGJnHLobDRmyFeuRJcruC7s1OaBpzmhtmJxYDa+9IcKJOWYqeFD9lTuFsJhRVH17FxNMsHWZ1b3T56egvcMZ7voG77n+zVLrzFxolw4RsQm8mk1B9+2cfSIEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738651; c=relaxed/simple;
	bh=BRy0MJSdVOujlhWtcryezKcC/GnZne3D+/47B+3Lo+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiXMX+h2ZiWKtf15RuqR5kIC+z3aGAWIHCX5nx5HTCXcysiNP0+GCucEPrQwMC9Lk2VV4dwmkCZNJfgFyr6PZT/fCf6eh7WrHhvIphNTSnD70MWSs2df5hsgRv6wmC7Dkg0eokvbQ9w9f1OLvZrdba/oRgQn4Pea4dIh68DvmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA7thgnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A78C116B1;
	Thu, 11 Jul 2024 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720738650;
	bh=BRy0MJSdVOujlhWtcryezKcC/GnZne3D+/47B+3Lo+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GA7thgnNsbkEf2K9+nbxIH39bhCYsni85QYGw3IeeNzgwYnEBEkoOesEy0tn3bS00
	 WmBKEvW7Zd9Fv5G8lg+9wSl1gK45+2szV7RiqQ7gPPnX2Qda3jhF2tXW0EqXDYCA10
	 lD7VbO8l471xRcgrJ87u7Se7dCZh2YwyGrNBaH/PTZHoH8BVqbwrAPxybQNncpvGiO
	 /mnTA5CP0x1GxGrYTmOp1FZQLpP/8Jl/r5BHYlmeaurBG3wrTh2FNMg5g6KGPpc5Zv
	 hepSwZ90tQKqDiD4izkh0VSgv/Xly+cJeFBovE1FTp2Ajfeh5Mhk8O9ql9PVZyXWnf
	 g1rSuuSzvCmAA==
Date: Thu, 11 Jul 2024 16:57:29 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: nicolas.ferre@microchip.com
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: at91: Add sama7d65 compatible string
Message-ID: <172073864892.3275467.14128782959779333381.robh@kernel.org>
References: <20240711165402.373634-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711165402.373634-1-nicolas.ferre@microchip.com>


On Thu, 11 Jul 2024 18:54:02 +0200, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add compatible string for sama7d65. Like sam9x60 and sam9x7, it requires
> to bind to "atmel,at91rm9200-spi".
> Group these three under the same enum, sorted alphanumerically, and
> remove previously added item.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml     | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


