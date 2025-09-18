Return-Path: <linux-spi+bounces-10125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA6B85635
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097957AE4B8
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161E330CB5D;
	Thu, 18 Sep 2025 14:56:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92830CB4A;
	Thu, 18 Sep 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207412; cv=none; b=TMz58m3mh520Xqm3ptey1qQTtV0nyfnTJXTTYZHPCVqZxZNVIJhMzVbhPzyCD9QvXUwx9mgeoCIvWYku7gAHOtD/5tg060vwjuGfyvSzS0LRvR108QyuYMpQTcCrKruJ6vdfQo7XJR6mSY3qkT+47LcVoDikB8TQSQxcXYwrg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207412; c=relaxed/simple;
	bh=4Rea0CJn+cU52Kg9PUi0QQZVkVEYQqNrOKaPzqZ6jgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzB5wlS10vt3MBHDPccx+eCtWAGooJ+WSoQBae+vUdvts7BZ7z6RcpCkWjr5t+KHeeDr0ucbcR/4YnDjYXw+N2GkP6lHP3AOxcPH7livrCk15KzPXJN/4pVrmdRQX2ud1QCwDiSyOz1lsD/OaKwQ4QJ3Udwj+IQ7HFJF/q/IF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 51221341B26;
	Thu, 18 Sep 2025 14:56:50 +0000 (UTC)
Date: Thu, 18 Sep 2025 22:56:44 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
Message-ID: <20250918145644-GYC1274501@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
 <cedaad98-1eba-431f-af4a-b84e106e5f65@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedaad98-1eba-431f-af4a-b84e106e5f65@riscstar.com>

Hi Alex,

On 09:47 Thu 18 Sep     , Alex Elder wrote:
> On 9/18/25 9:39 AM, Yixun Lan wrote:
> >>>> +	u32 data_reg_addr;		/* DMA address of the data register */
> >>> s/data_reg_addr/ssp_data/? I just feel uncomfortable with redundant 'reg_addr'
> >> My convention is normally "virt" or maybe "base" to represent
> >> a virtual address, and "addr" to represent I/O addresses.
> >>
> >> This symbol represents the physical address that underlies the
> >> "SSP Data Register", which fills the TX FIFO when written and
> >> drains the RX FIFO when read.
> >>
> >> How about "data_addr"?  I know you wouldn't like "reg_addr".
> >>
> > another idea here, instead of introducing a variable here,
> > how about simply using plain iores->start + SSP_DATAR?
> > 
> > so you can cache "iores" instead..
> 
> This code has gone through a huge amount of refactoring.
> 
> I hadn't looked, but now I see this field is used exactly one
> place in the code, in k1_spi_prepare_dma_io().  It's still
> needed though.
> 
> Here's what I plan to do.  Rather than saving data_reg_addr,
> I will simply save base_addr, which is the I/O resource start
> address that corresponds to the mapped virtual pointer, "base".
> 
> Then in k1_spi_prepare_dma_io() I'll use base_addr + SSP_DATAR.
> 
> OK?
> 
Yes, this is what I'm suggesting
-- 
Yixun Lan (dlan)

