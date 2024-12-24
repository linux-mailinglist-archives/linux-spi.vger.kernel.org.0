Return-Path: <linux-spi+bounces-6155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E69FBB54
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D018844F3
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E3EC0;
	Tue, 24 Dec 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hU6IkXoa"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E445191F7E
	for <linux-spi@vger.kernel.org>; Tue, 24 Dec 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033086; cv=none; b=I10uZ38wZX8HeJ7cYlaucVOqdN/HeCEjJY/rCgOoC49WAe03Uc4a7YFy4zaIquxzh+8939xN5YU7BfuO53Rgf8uPNkgVtrQAjktLxjVnOQYPpWLoZMcNHAQyxYRIBjfYUNgaWvDgQVHijn5/VvfrSlYZLRiPVomPKqTcR1QvHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033086; c=relaxed/simple;
	bh=gBPPOxtHffFdeWaNXscLfKp/7O7VkfykoygWXPPAjsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmvlkWdpGy/57blDijecw4JQbboGtBVG5quUZikHwKa6j5XHWVN3IRipcr1adYYHP3niyPbVKLljs/UHcNDub2kApGd/1HxCDDT4GKrYU8ksVwuso2QCKT+NvVExnGXuW0w07+yxpzvmF9abjDxhNQlPve11qLyabPNB7Hnpj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hU6IkXoa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82280C0007;
	Tue, 24 Dec 2024 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735033082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBPPOxtHffFdeWaNXscLfKp/7O7VkfykoygWXPPAjsg=;
	b=hU6IkXoaqfaaCeRa5aRTsich4mHwfabEBJ7s0XQFIKyaaLODFmp9F8pGEfdVOijjhHsSNF
	HBuPIaKEgcumcS23+bZ+pq3O0ETBZIRn0lSB8GrnzIn7d1S9mFmS3zPrxggFW4QfkDQXJ+
	nlK5Zn+IWyst59ZwvqtSCB7CwsxBFbe39NpLbDp5L//EfDUunAAuPayw3Z9EPk3CBR+lOQ
	wXRrYB36+++R/OQgKMzkVdVosOhlKq2WuWfz5iUHuqckvvH1lUZqoApbJCEscqhJR2OXok
	lBwBhbcWPeMxlOOQDkm+ZYX4ReJW54KtdCpjxSMGGVEt1akUVXIxQxRwGH8sLg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Mark Brown
 <broonie@kernel.org>,  linux-spi@vger.kernel.org,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 24/24] mtd: spinand: winbond: Add support for DTR
 operations
In-Reply-To: <87o712uunf.fsf@bootlin.com> (Miquel Raynal's message of "Mon, 23
	Dec 2024 19:22:12 +0100")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-25-miquel.raynal@bootlin.com>
	<6029a01f-dc4d-4a35-ad21-fd17e3fed9fc@linaro.org>
	<87o712uunf.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 24 Dec 2024 10:38:00 +0100
Message-ID: <87ttato1zb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Tudor,

On 23/12/2024 at 19:22:12 +01, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Hello Tudor,
>
> On 11/11/2024 at 14:40:59 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> w=
rote:
>
>> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>>> W25N01JW and W25N02JW support many DTR read modes in single, dual and
>>> quad configurations.
>>>=20
>>> DTR modes however cannot be used at 166MHz, as the bus frequency in
>>> this case must be lowered to 80MHz.
>>
>> ha, what's the benefit then? Aren't we better of with non dtr modes
>> then? 80 MHz * 2 < 166 MHz?
>
> This is actually a good question, and you are right DDR in this case
> does not bring better throughputs, it can even make it a little bit
> slower. I think however we should expect some gains at the PCB design
> step, which may be way simpler as routing 8 166MHz lines might
> apparently be challenging. It is common to have PCB limitations on the
> frequency, so enabling DDR can be a great way to keep signal integrity
> while definitely improving the performances. However, you're right, I
> should probably move these definitions lower in the table to make sure
> we run at 166MHz if that's possible.

Actually this is probably not a good solution. This stable is parsed
once from top to bottom. The elements order decide whether we'll use a
variant or another, not by deciding which one is the fastest, but by
taking the first one that fits. But with DTR operations it no longer
works so well. If I list items like that:

SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0 /* 166 MHz */),

It is likely that I will not run at the fastest possible throughput, ie
about 160MHz instead of 166MHz. But if I do the reverse:

SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0 /* 166 MHz */),
SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),

I will only run at the fastest throughput if the PCB lines are so well
designed that they can support 166MHz. If they only support 150MHz (or
anything lower) it would have been better to pick the DTR op.

My conclusion is: the current logic needs to be improved, so I'm
drafting a slightly more complex variant picker which will evaluate the
theoretical length of an op based on the speed, parallel lines, DTR
capability, etc. This way the order in this table will no longer matter.

I will soon respin a series because I've enhanced a lot of things
inside.

Cheers,
Miqu=C3=A8l

