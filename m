Return-Path: <linux-spi+bounces-9679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4937B381C5
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DF31BA2FA1
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 11:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DD52FF178;
	Wed, 27 Aug 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JoONyqOk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699D2FA0F2;
	Wed, 27 Aug 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295646; cv=none; b=e81TjWt/NpWRnU14rqxO49IDoDkHiqvP1ybO3z9z+HxzPWnIwcn8Qukc7v0rlUA9JD/MfUHxGaRZuubXWcDEvFX3vXrxVqRTlHpEZ4BUTxngpjc8IXUoS2jgEu8tAPrS1CIqxBZf2mNWBsjwFKF0rRKtbhNvCw/iiBI/0W/xY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295646; c=relaxed/simple;
	bh=N6iwUGMzPiDDO3HJpt4K9l9FNhes6zVx6pshwesN9Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0GcoZCkyxheR/b/KGcRYNFSQBgqxahw2IUrQUHK0Ex0iCTAcZBCedtGIhN0vFr5ZSYCmkJbTCbKmIZY15coEgNQZqZ/UMpL3xRhIhq6QChMiRGbn56KqbzE+LmXY2Sgwf0ZeiZO3vYRym/j7b4u6zlaGku0g+g9asBtvfMzOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JoONyqOk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756295630; x=1756900430; i=wahrenst@gmx.net;
	bh=1CxNxfmU1s/Ipp2mEtuHNGOwBlhZrn7R6mG61kk3apc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JoONyqOk/wvA9OuGoHlqSY+N99mJAVsGK92LVsN7ghMG9TJAQMnCfsfY1CYoaFOX
	 /2m27nHqRNLPbxR+sZ5/FdAIN59s4Ccg9HVEPjPWxNWfDxLZ8EL+lCDQiR3233yXl
	 cPfMswEK/FQ0/q6judMWArBR72mWDyHxW4/zFzyCRb6IlMHc3WfCQtzpqy7OnIPVa
	 j38p0eho6cBRTrmKZCZah1IAUmd0oFir8AwOMg7EqutoJz6y1zAGrwpPxjI76T9e5
	 HuUJRTEr1zWVp7jwCAmsZi/WRF/XEh79zeaRuuYPHmd0ULeXdWsKOB6eqsRfZUA/B
	 MJfxKW/BDfOBLd4OsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1uaFhi3gsx-012KC8; Wed, 27
 Aug 2025 13:53:49 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	stable@kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH V2 2/3 net] microchip: lan865x: Fix module autoloading
Date: Wed, 27 Aug 2025 13:53:40 +0200
Message-Id: <20250827115341.34608-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827115341.34608-1-wahrenst@gmx.net>
References: <20250827115341.34608-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMi0QQMgobC11EoWoa0F13as6zqIki/OZsY3TMXDJZT2X1Zdz5c
 TVBP6UvHQXpnUxhqXREM3C/IgHNc/QjnYcqdIkdtXF2cCJBoV3TWCaXrCZGVocaXnWMirjk
 BwTQPl+CXy8WZb84c06SpNDwbYel6BonuFSVMm5AvUhb96Z4keaqmwMySdxO4wJmjuma0gH
 dfgVALu3QMJZJ+xBMhEXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6J4LG38c5lc=;zXRBIADk0+zcArXpCEYDQGURzvp
 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
 QYQmGR3FQeRjtvWQdtH

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from spi_device_id table. While at this, fix
the misleading variable name (spidev is unrelated to this driver).

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip=
's LAN865X MAC-PHY")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/ne=
t/ethernet/microchip/lan865x/lan865x.c
index 84c41f193561..9d94c8fb8b91 100644
=2D-- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -423,10 +423,11 @@ static void lan865x_remove(struct spi_device *spi)
 	free_netdev(priv->netdev);
 }
=20
-static const struct spi_device_id spidev_spi_ids[] =3D {
+static const struct spi_device_id lan865x_ids[] =3D {
 	{ .name =3D "lan8650" },
 	{},
 };
+MODULE_DEVICE_TABLE(spi, lan865x_ids);
=20
 static const struct of_device_id lan865x_dt_ids[] =3D {
 	{ .compatible =3D "microchip,lan8650" },
@@ -441,7 +442,7 @@ static struct spi_driver lan865x_driver =3D {
 	 },
 	.probe =3D lan865x_probe,
 	.remove =3D lan865x_remove,
-	.id_table =3D spidev_spi_ids,
+	.id_table =3D lan865x_ids,
 };
 module_spi_driver(lan865x_driver);
=20
=2D-=20
2.34.1


