Return-Path: <linux-spi+bounces-9346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE1B21106
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AB768762B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0F2E1C5B;
	Mon, 11 Aug 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BpQ7Qpux"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C99311C11;
	Mon, 11 Aug 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927365; cv=none; b=QtqFjPbLsy64CKoOIUiUX15QNgSfC67KCse0M1X8FEIMAvPqDzqjautv6WuuzEtq/Ih4x6Id58AP+1vhtUWZkuWbImNi5chX5pPZEQ0T5DeKdGq+x9mcxa4ZfrN6N6Xh6ThfF+ZnR9NKbTIwSWqo0aBBhnXLgI3wtRn9IVZOctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927365; c=relaxed/simple;
	bh=0bGOXUpc5WLtuTTVybp1aSQKWOYrAH8oXKNn0n1p9g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hr0v6UVWaxOU/Prl1WpqzlxYjzBya4DKjAejUJ5Ll8TFfqhZg1Ms+EdCB7+j5TQdPKzFbBurIBqjdJiN2gvSfBUIsCV0Cbc9pabynkdFGTwdbyDEPeI/661JJQY62nUEN6MCXxL3FT5QbTyIeLsBBfkDoKxF86EHtr6TCZkdTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=BpQ7Qpux; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1754927357; x=1755532157; i=wahrenst@gmx.net;
	bh=tVKkRo0hIxV5OXPiWt0nwFUyWBjXLj5ga1KUsbMzwz8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BpQ7QpuxW6uLFCdqT2B6bi2MaiVTOCmBgUyAFiqisoypOH05p9FPrdw5ZkxMxVju
	 Du5ruXe+iClsBqWnwrRlrNmRK71l3CXKcK9BNvtZxFoQGHsX+IZKtFpBA+ZaHxc9v
	 Cti2cSIA0ytun9qK+0Zc0lSOKNgeWFc8daZ+h9ZsZa09qTUKsNxzap8PnuhISuMBJ
	 Ezn8E9SvZ1lajkZgmy8SBCWiAuz09UMRgCJALVWbHfpmkT25s2Gk5uiRcYynEFZu8
	 fa5+3eaaWIYQK4PdP1WpH6IZ6R2F6bQXiXIhspU1gE+c4iEOu/uSq5+ZmLcaTPHIs
	 JjR24kJ8A40QDrW2Hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1vAdaV3Y8F-00OBGJ; Mon, 11
 Aug 2025 17:49:16 +0200
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
Subject: [PATCH 1/3 net] net: ethernet: oa_tc6: Handle failure of spi_setup
Date: Mon, 11 Aug 2025 17:48:56 +0200
Message-Id: <20250811154858.8207-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:ZsH9c7tHOAFg3A1i3dlX/KSCeCBI0bSvBz+U+hApkIlBd23ar4T
 RWRNhiTwu63ZnUX1qm2GvShaxxCcAOFb5N6qV+IJP/TV9avTRYIANUnIGezPAcyzR6DxDOx
 i146gT66tnzzInx8AjbGjp+wLzjYin92dLd3+42OmGgvC/1Sc+SNglzPiD9xasX24+N6D5B
 hiSKURZtx+lnObTriEG8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+XBMW7iuqgg=;JJltkkKZzwgzPzNzGM4BA/seL4Q
 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

There is no guarantee that spi_setup succeed, so properly handle
the error case.

Fixes: aa58bec064ab ("net: ethernet: oa_tc6: implement register write oper=
ation")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


