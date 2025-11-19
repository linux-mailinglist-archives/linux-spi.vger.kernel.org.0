Return-Path: <linux-spi+bounces-11362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A5C7075C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0995D348457
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E860242D9E;
	Wed, 19 Nov 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gkpacRvB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EC279DCC
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573094; cv=none; b=oxG10mr0ZwaLraV3Q4MZe1J1kRouaZQ86cPUUBB3fJF71oC9CeYHnQxFQUNouJ5yKKMH+nn3QyTDiXZkBoMlPM1m9dzZoyucVKY+4mUdrfqvR+V8RDR8K7bI2vIzAJtyTIu1ZGU8kO90DGjPehvnQ2PLwkF/tx9lDWMQDSp5UvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573094; c=relaxed/simple;
	bh=bCLlxXlQNGim9JiBoOMdG194s5GaJEMos2ax91xMH6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mBmNnu0izdbScNKZw9eg28LOlXCkatbNCjLdhOyje2KHyJiblSc1wxoo95zhvyZQTNu66/bBVzxwA3llk5CoYpgaGs8XRn8RsgWoeiR3LoswGFOB8rpvCToCDdzggvYwlCBatONjFI8qojnsvN119sgvaaSopmAzc6I2DlHgFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gkpacRvB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2F7AD1A1BED;
	Wed, 19 Nov 2025 17:24:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 052E260699;
	Wed, 19 Nov 2025 17:24:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E27E1037173A;
	Wed, 19 Nov 2025 18:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763573090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=StwFp1RiLdLsJV9cLt0jptBNtH9OxMuPJ8PmQfC0ajY=;
	b=gkpacRvBxMVaOw1bdmg1zk40Nb+fYkvbBLR/Kio2f7TMvdDcz1yyXLFXb1MVWcLMultBh8
	Di5rM5Aq0PmRPBacR3aXAuqcey1rfB7rd0h3hbZl6yjXlTRPvPrTOH06AQJrT8UAHegb6Q
	mrsyHOdD23cx7P/NFB5Z4P/jSqdB4jp8W16REiwO1xO+zyR4w7Io82s9J+tXPx8ScOC0Ni
	kPbnOR78WoREDv8jZffVSyavy5fYFKiLIVzsiwc+aajHXwqO62yXAas++f8aAufYHSdWEi
	97H+Zo1y0cWCwdGfpkNilxlOIdlSr/FkN4TfEaHVljtE55a4HU9RbMJ3fvCixg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K <s-k6@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 11/28] mtd: spinand: Convert vendor drivers to SPINAND_OP()
In-Reply-To: <d77310d9-f865-45cf-90ae-ff542cd1140f@linaro.org> (Tudor
	Ambarus's message of "Wed, 5 Nov 2025 17:30:20 +0100")
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
	<20251031-winbond-v6-17-rc1-oddr-v1-11-be42de23ebf1@bootlin.com>
	<d77310d9-f865-45cf-90ae-ff542cd1140f@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 19 Nov 2025 18:24:47 +0100
Message-ID: <87ecpuaqao.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 05/11/2025 at 17:30:20 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>> This macro allows to silently switch bus interfaces, use it outside of
>> the core in all places that can be trivially converted.
>> 
>> At this stage there is no functional change expected, until octal DTR
>> support gets added.
>> 
>
> Shouldn't this be squashed to the previous patch?

That's right, there is no strong reason to do it in two patches. I think
this comes from the order in which I progressively converted the
drivers, I'll squash.

