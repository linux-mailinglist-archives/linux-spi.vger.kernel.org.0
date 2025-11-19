Return-Path: <linux-spi+bounces-11359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4452C706AE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 189642A1E3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB6327BF5;
	Wed, 19 Nov 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1Rb9Vg2G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39002E5405;
	Wed, 19 Nov 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572697; cv=none; b=QRWoV8th7/4KOAodW81x8K6vAfKI3bru+dc7jrMMN0jVMxlAyxUATyxfnd2UVOy4ktnSrzH4Q7f6aDs5BsVmNje72fzioJ4XiP9w+OQfSeuB187f74UPXwjG6OBeQm1irEBd90i9dX3dWzrUcd+t3h5pLa5Sd5vE2SJI2VqHAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572697; c=relaxed/simple;
	bh=4cxcVUj5M5eta6dgUmGXA1pHA83Ea+XKRHROrVMcz74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A4AaVvQ8LFrTOm5K7zd/8cSkI+6/MjOnQ+ut4Q3F7+Sq+maNJocRtD9wHnoH19C3MY2eKogRUpcZqvQ1gjWb80/eeaTLyv9vBg4u6j5WMu9J+Hs9sUcExL7WO5ZaDKoYl9L/zbeKOoLKAUuc1UWTFjRSQh7cKj6fxDiFXYPU8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1Rb9Vg2G; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 908351A1BEB;
	Wed, 19 Nov 2025 17:18:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 651E660699;
	Wed, 19 Nov 2025 17:18:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C236B10371A79;
	Wed, 19 Nov 2025 18:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763572691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4cxcVUj5M5eta6dgUmGXA1pHA83Ea+XKRHROrVMcz74=;
	b=1Rb9Vg2GIPy2BtYk8RC2tBW5CrnQD2o/kuHFheZ4w/GnJbYeYG85sByYkvu0VcBUrp7fNy
	iVVyVVy2fMHzFOJ3pwCWxUK1sgm87AJI9S6YapTKLeuXAOvaIRPN6pGPdhzIGaJe97TKIL
	j11d2Tvka14EGNoqkJxrhd4iVL4vx9QPRUvlkgI5idWwxM92x9L1H9HS1vjqHeszaLAH52
	GrXcb5MVV/ndHD5jHM7aLAOld2j5PgK6U8oeUBuC+EX/uN4w7EeRFbzu/IILVeihf3tHLi
	LDuHXPI5LyLm4bSi6uIxxTmfv5IUrS02jUwId2Q5/65lbwRwdvOPG7+kR4bC2A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K <s-k6@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 04/28] mtd: spinand: Fix kernel doc
In-Reply-To: <efb8bba5-8805-4c95-ba1b-3bde46a4e528@linaro.org> (Tudor
	Ambarus's message of "Wed, 5 Nov 2025 16:57:39 +0100")
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
	<20251031-winbond-v6-17-rc1-oddr-v1-4-be42de23ebf1@bootlin.com>
	<efb8bba5-8805-4c95-ba1b-3bde46a4e528@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 19 Nov 2025 18:18:08 +0100
Message-ID: <87v7j6aqlr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 05/11/2025 at 16:57:39 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>> The @data buffer is 5 bytes, not 4, it has been extended for the need of
>> devices with an extra ID bytes.
>>=20
>> Fixes: 34a956739d29 ("mtd: spinand: Add support for 5-byte IDs")
>
> no fixes tag for documentation.
>
> with that:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>
> (commit msg can be updated to smth like "update kernel doc comment"
> too)

I partially disagree. Tell me if I'm wrong, but may I guess that you
have backports in mind? As opposed to backporting comment fixes which
might not make much sense indeed, _fixing_ a comment makes sense. We
know that stable maintainers, even though they ask people to Cc stable
for backports, they automatically pick with the help of AI almost any
commit with a Fixes tag. I believe it is wrong to not mark such commit
and even change the title (because "fix" in the title may also lead to
an automatic backport) to circumvent their tooling. The tooling must
adapt, not the accuracy of the commits. Plus, backporting this kind of
commit is harmless, so I wouldn't care too much?

Thanks,
Miqu=C3=A8l

