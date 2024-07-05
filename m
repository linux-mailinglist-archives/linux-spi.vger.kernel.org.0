Return-Path: <linux-spi+bounces-3765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5B928B52
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43283281462
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68A15FCE7;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jASDwhGf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466214AD30
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192367; cv=none; b=nKHZdkGSsyHERvDbGY7HPR5VJp68m+mEZObbrFL89gLseUX+zKc8DRpLYKlMMIgsXv1HG4NIgYhu4mCBDMb/RNqDGKmDpSboOLFvCdP+L81N5dG+Mog93x5Er3o22zAOv5Pfo8A1UX/Wxjdjy1mdJRtZIqO/w4tCvPCetKfEhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192367; c=relaxed/simple;
	bh=LN04TIx4OcKchoiNPQVevQlcGCapW/1hpCrOKwQbg6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reCKzfU2ZjPg2KxGakemxFe27K71YoZmtVMkYtAQwEpTems1qCaLXX2S8IhLpEQ71GBGZJJl//542wWZJlflsxD9260nH7Ki84jBsHXWo4OD/18QK/km1LH6g+82IwaPGQXNKcPtrrpj5WZpMYM4gTQ/d9VA/mlimx0CL7jYYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jASDwhGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77145C4AF11;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720192367;
	bh=LN04TIx4OcKchoiNPQVevQlcGCapW/1hpCrOKwQbg6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jASDwhGfh1Jetf39EPdiA259WmTWiq+bHRzahPCFGHL2Lvj05YC3GTGKYj4P32hyN
	 8sJxF6o0dbBFe5qWYJXoXD78ZMphJfHvCxokTlVcK0qZlDiCJfuT+8+Oes9gCtAWLm
	 B26fOcNPKacuHtjFvu5hslDM+laxGyPdv/BKPneafPJ/Ut+LbXl4JOoBLDBGbveqeJ
	 VntTIq1AA0Fk7HM5reY2sB1RQ+pymFOr+X6G/nCj3lDf1F8m/I0qHjsiEGUgAF3Nxn
	 Pakczcj16OJjFRBwZGmqD1UN+mRQDPd7h6mr3r+JpF9XwgB8x3pJgiVkScRxvOTCxg
	 N/1yoobg0oieQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDCEC3DA43;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 05 Jul 2024 17:12:42 +0200
Subject: [PATCH v2 4/4] spi: xcomm: fix coding style
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dev-spi-xcomm-gpiochip-v2-4-b10842fc9636@analog.com>
References: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
In-Reply-To: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720192365; l=3472;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZgTAmJ7IiP/e7QA90qtxl89+pg3ESD6JiaVtHgJhCxY=;
 b=mmZyYgI6j028rWMPshdA/87V+jdmdoK9pGog9cUMJ7+yuiqzeYPF+aYCnH5vUqMFXU18G+fH+
 s19DqRRY0WXCByCDIqcx/BLBGRy01ORQGEt0MX89FwThPTXolUeQKsJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Just cosmetics. No functional change intended.

While at it, removed a couple of redundant else if() statements.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 1cd7d2b9e11c9..846f00e23b717 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -36,12 +36,12 @@ struct spi_xcomm {
 
 	struct gpio_chip gc;
 
-	uint16_t settings;
-	uint16_t chipselect;
+	u16 settings;
+	u16 chipselect;
 
 	unsigned int current_speed;
 
-	uint8_t buf[63];
+	u8 buf[63];
 };
 
 static void spi_xcomm_gpio_set_value(struct gpio_chip *chip,
@@ -82,8 +82,8 @@ static int spi_xcomm_gpio_add(struct spi_xcomm *spi_xcomm)
 
 static int spi_xcomm_sync_config(struct spi_xcomm *spi_xcomm, unsigned int len)
 {
-	uint16_t settings;
-	uint8_t *buf = spi_xcomm->buf;
+	u16 settings;
+	u8 *buf = spi_xcomm->buf;
 
 	settings = spi_xcomm->settings;
 	settings |= len << SPI_XCOMM_SETTINGS_LEN_OFFSET;
@@ -96,10 +96,10 @@ static int spi_xcomm_sync_config(struct spi_xcomm *spi_xcomm, unsigned int len)
 }
 
 static void spi_xcomm_chipselect(struct spi_xcomm *spi_xcomm,
-	struct spi_device *spi, int is_active)
+				 struct spi_device *spi, int is_active)
 {
 	unsigned long cs = spi_get_chipselect(spi, 0);
-	uint16_t chipselect = spi_xcomm->chipselect;
+	u16 chipselect = spi_xcomm->chipselect;
 
 	if (is_active)
 		chipselect |= BIT(cs);
@@ -110,7 +110,8 @@ static void spi_xcomm_chipselect(struct spi_xcomm *spi_xcomm,
 }
 
 static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
-	struct spi_device *spi, struct spi_transfer *t, unsigned int *settings)
+				    struct spi_device *spi, struct spi_transfer *t,
+				    unsigned int *settings)
 {
 	if (t->len > 62)
 		return -EINVAL;
@@ -148,7 +149,7 @@ static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
 }
 
 static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
-	struct spi_device *spi, struct spi_transfer *t)
+			       struct spi_device *spi, struct spi_transfer *t)
 {
 	int ret;
 
@@ -159,13 +160,13 @@ static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
 		ret = i2c_master_send(spi_xcomm->i2c, spi_xcomm->buf, t->len + 1);
 		if (ret < 0)
 			return ret;
-		else if (ret != t->len + 1)
+		if (ret != t->len + 1)
 			return -EIO;
 	} else if (t->rx_buf) {
 		ret = i2c_master_recv(spi_xcomm->i2c, t->rx_buf, t->len);
 		if (ret < 0)
 			return ret;
-		else if (ret != t->len)
+		if (ret != t->len)
 			return -EIO;
 	}
 
@@ -173,12 +174,12 @@ static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
 }
 
 static int spi_xcomm_transfer_one(struct spi_controller *host,
-	struct spi_message *msg)
+				  struct spi_message *msg)
 {
 	struct spi_xcomm *spi_xcomm = spi_controller_get_devdata(host);
 	unsigned int settings = spi_xcomm->settings;
 	struct spi_device *spi = msg->spi;
-	unsigned cs_change = 0;
+	unsigned int cs_change = 0;
 	struct spi_transfer *t;
 	bool is_first = true;
 	int status = 0;
@@ -187,7 +188,6 @@ static int spi_xcomm_transfer_one(struct spi_controller *host,
 	spi_xcomm_chipselect(spi_xcomm, spi, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
-
 		if (!t->tx_buf && !t->rx_buf && t->len) {
 			status = -EINVAL;
 			break;

-- 
2.45.2



