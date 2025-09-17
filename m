Return-Path: <linux-spi+bounces-10067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BCB7E0D9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165BB3B771D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DC2C029B;
	Wed, 17 Sep 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I1mEL4GL"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8531BCB7;
	Wed, 17 Sep 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099759; cv=none; b=fljXRELYl17XnZtDRZDYfkT46PjkfFAgPzLVLyJy/UvZcYA/Z7F+f7FSsecS9Dw01fajjScOVtqhKSFkZ5jYSgGK3oW5eKJTb5q+EWUcvSYFZL1By9RNGI34A+FXmfBbfGZsLvrc2rvZhYtsdJ7LWDTKiMg6iusjnbnu2KE0kvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099759; c=relaxed/simple;
	bh=3I0xAujrqXNySvA/jSJripSl2wkgTi/oVKNIpzfHs9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+Da7OC5i0J8wtyunX0ttloQ/asv8pIMRA4XBk1YU2mhCmwv1eTNZx4ZCsy3px9u2phQKmHIGqsK0j8W3wllxEFyH2M7TCtEXsedne3ZWfjL1OhN/mCL6O1wwX5q/yjIQDxULFCPMwSCGrMygWY/lQeISfbWpvSEYp2z/mEdFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I1mEL4GL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758099748;
	bh=3I0xAujrqXNySvA/jSJripSl2wkgTi/oVKNIpzfHs9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I1mEL4GLjKOLZ+oD5m3q+2PtWZkCh/9PCnI1oZipqtsmQD8jAHOrbVIn1YLWaYvxx
	 rHVLBrGXicm0PZ8z27I/HuQYNXClfsHKunUbNFwih5wKnUJGIFhOO4MwPzNAXziPxL
	 IyY8iaIpTarkTausOqGxDoGDqMv9yEOPQof9L3hoMjKlUFiU9Uu2s94u43VUNT1Y5g
	 N6OzPJ+32KLoy+vMrcjc2iSkTFAOA98Rye8nNXUGdcion8S8BNvC2CZr1OA6Ttet4j
	 lqSxcvB2DHZq39ruAEmANP/YuTZknEnlZiNsWCDCsh0LZO1tNIYq3Hv7/FVFdT8BzA
	 0u6wMHNgvQEDA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 46C1417E0AC3;
	Wed, 17 Sep 2025 11:02:28 +0200 (CEST)
Message-ID: <d1c26107-6365-4681-9f7f-5a8bbb2ba08b@collabora.com>
Date: Wed, 17 Sep 2025 11:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: mt65xx: add dual and quad mode for standard spi
 device
To: Tim Kuo <Tim.Kuo@mediatek.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Steven Liu <Steven.Liu@mediatek.com>, Sky Huang <Skylake.Huang@mediatek.com>
References: <20250917055839.500615-1-Tim.Kuo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917055839.500615-1-Tim.Kuo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 07:58, Tim Kuo ha scritto:
> From: "Tim Kuo" <Tim.Kuo@mediatek.com>
> 
> Mediatek SPI hardware natively supports dual and quad modes, and these
> modes are already enabled for SPI flash devices under spi-mem framework
> in MTK SPI controller spi-mt65xx. However, other SPI devices, such as
> touch panels, are limited to single mode because spi-mt65xx lacks SPI
> mode argument parsing from SPI framework for these SPI devices outside
> spi-mem framework.
> 
> This patch adds dual and quad mode support for these SPI devices by
> introducing a new API, mtk_spi_set_nbits, for SPI mode argument parsing.
> 
> Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



