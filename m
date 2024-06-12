Return-Path: <linux-spi+bounces-3387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7E905760
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 17:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0D21C21C4F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D097181339;
	Wed, 12 Jun 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqL4E593"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5A181337;
	Wed, 12 Jun 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207341; cv=none; b=aQGNhPHc5OfwAc1Qma8abqYYCV6eCWWsoejYuq4F3/wFETneYV1faZICpK3IVhU19YWlimK3pAxN4F+GPMWU6nSW3lPxBA79ucr8wKOJuoOgyXSEySehZKqObK5zFTdUH9w4QprfrcL3byM308guU69Ljzto4Ae8N2bxVVP2pUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207341; c=relaxed/simple;
	bh=LaagHmLtHa02PqrnfSRNf9Efh1AA8FhF1xWGgB7qiDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgZigFvpafUVuAHudzG88e5gw4qr3JB2exGBrOUJ1IodQshvZdSUIbMuhQVlbV74Bx5lr+5smrp1nVM8+7RudPe4ow9P9A+bIw88zMIcxyELMvptKnSt/TYmXULGQaAiiCyZa1ZO1ZLYaKHGN3Itcb1YTJ3xcwFXZ9t202uKWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqL4E593; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E301C4AF1A;
	Wed, 12 Jun 2024 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207340;
	bh=LaagHmLtHa02PqrnfSRNf9Efh1AA8FhF1xWGgB7qiDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqL4E593HE6FBLtOmyFIOKrIMD5dhcFtcEOaqwRwBYlr1rbWEEnLlf+zTxQsPG65G
	 ofyRr1EkMcr5oB38/1mB9k1dAFO6+hhLIxiySP3+gG+tYPX3W/WIyyArM7LmBzlOJp
	 pe1n/JtogylSDtRVl/c7V6jIga7KJVIUZBt9kS24wUBdwNH6zXXHl/nfUM1HFOWgrX
	 d3H5OPazlmfW+yiIBbwmMvz56hzvj6qAdlk3D/7/XynHvKCVwzO2CP0NEGapX1NXBb
	 LsdvXZFG0HfeubchgL3r6NlvS3hCh4tN0Gse4UlNlG9JN/2hkm0yU3rztyxNQxyPA4
	 vUhU6xhQSehLw==
From: Conor Dooley <conor@kernel.org>
To: linux-mmc@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	cyril.jean@microchip.com,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [RFC v1 3/3] spi: microchip-core-qspi: set min_speed_hz during probe
Date: Wed, 12 Jun 2024 16:48:33 +0100
Message-ID: <20240612-attach-distaste-5c32099c1a76@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612-brigade-shell-1f626e7e592f@spud>
References: <20240612-brigade-shell-1f626e7e592f@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=AySwqgGoZBkSC9iafcJMybZD7Uy/tn7eS25Dxx5hvrk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmZh32tHs8R7f/0n1feU7W14kqKbsjk9CkTQhyVVnyZs uC+/BGhjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEykSJiR4RuXXZvMB8HqXcFv C+00E083mzUE73ea47Wi9hRP4PzyHIa/4pvd6hnvGbExncp1ZFykb6bmnc/84fHZZYnrQ1Mbi+Y xAgA=
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
index 1b23a38c155c..a549911b2f66 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -763,6 +763,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one_message = mchp_coreqspi_transfer_one_message;
 	ctlr->num_chipselect = 2;
 	ctlr->use_gpio_descriptors = true;
+	ctlr->min_speed_hz = clk_get_rate(qspi->clk) / 30;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
-- 
2.43.0


