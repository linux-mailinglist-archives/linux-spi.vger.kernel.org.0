Return-Path: <linux-spi+bounces-4997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1D987110
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB6528578C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725821AC439;
	Thu, 26 Sep 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HXrrveUW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D11A726A;
	Thu, 26 Sep 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345692; cv=none; b=KjRqEA7k2yXKeHe+JfGfYyWl28jDGZ7F9KR08lP5EYEsGNSgZ165Q5cM5kc3Bm0BGpHbqlwKtmhJw3tf8rq5/RsiQ/p0M/shYyf4GUvfT+WCfur46Dw2Sxw/QNE9y1sskzDHiBv5BA57yRUkMEmu3bD4nuyz61pa1iN615GpouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345692; c=relaxed/simple;
	bh=Mz8/Ket6/rraVDbhe+ybdmv1uxs13o2brm9qVs+a+ac=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l8C0WxNplWSuXPocKu8ZwtUuvlExTcFevI/GTwmMVynsvqjD/UxQqv4+1p6xUWh705gok6g2iOj8bCBIAUPlIj2bdFrHGVuzRLR24GS+803+NVFREQANYtmOIrE3zF6jHWJA9QeiDANRM2zdvu3QLthkotVM/3zoC6XC+MNcOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HXrrveUW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727345688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wS665X+guWUxjV3EiTZ06q5mRi1Mtf5MqZtjy3COO8E=;
	b=HXrrveUW3XFAOFVeKTPflURf5fOTiN16H6NZ0C5PspX8myut3HFRuWc8WczyVqILMWDFXA
	D3n6/11crhP6NZEora/R6801VldyAkpB0dsynkN/ksKTZTt+GoGQF+LaO7CZL7+Cn72jh4
	QEJYQ9tC5mBqxzeHjc/N4f6nggwB258aPbm3wCdRKwEuT4JaRl13sBs9pBijUjjafZ/80C
	OvkRn1V4a+DpHI1Dc8UJ3zLeUgB7NsiSdfvwMmxFDqtv06W2Dc9CpjZzyXBRYftfJPr09k
	+JgIOV0EtRtkKfYtFrZFCV98/rh3W/hA43k9Dxdc1PHq4miMFtNg9f+ihz4U3Q==
Date: Thu, 26 Sep 2024 12:14:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, oss@helene.moe,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: rockchip: Don't check for failed get_fifo_len()
In-Reply-To: <ZvUmk48R4hZYlO71@finisterre.sirena.org.uk>
References: <cover.1727337732.git.dsimic@manjaro.org>
 <ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org>
 <2382990.BjyWNHgNrj@phil> <ZvUmk48R4hZYlO71@finisterre.sirena.org.uk>
Message-ID: <cec7e3f531d936ab34486d52bd16daee@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Mark,

On 2024-09-26 11:17, Mark Brown wrote:
> On Thu, Sep 26, 2024 at 10:55:01AM +0200, Heiko Stuebner wrote:
>> Am Donnerstag, 26. September 2024, 10:38:14 CEST schrieb Dragan Simic:
>> > Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep FIFOs"),
>> > function get_fifo_len() can no longer return zero, so delete the redundant
>> > check for zero in function rockchip_spi_probe().
> 
>> Didn't this topic come up in another recent patch too?
> 
>> Anyway, having looked up the what the current get_fifo_len does,
>> the 0 case should never happen, as you describe, so
> 
> One of the people doing random cleanups posted the same patch which I
> pushed back on since probe() isn't a hot path and it means if
> get_fifo_len() changes again it could silently break things.

Thanks for the clarification, it makes sense to keep the check for
future proofing.  I'll drop this patch in the v2 of this series.

