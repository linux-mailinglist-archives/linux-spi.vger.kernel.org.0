Return-Path: <linux-spi+bounces-12378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90568D21DC3
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 01:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EA0A301EA2F
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858ED35949;
	Thu, 15 Jan 2026 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="X1/9io8O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D2335BA
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437221; cv=none; b=b6UgfzTMAOF5vPUyxN3dwCLQsc9fphZHZ31xhZq16sorlSohCkeM4E2WnTfnif6WBBo300MOZBU9Ri0y4qUP7yIQr19cWa7nVYiGauCFWk6NaF/hJREeda/T7TcDqGjmB5rXiF5l+klfzmUdGfov0wS5kKVGJtGf3oMSTxuyCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437221; c=relaxed/simple;
	bh=jy6olIuzEK+BMIClFLLO+ElIsY42zCpVgIguEe0ki8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1o7+uBQvdT8iXOnkqvrvUhIE1vxDOmieW/rpXwMBm3RIjkag8qG/3UuJ5C7H66UJ14nNEY0wBnZFvowiTGXPa9VRnY3r9sDvAhKrKBlTBWPcCsEBHcyfs09ypWGN8miypPZpkn0ypBHdZoMJK4V/kWtg3vaD83gIaP7MGNuAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=X1/9io8O; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-123320591a4so371845c88.1
        for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 16:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768437219; x=1769042019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXtk0sA7TGlPJIYepV8HIyQX3pf9pLDE07n5yEMjuS0=;
        b=X1/9io8OkjzPBtwsMEapSygx5TB/4XS+WbaLQKLFJIStEWvvjjOvOXkMEOcZiM2Sx6
         ileg4HvOSEWPrS7ObVb5nV8IBguFbYAjFwfWUoEbxkTuPYLs8EA2AV2gRaHn8du3Nh6o
         hg8PeXsCdfgugxK//DOnAaNCguZMwV1azjSYp5NqqQLe7Q+eOoF3oHGxQXbEC3R1n8/K
         MsXxLvKuZKv7DA/bi1cuVbM7wCg9vjpUYEW45INfr3uoqx8FzMkMwE53QcZi6hiLuqlH
         QwqtjlkCVFAF3QqYmFos/m9PaYhOjMQSaxNTtON3XcCJPYsBFwBejXyeMMpMVozUU5Fm
         w5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437219; x=1769042019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXtk0sA7TGlPJIYepV8HIyQX3pf9pLDE07n5yEMjuS0=;
        b=DLpvMoUa9lqJoWxNa0wmvsNtt4f7+vzH3oGFEYqJmwunIKULo+KpFxm1t81bzoJJlm
         8MH6nNF1CRbpMp3n3tDhxrKSjtfbAhHIMy0VvL89qNj3wTGPP+OcaWB68NUmydUcCwVW
         OdaLmXFhzMhhwd9QaRP0zlnW+cUftwB7FDlF2dXYzcGPMtYMpknetM7OaPdAFjl+M7Jd
         Kkn/Cbc5wENknJQTGDdl6YSx7EDuIJJbk2FOb9bsWFvvzu3g6nwiMrzSgOGZHxlqa4O9
         ZIpah9l6vMl/S3Pond0B0xXR0qXJ12lP7KsZDxPTb89MB95hAvIVIYxxvjBVj+mFykad
         xPgg==
X-Gm-Message-State: AOJu0YzuFtqvaA3+t00bjpADWz/PtfHHVoiweaAH+6MwCorRCU2ma5Nf
	0K0d0cQT3k/AixWLgJqEYkBOOzl7L5kT7wQy/w+jpHuw6mUjSi7Ys4n+7zFPOiCFD/Y=
X-Gm-Gg: AY/fxX7Tzf2XEFS4r7qt0fG/BvSfNc6jHEOOfZ/c5rZhfmx43bNTugRmeucPSfM3OGj
	ebqBusugL9xel0xyfKsFKz8zC9WVMmtq4lpeXUQ2z7DNZlwSZnbuo0LnOBxzARL27lfkmWmJs8/
	GLK+o6+GUaT2GlifXXZsspdY9tHmHAkLzXvs4109V2rtde6ZNoPgWuxCrnBsq/CoRkbbG98REUo
	nntVq8QAByw3htAPAT0nJbYP7eMX6XWMrvN9fZA3vce/hMdUuHJbokXXXuxJ8S2K+vGGXg/7pL/
	fZY84yVc7y2N743Yyq7Y58cJd/5Mtrh0yQGTNmTQZ434JuVp4aB2h32KZ9ZI/eshYO5e9QsGzug
	m1lmD/3gmIWnvj724aNQkNIihDJKkuFX4nLCmPOCPN+OKc0KztdMUvhXTbXKrfl23+HM2RrNNIm
	iraDTc3v8f4UDopnPcRIVR7A==
X-Received: by 2002:a05:701b:280d:b0:11d:f464:38b3 with SMTP id a92af1059eb24-123376b1d88mr3105776c88.2.1768437219338;
        Wed, 14 Jan 2026 16:33:39 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12316f2db84sm13313027c88.14.2026.01.14.16.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:33:38 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH] spi: xilinx: use device property accessors.
Date: Thu, 15 Jan 2026 00:33:28 +0000
Message-ID: <20260115003328.26095-1-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the driver work on non-OF platforms.
Also, make irq optional, since the driver can already work in
polling mode.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/spi/spi-xilinx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index c86dc56f38b4..9fb1da2fcce4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		bits_per_word = pdata->bits_per_word;
 		force_irq = pdata->force_irq;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
-		ret = of_property_read_u32(pdev->dev.of_node,
-					   "xlnx,num-transfer-bits",
-					   &bits_per_word);
+		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
+					 &num_cs);
+		ret = device_property_read_u32(&pdev->dev,
+					       "xlnx,num-transfer-bits",
+					       &bits_per_word);
 		if (ret)
 			bits_per_word = 8;
 	}
@@ -471,7 +471,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	xspi->bytes_per_word = bits_per_word / 8;
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
-	xspi->irq = platform_get_irq(pdev, 0);
+	xspi->irq = platform_get_irq_optional(pdev, 0);
 	if (xspi->irq < 0 && xspi->irq != -ENXIO) {
 		return xspi->irq;
 	} else if (xspi->irq >= 0) {
-- 
2.52.0


