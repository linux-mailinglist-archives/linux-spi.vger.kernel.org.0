Return-Path: <linux-spi+bounces-7793-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17FAA0449
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BEC5A77FA
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA52275844;
	Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U3auC4Mk"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709F26F47F;
	Tue, 29 Apr 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911410; cv=none; b=fWJNBwD9QdlmFI08aLCbVlX5eutb5ksP6iySi1RlAdHzXg9mGMkgpremGc5KBuY1tFLtlNkXfJ/9am1Z7GEYIaeI6mViljGtPce6dz3fyFGmKLEhtru/Gkdcqjl3JOjYOW4tq6Flm2OtsyR4rKOGKKDA26Az/soAQSoQXGuIjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911410; c=relaxed/simple;
	bh=MhKCWuFVwH1hHKekt6v1rdT49qbUO4WZ7IDJ35etBfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3835WXCBlE2+P3AI2t8j9OHdTmGZizj3HwqkKRY28ppLEPSuySaEK2+xKGspNdXYReo/Eqm3quEgo9VasJ6PI+bTkSwPYirwsGNeBnmsoJqEI0V3jOa+cj4/DlEG2h1qmAIshlERyJK4piZbbWuzvFzICW32Kj7Iaq0X/vpxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U3auC4Mk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0AFA439CF;
	Tue, 29 Apr 2025 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745911406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhKCWuFVwH1hHKekt6v1rdT49qbUO4WZ7IDJ35etBfI=;
	b=U3auC4MkFKxqBoIXWhrDbWzpqYrdCu1xXAW1S/vyLJAVTKTfiqxY3NPU5EWUyvCfSJgOau
	9fYEjDPjRqINC3p+HPqAWg0KBVNBYkSHg93+eOaQrvRDLQ3tROkpTiXXdoggWSeN4NMlWb
	OR+DhzZH5SdAIWibj4YebT8L6reRIV0bOXQmT6BSkYgon80KDtm7wsNQFOnIvjqdGzoL4A
	lNgWZ7EQS4bem22N09kJNsYHYiV78I4b9IHtc3/ivjYksBTy3mYVNdFW0saPgYP2hrNLiY
	PMvWug7ZC5jUPu64qMfwPnx8O3C9GgPltLIoLChMk0NUGkKMfdNopaL0/RntQw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,  richard@nod.at,
  vigneshr@ti.com,  broonie@kernel.org,  absahu@codeaurora.org,
  bbrezillon@kernel.org,  architt@codeaurora.org,
  quic_srichara@quicinc.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mtd: rawnand: qcom: Pass 18 bit offset from
 NANDc base to BAM base
In-Reply-To: <bsj6kvqjo3pfbsakex5quamk5tkrtigxdcoyu5bj3nt37zsgc5@7h7zidzbcs7p>
	(Manivannan Sadhasivam's message of "Fri, 25 Apr 2025 13:17:54 +0530")
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
	<20250410100019.2872271-2-quic_mdalam@quicinc.com>
	<bsj6kvqjo3pfbsakex5quamk5tkrtigxdcoyu5bj3nt37zsgc5@7h7zidzbcs7p>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 29 Apr 2025 09:23:24 +0200
Message-ID: <87selrv3bn.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrddvheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddvheehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghrohdrohhrghdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopegrsghsrghhuhestghouggvrghurhhorhgrrdhorhhgpdhrtghpthhtohepsggsrhgviihilhhlohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhgthhhithhtsegtohguvggruhhrohhrrgdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 25/04/2025 at 13:17:54 +0530, Manivannan Sadhasivam <manivannan.sadhasiv=
am@linaro.org> wrote:

> On Thu, Apr 10, 2025 at 03:30:17PM +0530, Md Sadre Alam wrote:
>> The BAM command descriptor provides only 18 bits to specify the NAND
>> register offset.=20
>
> s/NAND register offset/BAM register offset
>
>> Additionally, in the BAM command descriptor, the NAND
>> register offset is supposed to be specified as "(NANDc base - BAM base)
>
> Same here.

I will fix these while applying.

Thanks,
Miqu=C3=A8l

