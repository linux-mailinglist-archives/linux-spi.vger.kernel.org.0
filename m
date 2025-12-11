Return-Path: <linux-spi+bounces-11867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E908CB62B2
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 15:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C01C3006449
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFADD226CF1;
	Thu, 11 Dec 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zeztCUkh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6317BB35
	for <linux-spi@vger.kernel.org>; Thu, 11 Dec 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462779; cv=none; b=d7R/TFIU9a9J2XqiynGKnf+7JgbBVrHsV8FUGO8e4d+c7bLsmcQDBgAsXjV/mANuYpNCtf4VBgelgMivwYOLg8OOvED+0HB8KnJIStgHImbttJEpJexUTi3tWsiNzOYz1iC1LeXIkePPYyqdLkJbRs+G1AQhoBrDl/ni/24DKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462779; c=relaxed/simple;
	bh=8rjys0EWHdXH6WGIS1Zzap+OABSzfKqtGnMMZqg29FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gy++s5w7wI52YGkRLk5hRXex28QUXEPqLsdTvwe0kWTJM1p1umz1gqJwAPn9L0NV7yIy/ErMUM2rMI0b6CV+flya0Tz+l/vwTUubBdVoDxIfMheDTuuDH4lmmiqJpmih0dgy2Xp3XdYatj4+/jFWE3Ge/1qRQh3ClBUgGuj6GGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zeztCUkh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4FA531A20EC;
	Thu, 11 Dec 2025 14:19:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1015E6068C;
	Thu, 11 Dec 2025 14:19:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61B29103C8C1E;
	Thu, 11 Dec 2025 15:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765462775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8rjys0EWHdXH6WGIS1Zzap+OABSzfKqtGnMMZqg29FI=;
	b=zeztCUkh2ghNaWhvbCqXv/dW6nAyuBawnJCDfOAjKgOB/lwpeHBaU/zyJlfOLfWxx7oMmv
	ojQc7vlyeliMXBXKgj3sFo2y1g4J1lXNjLXE8NBefvuXKslzYDA1wWMSggdLLjNHsprfZ9
	+fSVZjMMP3Jcor1nstjNVagQxP7YHarSP9Dar21M6+RY/Ubx0cEUn9Yq1ZLIEtpcPDl6qR
	LoJEAH/ri8YRBZmogJHQo3uVRxLEiLc5daO3KOgBDuf5FVMfGzoPZ2PG9fCAKyT7UYrY1a
	+ATM18UShpbTtfA3ygelN/vMGRenpIc+Mfbff/DWQ0MqwLre54yT/SZ0WcR72Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Michael Walle <mwalle@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  Santhosh Kumar K <s-k6@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 5/8] spi: spi-mem: Create a secondary read operation
In-Reply-To: <aTonE4REBDfaWBQo@sirena.co.uk> (Mark Brown's message of "Thu, 11
	Dec 2025 11:06:11 +0900")
References: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
	<20251205-winbond-v6-18-rc1-cont-read-v1-5-01bc48631c73@bootlin.com>
	<aTonE4REBDfaWBQo@sirena.co.uk>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 11 Dec 2025 15:19:31 +0100
Message-ID: <87345h6qz0.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 11/12/2025 at 11:06:11 +09, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 05, 2025 at 08:38:56PM +0100, Miquel Raynal wrote:
>
>> The choice of defining two variables named primary and secondary instead
>> of using an array of templates is on purpose, to simplify the reading. I
>> find less obvious the use of an array here but this is personal taste.
>
> This makes sense to me:
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> Feel free to carry both these patches along with the rest of the
> series, if/when you do end up applying it a signed tag would probably be
> a good idea in case there's some collision with other SPI work.

Thanks a lot for the feedback.

Yes, when the series is considered ready, I'll take care of that tag.

Thanks,
Miqu=C3=A8l

