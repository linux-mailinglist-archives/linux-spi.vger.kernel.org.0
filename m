Return-Path: <linux-spi+bounces-12429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76264D2EE94
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E95304815F
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573003093AD;
	Fri, 16 Jan 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xvKIVUAP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB23570DE;
	Fri, 16 Jan 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556381; cv=none; b=P4nuuFyBnCwTVAXyQ7viXfuYdPh545MGnvhMoQHXpKg5UAA4ZeDs1ubBZL/1sMfn6UuTEfXuhUW/Dtqb3hr3sQrFmZ+OVljT8FfcOdjN74ODObtr2JutDMLMu5MsPdvEnoLM52OtYBBCIGlMo7pDBEOlXn4P74YEUnnNwU0L3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556381; c=relaxed/simple;
	bh=H4C93+ZkMlEb9XBNw7sh62YR21svyKRXCLFCFhyWbKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFAovvEDsMPXlhTxbhRKk0oQUgVxrk3KaHpKcMAdgxPS8NyJ2YQGlrGR5Ktec30bJNoTKs9l11tOBNAchIKYFEM3fzMF812TEvFH1SOk5b44WDQW9UlwmvdBXTGKu8xZKy9QGP1scEaB7LGE2cUNNhzli1XAE4GdCu1hdZf48KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xvKIVUAP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DE4CF4E4210C;
	Fri, 16 Jan 2026 09:39:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A79A060732;
	Fri, 16 Jan 2026 09:39:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B17710B689BF;
	Fri, 16 Jan 2026 10:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768556365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XbjH9k6hR0+iNn4Dne3Q+OfRp0UCb6RwciWCvMKXMy4=;
	b=xvKIVUAPciMGwCewA/6ieUoIy7fzfhjJ1w6NDwLhr+bGIxX/bbAYInbTZmkXQD6g5tVpDA
	+KIe3T8ndr86GXpGqtLpj4aoYERAF8rMr/rj7m3n1ULsRrXmFYNsPS1U+SRLl9Xn52/rcZ
	Jcps/r0XbjbWq2bK9FLQ8wKrCRPuEoWE+co4P0cebTRDPcQdNaIriGeV5deZurLeywOh1S
	F6xt88Z2GOt5EsWWB2vzGxh4T7fq2XGPMxxCrFixRCpil4riCLvNGMbt0HNNn9th8zK6kA
	A6FMpAkn1Dcatoj6HWMZ1HWOjSSjqgMBF2x08/wFQA49sLZ5pkk1Bi1BNO294g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
In-Reply-To: <CAMuHMdW5hwNu-07-7xvyWdcGKUZy+pCX0=W=JNgd4h7m72wQFg@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 15 Jan 2026 13:45:39 +0100")
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
	<20260115-schneider-6-19-rc1-qspi-v2-1-7e6a06e1e17b@bootlin.com>
	<CAMuHMdW5hwNu-07-7xvyWdcGKUZy+pCX0=W=JNgd4h7m72wQFg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 16 Jan 2026 10:39:21 +0100
Message-ID: <87qzrpucae.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Geert,

>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -80,6 +80,10 @@ properties:
>>            # controllers are meant to be used with flashes of all kinds,
>>            # ie. also NAND flashes, not only NOR flashes.
>>            - const: cdns,qspi-nor
>> +      - items:
>> +          - const: renesas,r9a06g032-qspi
>> +          - const: renesas,rzn1-qspi
>> +          - const: cdns,qspi-nor
>
> Doesn't the need for (at least) the CQSPI_NO_INDIRECT_MODE flag mean
> that this device is not compatible with cdns,qspi-nor, and thus the
> cdns,qspi-nor fallback must not be used?

I understand the question. It is true that I use driver data to limit
the number of features the IP can use and this data is associated to the
Renesas compatible, but I believe all other flavours of this IP would
also not work without driver data attached to their front
compatible. None of the SoCs with the Cadence QSPI IP actually would run
without their own driver data. For me the fallback compatible is
relevant because it describes the hardware as "this is a derivative of
the Cadence controller" (and it is clearly the case, and this is also
mentioned in the reference manual), even though I agree using
cdns,qspi-nor would definitely not work alone. But again, none of the
other flavours would anyway.

Thanks,
Miqu=C3=A8l

