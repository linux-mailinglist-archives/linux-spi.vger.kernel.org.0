Return-Path: <linux-spi+bounces-8224-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EDABED54
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47BE1BA3AA0
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43F2B9A9;
	Wed, 21 May 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kEtrPH98"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5117BD3;
	Wed, 21 May 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813957; cv=none; b=g342wWcQgOune/y0hVcgMYi7Oll0oFZ7vmxLMw5UwuIOP3xf5Kni/ZCO5NrBwlLG/IkBdPMEylUmm3M0blhB8bnjLXLOy0AESnJwKkpJl0NaCNbcOYpTl5JcW8lGONG/JBn8BnmHnMQjNRa+u1uZNvyteQK+5xpRcL6oacHQ9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813957; c=relaxed/simple;
	bh=rq+bsMJzZLsRFWFAZdDWQYndSV6J+iIZHa5Soo+xpDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpyPRVvr74nYc29QAhLGFmYidIJPIfAWKXNMNdyZHAtAMFoV7+F7VYypGethIR4S8rpIZhv2OW82UURrVnKxaOqvsb8BJRzOtLfpHkfpDKInfmH8CPGErADylBz6HDhBdV3xLCXMQcrEqJGqec/krCVd2ObKPwp8NizbDIvjPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kEtrPH98; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7CB443E3A;
	Wed, 21 May 2025 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747813952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTX81h9G8aXD+7JUezIJElO7ofVmpUIJ9dOvTE7EZYU=;
	b=kEtrPH98gylBd4+JZ89TFaO4BcZthV9Wte4mp9eciEjpkdsnOFEF8MSv4ePIb8dfiQGS7H
	qKQVtn1ytcQT64zRU7moFryKdbHsJTIJfmg1WoYBwB66fOWVquEW+y4Xe213lo/2gH+Kxr
	NyBl7ZEpb2xzftcO9W7Me8ix1yX9tic+NUdZL0XWl16tQC4Cso9JSg1X+tdfMUDQN135LK
	qOr/YuP5KTErCd+EeS7lx5tS6xF7eL6ogeVKumVPyXpUc6BB+FYEiX1BYCIT/pLkPpkvil
	xZqE/cU4JyQnGJFuMsj07dRw9EfpQSTe7b9XABKFNrN1WcPt6FQJ1cdK5Ge7tg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Gabor Juhos <j4g8y7@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  "Varadarajan Narayanan" <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  <linux-spi@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits
 ECC strength
In-Reply-To: <e9f460c3-a575-1014-cca7-27f1d79024e2@quicinc.com> (Md Sadre
	Alam's message of "Wed, 21 May 2025 11:08:02 +0530")
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
	<20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
	<8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
	<c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com>
	<878qn2nsa0.fsf@bootlin.com>
	<16195524-1f31-4968-a3fd-f3d24f1c4223@gmail.com>
	<87msbhezjf.fsf@bootlin.com>
	<007881c9-e03c-1473-d8eb-53fbad8c6a8e@quicinc.com>
	<87frh4ej87.fsf@bootlin.com>
	<e9f460c3-a575-1014-cca7-27f1d79024e2@quicinc.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 21 May 2025 09:52:31 +0200
Message-ID: <87h61e8kow.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvhedvucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhou
 gdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 21/05/2025 at 11:08:02 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wr=
ote:

> Hi,
>
> On 5/16/2025 7:44 PM, Miquel Raynal wrote:
>>=20
>>>>> Interestingly enough, it reports the correct number of bit errors now.
>>>>> For me it seems, that the hardware reports the number of the corrected
>>>>> *bytes* instead of the corrected *bits*.
>>>> I doubt that, nobody counts bytes of errors.
>>>> You results are surprising. I initially though in favour of a software
>>>> bug, but then it looks even weirder than that. Alam?
>>> I have checked with HW team , the QPIC ECC HW engine reports the bit
>>> error byte wise not bit wise.
>>>
>>> e.g
>>>      Byte0 --> 2-bitflips --> QPIC ECC counts 1 only
>>>      Byte1 --> 3-bitflips --> QPIC ECC counts 1 only
>>>      Byte2 --> 1-bitflips --> QPIC ECC counts 1 only
>>>      Byte3 --> 4-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>>>      Byte4 --> 6-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>>>
>>> Hope this can clearify the things now.
>> o_O ????
>> How is that even useful? This basically means UBI will never refresh
>> the
>> data because we will constantly underestimate the number of bitflips! We
>> need to know the actual number, this averaging does not make any sense
>> for Linux. Is there another way to get the raw number of bitflips?
> I have re-checked with HW team, unfortunately currently there is no
> register fields available to get the raw number of bit flips. But
> for newer chipset they have fixed this issue. But currently the QPIC
> QPIC_NANDC_BUFFER_STATUS | 0x79B0018 register bit-8 will get set if
> there is uncorrectable bitflips happened.
>
> For 4-bit ECC if 5-bit raw bit flips happened then bit-8 will get set in
> QPIC_NANDC_BUFFER_STATUS.
>
> similar for 8-bit ECC if 9-bit raw bit flips happened then bit-8 will
> get set in QPIC_NANDC_BUFFER_STATUS.

I believe the unrecoverable situation is handled correctly. What is not
is the fact that we care about the number of bitflips before having a
failure because if it reaches a certain threshold (typically 2/3 of the
strength) the upper layer is responsible of moving the data around to
avoid loosing it.

You need to identify the hardware revision that fixed it and provide a
warning otherwise, or at least a comment in the code...

Thanks,
Miqu=C3=A8l

