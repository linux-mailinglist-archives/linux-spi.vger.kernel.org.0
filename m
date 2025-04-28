Return-Path: <linux-spi+bounces-7788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54549A9FB85
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 23:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA973BC5EF
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890620F066;
	Mon, 28 Apr 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DmLOTPdy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258920E021
	for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873986; cv=none; b=L83V/8bHE9KV/1aPrB+d/O6b1smGssluacEf6l+OurspdEw2bUYe8MEmK4lXfsCvmmdU8m0P0hlhU3yJkCTy7jrxCJjOps879ouiPL87yby6iXBYraXVEWRaSto6kUUHPe+oK1K+EP4pHE4CaP6LeWCXBzwBHteuvjqSavR7mP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873986; c=relaxed/simple;
	bh=4YUyAmqj6DMqtc0zwouOnq7KPjPXOMqMgSZciQQWnro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7ML8fBUKq6QjtQqSkS5fupWweIYOCnXntSgGTH4dKWGVWa1iGbP/XobVxFi0ABt/JGFM6GeggFzit1PnppbN4py182ocSSGSAsuNqQW9imOa4SP49kWoXKsjU0mYUqNH25+wQtxwXMqRwZZ9++dYmsgxlY59CJZ4H82V8yi7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DmLOTPdy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7301c227512so3155896a34.2
        for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745873983; x=1746478783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6lQOjzQQhFPGZyqHYohzhwr3/IzfWMuRpfSMF+bnRg=;
        b=DmLOTPdyuKxtpEVOax4fJuIRfwwjBMl9eKm7afA9mQiBB6TF9XtTm4wUHskbQQ1Uks
         c4PgsNZ1E11eRr7xb+mhiQQj5WStadXiJKNJCI22gG+wAWy8EitEzS7XFgmrPNyu6t5v
         RiI+6ubi942OAfsLFJFJ7op/WG57P8XEGn89VZCpJV5oBkHOC4opJk+1g22nvQ87Enju
         XAnQpar2yFWU5bksr9G+WJfc/2uiGhJVDvTB2BS+6CpZCeBL8cWMof1g4nt1UKw6jI2r
         qd83C0Sha8AbkihvtQt1RE/C3TRRHrdufrRz+Lqws5cF9BftUX+FYwhby4KoTVSDAJyT
         ysCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873983; x=1746478783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6lQOjzQQhFPGZyqHYohzhwr3/IzfWMuRpfSMF+bnRg=;
        b=UBKxlVF995cxUV+nJLDmn+qIFVvJrym8ihbdeCSUV8edUbDq6Qtlo2GX9tjYrFUz4b
         P7PBQ9/H6YamI9Y5EWaUafYDox/c+22gxOu2yco/UTl0DICve8mPwz0uo46yY5w5EJNS
         AltACu1sQtiCOiIIJMiQUzH5hdrnsjSMEwSihx5/7Z6Vzy8Dim4Uvbgh09JHfvB3RK8D
         VrfwtI0OvQFcLK7CLtnrFKrAUrW81iB5/108SqaHA1tJN6aIwAdwJvcXvfv0gCbk08Dw
         shbQmm5oirVTx3Ba6ovk2LiGiqrSkWwTDXW0zZ/yV+b1gy1R8LI1sW9wssfLSDOTh8lw
         Iukw==
X-Gm-Message-State: AOJu0YxRwVm9M5qKMkAjy3KHDWlfX1eYEZA1VYCe175Mwby7Omyr/f3L
	a1vFY8I/L/YZSnLkI9vvAnKbBGW1/9iS9eYdv9UwgM/UjO1ZFHAOi1B6SpK0V6Q=
X-Gm-Gg: ASbGncsG41ugFeoqW5greYfqLsCOQ4NRiMOFg9xDBcK7E44Xd76v5VHXG4GVF3yFzf7
	6Rniow5jrzKcRPeKpLP/54nfC7YqIG3Y6cAL1xGeMeOa3pEtSNJs1H66KOjVkDMe7KU0+uz1xdE
	TAHZV5NOCtgCU0aLuZ8rFBry8XAVKBJvxgzg0L9pLCS7el1RPV+HaWUvUCX0WfehXIL/7s+4JI1
	RLro59ICf/STAUBVc9x+0khpnkETFl/5IZbnZmVTZHf63iHBm1e7YdXpHpBZtxKRWFgbaTzv+O3
	l70Ga95mGF3T6h6pdKFdMA2VayFU9kpzGzf5FlE979NEX14=
X-Google-Smtp-Source: AGHT+IHlJSQkB9+ichJ14rfahl9hWPuKPe33valnFBNvz69hHak5mbInhbEyboqZmxSs35P3xykTfg==
X-Received: by 2002:a05:6830:6406:b0:72b:9316:d596 with SMTP id 46e09a7af769-7308a4f129amr197220a34.3.1745873983137;
        Mon, 28 Apr 2025 13:59:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f056ed8sm1907614a34.0.2025.04.28.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:59:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:58:56 -0500
Subject: [PATCH 1/4] spi: axi-spi-engine: wait for completion in setup
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-adi-main-v1-1-4b8a1b88a212@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
In-Reply-To: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4YUyAmqj6DMqtc0zwouOnq7KPjPXOMqMgSZciQQWnro=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+wgikM7d41wI70h43Y6kTnzcebvjLzmaVj/T
 q/8VSAwnR6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/sIAAKCRDCzCAB/wGP
 wAIsCACO6ZHobVgzjDmekcnGZALCIK/EXWkkoE/NMYAc7xb0Ud4owkNWJTHEKw1QP5B4mGCN+hi
 ZrWj/rkiCoOQb1itABa0a5M62SluKm/saalgejkAAwDqrIk4it7PBc3zgBvYdTr47Mo+sUKLOmX
 3WaZim/Q8BPMCUpl5uvA8IJT+GKvPYjxsxkNjWkd748tfBc7St6kZ+G7m7UQ1DuvmVHqnPGv+vZ
 lcfFY3EkihtaEb/QFIeQfgMSVTGDVY4xxc9lK3n/MxuJmskVNzSbmAsVEf4ty5j3YeiL95E/Mng
 gweqI4hh0GQTtEoS64lFtIN3NCbuCM6vVNGNK06Dws4SHu6X
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a polling wait for SPI instruction execution to complete in the
spi_engine_setup() function. In practice, these instructions complete
in a few 10s of nanoseconds, so we never ran into any race conditions,
but it is good practice to wait for the completion of the SPI engine
instructions before returning from the setup function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index da9840957778579dad3286f493abad87ad8a3bfc..d040deffa9bb9bdcb67bcc8af0a1cfad2e4f6041 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -14,6 +14,7 @@
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -739,12 +740,16 @@ static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	unsigned int reg;
 
 	if (device->mode & SPI_CS_HIGH)
 		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
 	else
 		spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, 0));
 
+	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
+		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
 	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
@@ -755,7 +760,11 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_ASSERT(0, 0xff),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
-	return 0;
+	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
+		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
+	return readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
+					  reg, reg == 1, 1, 1000);
 }
 
 static int spi_engine_transfer_one_message(struct spi_controller *host,

-- 
2.43.0


