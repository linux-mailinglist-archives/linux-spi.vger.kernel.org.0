Return-Path: <linux-spi+bounces-9347-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04BB21132
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A87417D419
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4AC2E11AA;
	Mon, 11 Aug 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ub1yLU5s"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656B2E1C79;
	Mon, 11 Aug 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927373; cv=none; b=cHLr9q2W1Fg6dRJdypucQKW6mBkVPJCXxS5uQFLe8GhQII4myzbKA7AbBy75MJFW0ZbmSs4SAKEVWpbT0nTB2lYda6/+9FBFDwybF1CWvz23KSVlI5nYDonab29Hxg7U9PKQkym3oDEQjlBSWTDQ7t9KTu0Ol7OaT9QlvYYWy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927373; c=relaxed/simple;
	bh=sddFAvzGffV2xsFOQsgk436m3MHPkgE0Y5tUuKdUTfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C88hGgJBL6VmGL48nyPePzj6kkH1Dv8aMS0hR8DJisqA/agEK8tPk0dKKPLBv2p+CSMOZ9OQWJXrUhIGyElkdnQD35FLdD00ynuUb579m3FOXbycS1hREmPArBDGh0neCidcDYcezhLipWz3vBitYy7XRv5GVOcOhmEaKhViiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ub1yLU5s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1754927357; x=1755532157; i=wahrenst@gmx.net;
	bh=2NMbOWtt00pnSQEdML15kIg5Is9ykPYip62b0/oCXLo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ub1yLU5sVx+PkTb2fcBWZyiyOKLluQJBw+fUVdGEkqpL/PddF9vPH0Ud8yWH7yob
	 BE864nsoYrWZ9lRNmydWPcBywI7ZlZtc2dyAu8+3q6qmFiyQ0Y+LPkRNBwySG+RzV
	 ELxjsBuKA+s3sc3IGbcLbgRiRKz+7JnZemM8yBWziSzrTCzd0kFlP0ZPofOeJDxGd
	 wrbqp14my1QcGYJj4j0RBNzMnZCfZznrpz8xQyqH6+C4qjvNZphPrUF/7v6s8gAgj
	 9eQw5gKDz8w/XlJamCMzlUG5qMlpLtfNnL54j7tA/wuSaQsa1nBfr7dbYjWSSnw48
	 Wubp+rqQGIgs9csw3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1uBLbV0oJg-00nW7I; Mon, 11
 Aug 2025 17:49:17 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/3 net] microchip: lan865x: fix module autoloading
Date: Mon, 11 Aug 2025 17:48:57 +0200
Message-Id: <20250811154858.8207-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811154858.8207-1-wahrenst@gmx.net>
References: <20250811154858.8207-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ydb/XEGo53B9cx+qSOJM6I4SUta1/z5Z8Gh+3WzsZ+iHnA2/dW
 cR7+Tvmyh4Z/mm95GQf+q6I6yDAHQulVFbekmc+LF+D0eryY3aOHaSk+ZnCPw9Dst6oAi8t
 DIXH8VSMcbRQfDhrApZSgsZnWtc9PR2koPVz9DopGQfyw6ycqqGirREmoMFyc94WzFcjGX9
 MhK6p8qXVdLnK/kEWlCIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yiOprY96Wtk=;+wzZ9UXuBa1S9USj4qF4/kXk8OZ
 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

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from spi_device_id table. While at this, fix
the misleading variable name (spidev is unrelated to this driver).

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip=
's LAN865X MAC-PHY")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/ne=
t/ethernet/microchip/lan865x/lan865x.c
index dd436bdff0f8..190122feb2a4 100644
=2D-- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -402,10 +402,11 @@ static void lan865x_remove(struct spi_device *spi)
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
@@ -420,7 +421,7 @@ static struct spi_driver lan865x_driver =3D {
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


