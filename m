Return-Path: <linux-spi+bounces-8999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB8AF5DE9
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B4C520283
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAA2E7BB9;
	Wed,  2 Jul 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QYafDFnn"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B43196A5;
	Wed,  2 Jul 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471883; cv=none; b=Iqi4aumPPvewKhvpEfrjdAmLtDZ9MwXm73iAQ0oVTiey3h4inzB5cjMHkLqzn+w3zPWqmnORs9iOWKCdPFEj1Nf0UeprE0+QdEaxmQ9pZqrBMo2ChIcPJy4SpGaj9ocO5gSzXVnmVu3TjYfj5cj0yCnDkli4OOpI0Dlu3BU5bm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471883; c=relaxed/simple;
	bh=5hfDPZP3goEnu8Nns41kP0rSut7x+DAY1Oqm+6uGkYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrrW2mV9HreAfPtJEFp87rZzyn5revE5aw8aDGD1h636mIwxC8J6vJFLXcv4IE95lGNX2KRlb3APyCd4MrQTBNNDTfy48vFutitI6cDldBwoUdeNaLp4Wpnurj5l7b09kEWioCKdJtA7q92zGxbvcXc0J5v+sFpaNHGQ07sdkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QYafDFnn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90D78444EC;
	Wed,  2 Jul 2025 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751471878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hfDPZP3goEnu8Nns41kP0rSut7x+DAY1Oqm+6uGkYY=;
	b=QYafDFnnUxW8bTyChHQaAIDR1Gj+INHqaDrY+O6uONURspxRU0jM33avII/QtJREUyQNvd
	Ot+jpm++bzkwIBjz9K50HYhg9InxRGP6fXhJayrMp6TxTr6M4JRV8Orsrdcy04PVMc6JaR
	xAGNg1wN7ACBpzTRbhwlU/Fm5UZj0fQ5H0kwTpB0bWYVZbiRXG/XjCrx6Q4j5Io+fSXZ3d
	U2E504d9B/bIhotxffcPos/AfFDodSAXcgUGOOu3fvLWi2HIgiEPrJJAIhWJmX1/9boekX
	LzhswHqQoTnatOuSuxNdvxLGd5vHzdzaLUobgAL73mQcDGmIByC4KjhEA1+Ylw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Manivannan Sadhasivam
 <mani@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Md Sadre Alam <quic_mdalam@quicinc.com>,
  Sricharan Ramabadhran <quic_srichara@quicinc.com>,
  linux-spi@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linux-arm-msm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: nand: qpic-common: add defines for ECC_MODE
 values
In-Reply-To: <20250702-qpic-snand-8bit-ecc-v2-1-ae2c17a30bb7@gmail.com> (Gabor
	Juhos's message of "Wed, 02 Jul 2025 14:35:23 +0200")
References: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
	<20250702-qpic-snand-8bit-ecc-v2-1-ae2c17a30bb7@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 02 Jul 2025 17:57:57 +0200
Message-ID: <87ikkamvp6.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepqhhuihgtpghvrghrrggurgesqhhuihgtihhntgdrtghomhdpr
 hgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Gabor,

On 02/07/2025 at 14:35:23 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> Add defines for the values of the ECC_MODE field of the NAND_DEV0_ECC_CFG
> register and change both the 'qcom-nandc' and 'spi-qpic-snand' drivers to
> use those instead of magic numbers.
>
> No functional changes. This is in preparation for adding 8 bit ECC streng=
th
> support for the 'spi-qpic-snand' driver.
>
> Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

I hereby agree to let Marm take this patch.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

