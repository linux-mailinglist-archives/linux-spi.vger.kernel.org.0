Return-Path: <linux-spi+bounces-10120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61FB851DF
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DA73AF06D
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA73195F4;
	Thu, 18 Sep 2025 14:06:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BDD31690F;
	Thu, 18 Sep 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204401; cv=none; b=GCHuokhg+LRiMoJ8NasuYq+omozx/Va4pzWy/JDPJ7ekhdduG7yNqPoPhF3ZoQpOhuNI66QkcVSl764iOxRnoJSbanx8AVT/5Sy54hYe5LamVJXSK04dq1j/DkQSWQR3Ju8/ooBDmEt4Oi4skNB10IVMsLQn/UTRYPIgOveE86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204401; c=relaxed/simple;
	bh=K9t0uPB4LbowQKfZX9ZnuLPTQKFpOIOWFX+SEBhDARE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeSkUztlIegFE3AzKtSuuCc2vE16i4b1BgRjMHlIjzwR6vzBDU2qtdMxZLZzeNOzCRibPuGyTKyWyn+agy5HQ5GSL+ZjQfhhAiEf2Et90h32jaUDPD0sCAN2lOCdD8akwMtBei8VrQ5fH+Yfq9Y745ffeaG2glrhQjVPg++EMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6D66F341F57;
	Thu, 18 Sep 2025 14:06:38 +0000 (UTC)
Date: Thu, 18 Sep 2025 22:06:33 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <20250918140633-GYA1274501@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
 <20250918133209-GYB1273705@gentoo.org>
 <5956e320-7cbb-4d9a-95a7-720cfa6b9654@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5956e320-7cbb-4d9a-95a7-720cfa6b9654@riscstar.com>

Hi Alex,

On 08:51 Thu 18 Sep     , Alex Elder wrote:
> On 9/18/25 8:32 AM, Yixun Lan wrote:
> >> +			spi3: spi@d401c000 {
> >> +				compatible = "spacemit,k1-spi";
> >> +				reg = <0x0 0xd401c000 0x0 0x30>;
> >> +				#address-cells = <1>;
> >> +				#size-cells = <0>;
> >> +				clocks = <&syscon_apbc CLK_SSP3>,
> >> +					 <&syscon_apbc CLK_SSP3_BUS>;
> > ..
> >> +				clock-names = "core",
> >> +					      "bus";
> > can you simply put them together in one line? it's kind of tedious to split..
> 
> Sure I can do that.  I've seen it both ways.
> 
right, it's merely a coding style I want to enforce, to make it slightly consistent

> >> +				resets = <&syscon_apbc RESET_SSP3>;
> >> +				interrupts-extended = <&plic 55>;
> > why use interrupts-extended?
> 
> Because it specifies both the controller and interrupt number
> explicitly.  Why *not* use interrupts-extended?
> 
It's just unnecessary, the SPI node will fall back to find parent node's interrupt
which already specific as &plic, brings no benefits

> >> +				spacemit,k1-ssp-id = <3>;
> >> +				dmas = <&pdma 20>,
> >> +				       <&pdma 19>;

-- 
Yixun Lan (dlan)

