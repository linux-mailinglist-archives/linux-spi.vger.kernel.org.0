Return-Path: <linux-spi+bounces-7694-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102DA95B8E
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B7E176B75
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8261EC00C;
	Tue, 22 Apr 2025 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aACARbYm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCD1DB125;
	Tue, 22 Apr 2025 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288279; cv=none; b=G10x6VjvXgGft7ulCXhICipfkqvwR7BdhiRo7ra2dEozjLZ49GgIF/UM7QCE+Lm7uNj6kgxzoPX1wWe8QGISgdmIp9Ayr/UYx1zlkuonufg4l8my/8swYsqZsuyNVgxpEsq375FvrWwGyRGJlolACNnXOki+T3qE6Bw8b1jEsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288279; c=relaxed/simple;
	bh=IhFB+xbbde3u59vOfCyH+wwyKbhpdWvK4JV39dU+oWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ne6BI3jpJSDinL7Spy0AM+PcmuwJbQvQfIJ5MtOi+JmaVaWo9GdFUGSTzpOfAkBi2TJ+IxjDdJHO0XRQq1tQcwBjVnzitbVRlSg6j4DYNJ1Y4Mw4lIaIzF4z+8mrJu/SXaXHHp0pJN30U97+Cnf5lJjJZy1qoUqSkT0Wd9dtrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aACARbYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A47C4CEEC;
	Tue, 22 Apr 2025 02:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288279;
	bh=IhFB+xbbde3u59vOfCyH+wwyKbhpdWvK4JV39dU+oWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aACARbYmSVtYFVH3w98jkfjKZjTNVxWnMdfWnzAowwkbaTF/R37eLab4n03WMKLSI
	 SaKwgZgH3T4Kj4BtAHn2wq/1mz7IzBgd+NHdSjF9MP3Jiyz45dFjw4GtwupWxz6Z/K
	 bXM0JqofbkviSFQTysS90P5OmPA84zXml7Ofh64rghlp8yPrUzXpNSXnEOYiDFahWs
	 c4tkzkS+jZeTo5OJ4scKdlgBDIsxrOfvsVLboru0arNJdcMJzalTyCzRtbSzcWv5VI
	 5kTz8bH0mnVDH0Jfbz23xSoDfuC54SoCwRfXy/GhstXte8eONDG57xr1qcOgFyW4n8
	 0cfibUzO/8hzA==
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
Subject: [PATCH AUTOSEL 6.12 23/23] spi: spi-imx: Add check for spi_imx_setupxfer()
Date: Mon, 21 Apr 2025 22:17:03 -0400
Message-Id: <20250422021703.1941244-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
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
index 4c31d36f3130a..810541eed213e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1614,10 +1614,13 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
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


