Return-Path: <linux-spi+bounces-2862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9088C753D
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C6E287AB5
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF01459F1;
	Thu, 16 May 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="H86aIONB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A481A28D;
	Thu, 16 May 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858928; cv=none; b=BTZ2cRVPM1rs8yDvSNxjzIhqsojQIG/2pXIISnKdkiPtEQXhLJMa3DndWFNb5nAfE+sgOfZqUPurl3uU84Zi7ycwfKnGCYcSq452DvWWilzx/I7Td8U7X8eB7EymC5FAHvPrUbPlDf+n5lhyA2Grre0ACQk40Pr2PPIjoy0W7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858928; c=relaxed/simple;
	bh=enKVvRzU5oZ+oBuhTjqo5JEvJIXEKjq9C/ONbAnmrx4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XGNLUXtmJTUzp3Lvhr/Ks1FkJ7GHs4Qc2pGJkQzxv4bmvyIQdZYoBzo0u+/2rNjHRRBRFewdP8wkujgM+CGdbD3TkT1emtEKew7P1Bj0250TkcDKwP5Ply5UUox00u1NvG2dni9rOCasDUT+NNqPhjwMgnZRMxgO8rGELFWgwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=H86aIONB; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715858904; x=1716463704; i=markus.elfring@web.de;
	bh=5i0xham76HEOhXJqsxBHehiz8KwJEYaip6aTpBTpCZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H86aIONBqwK8OyKWHLrU9c1MuUbdEX2GHTxNkQNYU2AngRhZ6i5Axjbmp1v4Od1F
	 6o7ymLBteX40N3HllBBLU0c0IIfsutlOM7FmZN+pJ+9ile1a8Xags9dbZtZbLY5Na
	 uImG6GyEZgIZrBHJf0/Pe7V5aPcPO49dufeYaWcWip3irznyv6gDU7gnOvf96Rm0g
	 HIy6/kaVGkGz7QxAtuG9WwbnqV1PYNcpsBvkK8GQtoSIQhX8rYF1hk0S3dVJjcYNa
	 4yTG6zD1LLFXCkTfP49UDurrsUogDsi9b2+L4xiDpdRKPDn2Ceilo8Z/tOaUk4fe9
	 OLnj2YhxI2iRbcaR/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1sSY4W3yKd-00xKQf; Thu, 16
 May 2024 13:28:24 +0200
Message-ID: <6bf6d165-5b7f-447d-a804-25c4f7defe53@web.de>
Date: Thu, 16 May 2024 13:28:11 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
References: <171517009614.2014074.15995946356965034064.b4-ty@kernel.org>
Subject: Re: [PATCH] spi: Remove unneeded check for orig_nents
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171517009614.2014074.15995946356965034064.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7QtqQv6V4+p6dQ9XjTYyGG6RH4s+5KrA0jlgsKxD6T16Y8YQeKo
 vmqUlykKx+P1RKQodcjSxhXMUkJ+PDnYx7DMOj5dI/MSo7Ri5CZLqvQZWFi9tdXGE63/K2w
 pnBDOcqPkcbi3+y4G6Yf82qnLOZkUgg4Koi9SZNtdRcgEiICvnpoBoCd1r6WD6jRgc7pRH7
 OU5SfRvPJ46GfR9P5CcsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:708x+Vn/bH0=;eUTZJkIFGasy7vrsUkNULKMEAiL
 GjRjNXiHPuEv4cm2u89R2+yulWZUmY7m3TmDdG3UY8U/44n6SLFBF4WLXmVdF3rN2PbUa4Nbl
 iWeFmMv9zBUCCLElirFY1c1pl6WZO46KaaxpE+Er4V1sh/x7lELj0+UMI2gWFtG0sii3Cz09K
 9oKYZJBa/nX/WKBhpCLOSL8qRYnQeLXPdyVMG50KoNNLeqJOcHW/3pawl8/MLxydGJZozNumr
 FAt8KUXLpnCRG/3nKRe7ZUXuqJq/jp1WYqNK4HM2ksvD/1tupXtWeGHrqEpaQDiTTeVhVis0w
 ifcaQTNEtRywujpesxfWgJTHy21M76ss57uk0qm0u801tMakMNsXv6WiV6xy7TCKTORXC5oNt
 h5ogfSe7ZhtjEfQxzuX5Pw6p6m35/9Zh/fkEydj35QXtIVM1A9AaTGmwOGVHdPcWWVPUBYMBa
 U4XWBKnS0T/BNLLI2uGs4+yIwvqa3dHjOJm1zqSMIBCtSNcVynwFztqMaHbTB2jlz6t/GhKYz
 Uo5OGhhujSyKkz3n5/o8L99rEOQMawZwydFYLaiOz4vsc3VEItdyvhpMbUbwUYJxEbqMBLL6M
 0zCJNBdKof33ln/cJEA/NJvYkGiJWJSwToMeA+E+z749r3kWQ/19g7C+WpUw+HE2t584CdTaq
 6INjL/KRc2j4Uq+xOkv0k4ITq0p7fSdYpUQRpDtqLSlZZiiQvIYnYkPZ0yUbeipEiSQtXP4Ar
 ccAjIAu2evRTSxaOElhlHBHVb3HGcoVnAH9+K1Wct+p4Re0JI3LeRPGttA2f16ViDgI+OF1AZ
 4BSOaJdFyIozL7rLtWQymghQMDKxM4INkdBs8ghXfiDek=

=E2=80=A6
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-n=
ext
=E2=80=A6
> [1/1] spi: Remove unneded check for orig_nents
>       commit: 8cc3bad9d9d6a4735a8c8998c6daa1ef31cbf708
=E2=80=A6

Are there any chances left over to avoid a typo in the summary phrase?

Regards,
Markus

