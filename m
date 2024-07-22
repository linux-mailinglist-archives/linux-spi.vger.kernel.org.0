Return-Path: <linux-spi+bounces-3920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81D93938F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08070B216D0
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C316F29C;
	Mon, 22 Jul 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sWp9LK1o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5C16F0C2;
	Mon, 22 Jul 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672704; cv=none; b=NAf09XdSHwEMsqYUhT8nBRNnyNAUVD0gxUlG0GME/sgZjOhMsi9yfq/VFD00Mual4t6tO6+8+ICDJaxaLeDj76pq5GIHzGzUqSy1I8xNPdB+LGulnL3vGZuh0baiVaeJ6zq/PyxiGKsKR2A09cutFBbk4aaqO7Vlmm4XHTcFJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672704; c=relaxed/simple;
	bh=WX0VtNoRbqAErf90cp8dai9ieT+dqy97QRBrWMOGyxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKs6Ind66pLl88UFIEsira9ZEgpEujg6zi8fsDU18RJ7hVIvOud98Nk5zRU0+hwUFB41ldyOvXTGwG/UHlR7gC/nihT7+W7TWpifD480t1HC/51YCCr/5FX7mCM2rD2vXNdTOndJ7W52crtid385DCilW1FhMhguAikw5mugMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sWp9LK1o; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721672670; x=1722277470; i=markus.elfring@web.de;
	bh=WX0VtNoRbqAErf90cp8dai9ieT+dqy97QRBrWMOGyxA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sWp9LK1o0zo1bsYiWtoXQpWIehoYLBcW99+brcppQpT/GMYOn42MR5eEeJwcWJ/X
	 MqS/fEgF1qxl7Zr35fjxE7KOkrpo2ajOhwpfeK2EXirfc3AWba2005NbrmWg9LID7
	 0xFLpBndEHCLXx9PGZXofwBVW5x1BA5GuQRcoj0evAg43Mg1WnBcTE/Aib4pisgdu
	 YmidHxjbjcTtXy5Us5HkrTLgqU3UNPsJzRZXO1cKZAOqGWR0gGYJzLRUTWCgyqUyy
	 t74pnjujIWOxlF3KfJG3FVOGrMz2ZJPC49B+nsBTCRkubBI7tFk5kcMUeohtntZZC
	 28cOx/+bpeh9lIaRBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1sacPc480n-00HRTA; Mon, 22
 Jul 2024 20:24:30 +0200
Message-ID: <3fa16801-50f2-482d-93db-29a7b07c2a06@web.de>
Date: Mon, 22 Jul 2024 20:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] spi: ppc4xx: handle irq_of_parse_and_map() errors
To: Mark Brown <broonie@kernel.org>, make24@iscas.ac.cn,
 linux-spi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Stefan Roese <sr@denx.de>
References: <20240722141822.1052370-1-make24@iscas.ac.cn>
 <bceb4055-e315-4c70-a682-228cb997f86c@web.de>
 <2dbd470c-80aa-45af-9324-0e81e1d9196c@sirena.org.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2dbd470c-80aa-45af-9324-0e81e1d9196c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3LgpV7XD650P1s0vnkTrTFzdMAHohEwIKAEGlt6sPHdBOV7ZNl
 /i73lC4fFCUFk6iS+MvLGJfOEuHvZ4vvHRB/PpOfLEgE3sCQYW8uGmSNfkU8t27+nSwSsSw
 YqSM93NeZCaXTDGjZVWaKSZJuaFb41dJchZpcMdpJtpQ37gMpaoRwC3DGlwgbN35nRwSKyz
 Uo08+VzK7vFyU3EVuUQUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oxmBtoTqeLA=;XSjYid3KsQVMMUpM6vIHFYrVNoU
 ll3tc+7uG0tsTghMq/gInUe/NI1QVqW18c/K4uoqbehBlmSHqikYznjdOCA8j1oEeMlU/mUK9
 Fwq4LSuMMQ5lzIFTdzYiZHRrvMdzIfV6Hs7EVYja9Kt01TYf7vdwP+WD2InYLs9SSCpPr2nRV
 8LuU3usq0L0TDpQ+rLXUAFHdm8v0K3iMaiUaBfjjVJBqgKA7LrqEi2ku/zMMyqGrZUpWkafmc
 yl6+KBX09MjvQAM8kbyxH7JxWcE3Sv0Ea0eq13NKAa92uJriHYDodnoDD+bt6HmaACAbiwM2k
 30ZJxdbgWOksYj6EAMd1lT+dCCbSxMlC9QwETVkxAqyIuMl1cz3FVuRSJGYKhdtjxXI8AkXyL
 MgtpJdeQwKgkDwZcJ9znIkT/puBI9S4K1d2mvBF8YKHedlA8nW4vG8gicbyVwsUnKjo3nAmM+
 W8L78yDAgxmQ8ppwxKLspT0IQ5fsW5cjP+c2i0eI1F6QYjjnAhxy2TclOi8qIfQAeMRNuYD+5
 /FQD/T4fAid1ZbCVEXUeNDku9IeeuZXZj4rO8e0eRgH51q8t74bsQSaG/91IhYMPn0672E3Rg
 zJrh9iom6izQzO3nf/Xz3j3/ZmgcOdHsBvPOPJa6B8x/DzR3Nr8kNx0x5TGFoAlzE1pa+kMFm
 t0V4+eZxZZQUSYxLpd9a0xj5zvgSFbDtDO9hGugjLMeNBmgXPv+TIxDEd7gky1Yk81dZGScis
 nN27MoWTjqMdFHR7sPxS8SBNm6gWaigQ2Nyjsd08ccZzt+gX5SmwgELu3DMOWgb/vJOHdstxo
 8y+HpwFVSL0jO7/c2g4qpfsQ==

>> =E2=80=A6
>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>
>> Will any contributors care more for rules also according to such inform=
ation?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10#n398
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/researcher-guidelines.rst?h=3Dv6.10#n5
>
> Feel free to ignore Markus,

Form letter =E2=80=A6?


> he has a long history of sending unhelpful review comments

The offered information can occasionally be handled in more constructive w=
ays,
can't it?


> and continues to ignore repeated requests to stop.

I hope that circumstances will evolve somehow so that additional views
will trigger further positive effects.

Regards,
Markus

