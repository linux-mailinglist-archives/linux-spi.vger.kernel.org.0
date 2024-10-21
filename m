Return-Path: <linux-spi+bounces-5271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9239A6103
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 12:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0DF2812E3
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8E01E5027;
	Mon, 21 Oct 2024 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WDeAFwi6"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355D1E0DD4;
	Mon, 21 Oct 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504940; cv=none; b=jY7y+dG4WcCtVPnFE900L3m2Fck5poP7BN6OB25XUHMQQMLxO3ptrBYEgjoxd7s+1QRXPuelDf88JoT0pNkEXpxtcFZaFqC0i+Fqcajw1hCJH1NN90AwUK1YqZ60haDdg72SfPBIoHUJUHA9trt5Dg46kR07nEe5ahk0rFVzfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504940; c=relaxed/simple;
	bh=bDztxjGoLMT9cbPe5QceDD5X4rmFLoxtqw7/vaEwEqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5nwD2DMhKzkZMxKdl539bf7jJTp1S24hiCFWz3CS8oVc7qb6gvhCqH8Av7TGYdaGnH2GU9bt5REzA8I60EYHWCGg1ChZk1BiKvukPuiHBTq3xCiOKFiKxqOy+tP2mavdibfMu05oyEn4aA6NeHzkP69U1ZIcG8j4rDCiInVx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WDeAFwi6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7787D2000F;
	Mon, 21 Oct 2024 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m79BIBKqneDCStQUQ14/pD49h3bl1usdmKNzsly5q9s=;
	b=WDeAFwi61lq51jGCq2dtNZcjZYRng+WYMANNQlyiXvBIPczC6sd9Lgo5R99LEfGy0Wj3wm
	SzmfcCM8jY0uiS/QE4GnfSSZeylVGZHUOKC/a4Ywl43vodweeWHqdMQ+zBcwTRJHx0yMKL
	OeNniS5u+Pi3kI2z0aU42gmkRCecObZ49gwE44CMBSTIiN3mbGEW5j+8GPzBva/z4P14Ll
	rrnrVJWRy+YLUNuF3iDnqnmiXukMRFbCSz+BoSrXAPAAfHdXzDKZYUy4IVA4/EYzMlmPKV
	AxTzUTPQKq8w74Gv+SotqloQEHThh2apW9b763Q0+kkQuUlCBdsjWeb9RdATwA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mtd: spinand: Constify struct nand_ecc_engine_ops
Date: Mon, 21 Oct 2024 12:02:13 +0200
Message-ID: <20241021100214.173157-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <72597e9de2320a4109be2112e696399592edacd4.1729271136.git.christophe.jaillet@wanadoo.fr>
References: 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'af264e5989055ac33f413c4c80874345cda0cc97'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-10-18 at 17:05:57 UTC, Christophe JAILLET wrote:
> 'struct nand_ecc_engine_ops' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> Update the prototype of mxic_ecc_get_pipelined_ops() accordingly.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   16709	   1374	     16	  18099	   46b3	drivers/mtd/nand/ecc-mxic.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   16789	   1294	     16	  18099	   46b3	drivers/mtd/nand/ecc-mxic.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

