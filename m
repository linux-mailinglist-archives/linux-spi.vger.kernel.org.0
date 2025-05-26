Return-Path: <linux-spi+bounces-8295-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E5AC3B50
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE87162B4A
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D71DFDB8;
	Mon, 26 May 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GSXFkOTy"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB66126BFF;
	Mon, 26 May 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247224; cv=none; b=kN0eASsWFs5GXYqlfscoffqADpY9QMBgvFF+gfZGDHsBKFA19GoPgsgltERHEo/kdF6DDjuuO20aXPPoxctshjK5SN8JLtiaQmaMZSTwy9SJnQvygApIjsuzvyvmKE+CChlDIhhf7Q3YKLs4omHk9oPO85Ymi+ZheByG3w3101o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247224; c=relaxed/simple;
	bh=uORZKIv+jWoyhEOoZVbHfLhvUmceHasoafLASmLyLB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYMX5XQJ5WGChzMANvMecg6r0DmM+V5isEZH8LNoBBt5WsDTMjT/jvQ5OihWII+VI2GI7ap8D09KEW1A+W5g1UzJEi1r1vRNL7vObzUfERLYK83sekcuGZGFfbkMcvnoBc5Beg8HRdhuDoxjmGyIlmVYaBUKhVt6LHBs7xEnw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GSXFkOTy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49AB6432E9;
	Mon, 26 May 2025 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748247220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkgd48Z0fU+G9rkmci+M6NLNIeowZJAaBi38kKpI/4=;
	b=GSXFkOTy/bPwBna80bRK3A7S6b3mQ+AVesQBtrPG37HgK95uhweCltEuc5zaZpIHH12Isz
	bTaikgUSgYB7xMY42Wo2O4BAU+Zu8xP0qMDfcc8h+LdRx+0GH6LbbzschM/rBy404ZyYAI
	U5ChMgTkEJS0H61LTNX6qGwf27MJDBLYmnBOzRN6BICHwvbZ1sHoLfxPGR472mtWBRrO8L
	16UqoF4kUa4LJGebsY0yfkXQereAoynP34DDGInSKFivas4mTF1B/Hr/O8xcuVx/SqF2TP
	xDFSa68fGAAneBXVz6uqRodG3rgs2DM0sbzUCXQx5vKDSpHa4b/UDa7AIYs2KA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Md Sadre Alam
 <quic_mdalam@quicinc.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: spi-qpic-snand: avoid memory corruption
In-Reply-To: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
	(Gabor Juhos's message of "Sun, 25 May 2025 19:05:34 +0200")
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 26 May 2025 10:13:39 +0200
Message-ID: <87r00b23ik.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujedtudculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgti
 hhntgdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Gabor,

On 25/05/2025 at 19:05:34 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> The 'spi-qpic-nand' driver may cause memory corruption under some
> circumstances. The first patch in the series changes the driver to
> avoid that, whereas the second adds some sanity checks to the common
> QPIC code in order to make detecting such errors easier in the future.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Gabor Juhos (2):
>       spi: spi-qpic-snand: reallocate BAM transactions
>       mtd: nand: qpic_common: prevent out of bounds access of BAM
> arrays

Are these two paches related somehow? Or can we apply them in
two different trees? If yes, please send the patches separately, which
eases our work.

Thanks,
Miqu=C3=A8l

