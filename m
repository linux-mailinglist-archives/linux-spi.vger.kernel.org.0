Return-Path: <linux-spi+bounces-6151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B99FB3F0
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486BB188490E
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332291B6CFE;
	Mon, 23 Dec 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BprkTsBJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE338F82
	for <linux-spi@vger.kernel.org>; Mon, 23 Dec 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978145; cv=none; b=kTBcYplxCUW2al7HyL+6+RwD4yGQ+o27qrlbNOvj8EJDRP/jN2TRp1FoYiIkG/OhcBiJiDEV3h4U3w05CNZpw+eqra9+0eaG5g7KYN+b7Xnwn3579B+yIxYtbVvp4WgHAVz+8Ti2iRTbkY7o0pkJvE0rdkqIuWUhAU4P2ci+wB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978145; c=relaxed/simple;
	bh=Tv6iJmtFz4jTMYOEld5KmoNhqIuilNzkh9WY1WJn4gY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dq6G/PyclY0BtFzJEGxhF1EUCe6NBN9/6xw6CtrN/uxmgZtCqHWNPmu+D+KwHq+eHRp4O9Y4ozyqFZbkeVoJRHFPYZmFzO3dZ8GuQfHOT80Pk+JVT7yCx7XYL2DFrKjmaq6Orm6FdFUk2xCXGQKGgl9gf1e9Y+154r8XAUC/S/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BprkTsBJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A560FF803;
	Mon, 23 Dec 2024 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734978135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv6iJmtFz4jTMYOEld5KmoNhqIuilNzkh9WY1WJn4gY=;
	b=BprkTsBJ7qEtphtbRAxKat6cRkjsX/srJJKRA1XLh5YWmoOAyCAPaqPgNW2Qqj0LLQwnqS
	9Ehjc1RPt1aXT9IyXvnCwO7qWEL5znOQG2uGXyfWlza6TT98LQMJEmwVQEg12UFq2o0026
	nWSsoblBr8IKNCQgnWKnK3SgH0EWLxLtq8c3NbAskr3sLXOoYYEt9PSTrYBsoG3WUJ1Ho+
	SWw+wNn+m2HX0WJCymjeEz9CGzeQMiy2+s6y/JwTJmlI5gNHhk1Kd95ez0CWTPpHe+WIm/
	R4HtCk4+2gURT+7vgn9XrcTpRCwPMPhTpy9jgetF7UuAp9/6as98X/bbBfONUw==
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
Subject: Re: [PATCH 24/24] mtd: spinand: winbond: Add support for DTR
 operations
In-Reply-To: <6029a01f-dc4d-4a35-ad21-fd17e3fed9fc@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 14:40:59 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-25-miquel.raynal@bootlin.com>
	<6029a01f-dc4d-4a35-ad21-fd17e3fed9fc@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 23 Dec 2024 19:22:12 +0100
Message-ID: <87o712uunf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Tudor,

On 11/11/2024 at 14:40:59 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>> W25N01JW and W25N02JW support many DTR read modes in single, dual and
>> quad configurations.
>>=20
>> DTR modes however cannot be used at 166MHz, as the bus frequency in
>> this case must be lowered to 80MHz.
>
> ha, what's the benefit then? Aren't we better of with non dtr modes
> then? 80 MHz * 2 < 166 MHz?

This is actually a good question, and you are right DDR in this case
does not bring better throughputs, it can even make it a little bit
slower. I think however we should expect some gains at the PCB design
step, which may be way simpler as routing 8 166MHz lines might
apparently be challenging. It is common to have PCB limitations on the
frequency, so enabling DDR can be a great way to keep signal integrity
while definitely improving the performances. However, you're right, I
should probably move these definitions lower in the table to make sure
we run at 166MHz if that's possible.

Thanks,
Miqu=C3=A8l

