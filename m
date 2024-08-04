Return-Path: <linux-spi+bounces-4135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23025946E6C
	for <lists+linux-spi@lfdr.de>; Sun,  4 Aug 2024 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B624C28146F
	for <lists+linux-spi@lfdr.de>; Sun,  4 Aug 2024 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985A29CEB;
	Sun,  4 Aug 2024 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Gisk60Q1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896111D545;
	Sun,  4 Aug 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771396; cv=none; b=qGt/UB7i5gL66zu8gFiYF1BAQQLEDc7Gfu6N7A4I9Q4wxyC81zTUKxfjlO+AOirJWNh6qoqB45hxVA4JeKdIz2ckk2nQh9utqAk64s491p2ckNrlsgF8cEKjftCQM8o6rPkp4zME9DsVfIV12hjwHHkt36BrWnylWUe016ybnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771396; c=relaxed/simple;
	bh=rPc4OVNtOL0903UNmvVJ4agBWd8+MncDod+sYX9roPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aLORBi18o2w8IN8aTobLANfJd488fI3+OwVIQ18YJJ80LsgHILirzwhdLfed5qUFi3wlIKrJIq+N6R9nlfxe2aS0ZwvmkmYQEOWO+/MANFWb6wd020LNmYSK3s3SF9+Hn7am2uLvdFzyEDdsS/nPEJEceLGeRXllU9rMxB03XhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Gisk60Q1; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722771377; x=1723376177; i=wahrenst@gmx.net;
	bh=o8wiZyuTf+7p/7c8oFkjGNg7jlgN2Y4Wy2pe5S8ALnk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gisk60Q1HhtUwBYr2a/n4ldu6Me2TBzpyivB1gjE+z5+ahV0TyX7f9gSBO6CCgGM
	 2hEJEigUVIjYVV8qeiGNdrxkIFv7Rt1KcJ35xcxOVARYZ8FEVkNBjiVU0sT+Lcrmr
	 d/8onTdYorrpt+rh1jlvhAGtXrSXZWLKa7sBn1PNG8LI49R6Qkkdnbcm1aFlTMyfv
	 lKUzwPPk/xDmDRXOGWqQzRqr+8MvU2S0y8QvVn1reKw5OiZBAkSl+vV2ipnqWMHeJ
	 q8BMQM+AXoVmFF42+gXUxFMY24dTIqGSsIlOdUJiSZf+/zeGn9GzkWVZ0YtHl8AtA
	 IdoRO+mWmWjTXj+09w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1sEcmv2tXc-013vNO; Sun, 04
 Aug 2024 13:36:17 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Mark Brown <broonie@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Gao Pan <pandy.gao@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] spi: spi-fsl-lpspi: Fix scldiv calculation
Date: Sun,  4 Aug 2024 13:36:11 +0200
Message-Id: <20240804113611.83613-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:niX0Js6Gc3sxUv1LEoco3KU9bIwI3f6AQv2+SLIljqq331yyAO4
 hE3XEJBSC+yFsBPVH+I0Sl92+2Af0ovj3nGSCewbSOJ304vfiA3r1DlVYXHv0O6hWrFYX0r
 yPoMeGAEr3YGEtIxcDMuTSmsAfKFQaUgMCdtCWtyN/CRcNVr1WJjfAXxsRrGXmmHDcWq9jE
 WmMU+06dioxipOsnd/yxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ulYULqnHBk=;B1BJ6ZR0sqUMWtNhJoVob21OZZJ
 QeGCYBaogUOH+8h8M+1XPE6fvQDOLxqhH82SYBVdn9NZ3AB7+Iimqrx1dJvstS4tfAMCxzhNN
 Qqmq7IQERP0P+e6YnPsCmlJSH4eclMVB5zZv7GK8PklGsotP/BKNJcG4jjBcNgIsixEd6SZK7
 FNRxOwLQj9LoNOjQMEwtegjUjNJT8AqXpJSFw1jg+KbqxQeFNuVGfPVaS2lUnibXDKwEBRXdx
 worZJqvoNW5rdxHBFHzgQnegt8iJexz6awY2CqSa1Zhxjj9135YFu1s2CukJIH7KFKFXNqOOB
 GB8f5y9wjM79iPvpyLocjxsDDfkZA0jJY3JAlylCgZitE8uoC641vzeekCoKnBHztNDRTp5u0
 2BXnzjZtZvjcO1SNjfkIfAkDScnrGr9HZZLdYw/daQG39GV0iHAYdJrTTt/ACuVd9aOkk3x7J
 wRz+Fr7QKsL0eLB6kaRYiqwSNcyr/CVBg3p+RBa+oDNmo+a0IPnaGHx00VhdanahR/NYHaeYU
 Lyp388n8Pcf4ijfTHrjzB9XCzAWwPNCKWvXX7Cck+H5OsnRuwEv3hL3vRigqG5zsHLVG03gnP
 uGp4G4iKZRmI9CX527LEVKwvrBpMTkUzvwJiGOYqryerLhZ+SjC9yXMzmiMDWXWn2QJGOMZeS
 +X0Lt0/69PBT1mv1vUQ6RlrPDHjtjxhW3aCjTYh2Lcyy/AJ+y86WH0tSdokQ1xXOFlor6PJUs
 Fm1zLKECpd/AvSlcuhAM1El3vvtBwMGMwH70yHhvR5A3SvI6iOpxncfOzBPWji6ckVE3luT2A
 d7JEybXiNnwQFKoBS+vr6Q3A==

The effective SPI clock frequency should never exceed speed_hz
otherwise this might result in undefined behavior of the SPI device.

Currently the scldiv calculation could violate this constraint.
For the example parameters perclk_rate =3D 24 MHz and speed_hz =3D 7 MHz,
the function fsl_lpspi_set_bitrate will determine perscale =3D 0 and
scldiv =3D 1, which is a effective SPI clock of 8 MHz.

So fix this by rounding up the quotient of perclk_rate and speed_hz.
While this never change within the loop, we can pull this out.

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-fsl-lpspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 32baa14dfd83..be261ac09df8 100644
=2D-- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -296,7 +296,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_d=
ata *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config =3D fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv;
+	unsigned int perclk_rate, scldiv, div;
 	u8 prescale;

 	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
@@ -313,8 +313,10 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_dat=
a *fsl_lpspi)
 		return -EINVAL;
 	}

+	div =3D DIV_ROUND_UP(perclk_rate, config.speed_hz);
+
 	for (prescale =3D 0; prescale < 8; prescale++) {
-		scldiv =3D perclk_rate / config.speed_hz / (1 << prescale) - 2;
+		scldiv =3D div / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale =3D prescale;
 			break;
=2D-
2.34.1


