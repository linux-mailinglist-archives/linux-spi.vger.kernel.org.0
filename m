Return-Path: <linux-spi+bounces-11361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A89DBC7076B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D55BC4E12DD
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28448327BF5;
	Wed, 19 Nov 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P4ptOHLo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7132EBDCD
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573021; cv=none; b=IZjQ/Kw3NRPp+RDuydXu0klsIkTbjHUXVnP4oe8w0+Fu7wEsh6G4XPycdJQCCSQpNaQM9SsniKmZ38GVUHDMzcASybfUGKqwQl0eBs+HwCnBv4g06yc0Q6GtHAe9QsoiZa95XnfoL0MQb+w/3rmBQGipdUwpLc8YcI+t+BK+Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573021; c=relaxed/simple;
	bh=aTcdmuPtkB7O/VmPyaQ9fJhDEvgojoMOoSylw2eoltU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rh/kczxy4hoCdQgxlXP3hwyG/Uri+8ojB9n7DIrWWXHZcGNDm3Kh+m1QhDLf08392fUB2R0D2Y/0Fnb5IPMqcxc5hVPRCqWxTwOdnmQwuhsVDKVkBy4eP+9LhMzejqbyS6c6lTOz6mUosoAMI7OsE7fW3hAXye8qhZmiR9l7Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P4ptOHLo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F184DC1118E;
	Wed, 19 Nov 2025 17:23:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 32F4860699;
	Wed, 19 Nov 2025 17:23:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0634010371739;
	Wed, 19 Nov 2025 18:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763573016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ap5JC1XuMG5qWhNHsUmg784wgr5oepd+e+ozuOEXcvo=;
	b=P4ptOHLo9QWH2oNTPhAJNyhbw7BX+0d/Qm6C27Ot5p9YdjAAMnku2ICzPEINmJw0WnH6sR
	4IOC6+9cFx5iZe3IZx0v7VhBUCYWADYSSNt6lZ6e9yNF/60oE6jHQRBp+lAamKb+8k9Lfj
	sijXUkA1H8EdJ4JNVnRhO58HZlVqXnPDehDxA9HxdNwr3sXi/YxSwazAuZC1AXVUtCRIlj
	xpFuOrE4n9bixVNsMAXP8JmrlNTOuEeO0Jp71Pj+myeoA7bg/5Tvui3aKhhDG8UaokDmhC
	f/qsxHeXSeqZlbVlpNgv8XpyDpOUUanT/r0ePfOueOJ2XpHSuCVmdHxALgGnIQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K <s-k6@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 10/28] mtd: spinand: Make use of the operation templates
 through SPINAND_OP()
In-Reply-To: <5680a2a8-aeb3-4274-a264-4ff658cc9246@linaro.org> (Tudor
	Ambarus's message of "Wed, 5 Nov 2025 17:28:29 +0100")
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
	<20251031-winbond-v6-17-rc1-oddr-v1-10-be42de23ebf1@bootlin.com>
	<5680a2a8-aeb3-4274-a264-4ff658cc9246@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 19 Nov 2025 18:23:33 +0100
Message-ID: <87jyzmaqcq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 05/11/2025 at 17:28:29 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>> index 4afebaf5f0195b9bc617ea1f125f637f76fff9f8..a8fd04a67cfa9925bd68c575=
39d86e0816b76274 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -701,6 +701,93 @@ struct spinand_device {
>>  			     unsigned int retry_mode);
>>  };
>>=20=20
>> +static inline struct spi_mem_op
>
> Do we still do inlines?

Defining functions in headers like that, I think yes? (static inline,
not just inline). The full line is something like:

+static inline struct spi_mem_op
+spinand_fill_reset_op(struct spinand_device *spinand)
+{

So it's not an inline declaration of a variable, but the definition of a
function (just saying, in case the diff mislead you).

Thanks,
Miqu=C3=A8l

