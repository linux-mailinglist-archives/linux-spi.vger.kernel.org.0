Return-Path: <linux-spi+bounces-9678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D79FB381C2
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E622E9814BC
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CA2FABE9;
	Wed, 27 Aug 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="i0Gtwj1M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05721EDA09;
	Wed, 27 Aug 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295644; cv=none; b=YNAAL0XOhlfjaRPCszjZC2Xb9hE/s58atFFFEihPhg/I8CYbRDIgXbBq9hML05w5Y5vCLxyIJray1hgpvPsSRUADnI56kRCy9zPJt9+cwJzc0KpDyT0BNXk9EhfnlNN4/CX6WYbIfH8h6TtJg6Em5N2I1MlfS7IOOsoQ+vmFsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295644; c=relaxed/simple;
	bh=SEQshoQJ1My/AlTA7S+E6JkBILW27xqYVy9AOO5p3+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mrqfq89LUfpDYzH9aRGAr8/KRLbKWy261AVyTXmLCDFYBgiGTbguBEx4z2W8yBd5MVKZKo8eEPyOzmtcsxPmM2vqFCkQpuqME6o/4pMOyC8TwDk7OGfuE9y0E9zjqbd81VBsg3T0M3ouBBeOAV4EJDUDisE7ZMKJcOERSwkNI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=i0Gtwj1M; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756295630; x=1756900430; i=wahrenst@gmx.net;
	bh=EOi1raod59gQWYFnuQlDhp8+n/cRGVPpcyoG9uXuR6Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i0Gtwj1MgfvNVbi7RjlLeyQPRbHQKsT3UlzSXd7WgVoxe+PfONfGI91H4AxAreib
	 MJ2heBb83l5ZZCghJzoZ4HDxJFN0xge/17/WASt0v3d338f3gcGL9qMq/yeXxCFG+
	 aKc0lRoscoqZs86UIJ9jOiK21EFbXbBxGDQnN5T5S/Z5BOg0GDZBiYss3uA0Uxk+g
	 1QyP+nn3hlb9P0zdkcafYKcYo+2iIHocjNlSG1+cl9xfsVxk4j04yeBbNfdexrn6p
	 cs+Qq4wxqq4NtV1yVo+dx5hwfhJgXut2EhKvl6RbYM/h9WajqBBSCoi6VAlDUjOfB
	 hn+UyNR4oBK1F/eMcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1uypxK0tpk-00Mdnn; Wed, 27
 Aug 2025 13:53:50 +0200
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
	stable@kernel.org
Subject: [PATCH V2 3/3 net] microchip: lan865x: Fix LAN8651 autoloading
Date: Wed, 27 Aug 2025 13:53:41 +0200
Message-Id: <20250827115341.34608-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:J2hEzO03oYZQvDWMbRmPTOz+qj3YMhq7tNv/ha2+B588vlTVHdk
 YHoy41mlJHA0htkIVpVsfjRCuJzv9N/AdhUQWFzysiLQ2vYhxAJz+QWK1XjwVjGi53REhjS
 JR6YaLrKKgO1keQlVTmQZUtEdr3Cj7w55bvs51M5QzPlHZCxgz00hHQgnGGqzj5QVdssKjX
 /Ankf9lUQ0MrTCR6tcO7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E+B/Xz5He18=;t0/EqfXQ/tM7K22BUlUgB72Nvat
 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

Add missing IDs for LAN8651 devices, which are also defined in the
DT bindings.

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip=
's LAN865X MAC-PHY")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@kernel.org
=2D--
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/ne=
t/ethernet/microchip/lan865x/lan865x.c
index 9d94c8fb8b91..79b800d2b72c 100644
=2D-- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -425,12 +425,14 @@ static void lan865x_remove(struct spi_device *spi)
=20
 static const struct spi_device_id lan865x_ids[] =3D {
 	{ .name =3D "lan8650" },
+	{ .name =3D "lan8651" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, lan865x_ids);
=20
 static const struct of_device_id lan865x_dt_ids[] =3D {
 	{ .compatible =3D "microchip,lan8650" },
+	{ .compatible =3D "microchip,lan8651" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
=2D-=20
2.34.1


