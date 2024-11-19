Return-Path: <linux-spi+bounces-5728-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5B9D25AB
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765951F24CED
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61921CCEC7;
	Tue, 19 Nov 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lJYOqh03"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2E1CCEC6
	for <linux-spi@vger.kernel.org>; Tue, 19 Nov 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018832; cv=none; b=pyhnIE556oBMvpcm1Q9f9WOPzKY85vIMGEzyY4k4sswkbB5tm/qgSDWxEo29B12URyM7aVr6WD+HdLoVT3o6iiYFMDKJv/w/lwksgKdrUSfdKdFe5xbGUGSsvYOxgJ+MEKFo71ItOkUq8GEvpQQVg+XevLKP92/I+oUyffs0WXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018832; c=relaxed/simple;
	bh=w0sHjT8VQuB2Cb0PG10o1aUNpD2nRo8ohlYqG2rZczE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HHEh+yPDx7sKZpcF+uCVB5mkxaDTiBgFxmDsV/X+yujkWegFGSg91hv0qoCLKnjRd6ci0eYma4u/5eEOQBNuh/K7pqi+wONwKoa0DsdlSe5uChyC8OnvdQ2UOEdStZsIidy84j8VXowqU60i3CtlRAPsNCEJuPyfUiblfGx6XKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lJYOqh03; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F05D8240005;
	Tue, 19 Nov 2024 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732018822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kl17eArBM0EZMPMgm5R/LCZavWU3H9uIUYsEhNJklA=;
	b=lJYOqh03bBvzBLZ4tZLr8cJ2DfzohdBNzn7gwtwNB64Padlc/uKaWZqLole/ahctWJo9fn
	Wrnmrtr+AjV++84vIidrwJpKdKMGIxmdacUBQmIoVbWGASUpcbsOM2wv9a0jqRt1dWqBCL
	w/P8Oh50TqynNbAL8Z7bs7Qw9oUP64apJArzYK8g2ygxzjjEZ67TOnmbWOr9Gi6akgCb8d
	uzB6VscH6u+Fo92j5zhnWuj0hpq0x9ishIW/YOSeXRHDy/a6x8emXx9sqvqc58IekDM9YA
	GhTd9hhWMNQbFB3WchpGGSggenSI1ylmGZRp+hpoCqptthEQyusMe/r95vVv7Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>, 
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <2d182f21-9766-4c05-8b97-786af69666a0@linaro.org>
References: <2d182f21-9766-4c05-8b97-786af69666a0@linaro.org>
Subject: Re: [GIT PULL] mtd: spi-nor: changes for v6.13
Message-Id: <173201882188.120826.10402782871636263997.b4-ty@bootlin.com>
Date: Tue, 19 Nov 2024 13:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 12 Nov 2024 11:32:54 +0200, Tudor Ambarus wrote:
> SPI NOR v6.13 PR includes the mtd/spi-mem-swap16-for-6.13 tag that
> contains a patch for SPI MEM and one for the SPI MXIC controller. I got
> Mark's approval on queuing them.
> 
> Thanks,
> ta
> 
> 
> [...]

Merged into mtd/next, thanks!
-> https://git.kernel.org/mtd/c/34267d3c

Kind regards,
Miquèl


