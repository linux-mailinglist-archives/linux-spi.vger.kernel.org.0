Return-Path: <linux-spi+bounces-12370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E6D1F80B
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900433024D79
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412A267B90;
	Wed, 14 Jan 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tXjK+QqP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228272848A1;
	Wed, 14 Jan 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401395; cv=none; b=guZGyLyeBBVUMhglCxsWul+feMS0lclZvtNvxbVPhkWFmmw+up5n8sP1PF4z7JtPTKFlkfsTET5eFZkFwc9D0LOwWOCUVDc0PUQf8qYJhX3TlXfSuB2tQgrVCctHo1FItYZk43k9JIaF3qB8nOtLEpHzeZDRnlwVrM11ncTOCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401395; c=relaxed/simple;
	bh=IlFPTbTxmVKEnCHnzbYIVZ07NF80mu/pg+8uID8lylc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=la9hAo5xsvS/QSEkg9DkErWVDITKYq1U+W71yIJrpJkhlBlOo+XGgQj6Jm8Eqw1wzOxJzbz2b0QRRb0NxGPW2chtHEsJ1S2hhw7T5uehliwjigWWoFEZh5kIAnHhvwqhzPXogmHgsr1mEW+Hjln+5klQ8gvNL8IZU6n3WygN7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tXjK+QqP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 403DAC1F1C2;
	Wed, 14 Jan 2026 14:36:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D36EF6074A;
	Wed, 14 Jan 2026 14:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A47C610B68240;
	Wed, 14 Jan 2026 15:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768401388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9p/xWhlZwsW5ntb9WQcb6PT46QQrinXc5tTssEQAbTo=;
	b=tXjK+QqPLzluFnuq6Nc42RQ/ad1Cn375G7P0LQDvjsInQ2XNv9gfNXMUzjWbzuIsOfu732
	tCmhl+PIDJ/T/v9RpIjVEhLkweS3kBR10WSJI8GwaVmupPHLrTPHBbG6QcnCd1a/qTCrc9
	aPoaghfJmTaM2nkOzM29DtNJtg/o6GyFFJUNKt0MxSryEYwf3Y5yAJGuVRzJIqGEZ49LbX
	oMqOQBSR3K5fW2bABCBsOQ1TM7QKR18KVS+EWynw280DJ5vjUWKZZRt8pvSL+KJYHMZc/+
	QF+Qpm8rK3KfCd4nvgpLvl1VU0rC4nZsEROrZ39MhNQmvM1W++y+h7tabbYrGg==
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
Subject: Re: [PATCH 07/13] spi: cadence-qspi: Fix probe error path and remove
In-Reply-To: <CAMuHMdVBwZW1JCrtpYe7mc55FzEv0BZOWC5NNNVejxXSzDLCpQ@mail.gmail.com>
	(Geert Uytterhoeven's message of "Mon, 22 Dec 2025 13:48:20 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-7-8ad505173e44@bootlin.com>
	<CAMuHMdVBwZW1JCrtpYe7mc55FzEv0BZOWC5NNNVejxXSzDLCpQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 14 Jan 2026 15:36:24 +0100
Message-ID: <87h5sow9av.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Geert,

>> @@ -1995,7 +1995,7 @@ static int cqspi_probe(struct platform_device *pde=
v)
>>         ret =3D cqspi_setup_flash(cqspi);
>>         if (ret) {
>>                 dev_err(dev, "failed to setup flash parameters %d\n", re=
t);
>> -               goto probe_setup_failed;
>> +               goto disable_controller;
>
> FTR, this conflicts with commit 9f0736a4e136a6eb ("spi: cadence-quadspi:
> Parse DT for flashes with the rest of the DT parsing") in
> spi/for-next.

Ugh. I got conflicts on 3 or 4 patches after rebasing on top of
spi/for-next. Thanks for the heads up.

Miqu=C3=A8l

