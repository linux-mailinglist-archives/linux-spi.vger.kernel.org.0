Return-Path: <linux-spi+bounces-11184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E5C5679E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6321B350819
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD8338928;
	Thu, 13 Nov 2025 08:53:42 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D1337BB0;
	Thu, 13 Nov 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024022; cv=none; b=q477G4RfIX7T0j/iFzUTBrNNzWY5THSYLxcJNj40sjpxaK/9hXLtFDLOl0sykOT5IyhTJLK3Sk1UneCjoKl2jeoPVcOEFBi6X4k3L8ro0EyMIwE7oGS5u5yy2F+cM5Plj8jCxLU4dpTTOhYqVnF0dx0LwMSLdu+K3yk7RbhxwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024022; c=relaxed/simple;
	bh=y0R355uAebCKJwwcxV5wFFdVmXK5xnO/pzj3PYhKo+Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6HgECuu6ai8p0N+kSf/gTTbU5sj8a3YZkuQLt5rIvV1t6eFbKgvvNz4+F0YzImFGOZvhoqeI3v8rrV7inGo0T78Cm8CT+OwE5KYmrs2Fln6wDbtfvav6z5rOuOA7Dj3wOwP4HH64s0Cq+ohvf8tXZFV66kKeCZpDvSXyT+76VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 13 Nov
 2025 16:53:33 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 13 Nov 2025 16:53:33 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<clg@redhat.com>, <broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/4] spi: aspeed: Enable Quad SPI mode for page program
Date: Thu, 13 Nov 2025 16:53:30 +0800
Message-ID: <20251113085332.89688-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113085332.89688-1-chin-ting_kuo@aspeedtech.com>
References: <20251113085332.89688-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Ensure the controller switches to quad I/O mode when
spi-tx-bus-width dts property is 4 and the Quad SPI program
opcode (32h or 34h) is used. Without this change, high-bit
data will be lost during page programming.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 179c47ffbfeb..4163632fed8b 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -263,11 +263,15 @@ static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
 				     const struct spi_mem_op *op)
 {
 	int ret;
+	int io_mode = aspeed_spi_get_io_mode(op);
 
 	aspeed_spi_start_user(chip);
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, op->addr.val, op->cmd.opcode);
 	if (ret < 0)
 		goto stop_user;
+
+	aspeed_spi_set_io_mode(chip, io_mode);
+
 	aspeed_spi_write_to_ahb(chip->ahb_base, op->data.buf.out, op->data.nbytes);
 stop_user:
 	aspeed_spi_stop_user(chip);
-- 
2.34.1


