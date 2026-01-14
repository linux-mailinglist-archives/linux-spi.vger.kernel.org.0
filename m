Return-Path: <linux-spi+bounces-12373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA9D1FAEC
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 16:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CF863088DDE
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48931B837;
	Wed, 14 Jan 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T89fDu0t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4231AF31;
	Wed, 14 Jan 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403689; cv=none; b=BWx6RmNCAmeM93Hmpp4mP/La1Jl/uFNDFjtbeB6XDO5UHlkKATk5k6K9TxZ/VCyq1ZSMn5QIVY0f/DGE8Ey4Hq/SAHOYobyGuRP/Ahfhk3R3XkRMgVB7QGeiQl7LaTTHk4ykpZVDJ+TF0rer6P3GGDg4eumdhZZMm0DptrGnj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403689; c=relaxed/simple;
	bh=1KA4MtqEpdNoc9BFqx/EY3In7xHttEjaWDdNRY45EYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYAL709YwUbVwDXBphpkrxJTGjznOLdZcbbhkwOTes6QCpPfkxVG6Beo11pe65+w0kVFuv29fEvEtU4A4kj7znnEQlWzdIW9Ayliy8wDjWMGA5rHxgrMUf3I+2/T/Qde0bvZ6MVAvSZlPg4e9PGOgPaYPfWjg+50O0GosQDk5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T89fDu0t; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 966801A2858;
	Wed, 14 Jan 2026 15:14:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 652E16074A;
	Wed, 14 Jan 2026 15:14:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6291710B68273;
	Wed, 14 Jan 2026 16:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768403684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/HPQSa6dGYoqrbjfrCxtwbHk+oGteX1ICb0IRX5s3xI=;
	b=T89fDu0tEuZ9c69TUrJjwxtXXLsYhRZxGm/DVR7oUaLnrLdARhL7KArOBCtTMxAp39O/Jj
	U5b3xsZCAt8iNc2nFdHKdxyJfdluzb1j5z0/aS9NBiTZTIpqTkzK02bHjOmLpsohUQB7GV
	E/1UVNE2QInEwM5cW7IXliH6vHn0L6f75IJ9mp/Djr23D55bqnSBQ9X3i598O1AtTARPxJ
	nV2rmBcRH4SVQKNYy9SSg6oCwRKrhD823AWyJGpnZ5cRJ3xipjFbUtUSF2kS6fRiI2kgc2
	pXmXf0o4BXAo5CF6Qom3rmSW1QJFUgPMKltX1Ob4upRYPo53oTqMk+pI9xviFw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
In-Reply-To: <20251220-sexy-feathered-gorilla-3a6aab@quoll> (Krzysztof
	Kozlowski's message of "Sat, 20 Dec 2025 10:35:56 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-1-8ad505173e44@bootlin.com>
	<20251220-sexy-feathered-gorilla-3a6aab@quoll>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 14 Jan 2026 16:14:40 +0100
Message-ID: <873448w7j3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 20/12/2025 at 10:35:56 +01, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Dec 19, 2025 at 08:22:03PM +0100, Miquel Raynal (Schneider Electr=
ic) wrote:
>> Add support for the Renesas RZ/N1D400 QSPI controller.
>>=20
>> This SoC is identified in the bindings with its other name: r9a06g032.
>> It is part of the RZ/N1 family, which contains a "D" and a "S"
>> variant. Align the compatibles used with all other IPs from the same
>
> I don't get it. I see only one front compatible, so what is exactly
> aligned?

Sorry, indeed the sentence isn't clear. The Cadence QSPI IP is usually
described using two compatibles, and the second is cdns,qspi-nor.

The way that has been historically used to describe RZ/N1D IPs, however,
is to use 3 compatibles. I wanted to "align" with this, ie. declaring 3
strings instead of 2.

I will change the commit log to:

    This SoC is identified in the bindings with its other name: r9a06g032.
    It is part of the RZ/N1 family, which contains a "D" and a "S"
    variant. IPs in this SoC are typically described using 3
    compatibles (the SoC specific compatible, the family compatible, and
    the original Cadence IP compatible), follow this convention.

I hope this is clearer.

Thanks,
Miqu=C3=A8l

