Return-Path: <linux-spi+bounces-11358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0ABC706B7
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85B4734ADB9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D62EBB8F;
	Wed, 19 Nov 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2ND/s5Wt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522542E5B09
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572262; cv=none; b=PD5NPVuGo41Tq/NIV0UFVtIWr9VWX6Mk+td8Hnltj/8/egxhbh6qmI89/uJ3OZYSSBKnv5D02jzXgOeYRFXP+a52BD3jNaC72n9uEpopBPwyEmBVcq/hQ27nLNjaxglPX9F6hoyNp9xjHCP25X0jW2dRdKTvad9B5tKw3xR9Ptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572262; c=relaxed/simple;
	bh=wUAvFcKS9r8S05zRydDWn+L/PIwZV9MI4k8Z2gDpS+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4WtVqZBsO8FMkdiqbvV84dksuqHx96naMAWjXs+1RJQ5Xrjn67o5S42kiEZVYr9JLwSmRH+XF8WDMs3VS9FO6g1bzupQ3l42IdkcEOJPopRm1TvEbxpUXNavCGqlj/nwf/4S5XLMsfxIFr6RI9mfst2X4sKdZiipBrbtD1KhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2ND/s5Wt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 97BDD1A1BE7;
	Wed, 19 Nov 2025 17:10:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F4D960699;
	Wed, 19 Nov 2025 17:10:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3694710371A3F;
	Wed, 19 Nov 2025 18:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763572256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Oi3Rozw+0ipekAzwE82KlZd/dZ7LDaSEcV43fCc6o9Q=;
	b=2ND/s5WtAar8KGYiYT5Y8ltdrKn509ue/5mzCwr7Ju3OxIquegqIzPcs+lLikjkGu5xA1I
	yuj8RNIk1Hlez/fJEwxFQMxYGwC7dnrjTBr/dbaaxUbkKcx6ZJA4xRZRfUdoV8tCabTAWT
	ntkGo4AAqsWILdPONynj19MsiLqu7EkywX2tH2caZKfPuWw6ZoepT3bwkDdDHBEn7PUfcH
	9YbMvR9NYppFbIle7X62iSw25A8i8CfEhxeIT3z6Kp6pmiDGDWzJbJaimBxF9ftz9kNtR6
	viF786dVS1M7JQR1rDSGzw3J80uY8e9I0WX+kKdBEXb45MPVbalDYlZKYBDJPQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K <s-k6@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 02/28] spi: spi-mem: Create a repeated address operation
In-Reply-To: <0be97b27-4f8b-4d22-a653-154e87ecbc78@linaro.org> (Tudor
	Ambarus's message of "Wed, 5 Nov 2025 16:43:58 +0100")
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
	<20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
	<0be97b27-4f8b-4d22-a653-154e87ecbc78@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 19 Nov 2025 18:10:50 +0100
Message-ID: <871pluc5id.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Tudor,

First, thank you very much for all this precious feedback! I am happy to
get feedback not only on the spi-mem side, but also on the NAND changes!

On 05/11/2025 at 16:43:58 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>> In octal DTR mode, while the command opcode is *always* repeated,
>
> this info is wrong: opcode can be repeated, inverted or a dedicated 16bit,
> so please fix this to not mislead readers

I didn't know :) But yeah I had SPI NAND mind which was obviously
wrong. I'll correct.

>> addresses may either be long enough to cover at least two bytes (in
>> which case the existing macro works), or otherwise for single byte
>> addresses, the byte must also be duplicated and sent twice: on each
>> front of the clock. Create a macro for this common case.
>>=20
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  include/linux/spi/spi-mem.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>=20
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 81c9c7e793b6ab894675e0198d412d84b8525c2e..e4db0924898ce5b17d2b6d42=
69495bb968db2871 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -43,6 +43,14 @@
>>  		.dtr =3D true,					\
>>  	}
>>=20=20
>> +#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\
>
> I find the name too generic. This is an macro for 1 byte addresses,
> right?

Yes it is. The name mimics the "dtr command repeat" macro name. Maybe
you want to include the info that it is  carrying a single byte? maybe
"*RPT_SINGLE_BYTE_ADDR"? but that's a big too long IMO. Any other idea?

Thanks,
Miqu=C3=A8l

