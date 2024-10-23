Return-Path: <linux-spi+bounces-5312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1E9AC98D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB2A1C2158D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC421AAE37;
	Wed, 23 Oct 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWlxHPUr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01F1AB535;
	Wed, 23 Oct 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684841; cv=none; b=GAzPCP02fJj2GC7BV+6wwLWKl9c6xa/LfDteaVDUz+H0VsolLZT9z8So6KrvqTVrpVh+gGjwiPSueskhb+1QHqtu4h478OK3e/kYx+nyZAiHxhNLzGn1PzJeZkaw+rqP8dZlP17k8jBQYYBPcoqN/ksiwy0dddB8NlJmIZQHJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684841; c=relaxed/simple;
	bh=mWunY4uU1TYl30+JYPO7VnVazKGvTmZbfdG/tQg2/Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JzvcE6F2lvlCRLjetulpcUluMzpuhNcX/6kHNaRnpMGrkFLBDcxzPkdDhz4I3p13l528XdfyJLj5/Deg1RsB1zwOZLKZn9IWJ5Ad6fPkqwHtWnW3RmpOcvjxuVTvc14UOp4bQjJfi8qWU94cPKzzf7dQz1fL6gCwcWu8ThRxPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWlxHPUr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c714cd9c8so67335975ad.0;
        Wed, 23 Oct 2024 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729684839; x=1730289639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJNXHF0VHu7kbpuItfAcI7Rgm0r0TbZCkUNZfFQ8BfU=;
        b=eWlxHPUrhFSqTU0SSZ3JI1zSYMiuzOLEGLDlSsxHs6/vjMRqFzkD07GfbW/8Ji9Be+
         oTOoyR9ffBa7jCehvNZoyJXqUdhBH31ScYUvkuGNjiajkfRAEOflewhm/JsfUdIUBV13
         eWKuSXGmX1dXrPV/W6AlqhhRFk8EEjJw/5brdomE9RpXlCwbyjf3Z5Fe+GlVvsRgv9xZ
         tG1wPXiF1c9tt3zSWjssYUGzSsY+vTXQtbTnD54sRbbPoANx495LbfkWlOLYRmUVqlfd
         kiLw0DGeZBVDLGooCWnb0KANiH0rDwZqXPak3+QUxOGqgK+66U8GKrIEo7fO+V7zJD1R
         pVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684839; x=1730289639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJNXHF0VHu7kbpuItfAcI7Rgm0r0TbZCkUNZfFQ8BfU=;
        b=VkW9F8Kel7UfKXYcmPubUDISeLDVQoVIwC1WCGmm6gTwKhLSua1npsSLB/cWuQVnGy
         wdaXiryFUf7NwVRiWC/5r0nOu0bKIHbfWyUAHvVtldTTtskqupkwpyATJxZNDXp8PojQ
         dIeSoe6nB9OKp2TAk48frz8YVXQtJn5a/sR2GsTjzVWgUc17oMaSe+emhetxBJhdFKVM
         vBcOlUo8ZHDfwSJEQhbZtOD4/jyYFXpVCkEXoXEcxDIBlTUMTl7Qhft4GV7iaKC4dYXy
         ZfFZ99+oZuLOAO+tWbcy2cYPEgJO2+UFVVggegeexNIwVTVXOiFk8UAJ8ZNci3Ghxck5
         HOIw==
X-Forwarded-Encrypted: i=1; AJvYcCU7rVwR6K9kB93Gmlf3Ix6m/kDjfdOST8h11nAbR4it0PI2oqXhdXCce6moYo1LlbvWPWSATi/YKhAT@vger.kernel.org, AJvYcCXneEJYPiilqYKThjFoUlCkLWFbVrGIqvQ+muAsII/v5h6yt8XPkiuWn83sikUDu2yiZdhhdIxPer6A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sJJi+I2fChSw8uO4sSzF3On8u2NQ4jlb7k+0hOIqMfeF8b4n
	pM9y18f4hgxvoU2FGOLulq7wWhxjwP8QR1J/PVmegeMl9unC3UsMcX5w0w==
X-Google-Smtp-Source: AGHT+IGKZ9kKamJtXaXuqPYYC/YHkGi7wGCxH1F2GY/K/ywqS859vhdAXMa8nE5cVNyg+egOXi5EDg==
X-Received: by 2002:a17:902:c94d:b0:20c:9821:69b6 with SMTP id d9443c01a7336-20fab2d8502mr29487225ad.58.1729684838947;
        Wed, 23 Oct 2024 05:00:38 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3468:366c:e529:6d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3665sm56598825ad.271.2024.10.23.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:00:38 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lukma@denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] spi: spidev: Add an entry for lwn,bk4-spi
Date: Wed, 23 Oct 2024 09:00:14 -0300
Message-Id: <20241023120015.1049008-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023120015.1049008-1-festevam@gmail.com>
References: <20241023120015.1049008-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Currently, the compatible string used for Liebherr's BK4 external SPI
controller device is "lwn,bk4", which is the same as the board compatible
string documented at fsl.yaml.

This causes several dt-schema warnings:

make dtbs_check DT_SCHEMA_FILES=fsl.yaml
...

['lwn,bk4'] is too short
'lwn,bk4' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
'lwn,bk4' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
'lwn,bk4' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
...

Add a more specific "lwn,bk4-spi" compatible string entry for this
device to fix the problem.

The original "lwn,bk4" is kept to keep compatibility with old DTBs.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 653f82984216..2b87b9ae56c0 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -705,6 +705,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
 	{ .name = "bk4" },
+	{ .name = "bk4-spi" },
 	{ .name = "dhcom-board" },
 	{ .name = "m53cpld" },
 	{ .name = "spi-petra" },
@@ -734,6 +735,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
+	{ .compatible = "lwn,bk4-spi", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
 	{ .compatible = "rohm,bh2228fv", .data = &spidev_of_check },
-- 
2.34.1


