Return-Path: <linux-spi+bounces-6101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984DC9F61E7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1752E16F293
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD781607AC;
	Wed, 18 Dec 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcF5NXQA"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388A158D6A
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514501; cv=none; b=aWHv6svWl5DUBpoHSi6Wjl7pgNJAoSNS4lDntVsrUXgr23HuYvqk96lVv8X40+Wkt4Z4aQheki5dKJ3dq483xkQrskmlXKKgXv5x4Bh7/5jl3WMaJrXMlTTozFIzd8WCOy/7tMN2thrAFHONd9YYDQcDatroBAueiywOEUaJH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514501; c=relaxed/simple;
	bh=pqUzbg8s4+XWHk5VuCr/5VoE4KujCN/tkGTpGffbPfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GZK0iLGjODiFcrM53cdR758GFf10XLTXKKshsaUCO8Y0l6ygX69oin9kb0zCwiyvVXIGkD54OHiApGgsHi6b+Py+Cho1st+x7Uirz+9uKUaL0UlzNAP59n5hFQSAEH5rexO3eTmsYWUFYIRjOc4QE/52YUsaoAUwoWCeQ5F3CbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AcF5NXQA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE0B11BF203;
	Wed, 18 Dec 2024 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734514492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqUzbg8s4+XWHk5VuCr/5VoE4KujCN/tkGTpGffbPfg=;
	b=AcF5NXQAGTctaVBHTkB6xFZxYx6WiQ23zorUD8MPTF2J6M82rURv/XRXPiFszlem0XsAQS
	FMjAxJKTUBUts3ZGxMo0AELDNpXb5nDybM2zB4AnxP18PAmc11leMzuzsaEP+ZsG6qQiUt
	nnSqLDuQrSyjesLJBsUyJ4tr0w18/r5M+KpZIeIcl4x+bWI/THfU4k92vM79Y0Gq2xMQam
	9GTa8nv4LK4CCHhJYrBc10nP5QXhIy0KIW5UhkYkS2W0ss0KNPkEP7fB6aIUN20dUNWMK6
	04OSNmUQDzJL5Vkkgeya0gTpTj6dwkEhRwCw9+/AVWYCAbpkLdq5EBw1R7/yyQ==
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
Subject: Re: [PATCH 19/24] mtd: spinand: winbond: Fix the *JW chip definitions
In-Reply-To: <4f523ed6-f896-4c0d-8ccb-66083cd2a3bf@linaro.org> (Tudor
	Ambarus's message of "Wed, 18 Dec 2024 08:16:39 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-20-miquel.raynal@bootlin.com>
	<bad3572e-34b4-492f-8e60-96b14e3424bd@linaro.org>
	<4f523ed6-f896-4c0d-8ccb-66083cd2a3bf@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 10:34:48 +0100
Message-ID: <87h671e3lz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 18/12/2024 at 08:16:39 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 11/11/24 2:27 PM, Tudor Ambarus wrote:
>> do you want the linux stable teams scripts to queue this patch to stable?
>>=20
>> if not, maybe update the commit subject with s/Fix/update? Or use
>> Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
>
> If this is a fix, would be good to separate it from the series and send
> it as an individual patch with stable tag.

I actually ignored the "noautosel" thing :) It looks like I didn't
answer, but I decided it was not worth backporting it and used your
trick.

Thanks!
Miqu=C3=A8l

