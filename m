Return-Path: <linux-spi+bounces-7735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560ABA9A45C
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD4921FC2
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE31F4614;
	Thu, 24 Apr 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAn5IBCa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304679F5;
	Thu, 24 Apr 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480001; cv=none; b=HS7PcaPMXkkTXzHPvPJWBgFe3ifDIGFImUl8fSPv+M27vzp3cIiUd5UuSj8CRgdgdBgfN0snkfwxEpRVa7WODBQiBTjVkImsVIRvLfujd7CTNfVln5Pilh47Koncm6RZAaXYSTgb6gdJ3K6Julag6dZTtqlbdX5ekpDzjphVPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480001; c=relaxed/simple;
	bh=SuP8EraeigJb0KaR9dhLAlA0oVM0b7bWlw5kuLh8108=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL0EB1uwycvqQj4SCtwTYM3BjXwCTZLrSNv9wz+pPw9N2gbo9qKfyeUog3EgTG8CcqZ2cPp2nMtdh3ZJX9LTX6rsboZl3XwmfIywXbd0GxAkfc5cOZh6Xgy8P0oHIsMN1wp2OUDhoINY1b0aIFKH316Q7BN5Nxw1RlAnIQOZ5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAn5IBCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E2EC4CEE3;
	Thu, 24 Apr 2025 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745480000;
	bh=SuP8EraeigJb0KaR9dhLAlA0oVM0b7bWlw5kuLh8108=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAn5IBCa1HR8cgzP/yQgp/EiVv3myBY0mp+DotdwTIpXvXyZ14/MJUwmL6OdMvjUv
	 KI8WGC0P/EY8lc2jDgnXraGmBOZs8wUK39z3R69blFJ54MTgb5/4QLvVHna+buVBNv
	 GrmUcxdw+gpa6jwyC87fekJTv16cFXG5mp2R97yZGECyBfgX5X/slw0jch2C+MomMs
	 wixVvFDPCXIzoGsFaR8gYX/kzKrb9Xb4PDWYfTfKK4lX13WCzgQPvOO3N2QsBISx4h
	 iSOsD7gZKVAFrCoa2x76r1X62CE0B50BtKjwitjKBVFf2P6yFFWLqLN50jK8cF++aW
	 EvDM3Pn7jCG+A==
Date: Thu, 24 Apr 2025 09:33:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, sophgo@lists.linux.dev, 
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, dlan@gentoo.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge
 duplicate compatible entry
Message-ID: <20250424-awesome-caracara-of-priority-57f9dd@kuoka>
References: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
 <20250422-sfg-spi-v5-1-c7f6554a94a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422-sfg-spi-v5-1-c7f6554a94a0@gmail.com>

On Tue, Apr 22, 2025 at 10:27:08AM GMT, Zixian Zeng wrote:
> Microsemi Ocelot/Jaguar2, Renesas RZ/N1 and T-HEAD TH1520
> SoC-specific compatibles, which eventually fallback to the
> generic DW ssi compatible, it's better to combine them in single entry
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml       | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


