Return-Path: <linux-spi+bounces-7236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63202A69CBF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 00:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD188189A7C8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2423218585;
	Wed, 19 Mar 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBsabnTj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88220290F;
	Wed, 19 Mar 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427122; cv=none; b=IGzat/Vey6tG4hO/KGWJ2tAnEiV3vaLwNBTXoteol1sDetJM9K9teBbDXUja+IC5/AO19Q5jm9dM5lheVH37KBceIIkie1wdypZDJbHF+/5ZqOmDPWHfYEEKwUwjuAt4nm2Og6Ngl/YFSw59HSiEj9xB6dSrJjdoR9lmvdbFXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427122; c=relaxed/simple;
	bh=BYK7wiJ3IYPwdWQ9eDYlq5k6sKt6lDU1cGmgoZP2yUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoSASekW5pshfBGkFu/g0tk9f3+bXbuAHaFrXTThIgZT/qBfOAvc7YLKfUSc7DljXQy45hm7XNj0MGqK/+/m2DgMv5inABxTLh9ECTOC5Dun09pyGMraEMpfETWn6S04LfPIKYSv8kxM+Bz2g7jk502KJKi0wo0OxhRv5pTXU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBsabnTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A10C4CEE4;
	Wed, 19 Mar 2025 23:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742427122;
	bh=BYK7wiJ3IYPwdWQ9eDYlq5k6sKt6lDU1cGmgoZP2yUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBsabnTj81gFC7wRg/9WIU4kKuVP7fT1PO9L/OsjlWxxlpqH4d8eLeKOeEwYd5F+q
	 A8GfplZG8AnZjZykwZppd8kpBmfNrzCbxrVNHFEOOauxbVwTctan2CyjEgdfnYvXWU
	 51LDtfz3mJqFUuNIX7gDvcC7xQ8bQbStmUPLgM1PnoKVGmYakyG699q/0JVLbGptMj
	 b6x/HRtDWBrwLfTlGzNVn0xULoPjfclGz2oI8Z+nkGf8LQJBSBbVeAt2Ia5J0yiL8A
	 7D6uEIDy9IrVPc7YV15Lc21OkJ0DPO6VR5OuKLGaO976X3cbcFf22CSG+TDfOl2/sl
	 1+/RZ56NzXR5A==
Date: Wed, 19 Mar 2025 18:32:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>, linux-spi@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the
 Cadence compatible alone
Message-ID: <174242712038.2634185.12472009117874721270.robh@kernel.org>
References: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
 <20250319094651.1290509-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319094651.1290509-3-miquel.raynal@bootlin.com>


On Wed, 19 Mar 2025 10:46:50 +0100, Miquel Raynal wrote:
> The initial SPI controller IP from Cadence has always been implemented
> into controllers from various hardware manufacturers and because of
> that, it has always been (rightfully) doubled with a more specific
> compatible. There are likely no reasons to keep this compatible
> legitimate, alone. Make sure people do not get mislead by officially
> deprecating this compatible.
> 
> While at deprecating, let's update the examples to avoid documenting
> deprecated properties.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> It happens that there is a single in tree DT node named spi@ff705000,
> so use the same second compatible to match a real life example.
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


