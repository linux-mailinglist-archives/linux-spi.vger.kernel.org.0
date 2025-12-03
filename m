Return-Path: <linux-spi+bounces-11745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73631C9E969
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9124346EC1
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5572DEA72;
	Wed,  3 Dec 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d89o6SPV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0202DA76A
	for <linux-spi@vger.kernel.org>; Wed,  3 Dec 2025 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755424; cv=none; b=RSb/QILpQv3EEF59wtBiWvpEqjStMwtObC1XXN+JpWXGsAxrtq5mu8ArQKUjd/ZQsUEoTMDz6rlSRgA4vKXAVkx2yyUb0y0Q2Rql1BGpPpE0kI0zapAgBzifJ4l56/Le6tgADJ9LMd0T+XTu+Xmqb6O7wXzGkpMPE+mIaMAVezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755424; c=relaxed/simple;
	bh=ZmaSmu9DGafoE7/fd7OBOhRpcxiWoFR3I+Q6xq/RNF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EIEXS9ySlgq3EsPjjVHWvg4XB8zYRG2xV/idS6fxzW2Chlggr8X7PhpaG/0YmpqU7vK7L5d0WbuDtagNcKp5uXBDOifo1jKzCcVN5jNcofgxdtMuhSDrU5uUsdHQHUWnkJYp3FZKh0xBHsSJNT2wAYrd/QPRJg0qvTISkqm2Esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d89o6SPV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2412C16A36;
	Wed,  3 Dec 2025 09:49:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3637B60706;
	Wed,  3 Dec 2025 09:50:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 411F411920314;
	Wed,  3 Dec 2025 10:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764755418; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bwV59Poqvr4TETkpzfKMM8Wo2Gkh86LU/Q3T3dW528g=;
	b=d89o6SPV3H8UwGn6tgVBA2/mYk+pxDiQAuMzVnhJM36IBfoxayPN3cWwAbKYoiXDBLzgGs
	6YFdxEIuw0wWd+bdS6rbXC3DDWSTGWvsMX5LbNUWN3BHtvYlgltchwOoaIifHyJEMD9zEU
	34CxwQXoPwOLh1c59fEdszpQB/rFWdiaIAvglgrGWeMm+Lb+AWF9tsGaLXDuxJ70qBEq0B
	2vFBpgbUhVoX2J8xuayyuhU5NKydMAmSrvsahoBAlvbITuXBgsAQZAOg5Rp0x8QeD7dp9Y
	3q5pKQaPhX0kepssvyQBErbERYG+HixhosZNBonmXOgcg3N22rEc0pxg5QJLfg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Santhosh Kumar K" <s-k6@ti.com>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <broonie@kernel.org>,  <tudor.ambarus@linaro.org>,  <p-mantena@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <a-dutta@ti.com>,  <u-kumar1@ti.com>,
  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <DEOH4AUI33SQ.DGKJ4W258658@kernel.org> (Michael Walle's message
	of "Wed, 03 Dec 2025 10:28:23 +0100")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
	<mafs0ikf74fja.fsf@kernel.org>
	<fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
	<DEOH4AUI33SQ.DGKJ4W258658@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Dec 2025 10:50:12 +0100
Message-ID: <87jyz3ao8b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>>> I think we should start with the requirement to have the pattern flashed
>>> already and figure out how SPI NOR or SPI NAND can discover that
>>> (perhaps via NVMEM?).
>
> But we should also keep in mind that certain flashes might return
> tuning data during the dummy cycles. I.e. the PHY might probably be
> tuned on each read and there is no need for any pre-programmed
> pattern.
>
> I'm not saying it should be implemented, but the current
> implementation should be that flexible that it will be easy to add
> that later.

Conceptually, yes, but in practice, I know no controller capable of
using just a few cycles every transfer to calibrate themselves
automatically and reaching such an optimized speed state as the cadence
controller is capable of ATM.

Despite the end result being close, I would still consider this other
way to optimize the I/Os somewhat orthogonal. If someone has some
knowledge to share about the training patterns sent during the dummy
cycles, I am all ears though.

>> For SPI NOR, we do not have an equivalent "write-to-cache" possible, so
>> we still require a pre-flashed pattern region. At the moment this is
>> provided via a dedicated "phypattern" partition, and its offset is
>> obtained through the of_get_* APIs.
>>
>> Regarding ways to locate the partition:
>>
>> 1. Using NVMEM:
>>     a. Exposing the phypattern partition as an NVMEM cell and issuing an
>>        NVMEM read during tuning does not work reliably, because NVMEM
>>        ends up calling into the MTD read path and we cannot control which
>>        read_op variant is used for the read.
>>
>>     b. Advertising the partition as an NVMEM cell and using NVMEM only
>>        to fetch the offset is not possible either. NVMEM abstracts the
>>        private data, including partition offsets, so we can't retrieve
>>        the offset as well.
>
> You can probably extend the NVMEM API in some way - or switching the
> read_op on the fly.
>
>> 2. Using of_get_* APIs:
>>        Using the standard OF helpers to locate the phypattern partition
>>        and retrieve its offset is both reliable and straighforward, and
>>        is the approach currently implemented in v2.
>
> I don't like that hardcoded partition name which is basically
> becoming an ABI then.
>
> At least we'd need some kind of phandle to the partition inside the
> controller node (and get the ACK from the DT maintainers).

Yes, agreed, this is controller specific, if we need to use an of_ API
(which is still not needed for SPI NANDs, only for tuning the read SPI
NOR path), it should not just be a partition hardcoded name but a
phandle in the controller node.

Thanks,
Miqu=C3=A8l

