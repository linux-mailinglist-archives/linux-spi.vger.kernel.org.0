Return-Path: <linux-spi+bounces-4664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A057396D6E1
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565031F21429
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B0198A3B;
	Thu,  5 Sep 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NWslCKoE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB6198A1B;
	Thu,  5 Sep 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534964; cv=none; b=AJByOjhOS4kDThrZqERAjUzopK305U0L1Ky+ZKFSBDjcjcFoSZGvpmkd2BQgdoOmeX06mUYDprc/oq7uKoDyQiZyY4v+vs0SvpyL4Y8qFqCR/JPXQaKxQvO3O624d6PuS05jsyeYX8CUBVxiTBrVZ8NZfYzAmO6UfM064o+0uDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534964; c=relaxed/simple;
	bh=NL9XNIXdO1hkue8NzahL9w1Jjviiv66bMRJSvs5IEm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiCb8765TQ5lt5jD3lCllAXYWhfUjXRMs1eK7KGXPA3UyKlvOJ6yeJoCziDefYQI27Po4hySa4Bs814LYzJe41UnuySVQOzvlfHJAz2FUpSVwP5sae9VgkmrbTCCnihE+TpbU5C54XzHEtP/+o7G6N3L1edq2G8pKKgtT1iyOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NWslCKoE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725534951; x=1726139751; i=wahrenst@gmx.net;
	bh=VWWAvKB8CPx/ZFejNGIcT1uB5OUCheGQG/l4ozGwpeQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NWslCKoEiOh0l016owuNtsK/tP24RLJLrf9p6M+zfUJlKsYrsqD54K8PdpXbFv5N
	 LPLubCDkwYv6AKKBwhIZwNUp5rWSI/6FjBPvMn/9gFWMKNEywGFJwDBmrlUoOlKet
	 bgymKOETWmDTMtBGs9Fz/hJu1pjpFXwFhZRjfDIqbJX1oJ1hrGmoFotjG+UbIEW22
	 vk3V3zB7BTIZDux2YNjzPPRVD57KuQow0/QqlkFOzKfR1/3zcuG+cdap+KEZNMr00
	 46DMcAP9KznUhIRtc5r6fbv1zM/eOhPvSqNeQJfD3b/wUjIoMeGkVRgvqwV7Ukk6I
	 XglhNduj7fn1T1qS7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1ruDMp1Tky-0117GP; Thu, 05
 Sep 2024 13:15:51 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Mark Brown <broonie@kernel.org>,
	Carlos Song <carlos.song@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	"imx @ lists . linux . dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] spi: spi-fsl-lpspi: Fix off-by-one in prescale max
Date: Thu,  5 Sep 2024 13:15:37 +0200
Message-Id: <20240905111537.90389-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8DMTw6lzm9Da3SPnbEqR+Wrn8812KjVHdwRX6dr817A1DsKsgs7
 upUo0NIKcnW78PYvV9mozVXaKgJUs+habOreyi0sBQIrwSCwXsRN3Dhf86tW79xC/tAEKur
 LJbbGYGcEPg/L4tNQBF1E3d1bgLG50BJE1TiTXXX6Lgt+VO+4YFxw2QIiVguYdWWT0p9wd/
 zkj06kwkAPCjYzP4dadxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I46yaLl5NEM=;tz32IesboqiI0ABGFHE7y6Vjhh1
 IGPbXMu0wmelu/MzAMq2fVudPPNkjFjYdmH6O7o+1DmDSRwM9eAgU+1TnD6gDD/gVxvEoGY3I
 vcxx/25H5vDEpauLwx200tVp1pNh3/UKz04EZNf7qOzzkBnja8q0mRN6Ty3vkmEqGaZFTNVE2
 PGlQp5Ew92Ddo7tsF4voiJS3ts4mo015LaerCaJmw26p2BEGpEqQ3S+6BY9qTM9kvhvO5tCyT
 2IC+VEbdSvJYpGx183PdGK8WHq5idR+SN8VYEUj0aObSnrN4iU3sBSx7d4PLSBg2tAFsxuZOT
 7VYQ4Ak0uEpw542zn6mHpFv5sKbTq3wmy/RxFXJVKcJB8RjRQuzafqVnP+AmZQ3GjYRjyyRUQ
 sqWvXRPy2lhjJTLQ1E+EDGvvacyrBxwTz1u8DqqpVsT1rYwmVE0h/in0mm1YIieFHJ2Oxbymu
 CWLk+uw6H4/bnhem3Kcwd8SIYxjOfUIETqGXii6WEMo6bYE4Oiv9a9ECRDP3vLv4ENvKzkZvV
 n0f1Cls17y1LiYXXArJ2KB82/w0UJvZupdLmlifxAyJgSsihB4aTTbyaZ3n50Qj/6TUE5bKhz
 RL1CFJoHg9Ua5Bu8fbAoFZEY03gdeqhWl3LCokp4fvGUKBmsB40D+v01rZxk7cT6v0h4IcXKt
 yhnCM4Sj8bO32v57oeHZyTfhaThhnbNu0drgWJmxSLjeViqWoYk2zThnr2ULvU2ulumBRhJdT
 GSymrz2Fox0pO+qMf57xl8xvKaKPYxhjEATX5PzXyEx+zbd1CTJlqQ3zE29UlC07196dv0S00
 K8vEOA/maloalMJvNm+0uFwg==

The commit 783bf5d09f86 ("spi: spi-fsl-lpspi: limit PRESCALE bit in
TCR register") doesn't implement the prescaler maximum as intended.
The maximum allowed value for i.MX93 should be 1 and for i.MX7ULP
it should be 7. So this needs also a adjustment of the comparison
in the scldiv calculation.

Fixes: 783bf5d09f86 ("spi: spi-fsl-lpspi: limit PRESCALE bit in TCR regist=
er")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 350c5d91d869..8ecb426be45c 100644
=2D-- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -136,7 +136,7 @@ static struct fsl_lpspi_devtype_data imx93_lpspi_devty=
pe_data =3D {
 };

 static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data =3D {
-	.prescale_max =3D 8,
+	.prescale_max =3D 7,
 };

 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -336,7 +336,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)

 	div =3D DIV_ROUND_UP(perclk_rate, config.speed_hz);

-	for (prescale =3D 0; prescale < prescale_max; prescale++) {
+	for (prescale =3D 0; prescale <=3D prescale_max; prescale++) {
 		scldiv =3D div / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale =3D prescale;
=2D-
2.34.1


