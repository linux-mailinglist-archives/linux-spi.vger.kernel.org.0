Return-Path: <linux-spi+bounces-9345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13782B2110C
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4581B683294
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D8311C2C;
	Mon, 11 Aug 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CDVr01DL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D4311C11;
	Mon, 11 Aug 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927361; cv=none; b=cXetn3WwV0RpyFoQ4RGXD54x5Sv5mpuOx9ZYuAxhvszgJ0rauUJ1MAGnr36lxyPs8Sei7q46hfBM0KGXdx9rxv2oRMHB4mEKgkD3hMXe2AmE2q1EK7hEzyumiT6tKq18cEk6czI/ed4qYtzBM054+f8F28wKl8/1l6uEgPbkPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927361; c=relaxed/simple;
	bh=Hgz0GH9KkAA2A3iaMEZ3uglvHCAsGyz5cd2dwHmsJD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhzw0RlC9LbaEkvLWdr4omO+wKvW4HHsexznB6SsmH6Ps6SZo7XXiI24ftYahPZije4i0O7uoiXfUffKPmoAW0ZI7dOP8WLo+RhBYez2vYVUdpyLnZxOdONaTiBWMbytAYN8OqpFETVLXbdRIKD0hXrVErARDZvMq0evdEqG+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=CDVr01DL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1754927357; x=1755532157; i=wahrenst@gmx.net;
	bh=enGNwadfiJ/oVGedHPohB/mFksRSDw0yblg2duvrzmA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CDVr01DL3TDrXj7tZnRv2sVqZNQMeW/bgfw3c3Q3tN8T0o/Y2EB3RwT9xNlHxVCO
	 adKFBzi3Q9/CnBlJysBPOAz01ht/yjqrS0/cEETypK6VJvgEWtQ1cLrWp2G81Yy0X
	 1dcPk5MujvuXdUYSV5/YHiCDkvXeR17fEOTmcUB1Y5o6i+Py4qyTSVG1ZIzIaCSga
	 xIJ42K0h5k1aO3jriALISauZC8yhCFnR89XOkhQhsgXBn9xwpaU9/8NjOvALt69yk
	 VAI42ZcU2CWbXrIoWlsqwL8YVIy9rTZ/pBgPKprFu+ftLxORS1NS0nDR/a/Q0iwlu
	 jt2YxProSVBhG50Baw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1usyDC2Ern-006Vqx; Mon, 11
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
Subject: [PATCH 3/3 net] microchip: lan865x: Fix LAN8651 autoloading
Date: Mon, 11 Aug 2025 17:48:58 +0200
Message-Id: <20250811154858.8207-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:i1mYOZXL2e6pj6xQfY7BB40JFWMv2jxzJEzTR/JbeXbk3HOFwxA
 KREpPa9J+xW/JocHDaAr0j2VPrJgdw+J4LFPdWyb3IoolTIDmmUUYr8QwytEjkMZ2vFXxrQ
 gkV856C3h/bKZ+ihsYAEQv+8rr+66mSjzs5ItRXXh/9HrBBrKFzXcewksm3NpKv3hEkckky
 4u0TqAzkpUCFzsxN6XTlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dAGcJ7WOPzg=;s1hsmXiWguySO4lRmLi4n1+ikkw
 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
 DO6Hi2LUyRQ==

Add SPI ID for LAN8651 devices, which is also defined in the DT bindings.

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip=
's LAN865X MAC-PHY")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/ne=
t/ethernet/microchip/lan865x/lan865x.c
index 190122feb2a4..bf2f8291d817 100644
=2D-- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -404,6 +404,7 @@ static void lan865x_remove(struct spi_device *spi)
=20
 static const struct spi_device_id lan865x_ids[] =3D {
 	{ .name =3D "lan8650" },
+	{ .name =3D "lan8651" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, lan865x_ids);
=2D-=20
2.34.1


