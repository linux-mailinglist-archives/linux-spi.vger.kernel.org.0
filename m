Return-Path: <linux-spi+bounces-12371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA17D1F916
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F177830146DA
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A030E85D;
	Wed, 14 Jan 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZmWypcq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB630E839
	for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402673; cv=none; b=r9K5o/kCyp0nNvK7K/hHDc8Xc6IjbHInFVxdQ0qiDUnFEghJGjp4nAI8t2Uj6JSxgHpUTODXfxyBPDMm+fpt7miE6CGTJSMiPOxsYaxhcTiPvGdJd6vLpGTY70jLv3cvkrtmtL3LR7MeAG/haqJwhG4PmA02sa1ZJf5lUDlRRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402673; c=relaxed/simple;
	bh=nmUrIBbrvEJ0xHsjaFEh0gYKvpLXTEy/itkXA0JyI74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQBAxM499zUp7KwDEUM8QntlvP+jYWDrfHugHZYl9dY503BolRLkHi4MLkGg86U8qBzBeAIb8WYqMcURXyPf/Uusi3/kEq8N2i1sGywHbwBzVOhl6b5q1szag35/i0q8sfHJ/IQIhFdc8qbkBkwPZoH7C+UbdfosQlTOtblrhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZmWypcq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1B861C1F1C4;
	Wed, 14 Jan 2026 14:57:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE5C26074A;
	Wed, 14 Jan 2026 14:57:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2858310B68265;
	Wed, 14 Jan 2026 15:57:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768402668; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r1j2W7fLaN75ysT9kcrcB6wEZb9WQOiNcbJymTXioUg=;
	b=KZmWypcqb11mMoEL7UWMWRDYg9XiW+BQOHiui3nAMVTgOjeJ4eIwvJ/eBYvkih9kH+Gv7o
	B6ZBmRUCbVbfZYJ7ScqSD+ooxoUB6FvHp7vtdfUC0/giw/rqf7OJsUXAm/SrpLT6aPD/Fw
	4AwvnYr615T27i9KAsLbjqBs2tkhVG/sja0ToJ7eEUHNRxCLAmJwbeTysNCgCq/4piq9Pj
	sQKuFRtJGRrTHkCnIqcClDRKGKU5WgUFEz3eCfqqCUyCX6VI6YfOhKKtITnNlX4OK2sduD
	FYzcvtWpL6EWiaTqazSu05WmDlFICl6Fhs6gPFT4nXpAv1o1XNSG9pCa3GlWOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  Mark Brown <broonie@kernel.org>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav
 Achath <vaishnav.a@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  =?utf-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Pascal Eberhard
 <pascal.eberhard@se.com>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
In-Reply-To: <aUZ2tbK8fMoY4AZ9@shikoro> (Wolfram Sang's message of "Sat, 20
	Dec 2025 11:13:09 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-1-8ad505173e44@bootlin.com>
	<20251220-sexy-feathered-gorilla-3a6aab@quoll>
	<aUZ2tbK8fMoY4AZ9@shikoro>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 14 Jan 2026 15:57:45 +0100
Message-ID: <87bjiww8ba.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 20/12/2025 at 11:13:09 +01, Wolfram Sang <wsa+renesas@sang-engineering.c=
om> wrote:

>> > +      - items:
>> > +          - const: renesas,r9a06g032-qspi
>>=20
>> This should be enum, knowing how Renesas adds more devices.
>
> In general, yes...
>
>>=20
>> > +          - const: renesas,rzn1-qspi
>
> ... but this platform is old. We are at N2 meanwhile. Extremly likely
> that no more N1 variants come out. And the other existing ones cannot
> run Linux (no SDRAM interface). I think const is fine in this case.

Indeed, it is a rather old SoC, unlikely to get new cousins, but I don't
mind switching to enum either, I like future proof descriptions :), so
either ways I'm fine.

Cheers,
Miqu=C3=A8l

