Return-Path: <linux-spi+bounces-5042-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33254989E4D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 11:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5382881AE
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE4188735;
	Mon, 30 Sep 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tb3jlyCd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE61885B4;
	Mon, 30 Sep 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688683; cv=none; b=UwvnQP1SxFbj+DGabNknMPTEHhb5Un+CzeGNHpV2QE6sJuflckRfGC1vMV3z+ltgUu17P2XjFXZs+YKav9dMh7kMtMEUT/Pzkf6Uz7+ghc6OioeSFPGfMtQE2r6myGV15+QD6DqYyKChlnTSDAbAs0Zt3A1b0YzCUqL8ONnpBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688683; c=relaxed/simple;
	bh=AlcPv6wM/rPK3vg1wItQUndTOFS+w/FSx2w8cGddILo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jf5PCNEDaXojlbDKyFIG60C6vmXTUeS72xNoLkVc6XDLDyTUEW9dB6wSnFWrlBKzG4gOVhrY547EFSsT2HlWoKFhpfz4sTtC8xXzKAoZpe90EUOo8qLf0rwLsNO6TT40efEzutyNG9erPt3gfP3tS8YiqAaWmauOkLtquy6AuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tb3jlyCd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727688660; x=1728293460; i=wahrenst@gmx.net;
	bh=+X2Z1whVBmZ9pEvWhFlRrTu0QrAjM3Rhzrqj1t1T+q8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tb3jlyCd87yYAEpScxETYGOSM2yGriatKyogQP0FW01x5A6iIt1ZRvy4rY3C9DAG
	 0PyJ1gbrIICB5/reMnn46JAWyHuTSfXAXKeu1hyli3WvoM0iIFUWxfEXu7oEDlasZ
	 AFS7X3nKBUrgBEkWi+rYBcj0huyjIEqDYMaAQ63uRzaVYQ5j05Ro8NoccATOeBp9p
	 jxVTbTVXeVgBURp8RVhAYOuzal456DcNUnzPPyPcSwVyTh9yBDxdMYc71kddz4ipg
	 4E8jT6VQArve5VS/K2rPfTsQntOWhpKk+4W8nSPIMd+OiRMS40vxTDbD30tkiPiRt
	 qdhz9PJ3rDYlt3L6HQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1rprum3YVD-013Flj; Mon, 30
 Sep 2024 11:30:59 +0200
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
Subject: [PATCH 1/3] spi: spi-fsl-lpspi: Adjust type of scldiv
Date: Mon, 30 Sep 2024 11:30:54 +0200
Message-Id: <20240930093056.93418-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:XTojNywJficBHKynfwbKw30/3unuVt9CLczbbmmR3ph54NfvtJf
 w+5dnQ9VXkzW1Y2h6DI71//BvPCeNNObNLwOjRkhz7F5Oq51KpJ6wkIdAwjdtU7FanePGR9
 8Qg6RQOdDTUYMHtdEmCte65yOyLtG+hdVx1NVKL1mQ/nFdOs9wLRb/X+FP7nuteI68OGWFT
 q9bPY1XVPjlXNz9v+j2Hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pe1o77MfILQ=;yCsSTCn15ubxI+rn0svoqKG7UkW
 JPyazT1iKLP3TK/kRPvV6PpLN70T4KY8GFUKpfu7JduaYNcFp5YuCfFynevlo2gPnaEAg5yGS
 eepeMF5pvTqxnrdCMBdYLUtP4fs6mgKKpt1E8rVCe1xrn+MN7SHj/ChjuXM+lg21AqyfXKGJx
 wZkn9lVf/qQuKauk8EcU7qzddtufKa0d74mtzH4fqp7IRJcCMRaIMrNYay3VxtVOzUN9KoVE9
 ld0BBjG6nqnEC505IjsKCer3Tc0RYig0jlQnqgT32pYS3MGDFzNIH92N3rgkINBd9362W3jPx
 Au9nDQOBMSeJHfiTPBLbvC+aTily1Rru0fzyoTdBI/Qwhww4eEAYIiRslhfFifJbJ/c6ajaiK
 sxsPOw2z3baG9zRnuXmIJLxSAvq/qQQHPZPPq/84ftfmT7B0KvaQ2s7+RTOX8PMAMD1yEcy9a
 h7piqnBwS4fgovwd8F9hd9CcTD8EZlT2JUKL3qaxsTuGJc6MkxHpMsQHTlgveMwdtBIOYi7HU
 J8L5tGpMW/l8UMrZtiFLiUVSRD6hjb03EuWMkZYyoIAu1jq0T2tHxILHLKLmwFeM7ySexjNgO
 4gFJxBNLeveT37b0qkZ01x+uNZIs34L1skFEfYSrbxH0rz8wsiPXf1y5ZZ7e5WUGebxaGSrbu
 TIy5LtUmWi9Nki1WTobhFKaPrCJwzYrsz8FYm38I15U7Da0Zi1kEo1VFzleI1De1hT2Zzd3qm
 trv2qVg60iUG1fpHJBHpXOue7CGg2wm7Msl3IoCW3mHs2IHqK3jIWMOYa5O9jdn3YazNYBX8r
 oS1jykeuNRCQ941z2Ft+g8MQ==

The target value of scldiv is just a byte, but its calculation in
fsl_lpspi_set_bitrate could be negative. So use an adequate type to store
the result and avoid overflows. After that this needs range check
adjustments, but this should make the code less opaque.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-fsl-lpspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 977e8b55c82b..196cc68f2057 100644
=2D-- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -315,9 +315,10 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_=
data *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config =3D fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv, div;
+	unsigned int perclk_rate, div;
 	u8 prescale_max;
 	u8 prescale;
+	int scldiv;

 	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
 	prescale_max =3D fsl_lpspi->devtype_data->prescale_max;
@@ -338,13 +339,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_da=
ta *fsl_lpspi)

 	for (prescale =3D 0; prescale <=3D prescale_max; prescale++) {
 		scldiv =3D div / (1 << prescale) - 2;
-		if (scldiv < 256) {
+		if (scldiv >=3D 0 && scldiv < 256) {
 			fsl_lpspi->config.prescale =3D prescale;
 			break;
 		}
 	}

-	if (scldiv >=3D 256)
+	if (scldiv < 0 || scldiv >=3D 256)
 		return -EINVAL;

 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
=2D-
2.34.1


