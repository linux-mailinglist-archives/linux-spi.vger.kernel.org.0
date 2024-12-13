Return-Path: <linux-spi+bounces-6049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49AB9F0B88
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A76282D71
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9A1DEFDD;
	Fri, 13 Dec 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ObR9Upkq"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A1B983E
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090251; cv=none; b=oMCTDp+zTFUww3L6hvQzHy8s6Z78YrNLl++bFgE3ozGYnXbLE0YNODvSZm62brZSLfgo5aNKs/ytnnQJNL6AS+NfQPi82KNl9b9LUVkeOH6AoYoKrfd+rrYSxD2nR02uJLuEdMZplEiu9ZKFWsJiByXFqqrdjzaGRJr73pV0jB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090251; c=relaxed/simple;
	bh=+7mATUIHkG8NZSamVn7nrNU4ZayJvQcaDK2lYNCVC+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RlOnxfrBiFSL0IurpF+bI+OQOxFTenu9l9QBjHiZX7smPxfKpH4Kwiv8IU022uy8BBAmkq0hWBf4+6YhsT1BAa/AevqqJOvl+gW5EJW91DOa9/DiUYDirO2xPDidbnsl2x1F5CTstk1ypysHMeUrNXl1i3Gn3s0fw2fAZqyBaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ObR9Upkq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4CADFF805;
	Fri, 13 Dec 2024 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734090245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7mATUIHkG8NZSamVn7nrNU4ZayJvQcaDK2lYNCVC+A=;
	b=ObR9UpkqoJddCg8QgXMN+prY1i85V/9FhmuXW31mQvqUSgrFM4kILE/bK9hcze6JrOxlDT
	U2WFnFNpAH/RHnKNVRJkm9FJDZMQF2gdbSm0pDyJnDH//es/bpmsG6XPHQMSjn81sadCvn
	kmHuFbca+zaweyOmhCwDAiLlcCHqgvSIpk6Yfn5Z7OOLfoqAWdLTK/BRufmSkSExqghzjn
	QxtFNMfmcZYJgLzz84ukBfO+kHpNRbloTBBYHLRuj1Fe7tCIj5rRBLjrGrNjpcKCXpPCbu
	3Y26TDBmwSk37J3b6cvxE8ZLIEN1o5QRjWU75mFeHR5Bk97pUCY+ANieMoAsgg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Mark Brown
 <broonie@kernel.org>,  linux-spi@vger.kernel.org,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 04/24] spi: amlogic-spifc-a1: Support per spi-mem
 operation frequency switches
In-Reply-To: <9e942bdd-6ade-40a7-ae4a-104ed288a09f@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 13:42:31 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-5-miquel.raynal@bootlin.com>
	<9e942bdd-6ade-40a7-ae4a-104ed288a09f@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 12:44:02 +0100
Message-ID: <87o71fn6yl.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

On 11/11/2024 at 13:42:31 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>> Every ->exec_op() call correctly configures the spi bus speed to the
>> maximum allowed frequency for the memory using the constant spi default
>> parameter. Since we can now have per-operation constraints, let's use
>> the value that comes from the spi-mem operation structure instead. In
>> case there is no specific limitation for this operation, the default spi
>> device value will be given anyway.
>>=20
>> The per-operation frequency capability is thus advertised to the spi-mem
>> core.
>
> I see the driver sets ctrl->min_speed_hz =3D SPIFC_A1_MIN_HZ;
>
> Do you want to introduce a struct spi_controller_mem_ops.supports_op and
> check that the spimem op freq is not below the controller's minimum freq?

I was about to do that but I think we can do better. I am already tuning
the max frequency depending on the op. I can just check in the default
supports_op hook that the operation max frequency is not below the
controller's minimum. So all drivers with this kind of limitation will
be covered.

Thanks for the heads up!
Miqu=C3=A8l

