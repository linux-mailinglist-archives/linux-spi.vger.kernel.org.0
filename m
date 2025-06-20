Return-Path: <linux-spi+bounces-8688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C432AE1C39
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16324A1547
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6AC28C87D;
	Fri, 20 Jun 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCN2peOM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5628C86C;
	Fri, 20 Jun 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426192; cv=none; b=OPu1Na3Dx/7MmC0JVc1Bz/c64NYye/+zfr201GppXVqfEWRrOmctYlt+bI7u7ePiQ9CyDMJ/3zMJP1VJsFrkou3O82D1Ter7f7H5Anm0NgO7+SWHFkPqHZDzYxfCkytOfPI2XaSGhhSifTuYazySDpE+EyDYYb3o+HLQyxwwbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426192; c=relaxed/simple;
	bh=wMCEdueOEnPJnfKEZa6a6pKrV+7m581v06Tv718kKM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrWTaJFDEIN1S3nM2momT0k9ySrDvkhLKmnjIi9ZoM7BjLN69Hr5r/1CgFWG7wB19CTF5cUMOgbLOvsRAWfnRe1LGHGAOrmH8f2njINJ4YcRXd7639IvgYfz7WGOkiNu8npHRdWxZCEubQs+u21KDYpUnREU1quq9RGAw6IVE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCN2peOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97958C4CEE3;
	Fri, 20 Jun 2025 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750426191;
	bh=wMCEdueOEnPJnfKEZa6a6pKrV+7m581v06Tv718kKM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCN2peOMYLJqNpdwFSUtBPShcuxG8BtAI8IRABDA/fypiOS+xFvsZ6IhExue1gWLv
	 PBipcaVhkX+NZ7VRI79wxKfo4GujJ3z5EkXI8wvj9NNkUi0kR/WAA8eEMpEEbrFwfZ
	 nLPs2eWD+apqvIBLOzHxWxxj0rr0QTA8AZMS+1+Y1r5Q8U/xNY2mX1y6Npx9VOKtwC
	 oEzaElmLFp513E+WPGC5yJ8mLN6ZF2pA6dgTaF6I6TApHP9sIL8KqQNw6jOa9Mn7AZ
	 T3yz3cscIapFNwJil3CpvamFaMUY7mNGJPM8pEgvWTHDJqp+kAWjpVMICmDWABIBRF
	 Hi5S+x6XU3Sxw==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] spi: microchip-core-qspi: set min_speed_hz during probe
Date: Fri, 20 Jun 2025 14:28:24 +0100
Message-ID: <20250620-drained-widen-ac311bd5f172@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620-finer-yoyo-0bcae988a299@spud>
References: <20250620-finer-yoyo-0bcae988a299@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=orpLnRq5nmIm7nv6mr3mpjzM37qOjt84M3FbOzOJkXo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBmhid8bP3fJW/l5vP1SwfjXJnilUbrBBKvVgtEvOJLtF 0UmPnvXUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInMt2dkmMW7znRe+GzW6mP7 2szrwnXyXvzyeXmI//DFEqWT/ZvK9RkZ3j9ucpBP3dr4x6wr84H4Yp9ntnN3HjsaxrEkrMCUt6S AFwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The controller's minimum possible bus clock is 1/30 the rate of the
input clock. Naively set the minimum bus clock speed the controller
is capable of during probe, assuming that the rate will never reduce
further.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index fa828fcaaef2d..111ae6519ff41 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -562,6 +562,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->min_speed_hz = clk_get_rate(qspi->clk) / 30;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
-- 
2.45.2


