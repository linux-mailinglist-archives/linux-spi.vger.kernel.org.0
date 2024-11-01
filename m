Return-Path: <linux-spi+bounces-5590-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DDA9B97DC
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 19:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E301C20C68
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4E14B94B;
	Fri,  1 Nov 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pYncye6Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sWmxrp/U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94282E62C
	for <linux-spi@vger.kernel.org>; Fri,  1 Nov 2024 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486754; cv=none; b=QQ4eFZ9H8Kc49pnnZrMWEcSJ3nu796cyy2bVg3D3KVrQUedjIv6xV99ncTPIjG7va3MTdPT/oe6ZeLkZrBM/SZQqqdLvJR+cHasIMtIW3RJXunBuubk998wZ6r5kCGG5JzVcrU5hFuOLDK9FBDoH1jghl3NGtQ5NMsbYi/iazAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486754; c=relaxed/simple;
	bh=OT9cBjHQ3ujswZRDw+FNMBH1MtYhwCWqL+mnA9z2tFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8+HR/8piKxBccMGL1wV0Iw6rFwb+AG9qEM7HSR6lgx95i+1cdhNw0+p/hTam5xNhBdMpwzhJCye35LNDEn5uGwKZkxSFv4qKmCkakmhrjRwFLtR0m2+Q8lwgDQ91RLb3rK0pAsuL1LAPwSI8/x3FL0hhKsLJh9uumCDMqchJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pYncye6Z; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sWmxrp/U; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Xg8nQ2VNLz9sZH
	for <linux-spi@vger.kernel.org>; Fri,  1 Nov 2024 19:40:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1730486442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6/9VnVsmxWUBEZAztesW0Imqm/4b9ZRdQZPnI1KaBCY=;
	b=pYncye6Z0PAnHdvQ8/fOW5OZwKD/vSHsN3WxnsRw4HFGklC0ugY2YuzxMmlHb1FJEksslm
	+2rlGBwd0Xr/uRgV3z/BdxnR152FbEQEvsr05GFcslQpvNTnvjkNRKqOobxPnrmelzYLzF
	5oc+VMgDGqWLMImJJFzhEBeMjKyWtkOQFZW8n8j3IJUvi5mP6VW1rwIzvUpyUrQ1Q0VLuM
	oROE/jXsP/M5nqRPQIMFMjjp3HXh5wE4XDeJy2doNepVvLqz6zfp7YEUqiomFV9JlXa6AE
	wXohB2BZHqF3VmIYtexbJCh2JtnI4PaJzNl83EOZ6CX+ShqW+gd3MNdQ3kd3Kw==
From: Alessandro Grassi <alessandro.grassi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1730486440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6/9VnVsmxWUBEZAztesW0Imqm/4b9ZRdQZPnI1KaBCY=;
	b=sWmxrp/USFBEm83yd+7QAUJxeHh2kyZKt6xhJilH6+T2NeduqkLPxSL5uXCmnBF8yx7qIX
	9KCOaRUCtAKEZtHRDStGslCvCabtBVee+JN0C8bLVSKaelJSqDmdHhw3JKSB6IRadMlJs7
	beUD/bC5jVzVUh9tcc7PDZDwuN9EPIXRoimKc6EMNFnhmzn4nf8TTyJPy9+C43rXhn69/e
	DTYzjCuTR+T29C0C1u16h2bRtfqzZERL6Fu+O1Y9lhvzyZYZbc79Yk+M2Y/osWA0XoN24V
	EleZUSeeYSlIzJZA8qtxP4qA/mHDRtHUCv1u2PFK6VLUrS0WcCxFkNeGlgHi0w==
To: linux-spi@vger.kernel.org
Cc: Alessandro Grassi <alessandro.grassi@mailbox.org>
Subject: [PATCH] spi: spi-sun4i: fix early activation
Date: Fri,  1 Nov 2024 19:40:30 +0100
Message-ID: <20241101184030.51254-1-alessandro.grassi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kw9miziwjmysgwow4xrjg5uy5sfnaa1a
X-MBO-RS-ID: 09fc033a06fb9b21164
X-Rspamd-Queue-Id: 4Xg8nQ2VNLz9sZH

The SPI interface is activated before the CPOL setting is applied. In
that moment, the clock idles high and CS goes low. After a short delay,
CPOL and other settings are applied, which may cause the clock to change
state and idle low. This transition is not part of a clock cycle, and it
can confuse the receiving device.

To prevent this unexpected transition, activate the interface while CPOL
and the other settings are being applied.

Signed-off-by: Alessandro Grassi <alessandro.grassi@mailbox.org>
---
 drivers/spi/spi-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fcbe864c9b7d..4b070377e3d1 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -264,6 +264,9 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -404,7 +407,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
-- 
2.45.2


