Return-Path: <linux-spi+bounces-3762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12EB928B51
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C32281414
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC805154C11;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTMv1u17"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDF14AA0
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192367; cv=none; b=AqosK6ThfnFqKPQMmF6kMfX2vZdFA5c4ESqDX83XMJptATpD4U/AFvU70ivgcb+imYx3qjQkIzaXmut8CGEpm1NgEabkCBvFud8lZQFhu9IKzk9C10pfCHAv6hzHmJOnrdftTodcu41LiSgP3WY5WrYLhIZLp46P6kmBHLuaWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192367; c=relaxed/simple;
	bh=g1wnaCmQJ9WppmXLzG0kuZWH8VubWR52LTeX7Hn8mUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyoGTKzSA6wEFrStOnt2YBhKkRIcLaFUBpsHDjwbP8y7zaPh3v9im3HEvqDvem2kV3TlIrPxacLrSjGtRSm1CUwKx10ohZ8hOrY9T9MmY271gYyxx11ugcDyHbVHoLgg2BBdHSd3OdNThtjXr3PTk/d+DUQuiAjBbymwfSlfi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTMv1u17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5867FC32786;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720192367;
	bh=g1wnaCmQJ9WppmXLzG0kuZWH8VubWR52LTeX7Hn8mUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lTMv1u17OJl7NUMivuJaOfP4bbYwC2/yP/vGzNb8c9wlYHn+s6uLNEMPCpQ0qf5bW
	 arqx1Io1LUqX5ueC4SmCrmdpH0am0dMWCj5v4Xk0w6AT3WGfeazjXZjlvBspEtZ1E3
	 V9RJ938nJchGGkrbJWi8Jh+75fWBrd2EpQ/3JW4+5zvhieYGjcWzyIT1WkHCVCmyP4
	 UzZPTNfv0+oi+W9Q2V0j28IrA1rcyyCotzROsa9KNnjNvMc2QF7HRplvFV5RWjH7n/
	 LhNgKS7pYJcePDoBLIcuRf1DGOg/TP+LJBRXmcLtRQPHikkvqa8CDQJ+/UtoZ8275Y
	 TBXWHfTajyU9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A4BC3DA42;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 05 Jul 2024 17:12:40 +0200
Subject: [PATCH v2 2/4] spi: xcomm: make use of devm_spi_alloc_host()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dev-spi-xcomm-gpiochip-v2-2-b10842fc9636@analog.com>
References: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
In-Reply-To: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720192365; l=939;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6RJlZH90JdCncjV5ZiRfVjQGYop1z1hLo21odk1aD/A=;
 b=osI/6myKylZYPHyEDCSsLzHduRcTVpyNgmM7465zYO3+Y133WVjNY+80HwVBPeg0SS1mjrklF
 HlvMmRz5AwgAVgF7AJbC5wDRn/E58tto5qrxxHzvAHSvsSIXAKnlTF+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use devm_spi_alloc_host() so that there's no need to call
spi_controller_put() in the error path.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 063ce75af6504..5bbc250bc0534 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -248,7 +248,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	struct spi_controller *host;
 	int ret;
 
-	host = spi_alloc_host(&i2c->dev, sizeof(*spi_xcomm));
+	host = devm_spi_alloc_host(&i2c->dev, sizeof(*spi_xcomm));
 	if (!host)
 		return -ENOMEM;
 
@@ -265,7 +265,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 
 	ret = devm_spi_register_controller(&i2c->dev, host);
 	if (ret < 0)
-		spi_controller_put(host);
+		return ret;
 
 	return spi_xcomm_gpio_add(spi_xcomm);
 }

-- 
2.45.2



