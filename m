Return-Path: <linux-spi+bounces-7328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D38A71D19
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EF8178317
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C321577A;
	Wed, 26 Mar 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VE7+O4vO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BD2045B0;
	Wed, 26 Mar 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009930; cv=none; b=S1/6st7rPjE4EiSmWWrYJxepWWCy+pgZJYjwm6WhG9ChlcM8C+cTyyP8Qs8Qi5r0srq+AsH6nKxY4MTq/e0p0vlxmHKFBCiRB0y3V8Y7EvHzorYT1y66+zkWxwGP5exMHXtPRtRb5PqQswYCCPnBlIJfDD2W6PfclbfihIq1WsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009930; c=relaxed/simple;
	bh=4xpFGtrF5dg9n6Tq2W6rWfUIQLdcdUdHf01Fz54ZoYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7dWjqNblkgmiZmmJl4YK6Ujo1mE98nFigs1i5sW4Sap/iPB4Wig+cOcyTNB87ISmZbFfCoMHnNfjauxnTiwoe3qJA46zNzJSw3vV41ixvPXdXX04aG8pUZFzIr5Naw4eNSvxvPCClyvIsL88vDOefy5Z01e7rwKiSfI5MFHSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VE7+O4vO; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3574A101CA7F1;
	Wed, 26 Mar 2025 18:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743009926; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/Vhwv7L1RuBItYtm4Om0dbp42wUxgwI2TCiRaX1W1Qw=;
	b=VE7+O4vOKIlJbBmYNFZi4VQgbkeNU71IKCE7CN8p74poRZCM4TR48b/YdoQF6sqQF6Rq2d
	5OqYJjWx5zCtRqxe+fzKevBqf5dBndppckdopM6MMxZlW9u4oBhDrDRN4wnuafPwbFQaKO
	8NN0jCxXOrGuutretZeOAbHfv+WUGjunH0t/Ib/Oba/MfhHBMpH7TiVTf4qVxeLvq7Em2U
	eiGHHpcClaJ6l81apGvFB3MToBAd+1Ed0dqKkIbUocaWmISF1RvyCrYEt/sS+CLsBxZOR+
	Ow5l/BpM1bqx2ReOvgVHhjd/L4EQB9Jt8Nf309mA69Rbkq5RjMPy70ykJWVthQ==
From: Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] spi: spidev: Add compatible for LWE's btt device
Date: Wed, 26 Mar 2025 18:24:45 +0100
Message-Id: <20250326172445.2693640-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250326174228.14dfdf8c@wsk>
References: <20250326174228.14dfdf8c@wsk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Liebherr's BTT devices are using spidev to communicate via
SPI to monitoring devices. Extend compatibles to allow proper
DTS description.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use 'lwn' vendor prefix instead of 'lwe' (as the former one is already
  well used in Linux sources).
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6108959c28d9..2568240490fa 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -708,6 +708,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* elgin */ "jg10309-01" },
 	{ .name = /* gocontroll */ "moduline-module-slot"},
 	{ .name = /* lineartechnology */ "ltc2488" },
+	{ .name = /* lwn */ "btt" },
 	{ .name = /* lwn */ "bk4" },
 	{ .name = /* lwn */ "bk4-spi" },
 	{ .name = /* menlo */ "m53cpld" },
@@ -740,6 +741,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "gocontroll,moduline-module-slot", .data = &spidev_of_check},
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
+	{ .compatible = "lwn,btt", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4-spi", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.39.5


