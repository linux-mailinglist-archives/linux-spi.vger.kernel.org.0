Return-Path: <linux-spi+bounces-6443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D4A1ACCD
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2025 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9BA188B9E0
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2025 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B211CAA8C;
	Thu, 23 Jan 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phb1REmo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBA1487ED;
	Thu, 23 Jan 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672322; cv=none; b=MdGIPD2pK9K/nXrCGkvvJ+Aj8HSJaNjpXNcgLzRW8UM82oqT/VDP9DjyiZbYhKW35L5uRD6yVPeAT9O65bjIunGLgyYPfLiaVhzkSzJ/ELPUAOYSawD226quT+DyJLcGP3QqXoqTBW/tpw3mIjhedWu/HcI2Q/A2kowgyRb7ItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672322; c=relaxed/simple;
	bh=T6bckikkRvSw53DcAsE/gahId3+JXQyypP+wi/p2b1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHjc4Qag8YZipa2ateOLc1N0V+ZMP3ZAH9bLRM7oJdPZofPeiu04jifFKt1pwWwMrInptBKfUktm8k+LKOtLf/Aw7FexgoBEYv8ip7eAG5nOej+YKZRtjK/rp3+Y6pu18/UPXV/MSjlHEG35kIVXUJnfVGAFzMWaWgPxD6ZP+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phb1REmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3942BC4CEE1;
	Thu, 23 Jan 2025 22:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737672321;
	bh=T6bckikkRvSw53DcAsE/gahId3+JXQyypP+wi/p2b1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Phb1REmoA5InyOxlBQ/tjC2/R/ZDD2uNX/kCH3UUhPCRtLDqekgmsZez7nLjkEU7N
	 YD+0GzJHDbAte0nJSs67wrD5Oa9vsNN9hItDNzQ6kmwkV/5sg9rZuxNwYuZ6r3HYYp
	 ZzVF8u0Lja9kLnrD+77XFu2CW21mRMl9ynQYfGhmyG1FyrARiZ35VsDNokQmzsV4Kb
	 XrdLZ8kvoLaNqzm1qfRmagQ8MvB7uLJr92ZTF4UiL8gWzqkfWASKuhl8DdwgOIqwqt
	 HhaL2U5q3gHD117qsgvX+IRipFa224iLHH4ZPsqMiECIU1bwoSsniBd7pn2bj2PKvk
	 1sGwviA70fi4A==
Date: Thu, 23 Jan 2025 16:45:20 -0600
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: spi: zynqmp-qspi: Add reset
Message-ID: <20250123224520.GA456390-robh@kernel.org>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-2-sean.anderson@linux.dev>
 <8a0d8789-7a0d-42b7-9aff-e867c14db3c9@amd.com>
 <b8e63009-13fb-493f-adf6-4d30adbe9b1b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e63009-13fb-493f-adf6-4d30adbe9b1b@linux.dev>

On Fri, Jan 17, 2025 at 11:12:15AM -0500, Sean Anderson wrote:
> On 1/17/25 02:14, Michal Simek wrote:
> > 
> > 
> > On 1/16/25 23:55, Sean Anderson wrote:
> >> Add a reset to help recover from cancelled operations.
> >>
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >>
> >>   Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> >> index 04d4d3b4916d..901e15fcce2d 100644
> >> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> >> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> >> @@ -36,12 +36,16 @@ properties:
> >>     power-domains:
> >>       maxItems: 1
> >>   +  resets:
> >> +    maxItems: 1
> >> +
> >>   required:
> >>     - compatible
> >>     - reg
> >>     - interrupts
> >>     - clock-names
> >>     - clocks
> >> +  - resets
> > 
> > In 2/5 you are calling devm_reset_control_get_optional_exclusive() that's why I expect reset is not really required property.
> 
> It's optional for the driver for backwards compatibility. But for the
> devicetree we make it mandatory since it should be included in all new
> devicetrees.

Generally, we discourage new required properties as that's an ABI 
change. The exception is really when optional was a mistake. That's 
arguably the case here if the h/w always has a reset.

Unfortunately, there's not a way to distinguish 'required' from 
'required for new users'.

Rob

