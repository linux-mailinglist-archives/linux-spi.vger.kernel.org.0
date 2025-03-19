Return-Path: <linux-spi+bounces-7237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A8A69CC1
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 00:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AC016C59D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23321CFF4;
	Wed, 19 Mar 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+4dR1Jk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A52290F;
	Wed, 19 Mar 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427224; cv=none; b=Jmv6KDzqBilWrLWMB0Z7ImMxOqAOnyUe9yztehiJFW+9w4jCTh5cMqVblxYcs6/7wFvG4rj98dZx+T08R4uyntklgsAM6Vy9DW82rNulHk1/0rfDLEw9T1T1RBJRvgexiFW0cDUC+hJeEOg+YC2HILzKvU+BZOASt/fjalH2X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427224; c=relaxed/simple;
	bh=PxRttoTvNB9J1QacekgUAuBtHXKYjOGUJEnneRLw5j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7pDCe5XNEtzDNNOviThzbNINqwIr9mwO/rnVE8pj6zPNCeuUNhhca1bpTYNvWO26EHoCrZf2tNJA6JfPZ+3wwaFC1Galop5KMbEAGdRB2PHVz41PN9sgqM0bDkU5Ax05jRSlgbQsdkcX6LLtxc2dRmAo85+2ZXoAnz8b0/jIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+4dR1Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763A9C4CEE4;
	Wed, 19 Mar 2025 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742427222;
	bh=PxRttoTvNB9J1QacekgUAuBtHXKYjOGUJEnneRLw5j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+4dR1Jk/LM38UAR+qw0mVLqpw7BJkDuD/wtNo677PfT5RxIWEQ5WIiNpDCHSgDHx
	 JersdSUebdsUgIFHYbsXCYTYM9/E/5yDzQ87+tb0IuTxc1baX61f/g+ULRt2XGmbT1
	 Y2iJCdcmt+VFeGYLerouQg0ovXnwcEx10zBZuAY2kZb4MwAspiZpi7htQo3obo/kKd
	 xk7MwRgN2vqMHVi1tiOm2U41DFpADh2Vwn5Y+o8eyBWCnuyz9e8l66yb7cOpHUy5nf
	 o4Ex/hNPcxUiuQX/5DbOaQl1zHsDNNIQknbjzUPWtRnS0hCUn3ICxdRVQsDnakPtAg
	 UZLa4evf8s17w==
Date: Wed, 19 Mar 2025 18:33:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vaishnav Achath <vaishnav.a@ti.com>, linux-spi@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] spi: dt-bindings: cdns,qspi-nor: Require some
 peripheral properties
Message-ID: <174242722090.2636630.12361103968129083480.robh@kernel.org>
References: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
 <20250319094651.1290509-4-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319094651.1290509-4-miquel.raynal@bootlin.com>


On Wed, 19 Mar 2025 10:46:51 +0100, Miquel Raynal wrote:
> There are 5 mandatory peripheral properties. They are described in a
> separate binding but not explicitly required. Make sure they are
> correctly marked required and update the example to reflect this.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


