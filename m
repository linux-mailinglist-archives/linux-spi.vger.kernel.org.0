Return-Path: <linux-spi+bounces-10532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E760BBCE52A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC0164EF6B0
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18E30146F;
	Fri, 10 Oct 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAbBoqOL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C442EFD91;
	Fri, 10 Oct 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122782; cv=none; b=rlkYO2bvG7WeYaIqKQ6tOouONoJ+SG71hEzKMvcawFrGheDzVHe7sK/Dc3QWOGwE3J1sdWCraWDpjXzAjtgbLgj96yIUdDRuj97KcBGJgU7XLPV5pd/UDWnKGipoCRliOa9Svt3yynF1eU6qtFzo6H7rcbnFj1xCX0oVp6xDGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122782; c=relaxed/simple;
	bh=sYk5aMSZbgzMbwPbuCiskyPX36SDyxnlnzL93Z3Hx8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsqoKzVYBxdXj88+4VypqvyfutTFUuVEc4VEMF9pqDdqPsfxFMsnnFrluF1O15ARyWniRUJdCvbspkVu2c7yDYvnoNpaWlNA79FuRRvfW8AutPZYU4/WZPsCfCrzLspqVOC5DrZheNC/OHiy7/0MI/5UjJ7MJXFIqJp4oGhf/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAbBoqOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4770C4CEF1;
	Fri, 10 Oct 2025 18:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760122782;
	bh=sYk5aMSZbgzMbwPbuCiskyPX36SDyxnlnzL93Z3Hx8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAbBoqOLzWF5nIYGCF3jaULfN5Z8H0pbTLCv/IjTM6Gd299B8zQJpW7CXm5El1rXj
	 iuJfOS+1Cg6jIH6iHKnZmTeCbs2GSzx2yCtpp0gdXr6j1HMku/mDAarkQWmDow2Hsh
	 VKVV/HgenrEHtChtQrtuaTsSl7d5HJhCKWS2b8ptAdBFrf7mkgLeRvuPfEg5gpQ5EZ
	 8HkBjSHV16j42dmgpdXvLgKVi/5O71eSJApuuY3jbzm00UhyFEuX7lWTZILJYm0aTV
	 /nddl0q8EVqvLysUt0crqykn5+yg9kykhhYYhhL54kE3rwJa15drT+Fqk12R1rWV7J
	 tmfbN4l/HCLaw==
Date: Fri, 10 Oct 2025 13:59:40 -0500
From: Rob Herring <robh@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Conor Dooley <conor@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v7 16/17] dt-bindings: spi: airoha: add compatible for
 EN7523
Message-ID: <20251010185940.GA715991-robh@kernel.org>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
 <20251010033136.1475673-17-mikhail.kshevetskiy@iopsys.eu>
 <20251010-landscape-cavity-88a963e45a6b@spud>
 <f709fe24-ca89-498a-a06d-677b703aecba@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f709fe24-ca89-498a-a06d-677b703aecba@iopsys.eu>

On Fri, Oct 10, 2025 at 05:57:35PM +0300, Mikhail Kshevetskiy wrote:
> On 10.10.2025 17:24, Conor Dooley wrote:
> > On Fri, Oct 10, 2025 at 06:31:35AM +0300, Mikhail Kshevetskiy wrote:
> >> Add dt-bindings documentation of SPI NAND controller
> >> for Airoha EN7523 SoC platform.
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > Please explain in the commit message why these two devices are not
> > compatible.
> 
> 
> They are compatible (at least from the point of this driver), but
>  * en7523 is an old chip destined for 32-bit OS (ARCH=arm)
>  * en7581 is a much newer chip destined for 64-bit OS (ARCH=arm64)
> so using of 'en7581-snand' may leads to peoples confusion.

If they are confused, then that is their problem. That is how compatible 
works.

Rob

