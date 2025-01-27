Return-Path: <linux-spi+bounces-6511-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B6A1DBAF
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2025 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63DF165613
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2025 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9BA18DF64;
	Mon, 27 Jan 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taB8rt8O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE218A6A1;
	Mon, 27 Jan 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000674; cv=none; b=Nb8WcrS0D6SRpbkcdqqbZSEo69Y93n1ZHUC+6XGpGrsYrWpICuowhtb6iW8D60U/JZiXK4BPtqIQY6t1E97DpECG+l32MrMJrjLjxL6RAkEWYxXTIHo5rVhtu2j4/Om3SkLVhaAhPeVgeVhX/D0hVmBYr7BykrLj53hk41k2Idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000674; c=relaxed/simple;
	bh=eRwlImKfy6D/j0+aY/e+F/BQIXecmw3nRjEYPm5CEZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aknis7UfsakWp7MEl/U5+AweHd1N5ft6Nt4h5YrQlNu3JdNG3BcvROYB2i/xCOlVo4I3pG7FsFaiOxIoQqAl6mdkgvanxK+hNRysqvLaYAlzFRcd8M2Vh1RFka0OhoAe0hkQjgU7ZLHX+1KLVuNjudzhCVew56RlGbvFnS16soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taB8rt8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DE6C4CED2;
	Mon, 27 Jan 2025 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000673;
	bh=eRwlImKfy6D/j0+aY/e+F/BQIXecmw3nRjEYPm5CEZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taB8rt8Ov96Pr5tafV52h4gb5vqvmzMkRXJ+WUxoB/5DikFq1O2MDk33898jRyxzZ
	 wYA5bn9D336Pez6mMV/OJthVdR80+y79gz5NBI3F9CryDNlJBOZyLARn2RFZfEVrMy
	 Jfqh0wlUj43NglHquCaOUPfno/Cqe/8/Jcg+EdGmI5aWvWE2jwGhcCEU8t6wT8I7/g
	 syxdPMq5e03TTj4WvxzyZ7K5dkElHPbF43ZXuCHzXVQ6KcnKNoVKcqUtTZuurfH1X2
	 dH7AqG6klq7oWoehDJLfwbOvgLiJ/3Opu+kt4G2J4HbR5R0QAgT6PGZISGA8T9ObLv
	 ph7i0hIeMA6pQ==
Date: Mon, 27 Jan 2025 11:57:52 -0600
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
Message-ID: <20250127175752.GA511180-robh@kernel.org>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-2-sean.anderson@linux.dev>
 <8a0d8789-7a0d-42b7-9aff-e867c14db3c9@amd.com>
 <b8e63009-13fb-493f-adf6-4d30adbe9b1b@linux.dev>
 <20250123224520.GA456390-robh@kernel.org>
 <34e84bd2-381b-4f3e-99e1-92f7a878ed15@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e84bd2-381b-4f3e-99e1-92f7a878ed15@linux.dev>

On Thu, Jan 23, 2025 at 05:57:41PM -0500, Sean Anderson wrote:
> On 1/23/25 17:45, Rob Herring wrote:
> > On Fri, Jan 17, 2025 at 11:12:15AM -0500, Sean Anderson wrote:
> >> On 1/17/25 02:14, Michal Simek wrote:
> >> > 
> >> > 
> >> > On 1/16/25 23:55, Sean Anderson wrote:
> >> >> Add a reset to help recover from cancelled operations.
> >> >>
> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> >> ---
> >> >>
> >> >>   Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
> >> >>   1 file changed, 6 insertions(+)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> >> >> index 04d4d3b4916d..901e15fcce2d 100644
> >> >> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> >> >> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> >> >> @@ -36,12 +36,16 @@ properties:
> >> >>     power-domains:
> >> >>       maxItems: 1
> >> >>   +  resets:
> >> >> +    maxItems: 1
> >> >> +
> >> >>   required:
> >> >>     - compatible
> >> >>     - reg
> >> >>     - interrupts
> >> >>     - clock-names
> >> >>     - clocks
> >> >> +  - resets
> >> > 
> >> > In 2/5 you are calling devm_reset_control_get_optional_exclusive() that's why I expect reset is not really required property.
> >> 
> >> It's optional for the driver for backwards compatibility. But for the
> >> devicetree we make it mandatory since it should be included in all new
> >> devicetrees.
> > 
> > Generally, we discourage new required properties as that's an ABI 
> > change. The exception is really when optional was a mistake. That's 
> > arguably the case here if the h/w always has a reset.
> 
> This device has a reset on ZynqMP and Versal.
> 
> The driver still considers this property optional, so it's not an ABI break.
> But I made it required in the schema to help out the folks at AMD when they
> get around to upstreaming the Versal devicetree :)

Not 'the driver', but 'a driver'. You can't say what *all* drivers do. 
If I write a new driver and read the schema, then I can say 'resets is 
required so I'll make it required in my new driver'. But then my new 
driver doesn't work with an older DT that didn't have resets which was 
valid at the time.

Rob

