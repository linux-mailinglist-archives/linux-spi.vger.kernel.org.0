Return-Path: <linux-spi+bounces-8273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B275FAC2530
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3781BC48CF
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F1B2949FA;
	Fri, 23 May 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OBVIR7YF"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB66128819;
	Fri, 23 May 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011180; cv=none; b=lhKgFoucKN5DTATTt6b30Bor+PWx4+4p3/CPa3V+x9QunZiqkY9Oi9PJwDc7/EFD60AGQmBlRDe1NQ7+tVkknOsG23hf8X96WzOqr4ymTxocZS22MeJUd7fddV0DZnydPY2PhDDtqbyY+vXiy8W7rTindrk45AZhrx716LTGCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011180; c=relaxed/simple;
	bh=ZOCK6JsdZd/ExEyqrEPPTB1IZhrxIX3Mph1RiKKr0VI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8DBV9N+674cuk9Kw2Jn70cAmge3zXu6Vcvc9DyuGiwpPmCAy+Omll0ZfeOB3ugD+8C+o0zYOCzTbWlfaYmAqqPYO/oQdeEaXcswJhWS9xVHPj+JgkgAPUUuLT5RGFFI7YXCAa3VgrnPy+Cie6WVcloEP0EXWqJFS873R4az/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OBVIR7YF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CD534397D;
	Fri, 23 May 2025 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748011176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOCK6JsdZd/ExEyqrEPPTB1IZhrxIX3Mph1RiKKr0VI=;
	b=OBVIR7YFZYAUkFrhZKMUINmFTYrEstapjIs7fISyxAuP6w6BZeuHjCzzh2WzYmq/RDOvK0
	qSo+jIEmhlJo1ptMCBgSzlIeCevKk2ejF4fpyJPQK2fQrqPE3inng3jBTQHjihbaTAHUR7
	Wfku5P8ArQRpTqmoskd15GoP1wkQrBXqscUxBh1FSH7P4YTTCsH8op/L5rub8Q4lEpOOPe
	IxNNjYjmwAjiyQ6BBOU7RNONEQmj4doZdwbkYyiKqAh0wqVAvKt5a4NcyqNHcrjHrJq2VX
	2/fFDa9SjE8340EeZ62B2SIs0qXboBRweqI/NMb5GWwhysh0y9gJzvM9D7KVkg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Md Sadre Alam
 <quic_mdalam@quicinc.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] spi: spi-qpic-snand: overestimate corrected bitflips
In-Reply-To: <20250522-qpic-snand-overestimate-bitflips-v1-1-35c65c05068e@gmail.com>
	(Gabor Juhos's message of "Thu, 22 May 2025 19:33:26 +0200")
References: <20250522-qpic-snand-overestimate-bitflips-v1-1-35c65c05068e@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 23 May 2025 16:39:33 +0200
Message-ID: <875xhr5r2y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeluddvucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeeftdefledvieegvdejlefgleegjefhgfeuleevgfdtjeehudffhedvheegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeelvddrudekgedrleekrddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdelkedrtddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehjgehgkeihjeesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghvrghrrggurgesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggps
 hhrihgthhgrrhgrsehquhhitghinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqmhhsmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 22/05/2025 at 19:33:26 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> The QPIC hardware is not capable of reporting the exact number of the
> corrected bitflips, it only reports the number of the corrected bytes.
> However the current code treats that as corrected bitflips which is
> quite inaccurate in most cases. For example, even if the hardware reports
> only one byte as corrected, that byte may have contained multiple bit
> errors from one up to the maximum number of correctable bits.
>
> Change the code to report the maximum of the possibly corrected bits,
> thus allowing upper layers to do certain actions before the data gets
> lost due to uncorrectable errors.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> The patch tries to address Miquel's concerns [1] about the corrected bit
> error reporting capabilities of the QPIC hardware.
>
> [1] https://lore.kernel.org/all/87h61e8kow.fsf@bootlin.com

Thank you very much for attempting to improve the situation. Giving this
a second look, it will not work either and will be even worse, forcing
wear levelling after each read. So let's not change the returned value,
hopefully the real life is different as the test case and most bitflips
will be spread and not concentrated in a single byte. However I'd
welcome either a pr_warn_once() or at least a comment somewhere about
this.

Thanks,
Miqu=C3=A8l

