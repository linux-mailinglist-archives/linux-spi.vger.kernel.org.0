Return-Path: <linux-spi+bounces-7790-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFD4A9FB86
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3992A16582E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492452139B5;
	Mon, 28 Apr 2025 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="itgL0QKg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885B20FA9D
	for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873989; cv=none; b=u46D2iymWEvotWwUOSJJamDmmOmFjGr8mXRIdFzaxau2OLMxxIvkXFSYBcopECx9hP/5+5ThueXs19+HPO/7kIL189TlvXBr60mNsCz87ysH9gsEK2Tp9di5T+KrABwpXps5qDM/Bb4sQ9z1zugvA2HpGOkSbznqmuulEC3DEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873989; c=relaxed/simple;
	bh=Hot0Oy29xwQca3fFwNhjd1qoO8ecKD1UEJkmEF7N4c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmYtI8Hx6PPOfbrkvYpOJxxjE4w5mD7CZMPVIkjbqSJ4NsT1duQJasGl1la+ANLVIniylw3rEuSYRoFaWL1JjC0PqlZdAKzoQMleQgd5EbgW3F1WLUMOYaqPcHArPfTDurdn/MBRbX1BdpKnO71y0/ZXGbdKB1f/nsKGMpELL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=itgL0QKg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72bbead793dso4278952a34.1
        for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745873986; x=1746478786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgkMltK7c0hJCGj044bGbv6mIEyEY9fELxtEWcXT/oU=;
        b=itgL0QKgQ3EwXiXtNZ0zY0P2e4pxyMaUHgh48B6FeSS/60KzGQ5C+tMDBy4qL5/dyd
         pwca0p3XgvM7xKSpucs9npVeUJFEA7pR0rtuOrrR1pcKGPGO09pIUl48DNd/to2RGH/k
         SwSHN37Zgjf495bhNkKvrM369WPMTuftoNzbbsPRurkf0TWt9SvLLw+SPft0DBQ4gAXQ
         80Z4f01IewNqN3y93G87wUxPxgfhJK/zZL+pDdo+Sz4+lbQlTUD4pz9ECxFBfoZzNNP2
         +akBoN2h61O7mwiqSNfRYpz0Sor0PLa9WHD6E/JELUJuE+ymMUH4DbfgNwQMjYEf/GY5
         Ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873986; x=1746478786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgkMltK7c0hJCGj044bGbv6mIEyEY9fELxtEWcXT/oU=;
        b=GEF5WayXaOn6i141dg1wzY35DzZIaf9vKbQpsgW5smB/vUlujLgL77Zkk6fwNf7FC+
         D7b5h2VkIc+CqaU0ExhBXtLCG8KiqjwB8juOrjqc9SYaBQ+sDtvBU4jve9qkxLHaGWto
         NFH+NoIin3NDSaeeNLYEg/OLjhTjn20c8Y/kykwbHMhX4xjptLeVY6dWaQCFVaJkWowm
         Ml+O/XutHHo+nTlg1ZbBxSVHOWESQK32bFqTBbPRrO1I4A33oO1Gl24ChAkJrXG2aLKy
         IbcXl2olxPmseCQBVqOkRoXClZtaeQqytAd9vKI2J2LxdqMV/y0psQEuRTLkenn2Jyt2
         w1xw==
X-Gm-Message-State: AOJu0YzvBz8wwgSUYwpPseEQNl8mx7XeoJCUTCCgYx0OxjKiyA1DDiIQ
	qx51TX0ZKLva1MS0amCsFvlGtP1TiLzVTBCcyQNMfwgvWg/kllVuxm+5l8G+kZE=
X-Gm-Gg: ASbGnct1A/OYt0jb10a190xpqVVCKV7y38n8G7i7ze2kaeR6caPS4cg1JVUJHfT6fxP
	/OOHcflMkd0frGvzw+XXUozE5/B/T3xL+fffIJsCD2Kd3+SyPNphvz/krNj3kjnPndtiFYfEWNs
	6llTqiEudUOAaEyGOK8NNoap4y2yMoW70l3FF/RgqDp6JiFQI/eUc0hHsXwOWDeHe6iOs5LJm9G
	QbDFjPz2QXAn1QOVLsFWfU87hzmhM+lAi/o9eHQoXKelBbSBgl2e4i1iQHP2ltgvtjSsbgebhF0
	H2kZ+FNmjjNAg5CfaW1krbQ/bcU3ow+nxUQcp4lcEC5cUe8=
