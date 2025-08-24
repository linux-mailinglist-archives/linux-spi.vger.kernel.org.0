Return-Path: <linux-spi+bounces-9650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F4CB33148
	for <lists+linux-spi@lfdr.de>; Sun, 24 Aug 2025 17:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CD7440D73
	for <lists+linux-spi@lfdr.de>; Sun, 24 Aug 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD925A357;
	Sun, 24 Aug 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xGvqGf7R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4902A1BB
	for <linux-spi@vger.kernel.org>; Sun, 24 Aug 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756050678; cv=none; b=MfvBwQ+wVZIBJncEUTNinQRf3gql8jvEOmTN0WXqxdDCe3e7cGVol8I0BhbJ6IyLdBiXLKA8SlLiXGuWKnbQqHVqSNamzvgKrlzCq5PpPEg3gOmmug+z5u/BnMRHafFDZNNO4K6SMQZBzX3BQ8aimlrZKHd8Ufoc4UdxEAo8cPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756050678; c=relaxed/simple;
	bh=N8TnPVsESid2cQ1hhF98BtD+FAEy1qWNfNCLT8zQ3XY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=trNuY+BzJ/Hq2tWS1ksxEiZPlmpqruylyC1TEPTX0W3rI0XUxCFE/DGlBWyz2rDa1yOtPRBGvtQY4KusRbYCCspI9aMXQyz1mVjzpy00uzgwVvZ4uVb6d8EkUsy5wk9qOec7i/mGluGS1QCaghimVWVBJy/XSjnFyNBHHgPFDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xGvqGf7R; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BBD44E40C1D;
	Sun, 24 Aug 2025 15:51:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 092EE605F1;
	Sun, 24 Aug 2025 15:51:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6C5A1C228A5B;
	Sun, 24 Aug 2025 17:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756050674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N8TnPVsESid2cQ1hhF98BtD+FAEy1qWNfNCLT8zQ3XY=;
	b=xGvqGf7RUIbvnFHVKYwyDxsvhN4cpVYRJdpCk068CKtchXKw29FhSGK9ubTRudt41vNmuo
	RNeqCEwo6Jea8JbdC+CeptKrmAXbyr9tvmM4GyzAY2iLXG9t3+G5A0toPdWcRJdybjl+AJ
	FcrFjY8NolfvDVaZW2qZOwNB4fnoBdBeRwXgcKPpk3+uaS19knB1dWK8KwEI0BdAnWzkrf
	bLnlmOgQNbw704qsR9jlBfh9ytUyKUhm/fM8IQRRmSOBVO2XGQoXwpJ+Mi9VlCsGhczfTs
	HqMke15N7FYJXtvy9Ythj9ewNzLHeby+Pw2HK+7znGITVrZAAtgrKhQT3tSxlQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Ray Liu <ray.liu@airoha.com>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Martin Kurbanov
 <mmkurbanov@salutedevices.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
In-Reply-To: <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Thu, 14 Aug 2025 18:33:25 +0300")
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
	<20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
	<78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
	<e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 17:50:56 +0200
Message-ID: <87o6s4k9b3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/08/2025 at 18:33:25 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> On 14.08.2025 18:29, Mark Brown wrote:
>> On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
>>> This driver can accelerate single page operations only, thus
>>> continuous reading mode should not be used.
>>>
>>> Continuous reading will use sizes up to the size of one erase block.
>>> This size is much larger than the size of single flash page. Use this
>>> difference to identify continuous reading and return an error.
>> This seems like it just applies anyway regardless of the rest of the
>> series?
>
> Could you provide a link? I do not see this in upstream linux repo.

No link, Mark can apply this without the rest of the series it seems. If
that's the case, it's best to send two series because these patches
apply to different trees.

Thanks,
Miqu=C3=A8l

