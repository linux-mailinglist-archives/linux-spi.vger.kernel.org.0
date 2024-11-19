Return-Path: <linux-spi+bounces-5755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659B9D3008
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 22:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE78284060
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F401D1736;
	Tue, 19 Nov 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fs6XKAXK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10791D043F;
	Tue, 19 Nov 2024 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051860; cv=none; b=t+nRNh1oJENsrSD5F8lvbWFzAJSyjg1+Ng/nWgMCh8aUVxikEi1wjUNixA8KdiUV7nYfRGhl6jrCkW24IKxi1Dslwgx13F7b+GQ4yV7iW5AkeVBdjFMpoieaAOV9D3zEjEKMh/Dkh+xD0QqH9fZQBYkSR5xhNXlw+x71XT66+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051860; c=relaxed/simple;
	bh=CLacKn45ZJzzKF/aDfg8hX19NVkE4WN0HsH0eXEdVjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCdCRw/P9EchELR3MA3oOFShGsCRvXPIrYl0LWn/ngpFmC28RNEZJkLgUeCGOXQOQkzZIBMnkYIXkFxljWqamHGq67+VpXw+VqaogP2hAxZ11bkYqHcdUdafjuv3dxA5ir5jvjWobc9g/qULomkgR7HaiKW4xygyfj+HrA62gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fs6XKAXK; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id DVo0tZBgMlMRCDVo0teyUl; Tue, 19 Nov 2024 22:30:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732051849;
	bh=EjYh1cknlZ7PMy6sRG187xTDVC5FFJcX/Odw6mzP5bM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fs6XKAXKEa7OiGdYVIxWxoX52NB9X9sFNwHavWtknoVS7Z1y0i9KjA7T5Hcz2N04G
	 oGU7ylyi7JaqkPL4uNOf8Qk/bK7w/mBi0klb3GdO73sCvx76Qx4AGs7GAZjXMWs0N3
	 uX/cFd2bZHVehren5fcaR5tkVEH+EmLU1QCfrLU9crfmdQO+ck55e3SvNxfM1ycuM3
	 0dZbgx1nxMHEae/5hr54Un7Ta4Y1f49V21pB9poCOHlOuJMQ2pHfL21MvriwpNQM+w
	 eWKSG3bJhYwZT1m1VrxKdg4OqVRgIQpGTtElsaT46/a3uXEqkcMPWrNN1N57pXeVyT
	 QqRSxYCfY4y1g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 22:30:49 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Mark Brown <broonie@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()
Date: Tue, 19 Nov 2024 22:30:29 +0100
Message-ID: <4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A aspeed_spi_start_user() is not balanced by a corresponding
aspeed_spi_stop_user().
Add the missing call.

Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.


This patch is completely speculative, review with care!

It is only based on naming where a _start() function if not followed by a
_stop() in some paths but is in other paths.
---
 drivers/spi/spi-aspeed-smc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 8eb843ddb25f..e9beae95dded 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -239,7 +239,7 @@ static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
 
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, offset, op->cmd.opcode);
 	if (ret < 0)
-		return ret;
+		goto stop_user;
 
 	if (op->dummy.buswidth && op->dummy.nbytes) {
 		for (i = 0; i < op->dummy.nbytes / op->dummy.buswidth; i++)
@@ -249,8 +249,9 @@ static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
 	aspeed_spi_set_io_mode(chip, io_mode);
 
 	aspeed_spi_read_from_ahb(buf, chip->ahb_base, len);
+stop_user:
 	aspeed_spi_stop_user(chip);
-	return 0;
+	return ret;
 }
 
 static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
@@ -261,10 +262,11 @@ static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
 	aspeed_spi_start_user(chip);
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, op->addr.val, op->cmd.opcode);
 	if (ret < 0)
-		return ret;
+		goto stop_user;
 	aspeed_spi_write_to_ahb(chip->ahb_base, op->data.buf.out, op->data.nbytes);
+stop_user:
 	aspeed_spi_stop_user(chip);
-	return 0;
+	return ret;
 }
 
 /* support for 1-1-1, 1-1-2 or 1-1-4 */
-- 
2.47.0


