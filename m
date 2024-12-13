Return-Path: <linux-spi+bounces-6050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D09F0BBD
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B082A1888A82
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A71DEFD9;
	Fri, 13 Dec 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jkMXvB2o"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816284A21
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091005; cv=none; b=Z0oVQspzKL4XSmrol9ufs7X8XA7dsmK5zmFtvS74doif7h40KHoC2Jufo+PvoHesS8fKGj77Pm8qa2xcSO/Jobz797+NMNqAKStYRaPfObYUJvAXOI49bImFin7llquH2Dz7mfbFDevtX6q2ezmjdjQgu0JA/Bz0FmVEZcFBWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091005; c=relaxed/simple;
	bh=1N5Dij8c2GyjzKGRltjjEZbDJ8FA2c7LvDs7UtoWAp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgP/cjEXbVtga8QSnfkfAM8Ual1jXwtJ2sfX6oUwjypihYNSUJBrm4N9tBdcLtnV/xVBhl6LDE99D6aej7FI6zeAEbFzQsO8XO9nT/23h2RXAGkHVIf5r9ipnPrQG7zCDCIXYqd4XPkQN9I/UtekTRmKzZi10piCv5D/eB1i68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jkMXvB2o; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F204C0002;
	Fri, 13 Dec 2024 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734090999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1N5Dij8c2GyjzKGRltjjEZbDJ8FA2c7LvDs7UtoWAp8=;
	b=jkMXvB2otgUgTbT+cPpsZhN2aWSVafG7uXrKvWiP8pmRrM4H+CZ7R65Na6eGkf2D6/H8YS
	Syj2D+IbbKSGf1+PnU61bSDVAPRZR6eR+kSWsB7Gtb5tnsEckVvbhNusSlxdRqKaJsplDf
	rURgMShVsLtOjwutYzPOqNbs/LKauq9HOcwQThjRitkgWXzI206E1eBcthhBMeaw3zhy41
	tIeDJBo4ExqP/oFrJAgRz0s5ugT5GY7rvXxV2ysStIDuBAdT4Gug2ymr8ULMY7rvoKIf1r
	mEThihFGsuY/1Uz0+JfAkR2J85bWtEtVsCj5m2Uy9EMpFyk8z1dYO3fwiRVSLQ==
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
Subject: Re: [PATCH 18/24] mtd: spinand: Add an optional frequency to read
 from cache macros
In-Reply-To: <6e037ce3-1755-4cb5-9124-4b32773fbba4@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 14:17:36 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-19-miquel.raynal@bootlin.com>
	<6e037ce3-1755-4cb5-9124-4b32773fbba4@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 12:56:37 +0100
Message-ID: <877c83n6dm.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 11/11/2024 at 14:17:36 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>> While the SPINAND_PAGE_READ_FROM_CACHE_FAST_OP macro is supposed to be
>> able to run at the highest supported frequency, it is not the case of
>
> what do you mean by highest supported frequency? Is it the max freq
> between the ones supported by the controller, pcb and flash?

I am really talking about flash limitations here, I will clarify.

Miqu=C3=A8l

