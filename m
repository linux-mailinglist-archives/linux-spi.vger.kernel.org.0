Return-Path: <linux-spi+bounces-6393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA7A14B55
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E603A21FA
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D091F869A;
	Fri, 17 Jan 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bD1mE7xW"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55E1F754C;
	Fri, 17 Jan 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103318; cv=none; b=KNT1c8mayU4mXpDuhHK+AonO0NFRv+yyKHRygra6HBUnQQE515tyN5OxOqlmRQ8rC+tIBNqWGXN9f5PGcjGpgRfJn4TRkOtGDQOyNrDxwwJK71Row7vDwvazX450EwR38YYsoTZA0uOsnzIdwcxejl77r06XlyU6ZlSz3i6y8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103318; c=relaxed/simple;
	bh=Kcl5enqdMRs2CcCUSEWlMdhrMLxz2lYAT03H+4IXJe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USv/ofnZgN4dL4ZODgmQPZgpMXMrUz61XrLME4Se4CSJmvhauBaPysOomfbEx711dDGtcY7rpOBR1OaDJB8b6zpTqZYagGrbN3RrA8BgHMxZpvcr1xnc1W5TUeb8qwetgz2bBTDrG7K5wBtjQuQraU2DZ8Q33cr9MquBW+itm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bD1mE7xW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DC8720007;
	Fri, 17 Jan 2025 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737103314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcl5enqdMRs2CcCUSEWlMdhrMLxz2lYAT03H+4IXJe0=;
	b=bD1mE7xWSpji0DUI9yntuT2z/rWkqL5VDZiXqzQ6jsFebAR5dFYsvPSLLXV2ehXF0+9a0p
	uNNu/0gWp2qWm6Z3Rm7Q0moY+mfd1g9wHLDIC1yAZ7kpJfrssbDvNLiB51KYvrHMW0wlzE
	njP/UoLCmpskUNh478LQPRZHazsvjPifIK6FbMg+y47p10QnaZCBQgbEjGQRWLb0SbhCg+
	cWrrexKofbFlZ1TJr94q7lDO936lyd5tX9zHotLNOOQqWEyj7HF0wCDAEFL9nusgOhh0Kk
	O/3w03fTK1TrPAM2Fhdvcva0+kYICDtoxj+YuHDIetnVh3eeczZVPEaCr/IO+Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Mark Brown <broonie@kernel.org>,  Michal Simek <michal.simek@amd.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jinjie Ruan
 <ruanjinjie@huawei.com>,  linux-arm-kernel@lists.infradead.org,  Amit
 Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH 4/5] spi: zynqmp-gqspi: Allow interrupting operations
In-Reply-To: <20250116225521.2688224-5-sean.anderson@linux.dev> (Sean
	Anderson's message of "Thu, 16 Jan 2025 17:55:20 -0500")
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
	<20250116225521.2688224-5-sean.anderson@linux.dev>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 17 Jan 2025 09:41:53 +0100
Message-ID: <87y0z9j0ha.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Sean,

On 16/01/2025 at 17:55:20 -05, Sean Anderson <sean.anderson@linux.dev> wrot=
e:

> Some operations (such as reading several megabytes of data from a flash)
> can take several seconds or more. Users may want to cancel such
> operations. Allow them to do so now that we have a way to recover.

I fully agree with the observation, I tried myself interrupting too long
transfers with another spi controller:

e0205d6203c2c ("spi: atmel: Prevent false timeouts on long transfers")

But there were issues reported, so we limited the signals to SIGKILLs:

1ca2761a77349 ("spi: atmel: Do not cancel a transfer upon any signal")

But jffs2 plays with sigkills, so for spi memories it does not work
well, we had to revert:

890188d2d7e4a ("spi: atmel: Prevent spi transfers from being killed")

Same thing was also observed on Zynq7000:

26cfc0dbe43aa ("spi: spi-zynq-qspi: use wait_for_completion_timeout to make=
 zynq_qspi_exec_mem_op not interruptible")

I would however hint to use a specific helper for deriving your timeouts
if you play with spi memories, because it is interesting to adapt the
values nevertheless:

d8e4ebf870187 ("spi: Create a helper to derive adaptive timeouts")

Thanks,
Miqu=C3=A8l

