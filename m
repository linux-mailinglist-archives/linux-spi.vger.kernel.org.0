Return-Path: <linux-spi+bounces-12352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBDD1B043
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 20:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99A8301C97A
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3611A34F26F;
	Tue, 13 Jan 2026 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nucn17+X"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166334DCEE;
	Tue, 13 Jan 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332066; cv=none; b=bPK2akGLw/6LtcYzFrgTAe6gEjsfOuVEmI/rH9XHCU52BjsYyC7mOAncgfITwavfC2CsP2QuvHza0QtfBGeV/v7SnuVsNui9K7uCfMpM9VRnjXllFeR+Z1DYC/AvvbsGdVlkxCksWCCv1H14JuwD92E7+89nc03iWsF41GvLTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332066; c=relaxed/simple;
	bh=VQuEfo7ZUmabcn2Tnb8CA83ipw+4eTIezKMxpytF3po=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZKlRH9dPMpxgkL/lcCUhTDtaScj3vfMyFCfOB/j/MSjRzn+uzYw3psxo+q1uH6wLgZwIQtxSzWtbmofVrL3hxyUljpWjylt81xm9Xraec3a6uPGZocZZDdBFdj9VzbyjqnJfUxTs27uTBUd4NpMGWEX72aiTd4T1x597IGYBeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nucn17+X; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768332039; x=1768936839; i=markus.elfring@web.de;
	bh=ti9je09Dby1mKCL9p+69GvQ7iW/sqhOik7N9MuQj78k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nucn17+XI6kqZztTaYLysO7SQdcyAWbN8KYoAWGG6ZLE8JFR5uek5DJztHXWhIrK
	 OfSwg+w8Rz7aidCeY8OJ5j7cj3Jlo5R10l1E6tjDWV6FPiIlEwRen+bgWz2L4DpEF
	 cnkBb/kGadEDI3GJki9ljx8H447j4GKog+IFbJiFcW5PDLRqwLFutPhnqxRUZ5G3E
	 h4KX15BLoA6P9YmWu0ZQ5SltDkRaKfvj+zFBYfomGycSw4Q9lgZ3M69XSbzR1emDm
	 WmNRmcgrDOIKHIt4HBjerZdez6FibPmOgTA4mXyW/FMPcLxl460kakG1HB5b/SsXx
	 /0F9oiWt8oprwTAkTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Mr-1w3ZC01ekV-00yRHd; Tue, 13
 Jan 2026 20:20:39 +0100
Message-ID: <1c068a91-e0a9-4edd-b5d0-c7fde56999f7@web.de>
Date: Tue, 13 Jan 2026 20:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Brown <broonie@kernel.org>, Felix Gu <gu_0233@qq.com>,
 linux-spi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
References: <176830457213.25724.9815535994112539882.b4-ty@kernel.org>
Subject: Re: [PATCH v2] spi: spi-sprd-adi: Fix double free in probe error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <176830457213.25724.9815535994112539882.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C1TM29UF2/kqjq7zOd9o/w8MfNvR8zhCP8chI5HIpwAveuSSOHd
 dThorPOmGsO/clHFf+UeVs92tNkzUrZMneoNIBfVoFVbNDo+M2pd9W3QpT8WNz+fye/PH6k
 Oh5uo+9c0s1m2BqDbUg/gU/qKEvSFSJfPqBGW39odH3eQV69I+A2JT5AjKQhr5+oGUmQN/E
 SvGOaSxMi9ndYXy1LYjfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ABI+sUWsOLQ=;f9SQV+eFWt+y3oNk7fNebH9NlHo
 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

> [1/1] spi: spi-sprd-adi: Fix double free in probe error path
>       commit: 383d4f5cffcc8df930d95b06518a9d25a6d74aac

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=
=3D383d4f5cffcc8df930d95b06518a9d25a6d74aac


> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.

See also once more:
Check =E2=80=9CBAD_FIXES_TAG=E2=80=9D
https://elixir.bootlin.com/linux/v6.19-rc4/source/scripts/checkpatch.pl#L3=
231-L3269

Regards,
Markus

