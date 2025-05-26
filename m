Return-Path: <linux-spi+bounces-8296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277BAC3CAD
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF60516A6A4
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955111D5142;
	Mon, 26 May 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EvXbi/X0"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31191953BB;
	Mon, 26 May 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251670; cv=none; b=tpcbrLmwG+Xq2P9WuNKbcaSVb5M+s4x940fCzPmUM/4hbCleWh0KsR3B2B/QYNXl7D5XZMIE9Ebj5z7MQRjIfMbnODmm0s13zfYPwEBgZ1ZGQ3Dc/qnZserr7EeLoa7LhONx6nXjN6uKKZLxOTUdo/kaV15wP+S0s2MbAtzrjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251670; c=relaxed/simple;
	bh=1WCyRDCwiBHfV+0OnoDGBfWHBhe1h1gVlMDuYJge3RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2P2DH5sCZVDQAj657UkD0Y65xvIB9LFdplq4Px30dSL4B1bZHHYL4UpVfJ9Hx/BI0KR1PuJhcCuFFAT/AzAKTJpaUwx9wlZSHmMUIUlq1VBo4ujcmPmtZDrVDR5XlBGAoM1+jnX0qASLO2afOZ64MYlx2p7iu/d1OPRAw28/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EvXbi/X0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F01B43256;
	Mon, 26 May 2025 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748251666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Opa0z6GUCpMMB0xKiw3CdjHTRvy78s9FU8V6fF56RAM=;
	b=EvXbi/X0RcTrPnKhu5//sNlbalc0CuLlG1QBS8zessNsqCpGsPkHpFbHUkBXMSBTyuiKjF
	nEbhvl7Sh9YORKhnBF3V5obwFFNFHQj0roo8LJN/Lk3Tt5JT/ARJiND67GqmYrZeScEeLn
	PfjEE/asaLQGu/+O0F/q0a6z6tBEk1JyGfl76ycOi/s7sqfk/+a+hr+9b0Tap1mCqX00jc
	2vsHMiNyOXQ4xtmXt7B0xeP4OvOZed7T+pPSvmI7EdEFYOgwnjYVlVejkeEz0Mj7P4CJ0H
	QO8YQbjuquJEbRBwabvQKcOM4bOd6beg7K133wAjF0s2GACKHrhPkeX38yKZ4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Md Sadre Alam
 <quic_mdalam@quicinc.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
In-Reply-To: <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
	(Gabor Juhos's message of "Sun, 25 May 2025 19:05:36 +0200")
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
	<20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 26 May 2025 11:27:45 +0200
Message-ID: <87cybv2032.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeduieculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgti
 hhntgdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Gabor,

On 25/05/2025 at 19:05:36 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> The common QPIC code does not do any boundary checking when it handles
> the command elements and scatter gater list arrays of a BAM transaction,
> thus it allows to access out of bounds elements in those.
>
> Although it is the responsibility of the given driver to allocate enough
> space for all possible BAM transaction variations, however there can be
> mistakes in the driver code which can lead to hidden memory corruption
> issues which are hard to debug.
>
> This kind of problem has been observed during testing the 'spi-qpic-snand'
> driver. Although the driver has been fixed with a preceding patch, but it
> still makes sense to reduce the chance of having such errors again later.
>
> In order to prevent such errors, change the qcom_alloc_bam_transaction()
> function to store the number of elements of the arrays in the
> 'bam_transaction' strucutre during allocation. Also, add sanity checks to
> the qcom_prep_bam_dma_desc_{cmd,data}() functions to avoid using out of
> bounds indices for the arrays.
>
> Tested with the 'spi-qpic-snand' driver only.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Preferably, this should go in via the SPI tree along with the previous
> patch. It is not a strict requirement though, in the case it gets
> included separately through the mtd tree it reveals the bug fixed in
> the first patch.

Sorry, didn't see that in the first place. Fine by me.

> ---
>  drivers/mtd/nand/qpic_common.c       | 28 ++++++++++++++++++++++++----
>  include/linux/mtd/nand-qpic-common.h |  8 ++++++++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_commo=
n.c
> index e0ed25b5afea9b289b767cd3d9c2d7572ed52008..fb1f81e4bdacaa3e81660a20e=
164926c64633513 100644
> --- a/drivers/mtd/nand/qpic_common.c
> +++ b/drivers/mtd/nand/qpic_common.c
> @@ -15,6 +15,13 @@
>  #include <linux/slab.h>
>  #include <linux/mtd/nand-qpic-common.h>
>=20=20
> +static inline int qcom_err_bam_array_full(struct qcom_nand_controller *n=
andc,
> +					  const char *name)
> +{
> +	dev_err(nandc->dev, "BAM %s array is full\n", name);
> +	return -EINVAL;
> +}

This is rather uncommon, I don't know if it's very relevant to do
that. Please drop this static inline function.

Thanks,
Miqu=C3=A8l

