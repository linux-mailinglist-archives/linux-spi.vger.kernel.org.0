Return-Path: <linux-spi+bounces-3948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F893B075
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 13:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BF71C212B3
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609E15687C;
	Wed, 24 Jul 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HHIqMhFu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A122EF2;
	Wed, 24 Jul 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820992; cv=none; b=gHg+AwiGH3NvuDP28YS4ITZPkuPSv8eIKOCAGqpnidpVoWVmPU9QQhW6dPuCDirfA/WKtAA/cdgSTACyExITMZgpEOOMQPvq3nEu6I7fe6tsu1qhZzaVcWmL9Gq/37c50YzNJowEfcxBg8xEujQ6XLyNjwBoxlmyRXmcbbh20mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820992; c=relaxed/simple;
	bh=fTT4OBasRwESArtHOn+K/IjVjG0CvSu6UOeR2uw9tQs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bz/BfBBvOSbItKXyqfi2QUyfOh/5V3KSvqaCiuwZhGctNEiBntmclzPAdU0tviCO4iQng1oLvL5Vok51TsZ/JnrMH31SNWuxhdJKz44hQ2G8oUhRC64UX8WAYNW30JsmllePVsmBmSzoxVtQX3BebUoErpLQFe36yJAraweifQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HHIqMhFu; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721820957; x=1722425757; i=markus.elfring@web.de;
	bh=fTT4OBasRwESArtHOn+K/IjVjG0CvSu6UOeR2uw9tQs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HHIqMhFum0yCFNBT9Vgv9d2ANtF34lGJ2OSf6DUlsg5+w4QZ1f9fHEWQ0ktybfRc
	 F9D20YZT032P2N2TRsSMnSYVJFJcHxzUDwLNE9bBN2FjarAuXu3dPCAPYinU2XSOI
	 NGNjsDi39tgW2jJh123f3roUal8Nx926C0ZS7RI5BfgYl8axATo+WKRoCJmkXuXnp
	 GSWp/DDaARBF4xZxtX3o8Zh+EmSKsxPMF17rn0CGm/MAPoy4zg1F5T9KabIw7eJv3
	 3/wckO3ndEFgFrSY8HMx7gHOLBAVjBWratWvXM9LA0O3dZaN7CjS6hbIFrR7JwQjM
	 A8kR1xmkZz082vOdlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoeYH-1rvJav48e9-00kQIm; Wed, 24
 Jul 2024 13:35:57 +0200
Message-ID: <d8d29c4c-4c66-42ac-9e2d-821502b5f55b@web.de>
Date: Wed, 24 Jul 2024 13:35:52 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-spi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Stefan Roese <sr@denx.de>, Wolfgang Ocker <weo@reccoware.de>
References: <20240724084047.1506084-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v4] spi: ppc4xx: handle irq_of_parse_and_map() errors
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240724084047.1506084-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:awBrnmcjLoJ2aao/cBvNf85cEJVpQLvxTlA3NSM7NbL9yTtYMGq
 QMfqrzVSA9oNO7QKS9VFYPGS4e3xqdR/daZaNq8sNIOLtohMCAWMpBtJi6g2sd9CIkqTIHi
 HcmrIFQS5s0yj9hHmCa51dke3rNrY8vc9vYjs7VqHI5Lw6L0SCJn+WKTiGCoxnycN/BhwYv
 5T/k3vPtCuhWocxbEMGFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WTMeY2UlUpA=;uovBueTICGeXUo1KrPlA2uNSq4B
 r0cZ+/VxRheUOyaW78E0/ZTiOMn8k+dyn7OqzscIN+3SERc1AW1beyYyETDQr8vll42TSmkiy
 J8/whSW99XmyIA15pAtLMasY1XB2C5J+jj4p9xjcLHdzb4ANpcJGzje79JSJUhnI1W7IBEGZF
 E7fnPHaBBrfDm9eAzPcSU8o9Ij5S/P6kTj/7CE2Ov8aHYGXW7T6QlK+ZPwc9XQ8mfWMBRQbG1
 Wz9pl5fme1F7MnEw9n0EtyCNjRZAtnxMG/dKXF+SOYeIH2WD+hrkk0AB9H/XR1tVJ2fjOqgTn
 bPfDlxnKNHGIRAqB76YE1L+JWWy+eEBHwADIk31c1fWrR5SDch5Al7lNpRR/KnvqdxXPSIgTw
 YJflRlJZtun7b62cHB2C9M3SrcAjyPncSa4hEPecDQMBGwf6E3r6p5NSTM2zJtI0ZU6TniLCO
 gWpgXrb57FnP6nStdPkeC+7VmYJUVeMcHOZHUMYIEhkRggM/qA0t2tKoa9VQuccFQ1D2COnQT
 s/F6rLKqpV04TqLC0TtiDH++i21MznvCZxohS5fWEBn9ffBvHr72Lc8XB4cJQ68KmOW101nFc
 gDALtQNRgRlKvL3HVFvttRC1Ecbc3QJps+dzgerGoveNWmKaif7VggWTA9XVfhB2pHQnnyGQT
 f20oFqsy53Dwayk45EMx8gBDpfESzJm00CwSIT2diljL7HN6Q2Hk8UW8AkM9M0l2o+G9d26x+
 95VD67M8pvssmDYrDsu+gPptWAKft/To8S7CwO9BNtd7ZTXYJbXxB9zDYTNW+CfLuGj+/N9WA
 LlrsR0ybEFay6G7jhFyWqbfw==

=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Does anybody care more for the applicability of such information?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n398
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/researcher-guidelines.rst?h=3Dv6.10#n5


> ---
> Changes in v4:
> - fixed a typo in v3. Sorry for the error in the patch v3.
=E2=80=A6

https://lore.kernel.org/linux-kernel/20240722141822.1052370-1-make24@iscas=
.ac.cn/

How could the published development mistake happen at all in your research=
 organisation?

Regards,
Markus

