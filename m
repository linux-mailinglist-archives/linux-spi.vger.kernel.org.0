Return-Path: <linux-spi+bounces-5470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3096D9B097C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA27B284582
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70C1F7547;
	Fri, 25 Oct 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ewXQiO2B"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2814A0A7
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872910; cv=none; b=A78VW6WjlbTe3WzkeirTjrJro1AWuD7rcywyP5+Y+IPk9GCRcabdkyF0GvrMjyrb6e6mDRlRu/8AXdWKFLAe+3/Wr022W/IlcGfSbrjNxLfP2Z6Je3JlYUy0uoGWItzX1XHeW2oDCDe2C4AAxYMJZF4wHe0OL0mB+TBuxR8lrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872910; c=relaxed/simple;
	bh=WeBodc5s/2Cz+tg3KFMdBjOUZkcI1X5OR3R5cppiylo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc09kmjR2dOiwW3xtx7zqogjvgZEdpwT3AFYqfTzXKALFC6T8d0SpZXiBl3VaBsCOkgjsjc834BFQuuh7L5yKzbagL+9FXEvrFpp98q3ZiwyyZz/K7snIyZYEvb+04BdZGxMQKiHK7+KyzgeYwE9j2ebzTn1/SEh4l0UcKV1U5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ewXQiO2B; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30236E0008;
	Fri, 25 Oct 2024 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MqQVGL8M1OEzNy8JD1tP/grIhYfWZVaAJPj62AjrQQ=;
	b=ewXQiO2BMpQ4Txa7g+dQ0UZKGFHrpbwZgLnOA8f5geG63EBR4OfvynQPfW1JhjaCX4ofy8
	WHCuReHq12y/TVHykEkb4a4EKSK1lBg9oemdg2di/59RuBc0CzuoojhpUgPNViiPXgN2Bn
	sptU9kN5dG2keBXdT/m523ERwMmCmMHzgwuJ3bCUwoerMrcYMlDJoCh4Z2WSrkiMRrGdtw
	dAjy9VPGpdYUSktP8WPE+megwcx0xmaPFakCytQHPrgvWi1ESjB1UmY95RW11MwVY6BcZw
	w4rX6uQazfjuiQZ69/iU/q1dfgoSiqv5A0U4SB/aZ3sqDBNw42A0OhFmj2Zp+A==
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
Subject: [PATCH 02/24] spi: spi-mem: Add a new controller capability
Date: Fri, 25 Oct 2024 18:14:39 +0200
Message-ID: <20241025161501.485684-3-miquel.raynal@bootlin.com>
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

There are spi devices with multiple frequency limitations depending on
the invoked command. We probably do not want to afford running at the
lowest supported frequency all the time, so if we want to get the most
of our hardware, we need to allow per-operation frequency limitations.

Among all the spi-memory controllers, I believe all are capable of
changing the spi frequency on the fly. Some of the drivers do not make
any frequency setup though. And some others will derive a per-chip
pre-scaler value which will be used forever.

Actually changing the frequency on the fly is something new in Linux, so
we need to carefully flag the drivers which do and do not support it. A
controller capability is created for that, and the presence for this
capability will always be checked before accepting such pattern.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 5 +++++
 include/linux/spi/spi-mem.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ab650ae953bb..102d351c3d04 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -184,6 +184,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 			return false;
 	}
 
+	if (op->max_freq < mem->spi->max_speed_hz) {
+		if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
+			return false;
+	}
+
 	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 8963f236911b..379c048b2eb4 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -306,10 +306,12 @@ struct spi_controller_mem_ops {
  * struct spi_controller_mem_caps - SPI memory controller capabilities
  * @dtr: Supports DTR operations
  * @ecc: Supports operations with error correction
+ * @per_op_freq: Supports per-operation frequency switching
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
+	bool per_op_freq;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\
-- 
2.43.0


