Return-Path: <linux-spi+bounces-8355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F6EACAFBA
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E8C17F02B
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06EA221739;
	Mon,  2 Jun 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kz2KEqCW"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B8222599;
	Mon,  2 Jun 2025 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872401; cv=none; b=RdkUifr3ESD54dxdDPeWqb9F8qFXWMrjUYjvDOkDTem6DvSO+DSr86cgNV8Jgsg6QW6v9X9SRQ51HCQSqQUqgKM0TjBj7OzVB7MAQw3/u++Ssig5gDi4+u76jDz5LCz+Xt+oxtTWfIeGpgNpLBeS8FJFw1jtIVQytjWeGQuX3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872401; c=relaxed/simple;
	bh=L8QI9OdfPlgHwfQ9J6Un44ynYONk5qngRt3P5ZSjTjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EBP4LjRrdUudy3aWCzwVBJZz2vRY8ZmPm9OkOwko94Eri6OF47aVZvdlUa3DHoD4VzgVFAxYSjV+jQIqlUNg+WutOnZfhqrt7Qe2wvf6Vd4Vwj38uinadJ0zkUY521Wo1Gci9F9WEZREy4tHXMK6upSlY6r8IHeT8q0SC0QHGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kz2KEqCW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E111143B27;
	Mon,  2 Jun 2025 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748872389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfIDQOstnIKPbNm8LZJHuQa/qFaaDg5YKgwC3Nw0u84=;
	b=Kz2KEqCWBYAgQTS9+r3JiPTGOAcMAHu4g7y0y4+oBJ+GwiZrC2BzraQHmNLCpMcwlQy0qT
	djZzCIHV+aBFGAhDkVTYHr9l5O3nq3Vn582LTBzNvIOQki6boLSSTtaHyLjVlivjaZgyEp
	VBqgxTVjeDHhrnckQOsFIYBsR1vuCyZg8wvXneqMIoInXEYVQVIVR6wPTfDGcgn5LWgE/F
	6eoy8jCiCqKt+vNlvLW6x/khuWCO2Xw4+SlifVZR7qWBzzE4phl4Y7D8kAgSpKrvwM0iQh
	RQbC9ztEj5uLcDKLCyCoNOncA9HLefyN3PwKpXZLOjKO6CBVnfu/Ftwm3LcAPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Md Sadre Alam
 <quic_mdalam@quicinc.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Lakshmi Sowjanya D
 <quic_laksd@quicinc.com>
Subject: Re: [PATCH v2 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
In-Reply-To: <20250529-qpic-snand-avoid-mem-corruption-v2-2-2f0d13afc7d2@gmail.com>
	(Gabor Juhos's message of "Thu, 29 May 2025 19:25:11 +0200")
References: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
	<20250529-qpic-snand-avoid-mem-corruption-v2-2-2f0d13afc7d2@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 02 Jun 2025 15:53:08 +0200
Message-ID: <87iklep7wb.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeekgeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesq
 hhuihgtihhntgdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 29/05/2025 at 19:25:11 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

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
> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>     # on SDX75
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

I'm fine with this patch going through spi,

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

