Return-Path: <linux-spi+bounces-3935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18192939BE1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9123AB21720
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940BF13CF8C;
	Tue, 23 Jul 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="weDGzanL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E33D6A;
	Tue, 23 Jul 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720758; cv=none; b=X3FD20G4NFat+0DczY2JuvablxfT/8AfbbTc48R9jY6FZiUg3fnp3ntxsrtV70KKb31JBXw/CNfIbSWnbzLncS+PPMUCBz6bV/7tOfeXklOUslRTwDWE+ndaqNAFWFI3Pu64S4ATCPVHJD5xXu5r9ad8Nm6J7qjKZX9NZKZkFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720758; c=relaxed/simple;
	bh=ELz3uDA2quvFPtwWEBmP2HILXxTM8hmBC9VR15SpPQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYMItFFKLeGZAhzzjpXFvk6FL/wwBXAXGn5YlUAFBG7rk4CcOxYR+uw3SdrVsxz66/X/epXzP+SJzpG5ZxKY3SOp9gOYvqdnZ0hZfopr8UkRVD4jOEzdqgbcGnxUrulFYKio+9igKvzmaH3CacodKc0WCQQaT2uSTeZFcuYQGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=weDGzanL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721720733; x=1722325533; i=markus.elfring@web.de;
	bh=ELz3uDA2quvFPtwWEBmP2HILXxTM8hmBC9VR15SpPQY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=weDGzanLevBbRVGBBybZSjuYFTUrW3dp+zOk/SrpGSDOF/cl8SVYU8V5qDyeVK3/
	 gVckr7wAGF1MdRnJ7+uAbsxomC1NYg8WVqozGyHWWMZvFNpT5+h+0WEZiYBpdtSz4
	 ia9PK9vS4IcRFsp3owslKJOI7xxDxwzV+bvAXFFSqtXzQ3+bTRwT7uHb1l7OBB1EJ
	 yuLsLMNLxXGAwGFCumIcpcka+kxxwNUWkQXbalGxQtcoWcxMvMzV7bvvMyB89t+Tr
	 CVMPB/hYCe4GFprzANTQJeGXiKpH5MfqYZJhOI+NtOg/hcr5YMCe31HN7duZZlED4
	 wNHt5+wCtF+DaZLN7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP3CA-1sfxr72rls-00MYDj; Tue, 23
 Jul 2024 09:45:33 +0200
Message-ID: <5b0b8757-17cd-4444-8ceb-2178f4091a26@web.de>
Date: Tue, 23 Jul 2024 09:45:14 +0200
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
X-Provags-ID: V03:K1:SU6G0oa0W6MljftbcX0yyx7dYiTf4AgjbYLUjtZvtZGrpSr12Qm
 H7hvU0hactrBPS9plMPeXTIM3QntLIewJuR/RJKyL9Zv4wpoZORRTfSz1/joERaLjazs5nn
 HKXVkRtf4xh9ZJJqZek4JyrReWmMKMBhtLPzzo4kPs3rDMKDNYWmOmPIbjSMrgIarSrpCW/
 BCC+YyM49xjTzYXPyg3Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2fWotyvO/vc=;tF+nq+YqHEjVlshPCiuq5dtBcAV
 dLP4DQlzjRqsV7wm6xYpR6tl5MW+jysnu9GcIZ1fYaTko2RAc/dFbyq7u7TtXsKCLhIRWboLT
 36Dd1I0i0cDjptbxx6WsY6JZ7rG3to/K+rV6awmKh0hXctgkddcL6rub/Cyob3+v4xhctvxc5
 RTYG/Gzf/A9j3pLsYl/K4SC0OUg11HxkWDwZ4pJVoi10GgBCN+x8QWSgREMeVvl6+d5HiBX0R
 nNlCBUKEFQv2a7+2h1c+Ybx5rm+xBe/BNr3Kxk1ZKT5zLItXYDMwr1kvwnLqLYO3NOI/fv4oY
 RYOA2s5kbq5BT/ALs64avN/fLXCZU8qZMN/H0Ep/q+J8zjAzPR3eKPPNnaMUYYqi4vsiQOpjp
 Iwib2SZYnbArfmvBbVQjSjq1HKst5yKm+/6g1Vd3vFHN1JbyzkiaFhuftgqV9HLHIetjpSWu0
 6lonO2BH19i3YB4mfMGfe9BnZ3D5fDAY+AfljDlMCCY2Iju4HEOOrKp1nYJ/bZfDPBR8Z3VMk
 QNJIfNa3wLbxB2HixpgLDKvjA9wTBMvQGtll/akKXxe6sZLp+AC4sk0DhWJeLJBkIYmAV6wHJ
 hxM0CE4TQUYXUwz3b5Pm0zht60/pYlNs9+s6pkLQXpyyUdERtkxNZX/C5tiwYrmrrN8bj86ZX
 VUYZA82+X6stviSPcn09/ai/j+3/jiTMQ1oMq27r7iiaZJyXd/3xbFnkd0WCeY+6QOdQ2Bb4v
 jSHneQZKl4GJ8ltDFeU1eF9nNNIA2LRSGoBaseMIVKvVjZGFiVlzvR4OaPPcq7rCHDm7nePPu
 rkdkWwq7rNJwSWDIX7KvKKCw==

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

May any contributors feel free also to reconsider such a hint?


> he has a long history of sending unhelpful review comments

Will the chances ever grow to clarify the concrete items
which you found questionable anyhow?


> and continues to ignore repeated requests to stop.

I would like to improve developments for selected software areas.
Will communication challenges be adjusted accordingly?

Regards,
Markus

