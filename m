Return-Path: <linux-spi+bounces-12464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3501DD38B44
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 02:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77237301F4B9
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 01:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574602900A8;
	Sat, 17 Jan 2026 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gJ1MHz80"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8F279346
	for <linux-spi@vger.kernel.org>; Sat, 17 Jan 2026 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612932; cv=none; b=LtZqljp+i0XIJFqpxcNlRdg35k1zcP/NCKaQMxYJ48tpc5P8BC8rTfs84EKC7xtV3/b31HmhiYJiJbiU6y4azzmszqvqNS4gYiuKPcoPLSu6QXkY0qFdAHEph0nvVUwqOijfGhciw2al2TqDcZtbD3mHzCPWxvYkbREnAfVSRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612932; c=relaxed/simple;
	bh=0pyDOxIYiyKtDO5zBoCSbr5io67a+YIq5Io/RWNHqM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvZS5hgqB6MAkS9pyecUUkGl5Ef8lZoH5WiIZaS6/xFFPDmoqr9Vsb1F5tc9IttAenaKx4rAX3l648dmD6eN0HwEMu5oN+LEYWeXoY5863ejy8XC20eigMtjw4NYF6dlbIpB7hdYBBn6PqwWcvYjWtAmwUhH2gj6tQD62wMQ/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gJ1MHz80; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f42e97229so5850382c88.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 17:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768612922; x=1769217722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q0sRttI86mEpJh7BtqYPvvcOCP+5t2tb7f6cBrMGu8=;
        b=gJ1MHz80Pu9AGwPKuwLfUzF7dZWdssv6SwjrszmZkwxWdWq2p+XnYLFlZSP95Xc0AX
         qNqzTZ1LJt363tg5FAuJFQk9T6lHzIfpMk9sEGPQcAfoMG9GVbf0uI5KrEc7fcCTycCe
         n+vt2WY4k36JKraAc05mShRj4413eXxp3s5KLk1XwB55cIG/ACCinZ9c8S5oYMADJ6FJ
         pKsFiWmTQoNKrXhBc6Knaj0g2YF8/hjCGDMVhzJ9Vwty20BzCx76lzEZ/xVAfxoZsVQJ
         qRN/nKAc6gmP5+mcvAxYQeTRYbBWNpXQagoSIBD2okkncNHJ9TWuPld3KFa0H0fVtk7C
         as7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768612922; x=1769217722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q0sRttI86mEpJh7BtqYPvvcOCP+5t2tb7f6cBrMGu8=;
        b=XB45yjzqNWU+XR2HZT9YzW0URFEZnzVI3ztVYePCXQb0aP4Dsvu/tNbSYwggg8TOqq
         RfC31h61wGLDVJW8uKkbQguyWeHIOai4QlsDHONiKjBRIq8cNQEBQjomDA+X8X5yNlio
         GtBXY5LUnUyX0VOn+QEPyGdR0CPTuhBRYkJfAsgIoWQEvm/60pLfPqfxYTyZyA2INlXK
         gpeJO2/s+4MD+WT/T3krjyT5QD8w97OYY7GYUzDDRk3t7yQz9VzfZaoum98PP6XZQ4rG
         KB3/Cwe8N9LnOYSkC6sYWSGHcWMJgCg+d8Fc+buIeUGME4KT8JYGR+z1ER5gYdWdgNat
         CJRA==
X-Gm-Message-State: AOJu0Yzb2EH7JWUSS0L1dO4p4SvrHiCJk7uzyukef8+k0A0JRKI/flF9
	Ghtyn8NKmYVXMtRK0B5QOVkXYDw4t9tMjOEinG/fWXAUVVYUiw88vRcd/Qm4JEdQRvE=
X-Gm-Gg: AY/fxX7/Hd6JskTTzXxa8eU8/GIR1YTommrc1A0XizS11G0fUNA0I8tTiFThAg4v+lV
	GY4gzjDiG8wq+jyawRpxKtEclp47qqYGzSxVst8hT9ThsRWvxyMRB/apv+z78YY/R5XwpNRH4Mj
	XuBUfBXKKdNlCTDXTkMHsejzRt7VDyRm1eetQU7D7pGpmY/PJLgKOgejjzkjhI//bZMHSNkXLEo
	9E3/l1AIZjIXxCUmTUwI03auOT4GB/9p21b+CGkQzgGjPGjYdhHRATUoanQhs1AIF2TkEOv5czy
	t34NaMkeMSPrKlgtyLyy63n4+9QcBfXuLHkXHimFQ3Z83iQoNZ3X7MPt/SZb17ofrYQfWs0fDd4
	ZuQ3x8gD3Td/wBGyS4OyuaeABi7fhC6ZjUMNsHKJgEX4j0dd/0WM44J7kgoBDdVs8suun6TkMjA
	xUEOEkOtNG4vA=
X-Received: by 2002:a05:7022:322:b0:119:e569:f279 with SMTP id a92af1059eb24-1244b3802e2mr4431118c88.34.1768612921745;
        Fri, 16 Jan 2026 17:22:01 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm4977236c88.16.2026.01.16.17.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 17:22:01 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v2 2/3] spi: xilinx: make irq optional
Date: Sat, 17 Jan 2026 01:21:35 +0000
Message-ID: <20260117012136.265220-3-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117012136.265220-1-abdurrahman@nexthop.ai>
References: <20260117012136.265220-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver can work in polling mode in cases where interrupts are either
not available or broken.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/spi/spi-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index c4b70e95b695..9fb1da2fcce4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
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


