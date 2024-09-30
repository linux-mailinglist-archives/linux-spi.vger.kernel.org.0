Return-Path: <linux-spi+bounces-5040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75985989E49
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396A7287E39
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051378C9D;
	Mon, 30 Sep 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="oVdY7dwc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010CD16B391;
	Mon, 30 Sep 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688682; cv=none; b=Wt3T/5arKjSVM5wS9EylXBV8FhQ1+zSMheOFauVXdZJjpAkBSwyofCBmUlQBjLTqS9ldDX7Jlj/hDty5p+ZumA00BndMZ7dJ9pb0CgA+hNw7Tc46lSnl/hTfRwQVh0UZV78z6v9ZVt/BP30/w+wE/fXxSGFJMnhFJsbPMwHGJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688682; c=relaxed/simple;
	bh=wHNYVG3X9mlWhYKgl2wSYhCkZ9nP7gHjafRff+uXwQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEmXBqOY1yHGlPLSycJw+P6LTNyeS7VuMH9Ocgxsb08LXF44U0A+X7WXBG13LSTkJ3Sze/y3TfoOamfEIsnU/rm0bgkIy6k1yp+HtRPFgiB4T8jLwiWZgB5rP5F+K6Lq2uawq/0JksgyR/d2/kC47/+dxKHJBv5zFcU+F6THa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=oVdY7dwc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727688660; x=1728293460; i=wahrenst@gmx.net;
	bh=sY+L5lzlsetMV2bHl+NCJRDblGupsZADF4yHxFO+I+k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oVdY7dwc9BLzk7RYbS36Vf+WD3fXEDR3XJNzqjkgPUtruZVRD0H0v6WK+vphbbAR
	 GY4rjbChmACypZ2cvS7mSLUtsD0SCQDtcEf0/+oKZAW9jQNc3RLp/BrqPsIRN3zAG
	 b33AvdkCSfE6C0ozw9/OiqCDRtRArZDRjhFocoNO/Om8K6aYKJy7UsfS0cPxf7/iU
	 hFR01mD+ozQxjHlHp/mmWl+cvUvGVskNpiM5kHJ79WHV0DUuc3OIZhdApWR+yWpVn
	 804GtwmgHNTRYdiA11PR1gdNOUH6npzns6abdYFRag6ayWivVjbOtFzZETZ+inps8
	 d0c/XQRCjE6KRbEb5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1rtyeY2v8g-017OVO; Mon, 30
 Sep 2024 11:31:00 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Mark Brown <broonie@kernel.org>,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	"imx @ lists . linux . dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 3/3] spi: spi-fsl-lpspi: support effective_speed_hz
Date: Mon, 30 Sep 2024 11:30:56 +0200
Message-Id: <20240930093056.93418-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930093056.93418-1-wahrenst@gmx.net>
References: <20240930093056.93418-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FGHoyPznj8FacNxU9Nu//r0ysWw9iHPsxi0c3fBlj0Cz9lMJNh+
 PYX5XAYLoSsKGGlI78Q3llcgWUBWIsDOfEVF7KNQ2/0BrsUD2KxabzALkj2gafXB4qFbdRH
 N/MfD9trPE04d5t0918vJU6STOvNbzVMcMcNLzDQQ+h4/XEF4twWMkTO8QnaAm5IYDdgNLZ
 Ii4jrq8rLjaAKebngs6WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MV8S/9v7k0k=;0bCwECx6vZKE15FgPUKn8Y/HMqw
 tWsMTaIKHY3bOxjsHcmzDDvI/qsJTqinUB+bnRXr1xk55/LlTr9SfpH4UF32yjEFPJIlFtpq5
 5aNKG0mhtKpudyXPVqISpjRHpP8cPo0KV0gk/oPWgURNdkV1l9ZDw9Z9W5DGqtFepxJIOcXqv
 /KfGhKWj2aL6e+4ZRlg2C+iJhM+3iEgCIp3wiOjZnXqbnIAP1vNNXx8ZWvlnwkjUisf4kgA+g
 LTPBag83S6Ng35/eHjH4u3Ew6D8lrH8FspobOevgE89dnq+CNHbV6MV5vXdvTmtBWH1yGSC2s
 B7oS1GgdVMlb38/KAB8BaNC30ppFyD51+P+OY+8f74EqZmS6fI6zIsY982kUpGXjpCLWQt1qB
 R4Y3rQFXqenT9iQnM2Sfz+eva08wE6XMeF4uT/5AQtOjhdY++3IjBZeI/5titnDfe6mARUG8o
 m5F/KTZhXGfkhnQqi0Le9W4D6ULsZixPCa3NOSsSYAlGZEtOfFz8XiejoWE/REbNsFoBvEhta
 RAMRhN9C0GaMxdpLOXYrwKs5VrEeGDKA4ZtOJMuOdOVYQrEOds7tmqZkBrEaEgw96cG9gx45D
 TsJADn1abZRFSWfyaqp3IW4MfKiO5F6EymRj9tfhH3P4RbOKE1w2QBEzpNFMiBc8wELmyUdWb
 uPyZFU2O6gUqLMhNONa5jeugCF/ZhZm7+qyff8AqWCKCvanSfmBhmWoiEpqmko3rkRZFqw3Q3
 QzzyoPq8j7abWKn4kH2fDw/ZWEcb3vN5fjMlChfzuRlTQzcbkjZC+W2h+aJgbTHPdHYEREKYC
 ulJbxMk8eyGNeqTD1BrzwHLA==

Setting spi_transfer->effective_speed_hz in transfer_one so that
SPI client driver can use it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-fsl-lpspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 3b5aa91079ae..5d55ef4d4ba6 100644
=2D-- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -92,6 +92,7 @@ struct lpspi_config {
 	u8 prescale;
 	u16 mode;
 	u32 speed_hz;
+	u32 effective_speed_hz;
 };

 struct fsl_lpspi_data {
@@ -351,6 +352,9 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
 					fsl_lpspi->base + IMX7ULP_CCR);

+	fsl_lpspi->config.effective_speed_hz =3D perclk_rate / (scldiv + 2) *
+					       (1 << prescale);
+
 	dev_dbg(fsl_lpspi->dev, "perclk=3D%u, speed=3D%u, prescale=3D%u, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);

@@ -750,6 +754,8 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	if (ret < 0)
 		return ret;

+	t->effective_speed_hz =3D fsl_lpspi->config.effective_speed_hz;
+
 	fsl_lpspi_set_cmd(fsl_lpspi);
 	fsl_lpspi->is_first_byte =3D false;

=2D-
2.34.1


