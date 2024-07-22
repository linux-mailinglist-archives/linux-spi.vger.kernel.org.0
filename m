Return-Path: <linux-spi+bounces-3917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4259391F5
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF76A1F21F53
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161116E872;
	Mon, 22 Jul 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Lj03OggX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17CC2FD;
	Mon, 22 Jul 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663002; cv=none; b=DwDtljqtmkhjp55b5grx9vlBBkCxXohH6HUjqUIdeAYY+16ul4KySe7ZoKCUghP1S5WVeWLjd+lfhFhS7HaCRP6/+27psxQDbVv+VGmTA3QyUlAQ8Yq0bQOB03HV90iqOTG/GWx3Rgd6nwuPXgZ1p/JJPvaQ9zbzVNyWH7CqWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663002; c=relaxed/simple;
	bh=N7twLd8JKxdrxrzqJPGwvzBZv8ilEvBHRVo/IGjl5Oo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ozAXOE1Hfo02uB9wOZAtvU2bLm23vp0AyYrboPimlDY4cGlSRsWY0iADwmnxdogSUSV0W0Lhkct4danqQLD+AyRCkNq/jOOHyUUIoZhTcjWS+uzetHYnsDdgRIlDRdzW5kswKOF/vC7AQYnbnsGWM5YJd50uDZ4F+kBoZ48pE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Lj03OggX; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721662957; x=1722267757; i=markus.elfring@web.de;
	bh=NV1QIh4OpNLnyA+klMSBI9RWWe6ygdsL7TNoxE+cCY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Lj03OggXuOW19o2JPicR1M309VrcPX4Uaj9fYFRv+rQQjSaEUP+29RsTGNZcS+Mv
	 TJO24ctg0mTsc6vxbfrbDu29obvibs629sl4Jc8H6VjLjd7zx5VH/p6LteOBWTTcn
	 UftfWoiENjhpEtF9jGHHQW7EiJggOnVty/kCAL6SEUGzN1qpE9phCs5dGTSZpkhgs
	 r2sNIkF0TyTDWQJiNBsH0HMSlHgTLYTMjgNmHjWnUUhlBraVQsrQaG+4bzLPhNQOX
	 ttqh8IHLTGyE5+2ug018x+HjtsvikuNjttq9s6QqY0KbFdE35xEpDp7X2OR9iV02j
	 9VIKLPKpazbv/07kPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1s9hRG357b-00yxk7; Mon, 22
 Jul 2024 17:42:37 +0200
Message-ID: <bceb4055-e315-4c70-a682-228cb997f86c@web.de>
Date: Mon, 22 Jul 2024 17:42:23 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-spi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Brownell <dbrownell@users.sourceforge.net>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Mark Brown <broonie@kernel.org>,
 Stefan Roese <sr@denx.de>, "Steven A. Falco" <sfalco@harris.com>
References: <20240722141822.1052370-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v3] spi: ppc4xx: handle irq_of_parse_and_map() errors
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240722141822.1052370-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gIL1nlCkQT5wws30MVWgPwW8pfySJoeVltaF0YGAsoCWUQtcO44
 qoiLS4gMT0Ltl6sUWAjIHQkEA9dlUz46lJyFOZ4iOEGQWeopk+S2esxBRfeSOTtSic65Kyl
 XvDR6h2RYRdzkfC5v/hLrzbab4kxm2dGaGg7/IfLuopjqnfZW62h8W2Xoi2kypghM0mfDnm
 tRCFM6MTPzNcZf+uq97ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i/xHEy8h9+A=;dTzPPPtWuyy817xiO6ab0y9AM3T
 6hl2O1lI9QaAYIGzvLLZdxnne5wIWrmyk5YFOeClfhlW199N0fDymUyfXoMUk16cKpKybzvkJ
 TMjnP+NBo2z1GwzL04vLkoEyAKl/imwt4qXyxUoZZfZ944r016XL/jg2tkk+72FqCtyTKMQIL
 WKpcTug3RQFM5hUgXmWou8yYiRgfJvGWSSrX5dVHk9E1oKZgQzrHrvk69PWZS19KTxChxFee8
 v+txs7LOAHEgBR/dXcy7E73gR9oQgD/wtw1ZPxzet4PeWRedj314HgiDuyz1ivdAKQs9nGEQH
 JAQi7EOZl6aXmoBViVYO+qPnwJtTV/Tpg2ZryJotEMKBJSWLufmkc6nnoWWkKZBepJrMVVAaL
 NzVi38k6OO+gnCEEHUdXbfJMXC/WuufobqH7wtY5BfqH5Pdc7tqjb/jW7W1ZdtNBoY/xgk4Ma
 oCZ6T+CXevWnEwtGZpKKX2Qzg3srU+UH2jjJ5rZY17Mm1x5qoheYqcRXlgqX0OkuPTuGsecPx
 SypadHBhy01hqeulKRfQ7HaoMlSAHoDyDvSF+gb5O+7I9/OZEJxYCqXd3yKWO6OfiwAkRqGVw
 BsyqauGRz+aEDqTVJLynabu2LW+HeHJwqwGiUwpzKT18g8gYCiU80AQyZbvWKegDXZ2oVmb0k
 NPOfrdZkr5Ajl7fc0kmxhzVvoch2VV1tanp5ahYs4ujXgmarSA2I98QIagKxsLGt/3ED5R2bd
 rVrajkW8hyGPDq4C6BC11h/+4fQZbFm2EsY0IFHyP+rsRfhM841VkJBqY3ItBKTBgBptwtlwg
 P0iXPhLOAnglCnOi22ktnu3w==

=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Will any contributors care more for rules also according to such informati=
on?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n398
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/researcher-guidelines.rst?h=3Dv6.10#n5


=E2=80=A6
> +++ b/drivers/spi/spi-ppc4xx.c
> @@ -416,6 +416,9 @@ static int spi_ppc4xx_of_probe(struct platform_devic=
e *op)
>  	if (hw->irqnum <=3D 0)
>  		goto free_host;
>
> +	if (hw->irqnum <=3D 0)
> +		goto free_host;
=E2=80=A6

Why do you propose anyhow to add duplicate source code here?

Regards,
Markus

