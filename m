Return-Path: <linux-spi+bounces-8356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13504ACAFC7
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841DB1BA2157
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A39221DAE;
	Mon,  2 Jun 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SicAoHRQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8374221DBD;
	Mon,  2 Jun 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872454; cv=none; b=OEL8ga0Q717cYrkadZMiF9CwY7gDWaK4m665u2nr9vzYYLEd8ySk5kvg8yPe+Hku8tw+MeLT8yxQSx0IzM098lSH7WwQ7YSE9L1mCjQMDGI+lbvS+T12qbbo1CNPerJvOPr5sfyoZ7ufKwKX7M9V9wlzxsbdUNrvZT286v4h/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872454; c=relaxed/simple;
	bh=GM8Iv62t/e7wzoRm7D/cIuSzUvdjCu/Nb9piOAa+4fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQLJnTnRrAslbL/GuvGF5af4jOg8trr5LFQJ1yeHVOrUM7ZWYh7uFQgTN70qhDuZ1W++i9ZzyfOMxozD9d2E1J8XjDjiECApShP0uDD1D2okjc+FUn0ntF0Zf7Ur22zq9+9znHr/+ZPYMeXQwjfjYXLLL+FqwXim+0uaGaWqirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SicAoHRQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C652443B2B;
	Mon,  2 Jun 2025 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748872450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GM8Iv62t/e7wzoRm7D/cIuSzUvdjCu/Nb9piOAa+4fY=;
	b=SicAoHRQay2/kdWNB+eB5vNr794qZnTGuUj6PDJFXO1afRnUw5K1nuSyVyXuMLeqbuNe6Y
	F4KdCRmE/kqPfSzsxV1BQos8zRLDT7gIHk/AKpAqal4rd0bBO6MfP3wDjO/cXibnRgjeJ7
	jV8ZyQJO63IDklIgZGyzlsGPWKdpKZbrFrsBxHPaPRGwEw4G8zuO1brEbqtqrinBmYouu1
	vUNt/axtVE/Vp8Gh8D8ApyCQlgMFlv4zG5ypWQy67AJ6JZg50Lufo16GSW4cDHt+RpQgHx
	YQiR0K31lf0l7zCH2/muip5oq1fuMBCGrFm20PC1TWDFxbeh0RUBJVFCeapf+Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,  Mark Brown
 <broonie@kernel.org>,  Md Sadre Alam <quic_mdalam@quicinc.com>,
  Varadarajan Narayanan <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Lakshmi Sowjanya D
 <quic_laksd@quicinc.com>
Subject: Re: [PATCH v2 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
In-Reply-To: <28db650d-a911-4df9-9ad4-f926ea0683e6@gmail.com> (Gabor Juhos's
	message of "Fri, 30 May 2025 13:07:35 +0200")
References: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
	<KuueBg3qliXMt9QN9kV_5_on2xJV-BEWZAsktO_Ce-Fq1iBAPCFypbYUVZxlV4LjF0AUZG57KqiXZZ3uefQrXw==@protonmail.internalid>
	<20250529-qpic-snand-avoid-mem-corruption-v2-2-2f0d13afc7d2@gmail.com>
	<68c54d56-3e44-4f43-8bd6-f6b7fa1f379b@linaro.org>
	<28db650d-a911-4df9-9ad4-f926ea0683e6@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 02 Jun 2025 15:54:09 +0200
Message-ID: <87a56qp7um.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeekgeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrhigrnhdrohguohhnohhghhhuvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrs
 ehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com


On 30/05/2025 at 13:07:35 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> 2025. 05. 30. 10:56 keltez=C3=A9ssel, Bryan O'Donoghue =C3=ADrta:
>
> ...
>
>> This one doesn't apply to -next
>
> It is because the series is based on the SPI tree, and -next contains ano=
ther
> change for 'drivers/mtd/nand/qpic_common.c' which comes from the MTD tree.
>
> It can be applied by specifying the 'M' switch for b4 shazam.

I suggest you rebase on -rc1 (when it's out) and resend to simplify
Mark's life.

