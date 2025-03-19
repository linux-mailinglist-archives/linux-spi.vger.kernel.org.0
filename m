Return-Path: <linux-spi+bounces-7229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B889A69595
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF11719C30A2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAE1DF74E;
	Wed, 19 Mar 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ScccwaH0"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A831E3769
	for <linux-spi@vger.kernel.org>; Wed, 19 Mar 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403399; cv=none; b=f2D6vy/ooQP0SoY6p1xInmtBLjIjOUWiRcghfx85njaR2i1EEAvqxz/BkGwiNAhynRe8b0vNKxwg9Mgku8AhX/klmcxD8bkRhE+HW58iDjbteNiW34lahyAnE88p4aUtrzCiO7t1epHpYDe3Xa/LvPgprvHkP6LdiGr0f4jqHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403399; c=relaxed/simple;
	bh=Yt84NJ/eSw6CygyOHZNZzv7dUmIwyhxGz4t6WrXv26w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiDE7WdTj9kuXlQdJ8sEnN+96Fk8DfpbSEjXWRKZ7YJEcWTDl/ud6GDCuHmvaGoUL/zkyMZsNZpCJ3HFcHtFON+5EKAwiSObxepbxoYAJYVpvzS5QMhpNL3/CkGf5NZHWgR0hALEmpJV/dmqcKPDEjEa3awH4siQQkTEn8fEqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ScccwaH0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B0CA442B9;
	Wed, 19 Mar 2025 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742403390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tBHTPJtc4q7iOUGo1uSOWAgMdyAPJbAfPsRX0QpsnQ=;
	b=ScccwaH0hlQaINLb2+vRKeyDPlCwM1mcSdAmHf5YeDIMKCB8/p9tCh3qlVGooOe5zH7dZG
	4iJQrX1rjPdy1WGe2OHwJiwAx1yUFhVmRuDi2iRSTQEo+OUMpZqSuLeHdbTf/NtokPtGzi
	26h1TBfZh/TdS+NzgOGYDNpM8vu2/tH0elmYNYgkWdnJfF30tnPpD7ifarPw4BNkDf87Wf
	Lx/6fbWIpEKrtc+exT3QQqWUqxpyMDCKyldtWNgoFq7Ny6JKzWDjtZKf2VoqE5Dsj1ZrRN
	U0bT75MFntQ6YwrfLvMta5MMqHWdS4gWclpjva9U4gEZZHvzUmMdT4fa3/obMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  linux-spi@vger.kernel.org,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Introduce a default ->exec_op() debug log
In-Reply-To: <ce648080-2964-40d2-a2a7-cafcb6592cd1@sirena.org.uk> (Mark
	Brown's message of "Thu, 13 Mar 2025 22:27:54 +0000")
References: <20250305201140.2513431-1-miquel.raynal@bootlin.com>
	<a073191e-afab-484e-9659-66b957301db1@linaro.org>
	<ce648080-2964-40d2-a2a7-cafcb6592cd1@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 17:56:28 +0100
Message-ID: <87h63p2c3n.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepphhrrghthihus
 hhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Mark & Tudor,

On 13/03/2025 at 22:27:54 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 06, 2025 at 09:05:39AM +0000, Tudor Ambarus wrote:
>> On 3/5/25 8:11 PM, Miquel Raynal wrote:
>
>> > --- a/drivers/spi/spi-mem.c
>> > +++ b/drivers/spi/spi-mem.c
>> > @@ -377,6 +377,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const st=
ruct spi_mem_op *op)
>> >  	/* Make sure the operation frequency is correct before going futher =
*/
>> >  	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
>> >=20=20
>> > + dev_dbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%dB
>> > dummy][%4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",
>
>> Isn't this too "chatty", especially on page program ops? I wouldn't be
>> surprised if the prints introduce timings that change controller's
>> behavior. How about using dev_vdbg?
>
> That, or covert to trace_printk() or even better a trace event - with a
> trace event you get really fine grained control and extremely low
> overhead.

I do not think it is too chatty, this is typically a trace that is used
when writing the basic parts of a spi-mem controller. Myself I already
wrote something like that twice, just because during the initial
writing, performance simply does not matter.

Regarding the fear that the chatty log could have an impact: if it does,
it is likely a bug of the driver or a severe controller limitation
IMO. Anyway, the point of having a _dbg call is to allow
enabling/disabling the log if it is too time consuming.

I'd say that for this particular purpose I do not thing that trace
printks or events would really fit. As a developer, I'd definitely
always change the function calls to some direct printk calls in this
case. The verbose debug alternative seduced me though, so if that's okay
for you, I'll switch to dev_vdgb() as suggested by Tudor, which honestly
feels like a seducing alternative.

Cheers,
Miqu=C3=A8l

