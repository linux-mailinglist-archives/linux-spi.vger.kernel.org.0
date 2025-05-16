Return-Path: <linux-spi+bounces-8178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173CAB9E61
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 16:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B248D7A2AEA
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A513FD86;
	Fri, 16 May 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WbVJvmqx"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60F135A53;
	Fri, 16 May 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404854; cv=none; b=S2EhycB+zVtb6kRYZABAev7yD6v4TL8psOaaZW0XxvphE2qcV71bNt9/iSbn+nQMpn50CffUwh/IgrmqFkIylZ2ZJG8ujbTYEocreu0nkl6qr5HzWDd0/P6ZWv1v/p4SHqAA2OWbaDIV1JM7NGcPK2IOkLpBhILjK8EhpQ1Lut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404854; c=relaxed/simple;
	bh=E3fcoFFmMIs5yprPO6Uymi4+DPTsHexOcpOpad3qr6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzho3FOXA1MEeNw/HXeK3OtpXgg2VCHDkAaJwTjPwpEQfTJhhvh8oqE9HUNt+QmX7JLzqag/zAfDoWqWO2yRrDTEcJjHoM7A8QDQK61HdwbDlmzWUIafDoD9tsgvONVDPo6QUE5T4GPxCaVawUGPZbOHNEQjD2N3msdplik8b6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WbVJvmqx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F38F43B30;
	Fri, 16 May 2025 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747404843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFxrTARUlK2wFNTl5JJRwfbFdvOaKS20BeXfCwf1OTM=;
	b=WbVJvmqx5SngaVM6UbdN+k9MvlZmejh+STd37xHqMa6/V80ztCv5TTyvQqSF2ZFbZuwKLG
	wqcf/iCEFmf8tLYq3LMumYMnGDFOseajphKL6i+k31pj7vzXlinRSTRo8CT9Z0F1SB40zI
	BHSk0xRU9k/soVzGY9kc3SAipmmXKrorQxSmg2aGvmDWSBguOJBCOn407tmRTQoOfqXv0n
	d9NWSnlxHF7WhTkWf8Qm1B+4bSnL3GejLkgtR1fC3GEQrtmP0adKgUX/P4EW0pMh7CgfPj
	NHTpSKDUXR1oQCOIhrvdO+6740uBOxG+S7nZM5LxV3WNBvF8uWtl1jPLG7wn7g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Gabor Juhos <j4g8y7@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Varadarajan Narayanan <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  <linux-spi@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits
 ECC strength
In-Reply-To: <007881c9-e03c-1473-d8eb-53fbad8c6a8e@quicinc.com> (Md Sadre
	Alam's message of "Tue, 13 May 2025 21:05:09 +0530")
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
	<20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
	<8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
	<c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com>
	<878qn2nsa0.fsf@bootlin.com>
	<16195524-1f31-4968-a3fd-f3d24f1c4223@gmail.com>
	<87msbhezjf.fsf@bootlin.com>
	<007881c9-e03c-1473-d8eb-53fbad8c6a8e@quicinc.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 16 May 2025 16:14:00 +0200
Message-ID: <87frh4ej87.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhto
 hepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com


>>> Interestingly enough, it reports the correct number of bit errors now.
>>> For me it seems, that the hardware reports the number of the corrected
>>> *bytes* instead of the corrected *bits*.
>> I doubt that, nobody counts bytes of errors.
>> You results are surprising. I initially though in favour of a software
>> bug, but then it looks even weirder than that. Alam?
> I have checked with HW team , the QPIC ECC HW engine reports the bit
> error byte wise not bit wise.
>
> e.g
>     Byte0 --> 2-bitflips --> QPIC ECC counts 1 only
>     Byte1 --> 3-bitflips --> QPIC ECC counts 1 only
>     Byte2 --> 1-bitflips --> QPIC ECC counts 1 only
>     Byte3 --> 4-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>     Byte4 --> 6-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>
> Hope this can clearify the things now.

o_O ????

How is that even useful? This basically means UBI will never refresh the
data because we will constantly underestimate the number of bitflips! We
need to know the actual number, this averaging does not make any sense
for Linux. Is there another way to get the raw number of bitflips?

Thanks,
Miqu=C3=A8l