X-Google-Smtp-Source: AGHT+IHBjFNxaxXK2uTmSjmKOErKMPwPnwLBjXcUoUMiKswS0jvYT4ChJ1QEqctONlEWTN+lPYxlFA==
X-Received: by 2002:a05:6830:6409:b0:72b:9f90:56c5 with SMTP id 46e09a7af769-73088c2081dmr736664a34.17.1745873986383;
        Mon, 28 Apr 2025 13:59:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f056ed8sm1907614a34.0.2025.04.28.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:59:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:58:59 -0500
Subject: [PATCH 4/4] spi: axi-spi-engine: omit SYNC from offload
 instructions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-adi-main-v1-4-4b8a1b88a212@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
In-Reply-To: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Hot0Oy29xwQca3fFwNhjd1qoO8ecKD1UEJkmEF7N4c4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+w1ncYpjs/q9honQUN28D/IU3WXnD229sq4z
 jF3zy/aDumJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/sNQAKCRDCzCAB/wGP
 wIC3B/4rdKjJtlFDToqOrIGe5qv6sjXRM3wxFOP9IqRUQMZE8T9KxJaZp0yrem7LI9g9scVAUim
 0oxvvokQ4GE+kFm5pCCLzRThx8kdI17Jins1k98bKAH28wrBFNGM9rhcLlnSP98z8V1KUNOSaFs
 Rvu07RPaoGNETx9Zag6QaaKld9dmpfLTDHX0lGeP/WbyXBXtOLsJQaMZxPMnet+8BBveOZI9Ou2
 0OL8pBcQFanO6gLAf7r+dbV5ceQyzxLQ75OZ0nsPWWIymKrciP8P8RY36h/evzZAMuVHmwqsCbU
 hVY4gRa6aXKPBbNhC2bvQDY5uvrNvzfbq6pRbcVoabo6YNVu
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add optimization to omit SYNC instructions from offload messages.
Starting with IP core v1.5.0, the SYNC instruction is no longer required
for proper operation when using the offload feature. Omitting the SYNC
instruction saves a few clock cycles needed to executed which can e.g.
allow achieving higher sample rates on ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index b54d2e1437c9993d251aa2842d9040ec0949a78d..8cc19934b48b5276f49c4049dcb2dbbeb4112871 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -162,6 +162,7 @@ struct spi_engine {
 	unsigned int offload_sdo_mem_size;
 	struct spi_offload *offload;
 	u32 offload_caps;
+	bool offload_requires_sync;
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -702,6 +703,8 @@ static void spi_engine_offload_unprepare(struct spi_offload *offload)
 
 static int spi_engine_optimize_message(struct spi_message *msg)
 {
+	struct spi_controller *host = msg->spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	struct spi_engine_program p_dry, *p;
 	int ret;
 
@@ -718,8 +721,13 @@ static int spi_engine_optimize_message(struct spi_message *msg)
 
 	spi_engine_compile_message(msg, false, p);
 
-	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
-		msg->offload ? 0 : AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
+	/*
+	 * Non-offload needs SYNC for completion interrupt. Older versions of
+	 * the IP core also need SYNC for offload to work properly.
+	 */
+	if (!msg->offload || spi_engine->offload_requires_sync)
+		spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
+			msg->offload ? 0 : AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
 	msg->opt_state = p;
 
@@ -1055,6 +1063,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 		spi_engine->offload_sdo_mem_size = SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE;
 	}
 
+	/* IP v1.5 dropped the requirement for SYNC in offload messages. */
+	spi_engine->offload_requires_sync = ADI_AXI_PCORE_VER_MINOR(version) < 5;
+
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);

-- 
2.43.0


