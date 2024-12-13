Return-Path: <linux-spi+bounces-6052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4A9F0BE7
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 13:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380FB281D46
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657F1DF242;
	Fri, 13 Dec 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LB2Xu4fQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A21AB528
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091742; cv=none; b=JdFCSw9H+XCqd7JVwgKHVVoYQcSItc5mGTxmdThXA5pC8KjLW9oRmaAhagnvAxzo+mk/6h+pwfryYwdRPz6GjlbS6pIwO7TvkZ0WxpWbU0W6cYaoVyVEeJnIlodSYElvx3qu796BupxAFdf7fFLTWRDi0gwqDuYaBzQjuEJrTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091742; c=relaxed/simple;
	bh=w4NrdzbrxlNgObqS49Y8JyST+SX/xVsamI5s+do0qiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXDMAfzNpWrJ6IUuDg6x3ABzz+zI1gHpXQXb9k00+eucOCyHMs4O/cQqpphB8syzrr2fPq43ujJElx03Dq108mYNykhnAOOS4yy1vSR1OcX9L3Wcht5DdpxOvXeBDfw3jV+As3wROUdxKVJp2Xv5ICqOqyIhJDwm6mKa8ZHBgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LB2Xu4fQ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BE4A1C0004;
	Fri, 13 Dec 2024 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734091731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f3DmOhWIZupjc0mHh2kodPTDmUfjFFMcREGA7ikxOQg=;
	b=LB2Xu4fQfh9n8geRQtrbPBUOUVSTAX20D8bJTZhpdWUdOab3Xg74TJh01gw7Se8q1XOcug
	RfssqM8weQNHB65gr19QtBkqfGLHFfpY+jw5gEDCz/dh9nXlllLVEr7FoWkQS9nTR3n4Aa
	ynwr6N0mHgWsE7IZARwQnXtJZSxaqJvSu0FFVupnU5kB8XRmVFU/EIH8nEhvtK/QK/W0tF
	QTxJME31iOOIG0uiQeonFznF1wyL+BY0urNJevXxaMx2zl4oMGA9wD+RFd+U4DSGFlwTAf
	xq9DnLO5fC7o3Od8sZbpdMu+g+RsNpFUozeoXEwl068tItopKusDTgJaRzWLyQ==
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
Subject: Re: [PATCH 22/24] mtd: spinand: Add support for read DTR operations
In-Reply-To: <589d95d3-9153-475b-86f7-886ec41cd4f4@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 14:35:23 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-23-miquel.raynal@bootlin.com>
	<589d95d3-9153-475b-86f7-886ec41cd4f4@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 13:08:45 +0100
Message-ID: <87ed2blr8y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

On 11/11/2024 at 14:35:23 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),	
>
> do we want some names to these hex values?

I honestly don't think we do because it would be totally redundant with
the macro name, ie.

+#define SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(addr, ndummy, buf, len, freq) \
+       SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),                             \
+                  SPI_MEM_DTR_OP_ADDR(2, addr, 1),                     \
+                  SPI_MEM_DTR_OP_DUMMY(ndummy, 1),                     \
+                  SPI_MEM_DTR_OP_DATA_IN(len, buf, 1),                 \
+                  SPI_MEM_OP_MAX_FREQ(freq))

is IMHO better than

+#define SPINAND_PAGE_READ_FROM_CACHE_DTR_OPCODE 0x0d
+#define SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(addr, ndummy, buf, len, freq) \
+       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINAND_PAGE_READ_FROM_CACHE_DTR_OPCODE, 1), \
+                  SPI_MEM_DTR_OP_ADDR(2, addr, 1),                     \
+                  SPI_MEM_DTR_OP_DUMMY(ndummy, 1),                     \
+                  SPI_MEM_DTR_OP_DATA_IN(len, buf, 1),                 \
+                  SPI_MEM_OP_MAX_FREQ(freq))

