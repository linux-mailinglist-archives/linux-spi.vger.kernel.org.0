Return-Path: <linux-spi+bounces-7745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA049A9B0E5
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176701B84636
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976C27FD68;
	Thu, 24 Apr 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gs1EOdzj"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6F27F73C;
	Thu, 24 Apr 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504726; cv=none; b=WDoMfmGfODHDLlqRRFjBfNjeWtURzYZKW20tj1wM0nCCZku6ogZvD/izdIOcEILeS+rRFMzYBR6Zanj+7fR23IZHK6u6Lr0tcs41b6Tef6uuXAuAjGCNUk2hNszYYunb+4pVjbGw2NrnbmCh2kHJSmPmif3GxFUXfVQyNqAKDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504726; c=relaxed/simple;
	bh=e5RtvncoOTQkxZ4hTTM84fepiasWkNvfegkvWb+gsbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9UE+57xvAfLSAzHIamhD1SDwBmRUCCW1G3nyVzZP2cESjPZFFzggXNG6RhcjM7RlN8bonpZbpXDQUqKr+DVzbCrPTOQHq6pRJIjCiWUdct0GiAgSjCqZr2ZXLxnKvEFi9cH1R3ZGPXl63hsoMTbQBSUzO8Pi3MwwKfPIBjlJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gs1EOdzj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D5AF43A22;
	Thu, 24 Apr 2025 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745504722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKfuiDBm2asL1WGTg5mJo41pFCMZGBetlyuQnkV7VKk=;
	b=gs1EOdzjoMBPBa5Vre4GK9KL1WN1z4/D09qlwCJBqlUGmXAwaygy/cj3jppaD/03z4MGCp
	rylU/5/RiQgP2evGNJB/E60t6CLMK8k0/w7sRhHV7oHkql/iMRRXwLurEq9v5OBNjG7C1P
	lRHCGEOR/mObGA7OxvMho6+9jj98Ct2XqptGl0qCkSk7aV8d/JPOrru8djgCo/IgotufL+
	tkhuh7yWCYH1RUp8Dh0rh/5lW+mhKM0pvPpmta1M85OJmSuEnXcpi18YJNvwIYM/lTbh1P
	+nFWoBAnc61/vytoRjLR9rEp1q420Y6JL5kuZ5jZg/CFmWYP0NCHSyyKwxkcuw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <broonie@kernel.org>,  <linux-spi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Krishnamoorthi M
 <krishnamoorthi.m@amd.com>,  Akshata MukundShetty
 <akshata.mukundshetty@amd.com>
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
In-Reply-To: <20250424121333.417372-1-Raju.Rangoju@amd.com> (Raju Rangoju's
	message of "Thu, 24 Apr 2025 17:43:33 +0530")
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 24 Apr 2025 16:25:21 +0200
Message-ID: <87msc5hc1a.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeljedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheptfgrjhhurdftrghnghhojhhusegrmhgurdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhhnhgrmhhoohhrthhhihdrmhesrghmu
 gdrtghomhdprhgtphhtthhopegrkhhshhgrthgrrdhmuhhkuhhnughshhgvthhthiesrghmugdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com


> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -596,7 +596,11 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
>  	ns_per_cycles =3D 1000000000 / op->max_freq;
>  	ncycles +=3D ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ?=
 2 : 1);
>  	ncycles +=3D ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dt=
r ? 2 : 1);
> -	ncycles +=3D ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy=
.dtr ? 2 : 1);
> +
> +	/* Dummy bytes are optional for some SPI flash memory operations */
> +	if (op->dummy.nbytes)
> +		ncycles +=3D ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dumm=
y.dtr ? 2 : 1);
> +
>  	ncycles +=3D ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dt=
r ? 2 : 1);
>=20=20
>  	return ncycles * ns_per_cycles;

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Actually even address bytes sometimes may be skipped (eg. status reads). Bu=
t there is no
reason for using spi_mem_calc_op_duration() in this case.

Thanks,
Miqu=C3=A8l

