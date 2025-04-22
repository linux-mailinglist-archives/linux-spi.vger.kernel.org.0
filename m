Return-Path: <linux-spi+bounces-7700-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1EA95BE2
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A653A1664F0
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F026E173;
	Tue, 22 Apr 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukwxnxS4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D926E168;
	Tue, 22 Apr 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288327; cv=none; b=Y5WiTqT437ZneoKD/3yZNHm6yas/NaGzKuibU35ZuFSMseKkeVw3VaAZf1o7rwGYt76B2zD6Cevj5bztE1CDp3wjsBPbl6Qfx4az6iPXc84nil2GBF4c6futUj9n0EmsSG2YSlV/L2G0Lf/HDTUCvPRqcPMBeyW1fGykWRgtNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288327; c=relaxed/simple;
	bh=KvDZ7mCzuTOxw/CCqAMaB+URIEE6MZ+aoISGUCA8yYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWqjePiBXqcqlUpL+rI6517ItCmXGlb/zwRpBFyLN24ZInecdot3FGiBEkKuU0QsD8a11r/GA5Fm9Rry4IxjK9LtBe9pUQuOfRoJGF4RAvUzSnihcQXgyQOGntzHsRvlfbBlqHjEaG2cZgxN0hEprmNM3liLxNRI0tmerO+mQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukwxnxS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EB1C4CEEC;
	Tue, 22 Apr 2025 02:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288326;
	bh=KvDZ7mCzuTOxw/CCqAMaB+URIEE6MZ+aoISGUCA8yYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukwxnxS4E9aiPd+zo7kBtgcmVjYH54GcFyibucy9+xyfMed6VSMpPwqSaTXvw9ZFB
	 Do8EJrOEsiKhnKwQFUmdIELZLa6BRlBQU53oFIzNBeUZIOMGstXgrMEOddQPEnHn1g
	 ptFAxbcQEU4DnwXmkmseg2mSMh0fokw1Cur1SfHzig3hUz9ki3JyyvjiSUQUKv+fg/
	 S79PpsLMoT8tz9IaFgIxOo/J3FoSj0anW0vWeY7PttIJ51Ug1qIqVKSs2IOeKXTNwH
	 M9Fgb7v8n+vjiRz23VVjAFr/8umjB4RBxNnq7iYlmLXuWll6XFlCzMVcB4u8NkGV2H
	 U+aYMo96LLgcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamura Dai <kirinode0@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/12] spi: spi-imx: Add check for spi_imx_setupxfer()
Date: Mon, 21 Apr 2025 22:18:26 -0400
Message-Id: <20250422021826.1941778-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021826.1941778-1-sashal@kernel.org>
References: <20250422021826.1941778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit

From: Tamura Dai <kirinode0@gmail.com>

[ Upstream commit 951a04ab3a2db4029debfa48d380ef834b93207e ]

Add check for the return value of spi_imx_setupxfer().
spi_imx->rx and spi_imx->tx function pointer can be NULL when
spi_imx_setupxfer() return error, and make NULL pointer dereference.

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
 Call trace:
  0x0
  spi_imx_pio_transfer+0x50/0xd8
  spi_imx_transfer_one+0x18c/0x858
  spi_transfer_one_message+0x43c/0x790
  __spi_pump_transfer_message+0x238/0x5d4
  __spi_sync+0x2b0/0x454
  spi_write_then_read+0x11c/0x200

Signed-off-by: Tamura Dai <kirinode0@gmail.com>
Reviewed-by: Carlos Song <carlos.song@nxp.com>
Link: https://patch.msgid.link/20250417011700.14436-1-kirinode0@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index df73a2c7120c9..13a6ebef01894 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1605,10 +1605,13 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
+	int ret;
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	unsigned long hz_per_byte, byte_limit;
 
-	spi_imx_setupxfer(spi, transfer);
+	ret = spi_imx_setupxfer(spi, transfer);
+	if (ret < 0)
+		return ret;
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
 
 	/* flush rxfifo before transfer */
-- 
2.39.5


