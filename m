Return-Path: <linux-spi+bounces-9680-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE44B381C7
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 13:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA30C1BA6052
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB32FF653;
	Wed, 27 Aug 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="U9vEmFFS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B72F6594;
	Wed, 27 Aug 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295646; cv=none; b=XecPIA+FaVSZvcuHIOLYdwa7VocqhkJYQaaDsJQ++j76j3bOvmow8qXtkAqmEQVMxzr9+8Fa3QMzhVE5e6AZdBz0R0pQfnDjLFgNls25b8Fr/C7N3hn0AC1S+9LPTTkelPm9KV7F6LpH7er79vuyZRISgZtNlko63AyHDG0DFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295646; c=relaxed/simple;
	bh=Bg7AH59ONzA+dU+eOq5EBd/IhUHfE6qIQgEg0DbjFj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgJtPLfKB7YnTggc658eD/L5HCuJrfXvdxHHSY6BJ6TLsmkflXdwT2CICwnPEKNM8jcTBGDjwzcv1fFMbLzO8q3p+Y6GngYa+FlGSOfQMp0/THgqmUa4TO3Z1ykNzzzNE5Xo2EfF26B+A1s/otjdsWtGRlX/tncpIrG5TslPmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=U9vEmFFS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756295629; x=1756900429; i=wahrenst@gmx.net;
	bh=I/ReqWnGR+8WCJU9I80toXut/04jo+QUStXqhRvJeJc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U9vEmFFSa6SZZqLrU/tloLXA+WeDVAhS66j5rvJK6YoC6lnT65KKUXirQTq1S3qN
	 3WhGSAtzQIV6iiMChdnvuOCIp2F6vxH1GDWh3W8WFN0E2O70XlEbMPG6EBo06cs6Y
	 kAB1fRE+hOEqzZBnNsZUMqFV87pmf1roCf/hgDdLRXVK/BvpVQUqU8mDPtFeXwWNj
	 E+c0vgTyjOLpulaOH5zMxk2CW7QCgU9g0LsPG7U/IR6tcJIAl1CO87Fa15g0Fhbwv
	 rPLWUtF87kRlaCwo/ccZaKHtJG+mvfeWD88cOAKlAeScxhKDh5BBr7S/pAOXig6JR
	 i9JL242BjP76p1KLoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1v27kL1tqC-00LWnn; Wed, 27
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
Subject: [PATCH V2 1/3 net] net: ethernet: oa_tc6: Handle failure of spi_setup
Date: Wed, 27 Aug 2025 13:53:39 +0200
Message-Id: <20250827115341.34608-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:tc2mqANMBZoIXPGNqv+7ruzoW5dPe3wPL2un1IOqBOrq0DSoTUA
 +eg3SFmKLtvJT/Qf0ocOMIvyNO64t6GK92MUKCDgwT1CVQCezrsL+3XcdNQrZFf0uKbsvPu
 nMLkYcBDMgQQJtEpcjce+cyxql/EYpfhHDebVRmzdgQN/4ZpsP0z5K6CJxPTlwLKxwiv3eu
 2JtAnz5/1CBZuepy8E/sQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l40hV3wnWhk=;8kk5aiMYbYAZi71QFSfywp3bx4U
 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
 Cc0l2qFaz9FQz6WaAgw

There is no guarantee that spi_setup succeed, so properly handle
the error case.

Fixes: aa58bec064ab ("net: ethernet: oa_tc6: implement register write oper=
ation")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/ethernet/oa_tc6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index db200e4ec284..91a906a7918a 100644
=2D-- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1249,7 +1249,8 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, s=
truct net_device *netdev)
=20
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt =3D true;
-	spi_setup(tc6->spi);
+	if (spi_setup(tc6->spi) < 0)
+		return NULL;
=20
 	tc6->spi_ctrl_tx_buf =3D devm_kzalloc(&tc6->spi->dev,
 					    OA_TC6_CTRL_SPI_BUF_SIZE,
=2D-=20
2.34.1


