Return-Path: <linux-spi+bounces-5041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7B989E4C
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 11:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D22D1F20CAC
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844CF188733;
	Mon, 30 Sep 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QRW6Yj6V"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29792186E39;
	Mon, 30 Sep 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688683; cv=none; b=nlnHXO7QtrqAqf+Xq65/4hQRAsyC8rwJ6OXpGVgymH/Oy7jOaHPEGFbl73e3MMFCE3l1R+ai8lnZAbpAmaBJO0/QHbuGIfSWVhX77OKSfUp05l99GTaQuYGebzdyQHnB3bA9GpWshE8YNRfCgQyvMjKnwiF6bW/cFdB4MTbLJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688683; c=relaxed/simple;
	bh=xwZ/2ZuSKMh/BabpTwyTy7xC7Sma7pJGRyAtK91EtfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpnpSFLMpgmZLzyMgU0biexBcHIIWNgVC6RenSkTQKrs1IOcDptEtDk2bCBXvrv69DxUE1HeycyaYyWrImOCL+hE4sFqyS5PinlUcWXkBFdJTysdY843tlumO+k1rxG1vcDcoAvA6U5GWo3w50rnRyW3zAf0jwQH0pJ6FhyrxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QRW6Yj6V; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727688660; x=1728293460; i=wahrenst@gmx.net;
	bh=nf/ETJAt3DuB7mJlqmFgDdvAKEEogr1B0AOf7y/e70Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QRW6Yj6V392IjFRucn5Yfg6u8F9PnXdWnYXwF0EtLP7rbIYbCWvJFwXfjPWryaCB
	 XGZc2ah+evSmTH979ZZcZMyaFUgcNDynMm8YiFe6qR9bBotUayYwq3wHnQp49Sovj
	 QbMPdlsKF4/WD7Grx+kMWuNMKXYTAZYyvz4VHbiWeoV75/GtppjEPzkg3+J4YBjfZ
	 HBV1hmgzstMgqvq92j2T6Cj2EobHyBELmqECshGQf3QT5sWcbcbFFbioANuRDkq7K
	 rdLZXpOPsw2v9ibfV8CmhBZ6rLPB4AicZOZ93MZgeOZXwefAhI+CW+azPAOkA3OJR
	 +zouM/P77VsHOb1hzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1shi5P15H9-009DCx; Mon, 30
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
Subject: [PATCH 2/3] spi: spi-fsl-lpspi: Fix specifiers in fsl_lpspi_set_bitrate
Date: Mon, 30 Sep 2024 11:30:55 +0200
Message-Id: <20240930093056.93418-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Mu3FgyTvQcc2QnI8V3TQwr1QwpUjwgUn+zEFzJ1BkyhR+70I9zb
 IzOyaTFeHkDMq4Keaf3uQUyFwqA3+P+YbFGsyyIljq3pnqoSJKjKCQhqaOZqIOkloT8G8Go
 +ErxpXgUjCormnoGhYssSPmbwIKy5HvShrjluB5GA9oA6CCmd+9xqTBssyh7+j9XdV5neEf
 zgeG+G1oYfNLxeB9rZAtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yQbUhS798MI=;89qMK2L5FlKSGVc1pQ0PC6RXoeo
 76AMNtPnTTBfXEAqszCKxPif+QNtHKO5hHCsA+a0sof2gUIzTySRn3fRI5C9uMARP4LD9tAHi
 lcVmCrE/49/0nAebkUySlwDbzZayVD9/17dPVvcnoPwuth/Qx/hkx4zCaOSWqR7i9/bEtz24f
 nVC4sxFvRsjk3Ib58xEJ8Cb6fSEgOF6Y69j3YmiXXOCi0hkYnJaguiDBaLCI/rReCQ13AwS35
 xUhSADyqR1OCl/T37TpzIY3bLATp6Tp0hNbjRmsCv4vE6AlbSawlmMi+zAVYzOMVd32hqUOyR
 8nhmw5xgG5k7P8j5SnYx7vv1C9cUlCALqv4GOFPRkwz2rY2JYCR+JKR237SZs98dPLG/J8Vc5
 Xj84+OhHOtg82IceojISq/IVT/joGmKYgsQMLHSn1BbBAG3PcqrynN3HWsD7lEijjEqDn0gGw
 ANBgEeUHlgKLxTlH549znjLtvJlBmBHiK4tT6zJLR0CDczT3yeEjJ2MWPlgbiCGYTVZc8E/X5
 qhmP09BtL/dOtnBT8wcbI0s+j/FXqchGmfzSLkJcQPEzgtXvuRn9zYY89zn4KNguCaOdLbx1/
 lpiCnB1nTpzKVaG5tdv76rBC8OhRXMv2yhpKoonnmrpy1rpmrjwAF4kSAedeM3KtHjG0oA+De
 Xhi/jbNm0kExnBmn0uZ2Iqk8QwdtfnU7vShiVTFLCP7Bb2sYaXvCX4P9AxktmCKJVtSmQlBOP
 Ycu6aRxPkgWQ1rllYNSWy8weBESpbkgpzSQxky2sjqSkNhE4hHXwxVnT1icIgJwML30YA/SFn
 0Imbi2/WYn//iOHcWex/Dyyw==

Most of the parameters are unsigned, so fix the used format
specifiers in the debug message in fsl_lpspi_set_bitrate.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 196cc68f2057..3b5aa91079ae 100644
=2D-- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -351,7 +351,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
 					fsl_lpspi->base + IMX7ULP_CCR);

-	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale=3D%d, scldiv=
=3D%d\n",
+	dev_dbg(fsl_lpspi->dev, "perclk=3D%u, speed=3D%u, prescale=3D%u, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);

 	return 0;
=2D-
2.34.1


