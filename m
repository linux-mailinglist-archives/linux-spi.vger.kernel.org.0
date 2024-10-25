Return-Path: <linux-spi+bounces-5473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7082E9B097F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296141F24B76
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B609186612;
	Fri, 25 Oct 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kJFG5rf6"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB670815
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872913; cv=none; b=DXhAhJUTyEIQnd6oV2FeRbxammnR8DudgcFUuLNy8ICB92icCnFob8pZrpGuFAw8cm2kS2lU8L3sq/qQJY/HzOrzJN18cxLcG8l8I5XHBxaZ1uXHJAJLBsBXm48kN43vXHjQCcV++NmhC2z2pmBGFiG7o4PyhJlcaqcruR3IOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872913; c=relaxed/simple;
	bh=nHzXOeURbNWx8VqXLOzGayVrDlu3FPomdgusb1whZcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HchtqX33ucC+cRQ2FeKTzD63uuDgaBUAOZqgXSKvX9rs+zrG1QdiKbz41SBIMuQCRaJs7FVeUjsmqmkrKipFwUuiQYxQWB0q8rxcwVKc/nAAHl9zgjSL4Zi4VSFNkdl610fqb6dc5EjW5LVn7clV/ZweRFlrqjJZ25k01B/+glw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kJFG5rf6; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D3BCE000D;
	Fri, 25 Oct 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYK6G3Uspykcq9GsoHcgs9KWx8g7DS/IoXmWj78hfcQ=;
	b=kJFG5rf6Rl23MrFRsruvJA05T6GGbMRR2QX4iOj3B6uYXL7roopN42y5lJm0lB7v4N9aXQ
	sDZf3FjR7s5ugcD+d6RUnHIfFJrfdkzr+Y8vvLyS04cg8f6erULdLMV8USedGaUatpcJeN
	wmUYD3usPmkXWXhxb9xBGctoNiCzTozixdpi6FmuymZeG3wF5QfkLxzmr7asup93ePCL8e
	3N5GGT5s5xdto0rQhbF3tsnD/7KDonyaYGv6PPKvvWn/MZ3YDfQTEilUaI4d0UnsaCfpgf
	OC1EJdjTzKT8wDWZyC/Ht19mQrTAotZx+mJrm7ZU0WBGe3YiK0LbW9fmRo+y8w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 05/24] spi: cadence-qspi: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:42 +0200
Message-ID: <20241025161501.485684-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Every ->exec_op() call correctly configures the spi bus speed to the
maximum allowed frequency for the memory using the constant spi default
parameter. Since we can now have per-operation constraints, let's use
the value that comes from the spi-mem operation structure instead. In
case there is no specific limitation for this operation, the default spi
device value will be given anyway.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 05ebb03d319f..d285c7698291 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1407,7 +1407,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct cqspi_flash_pdata *f_pdata;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
-	cqspi_configure(f_pdata, mem->spi->max_speed_hz);
+	cqspi_configure(f_pdata, op->max_freq);
 
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
 	/*
@@ -1655,6 +1655,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.dtr = true,
+	.per_op_freq = true,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
-- 
2.43.0


