Return-Path: <linux-spi+bounces-12376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FCD20315
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 17:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8773630EB093
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789153A35B3;
	Wed, 14 Jan 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kAYhrAkj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2413A35A0
	for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407480; cv=none; b=XCO33u5MWBBPomXUasbA9a06gQs9WBPrD0eihTxRg0ZsIuTq+8b5ELxoeQ0h2EDUufXEHQKdzNOwpksk06VuXNHODS62izViyQ1Tu9DWuE06W9o9gt42p7KU2TUf0v1r45Pqzoy5MSskFXC7avsi4vj6nuhV7aokpxBlvlo/d3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407480; c=relaxed/simple;
	bh=uJ3orzaCZU3eAY5ni6VvmOYdUvquBH5vGX6sN6lP9cE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRemGam20qImSPmJdE8vhdkxz+j7dal9EWWNTNGlkTHXus4OSATLImS2BSLOsoF+t4HhPp7tCOwgZV5t5lcB0I4lA8jYt0544Pp78TzHqBq2ROHZRkvxB9YIJnanshixP2YKXnZYLJdpQ1nQaEBE8l48PQ5Z5ZaYIuLzxcaFdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kAYhrAkj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 250BCC1F6DB;
	Wed, 14 Jan 2026 16:17:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FB1C6074A;
	Wed, 14 Jan 2026 16:17:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40F4910B6828D;
	Wed, 14 Jan 2026 17:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768407475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kqlu/Go4zKkBAxvMQsNKsuLb9+tzbw0LkGCoi2mwHew=;
	b=kAYhrAkjiy4XZt+odcbfsystw9MvS3g5f+5WGi68laO5+CcYkzVnnWnXZYAo+Gg98DYKNZ
	YVZNeDnK5BGBZb5rZDZBB5nGL+ttLrFhKi9rs/FtFeU1bwkWo3sipA07Kijc7bmfQfhuOw
	yrfpgmBLRZI3nevzIo5NEnm7xod8FKlBXxDhrnNf2lXhyloRhxqHSL0ZK06qrPSRws4ydz
	vr7w1sXUrsNvVbURS3qGTdEbimq6UqVHLoY23Re+k3RfuXs1nb/ETetPQYEibG6s81C1L7
	az4obbAwpRfhgSniEM38AB4Lp5hsN9o0+sFkhNin82Rby5706/0zyBMJZb9M9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush
 Yadav <pratyush@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,  Santhosh
 Kumar K <s-k6@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/27] mtd: spinand: Octal DTR support
In-Reply-To: <61a547d0-592c-4cf5-ae4f-54456b08e83d@sirena.org.uk> (Mark
	Brown's message of "Wed, 14 Jan 2026 11:25:32 +0000")
References: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
	<61a547d0-592c-4cf5-ae4f-54456b08e83d@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 14 Jan 2026 17:17:51 +0100
Message-ID: <87qzrsuq1c.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

>> This series adds support for 8D-8D-8D in SPI NAND, which can already be
>> leveraged without any SPI changes as controllers already have this
>> support for some SPI NOR devices.
>
> The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f0176321=
93:
>
>   Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/sp=
i-octal-dtr
>
> for you to fetch changes up to 8618271887ca10ac5108fe7e1d82ba8f1b152cf9:
>
>   spi: spi-mem: Limit octal DTR constraints to octal DTR situations (2026=
-01-12 12:40:30 +0000)

Thanks you very much! I will wait a bit more and eventually merge it in
mtd/next before applying the rest of the series.

Thanks,
Miqu=C3=A8l

