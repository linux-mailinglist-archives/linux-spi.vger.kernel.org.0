Return-Path: <linux-spi+bounces-6231-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EF4A02716
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 14:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F7163987
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21E1DE3C3;
	Mon,  6 Jan 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f4ez3j8m"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5C1DD0F6;
	Mon,  6 Jan 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171365; cv=none; b=DpqN1idgszW5i7QeFNfNSdRI/mTgDrmqa7hfEW/1upXjjawX77gAC+16/ie46Y2IXkn50oREtYXWVJyC1ae7zlxsOld5fmVXRo1dnMDy4nKZMTuZ7lB75AFFCHojNWnMq4BXhanZ9bIwSspwH42hLsQly9Pd85iHE+KzIOKG6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171365; c=relaxed/simple;
	bh=LDXimFD+hEVunV4g41zyYrJcxb5U3S2/goflvp0vMeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrRgwmZgwJsDpxDoSc1HQGXWjBpg6TYbnlk7vWuji++09KppX4zNhtQecxuzh0LT5pkg7aPcLytuNGEYWwiNxfjXyz97PIyRikYwjnWrXuv1psGEL2WZPlfGSR/KpT/6Z9CtQEvdzJqlJU+PDC99/NTAC5OpzI02uoQVqM9Xeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f4ez3j8m; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62D7BFF802;
	Mon,  6 Jan 2025 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736171361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDXimFD+hEVunV4g41zyYrJcxb5U3S2/goflvp0vMeE=;
	b=f4ez3j8mLaR9Shg1dHOsR+mN1JaIM7yyUTnDDowiuKUbTTBnwA+EVPSih1Gh06XantE7Qf
	xQ0vznDCYUEf0cmuBjVpfw31Ii6QDR+xjDDFwMpjOjgUIiWhPvaMwp4YvxMgaiqL4Flpk7
	A+FISAPE0bvXKqoJSr+Pt4sK+zT2zK5gC5kfqJWBEoxy0IB+E8e1InFrna3qrDfLCEozW/
	vnL2/ITdInjOw5vzZUwkmAMEXonOmgXYMnViiAfJtSFb2BD26ENwP2K1SoAs6YPMlvuVw+
	LMQGKYolbz7rTH6vWQqqn257TKU8kyUDJPPUe5Rk2tMLtwJ4OOUe+sUtQJzI3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,  <andersson@kernel.org>,
  <konradybcio@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <manivannan.sadhasivam@linaro.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  Tudor Ambarus
 <Tudor.Ambarus@linaro.org>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Michael Walle <michael@walle.cc>,
  Pratyush Yadav <pratyush@kernel.org>,  <quic_srichara@quicinc.com>,
  <quic_varada@quicinc.com>
Subject: Re: [GIT PULL] mtd: topic branch for spi with Qcom changes
In-Reply-To: <87jzbp9hnt.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 24
	Dec 2024 17:20:38 +0100")
References: <87jzbp9hnt.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 06 Jan 2025 14:49:18 +0100
Message-ID: <87bjwkoxwh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mark,

On 24/12/2024 at 17:20:38 +01, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Hello Mark,
>
> I'm merging the Qcom series, in case you need a topic branch to apply
> the spi bits (binding and driver), here it is.

There is a breakage on x86 with this series, I'm applying another patch
from Md Sadre Alam on top, so I'd suggest to not merge this branch and
wait for the next cycle to take the spi bits if you're happy with them.

Link: https://lore.kernel.org/linux-mtd/20250106131558.2219136-1-quic_mdala=
m@quicinc.com/T/#u

Thanks,
Miqu=C3=A8l

