Return-Path: <linux-spi+bounces-5986-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE049EB088
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B1D16593B
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B291A0BFB;
	Tue, 10 Dec 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="RshNwLsn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C11A2398;
	Tue, 10 Dec 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832691; cv=none; b=sQfj9FotViiS3onRLguRwtA8tGHaiv6P7vDV+qb1BXbNVE/ZhQSKPsWwhSa84HHrdR+LLL0NHlWf3mlfL31PzPrssVkt040fMMjpnf2m6HqSCEyKmUpCC+c0qEWaZEuoV+np1LoXKejOW88R4G4LAKwPRL/uo5FtcdfAmoHBm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832691; c=relaxed/simple;
	bh=xOCQ1nQQ5IdmCXYr09vT+gAb1OtH1eDvGpzuSUwDa6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tT1OsmMfNsmQV6LpHcbdK/I/FxSa97g3xcHE1zfoPbsn+JUhKWm4wg0/GZilWHOTa7Ngo6GLdNdSnjjVLE68K87Gb7pdUPqApFiaL8r9QvsH35fQaDFRJ1wf8gfXrp5MLP3Ye+up20eb5YP0rCUvcWwK7iIazB91YRnUHPns4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=RshNwLsn; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733832670; x=1734437470; i=wahrenst@gmx.net;
	bh=GzI6ojaHRtxqwhRF3SUc2EWRLaNMTnv2fcL6TjkwiHI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RshNwLsn44/ehDqRQo/F+yQKl8Hhf2l5O/Mwjxag+yehwT/2UKYm2NC+uZDmowRu
	 mreJwEy9XpLfEOvyoAKFAUJO7phFXpZy+WQqsLW/kYm7VIlCNHhM6mYcwuaxg0QdZ
	 /Ue9zrAgZz9qhilggECWYwZ4f2mvP3n4Pt8rcgMbXyFRdhT5CVJDMHgVpLlHSw4F3
	 /uX4ve/tjXslRZmikqRWWhPchxb4XvcCM213k2uiQSaiIemY1uo6MUGAW15EnagSF
	 0KxwqikvdU4Focqy12UYz86jTYuDEiKzJGH7JiY3jhsnLJxZ51SSIos9vz0THkDpa
	 EFv8+c+1aM8bERBhZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1tX1FN2aM7-012AJR; Tue, 10
 Dec 2024 13:11:10 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH V2] spi: mxs: support effective_speed_hz
Date: Tue, 10 Dec 2024 13:11:05 +0100
Message-Id: <20241210121105.5314-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:inUN7R817bgJ5FVj1Azb7aI2HnZq6RxaKGD63Uv7UkmN4vKpXV+
 roFsgS5xxM0krRqVdlVLN52y7LAUQyjOl3XaYlzFUst3zWrRnfOcI7ge/dfJ/pzY9f6lpT4
 1BeMhZkwxmO8ipMqJrgBFrp69/S3aGTVxrOmEqBwaKC8e85DW6BtDct8c9zPqraRGZh+ZEc
 yY+wogUQPp3U1EDopZ+5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fvwzoULYPCo=;2mwIPDWLPY8uKxrhfgq8PdGQn3n
 E9i/NtV90B2/y86Pa/IiXgJxBYiivYOGqGnUUU3OGXS4vMj0kzcJeMAcrt79O7JNTeA39ZRR6
 LA4yXQI9BrR0/v3XhJcIStOdmPIihkf0zCvXn4zHizoPAIE7rDzoMPhn9IEyDwNYRuWkQ0YrL
 JzKVoIGL2PYfpV6Pxclok4KQ8wdNcOQUXDstncJ4YHzrHp8kwiPZYB7T/qQ67c8GiVD4jEo2M
 X+KPGve+fDkD+3MG1F4OWhDekes6HIV+wFAKyQjmhXPwhaQl0yhIBrO87FqOJnMcvYepUT6Qi
 qaJ+WHW3lmiTbl6WzQUO+OpAQyVvwjMI3K0v/p2FLIKLtdgcdDZvPB++v/PDI8lYW55aIuetc
 ++v0mVeokCXxTFUK7SMfxwRJ08reGF5TXEnAoRA0MQb+VS0eQUk5A09XzLYXi93HgokaOivdn
 /uNX8WMnWFD+Qtq7fmMZ3EDIqy4Gr9xMJ7V2zhA0JZooXlSJngnDIh4ENdr1Ryv5yR1zhpttt
 5hggLMuJ6u5pR9KnUVCl4Kx/FyyuzEdvFMJL7nxKNXeW0yU8lq6pciGWCbV1Zuojw/a+9BLHT
 Lqo24pvbqQYuVqDe34jFnAPyFQQS6LGYeZ6X4EAjtLqd/uNaV2vO6jgxAD49ofFrCbXSJ4j8G
 4ivTx4gTfSFm1EciIi+VujzfXcbZ48j7wG7KhmK1F8zukXka6XhvzxehH6oeoHPY9P+o+kMls
 wWNdSaEkNNJu5eYXAHhx/Ed9USQwRfHXTrmf6NmBJbYcFNZSJJK/xmb8KJDS0UEz9EpBnExaY
 uNNK0LJfbJSnViW7GA5e+3eDiFC2DrgCrlwigNAXqzaPWpquvy9PKqEf+4C4NHzFOnGJtlNDz
 YhogWdAzRQ1HEC2HdVlveYZrnvCDIDSd1XDNWc7NFk8LqHVqSTixW+9YpkgYycPxYwPyUxX6h
 G1UAQxqD76HV+9HJs6B1aBEO9wysk1vmJsObS5LSvYAQAEoJwG+N6qOghqawceLSEeUhy0d1Q
 6avn6Ej7fYdcv8r6cJzLqA2ZpGiX/OQ9BwJORlkAiFhPEFQWpyzUX9WKuLULkiuEr8jB0w82f
 jeLP+fRdEf6H250LiCgh3BFBb1OYoK

Set spi_transfer->effective_speed_hz in transfer_one_message so that
SPI client driver can use it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
=2D--
 drivers/spi/spi-mxs.c | 2 ++
 1 file changed, 2 insertions(+)

Changes in V2:
- fix grammar in patch description
- add Frank's Reviewed-by

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index e6d955d964f4..43455305fdf4 100644
=2D-- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -381,6 +381,8 @@ static int mxs_spi_transfer_one(struct spi_controller =
*host,
 		if (status)
 			break;

+		t->effective_speed_hz =3D ssp->clk_rate;
+
 		/* De-assert on last transfer, inverted by cs_change flag */
 		flag =3D (&t->transfer_list =3D=3D m->transfers.prev) ^ t->cs_change ?
 		       TXRX_DEASSERT_CS : 0;
=2D-
2.34.1


