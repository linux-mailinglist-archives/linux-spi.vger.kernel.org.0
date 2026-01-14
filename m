Return-Path: <linux-spi+bounces-12374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F04D20172
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 17:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2BE3064C01
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9F3A1CFF;
	Wed, 14 Jan 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1ZU7l5da"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D63A1A2E;
	Wed, 14 Jan 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406860; cv=none; b=F6gd2sYuaDCCX0xNZRC1YAsHmiJlbByBOtBR1bmvhXPbgu9XPNxzNv2swFY7OMEdQvVCmd2helEpoioKwC4fr22+x6RjsgBKxJEskd6GeIm6IuqbjZ0czQEGoGRIoZip1Dj3J/1BR+gZejUJQ20leGcGdorNipON+IqeE4EIXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406860; c=relaxed/simple;
	bh=hKfoS2hwknGcM53kdGxag6tH2rYC5QGCeO/FU7hXV+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9GS7Imkm22xa6sq569h7PDabjM60oxG4nqb1LnT0BmJUVEDOgy2p+VR2umPxMWbvCixQIOwQ4QsISSisIkALjyK190uGCd0crHwhkSj+nxJPeVu8k6QQF+cE3Cw/OzCAt9UwjZCZS7lDuF0KekmOPMNUNUbgLHq7+FiLNW0CWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1ZU7l5da; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B45564E420D7;
	Wed, 14 Jan 2026 16:07:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8780E6074A;
	Wed, 14 Jan 2026 16:07:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF9D810B6828C;
	Wed, 14 Jan 2026 17:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768406854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7GHhvNDeEejFF40Vr4lqZtPBvamQWVFjBd1GvEqK998=;
	b=1ZU7l5daZYARt8ZZ3NihYRpoz9rBPLNo8BZmlvdL0kq1omKbsRWaeXhaxv18icLCIDluIC
	C3Z28E5/92lc3au+2nM/zMv36+VPQeLvmn5H7cVx/BURIGPpYyasPZ2YUOeGf62dPCJVoU
	cbhAIgSDr3sJy2dLdiDsPdMGIkMiayGnEzRdonK6+YfoZ5T2hJDfKEXaIeu064AnGlkXV9
	2ZU4a6qiuaMbeVj5XNyXiqaS0rKJ2QzqjZiKoP4RQyswFfpJqIgvvcdROiemLJlX2+61gB
	qV8jcveLm3TUKXefCixh7L8OLflUWuXUa0IFD8sApPaD6nau6WU+yD3Lc449KA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pascal Eberhard
 <pascal.eberhard@se.com>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] spi: cadence-qspi: Fix style and improve readability
In-Reply-To: <86pl85b7cy.fsf@kernel.org> (Pratyush Yadav's message of "Tue, 23
	Dec 2025 15:28:13 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-3-8ad505173e44@bootlin.com>
	<86pl85b7cy.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 14 Jan 2026 17:07:31 +0100
Message-ID: <87wm1kuqik.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Pratyush,

>> +	} else {
>> +		if (!cqspi->slow_sram)
>> +			irq_status &=3D CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
>> +		else
>> +			irq_status &=3D CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
>>  	}
>>=20=20
>> -	else if (!cqspi->slow_sram)
>> -		irq_status &=3D CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
>> -	else
>> -		irq_status &=3D CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
>> -
>
> I suppose you can further simplify the if-else chain to:
>
>
> 	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
> 		irq_status =3D ddata->get_dma_status(cqspi);
> 	else if (cqspi->slow_sram)
> 		irq_status &=3D CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
> 	else
> 		irq_status &=3D CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
>
> 	if (irq_status)
> 		complete(&cqspi->transfer_complete);
>
> 	return IRQ_HANDLED;
>
> Note that I swapped the latter two if statements to get rid of the
> unnecessary negation of slow_sram. I suppose the overloading of
> irq_status isn't the nicest thing, but I still find this easier to
> read.

I'm fine with this approach too, I'll take it!

Thanks for the proposal.

Miqu=C3=A8l

