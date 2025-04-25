Return-Path: <linux-spi+bounces-7761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A774A9D0AD
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C83176E97
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91D21767A;
	Fri, 25 Apr 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkdYx3Op"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B269192D87;
	Fri, 25 Apr 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606722; cv=none; b=f/OyMHsw/qYEBY6fJDWtanX8E+Hlv876qu2v+p0tgM9AxxOD+u4ihJbLTAOcVuLC5jHJwbEJ5dvbkazka9+4kMdFiBXnuCMjl5i4IQjrUtMf3LyMM9mFbFUIzMclnS/A+mtoEzgAJW68miSAYKTVgFcdkT7M2CkxfSplqPGoxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606722; c=relaxed/simple;
	bh=9Np55gyRaNzYiMR1dClIa2knfogC4NSAlr88zKx5tzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYy3sSZ3KiJP4W9hwZQoF+BkJpmVsane/EUtnv68lVFC57zVqPy3KYyfe1jprUc32KRF7DYciAX7IFgyn6uSP2EegkkJ2+ylqBBLQ5ejBYmAA1zOB+TIVhtZ3JCBl6WtoF1Llr89H2yi//S04EjBpXMhlZTz9DP/0oF4/CfpVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkdYx3Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B2EC4CEE9;
	Fri, 25 Apr 2025 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745606721;
	bh=9Np55gyRaNzYiMR1dClIa2knfogC4NSAlr88zKx5tzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkdYx3OpgizUSDTrAFbRe2/HBJ1opXhBLCZrlCKWZc1TAivTj2qsJUn0xIOjnPXNs
	 m6JvPq5PvxvMPClt4acLlbtsFvXIU5SMVxZD3InBk1xom9pMY6DafG89+A0W333BOQ
	 Dqg8Z3OHr91kEJdkjQMstVaHF70k3H6Nrafbfl0eX8w5eJSlROAwIyU6D2gcuZPWy4
	 qLXCqQ2wBBBV+Eg5/tRz0glOQuaa6Sny2CiBPRm9ybvSXr3sBtQksYfUELZP/yzjfs
	 wxBswDuC8QvYn30zQf1FSEzfDpOAQi6VtC+hDjYPaxxxs4hcjCaX9E0FAaEiwfNspn
	 wFBBDgFOVOY4Q==
Date: Fri, 25 Apr 2025 13:45:19 -0500
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S
 Sound support
Message-ID: <20250425184519.GA2678830-robh@kernel.org>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
 <87zfge2x0u.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfge2x0u.wl-kuninori.morimoto.gx@renesas.com>

On Thu, Apr 17, 2025 at 11:22:58PM +0000, Kuninori Morimoto wrote:
> Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> uses Of-Graph in DT.
> 
> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.

That's some odd spacing...

> 
> Adds schema for MSIOF-I2S (= Sound).
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/spi/renesas,sh-msiof.yaml        | 43 ++++++++++++-------
>  1 file changed, 27 insertions(+), 16 deletions(-)

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

