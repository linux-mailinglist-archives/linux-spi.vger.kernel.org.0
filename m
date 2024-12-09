Return-Path: <linux-spi+bounces-5971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C024D9E91DE
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55396280E3E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577D339A0;
	Mon,  9 Dec 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="op+Wk2Um"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3E218AD0;
	Mon,  9 Dec 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742816; cv=none; b=Xk8S13GnLPaR6ypqCCOPY2/TFpbDw6RF0oOmT+app3YlPpDLjyH6o53fpX9tOlZPtaau7EgNJMW/9Yfqn+PvWiomJagLwCi3C+Vy35CO7Gesy98+KKDldYfQVWMw2C5GlSAQB1zg/YaBkdIlOjwrtMhIa1KCNFAy6ub9BBftsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742816; c=relaxed/simple;
	bh=hsdXPBg1wNzSZQf44cOoLofjUW+crZWjWDsBwUR7khQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jAvH7UY7bPZ5t9qKe9CiNJZmCJY/UTlFhf6f9kJ63X5X/3C1cPjrijb3ybhP3Otf+4MQ3O4ngi06MAxscOLJHoquBYgZwnUGoV/BpL2VQnuKIVD6nSGeOCfiPox0TRT/d/BUMzGRw7pCTAF75apFJUmvdcPtSA4cd7SsKcdG9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=op+Wk2Um; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733742802; x=1734347602; i=wahrenst@gmx.net;
	bh=MnVRvutz+MB81qIbBeoAPpk5qPXvFK/vt+kslQ5zHcQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=op+Wk2Ump/EGK6A1hdCYJAbYRkIIrcWyKdZeSQ5x0rmamzRuQrIpTq/MkE2/u7pT
	 2KbcMnCdYn0Up8Izb51hxcb4wr0HDs5i1Nn4ssKtpEh0rl2j9kc9xnNPWV6ofPc9V
	 Mi76//VDBMjioaIXCXYS3ggWQw30PqOvXobkyevme430w+OaE3uot9qB2viY6+Zhj
	 1Yv4FTj4bul6AquNPM0VLW83rqCdrgZgo/TtbHWd9ov1eBo7n5q0cTSmPS4LrsRNz
	 dinI+gjd7ir1OXPeSPfEETXbtK24g2L9z6mZaYAcrLbKTsvGw52COZoHuLDBmwJDm
	 /i3bDJVivKRt3vNwyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1tStRQ0DC6-003nDs; Mon, 09
 Dec 2024 12:13:22 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] spi: mxs: support effective_speed_hz
Date: Mon,  9 Dec 2024 12:13:16 +0100
Message-Id: <20241209111316.4767-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bj8yJBzEI0MpblqK6MWrpe0cW6O2NZ2heU9xB9UmFvuzqmoQQRL
 vAdXApwIuc8M7mF8iGZX29kVTdLXZujZjQBpl0Awunr0wIf5yTzBCMnCYZB+zxbwY569dxc
 fovlb2P8RjeeqP/6SlnGLUylOU9ncu2d62jsgjakElVTdAZsvgLeEXsxBiVHV/Zezk4oxK0
 lUUY9uyLYKj7OV5V/zyeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:enR62G6NnoA=;QejLnRU9XM4TSRSqTKMm20mgIod
 Xy+aVx626vtgNxajveMAVuUA/psRLHq7XIlqf4SBur/DJ0hE8igkW1QAtTrT+Fc7BrLJJ5tY0
 GEipAShUCBrtIeLyNDU5vuj/u+EyljD0mL3VPTIcfoO0ibT7i7ULCgdlRbg9Rdrfh5Sc2dcwP
 vyIw3cEjwgx8b/FILYY1bsyN+ZVlltPOrxnISf6aVD+FjBA/P66DBucrWD2FF8PgD+/wkrRWd
 oegNy3v0oLwuIdkTfe04w1TobkxnCBZ0n9YlaJw7aNABWyusF1l0QwpksFaAZgXYp33jI99EM
 DN98NzxjlivGAnkocCzFXSI+/U4nmWAgvy7UVU0yHaNrNf7OdORyyQ3JpOFMFt/XyeW03lCgZ
 OP+ygXYkzVm22TsiNE0BTT95EYBIP1pgAUBK5bkY+fHFxjYCUcsD15ZOdQTy/dL1VKtnWZqSO
 289MQNaIQqX7JPj0rR+w2LAAk7ENC6OKmJb+yCqpd0pzS+Q/gyzz9PzNsRXDY/DY6qBu780EZ
 O4DiyOb6jpL+2Qu/EQGnv2xyBpPoGUwdsbVtoPm6yowcLfEbPaaJsz0tLO7ljnp6Mc2NTjcgT
 C4AxP66nmlKezrQ6eF8NYSdNgQtZRARfaOGWy8sJIXllJiCiFsLJy+Ps+sureu9V91Bsh1iWl
 6aEhuVPdqxgLL26juL+S2uJjQcE8qYr4ULcwmikp5J1Zv8WBXFmhi7BQUmXXua+UFkZfnGI20
 bg003Qq8V7wnrOtwcZ8vve0s0zJhQvh/RQYdSiXki6JaAzHJfw49i4llEu+bqrh2kNd1NWuG5
 yRnlxa/853AeNgTQSuVq6Ay3LnMqn6H2816zP7Q+FLF3JHZaUBDgofsNEd4iv9uQreiJews2W
 fBJybYs4hfUVQ4WZ56UH8DUqn6DGJndE5vNNoMhoPDy2om6qWwNaaVgeFmRTWhKyXSvGLNJES
 mbi8O6UUPvaUtJfc/sgY8GHIZ4VwjxHFm0F9N2LzH8pGFxOCEGPGzwUnWnXznDzBzwvoj2HAp
 a1zuI0FR/f9jm4j15WdIm3Vx5V/6o4BjTw5E3zMFljvDgwjwk091yoGAi7dMg4xwtXazVTwlR
 PwaZOckV6yRqN4zAgvrI6rSGGHH+Ks

Setting spi_transfer->effective_speed_hz in transfer_one_message so that
SPI client driver can use it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-mxs.c | 2 ++
 1 file changed, 2 insertions(+)

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


