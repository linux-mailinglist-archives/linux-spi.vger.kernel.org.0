Return-Path: <linux-spi+bounces-12458-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B88D38A4B
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 00:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B033230A28CE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B6287518;
	Fri, 16 Jan 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gYpluw8d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745621FF47
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606556; cv=none; b=j6j8SYQkoxfiUUE8hKpwc6VcCs4Hco+bI0EijGAjxB90itNRpozUGtO29RFJVuPMpvudd8numMX5cCG52Q/uT7ojj+YFwc116ulrgMEKPQWHn1s8NEeBsUsYlybljMLcdwcVbZA0G9a2KbNAt6nanzhbmWkGQFh5v22Ixqatmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606556; c=relaxed/simple;
	bh=0pyDOxIYiyKtDO5zBoCSbr5io67a+YIq5Io/RWNHqM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlNCo+tD5AsWTTfMX8TnJOd22E4+sk2hv1rmiCljGXakMaUV9qnZJz7BG2ESAYreqWc/cah/ecysYskaIOka4Zz3qXU1mjDuDH8ofCxBUrt7S9CHVzA6cmnJYrmKpzKjaK488ttvYXHtNYutup6jcPmLodu2iMuEGFLUraoETy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gYpluw8d; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-121bf277922so3526712c88.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 15:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768606554; x=1769211354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q0sRttI86mEpJh7BtqYPvvcOCP+5t2tb7f6cBrMGu8=;
        b=gYpluw8d6VEwidfAYH3DbTFnfP0O7IOhsOGAbrh+wn7nZBLmpNuu/t8h1MXnUdEhcM
         v9nDnG5BbII9MwmFFOVPTaQfmlCntcFTNkcxNq81UJ/DSR5B3Mw2J4f16+7dfsIcU567
         y8pwmuTIFEOIA+x9emfc6zR22QEQzaGSeBqJpfZFd1wDaW7tApEySvmF2ptCwG+Ywham
         +IaxVDp1sX89mCesmGm5Z6MLcRFDRiJUxHtza/gL9hN/v9eIVix5I51uaJ4xNPdSSBMH
         d/NHY+WjORnx8lQwF1ALlj1usCzeXde5epHV43r90pa0xhFrKZO8/wzByr1n8ZVEaUJe
         2BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606554; x=1769211354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q0sRttI86mEpJh7BtqYPvvcOCP+5t2tb7f6cBrMGu8=;
        b=eaHjSx3DS57JcJFEh1l75e48C5WNhec8JqFbDB1BpQGK9zzUTtkPvXJ4aHHGskk2Lg
         gqZnlbvFusVqgeoTmPrZI+KUo+HEQMNBTPf9e0XV9P7E5/5b6y76XhkM0f2Bd5fQ2CM2
         x/bjlhFd1Nnato2B0DPII8d4ifowC3HM0AuJGhK9dQWiALCujCulMETLxWiUbLgDHw/n
         11ilD469tsn2TQ7vfsIbqsOz0JwdXg4kcfBif1ayxeNUbGdegsPbhacUds59w3GMn6vy
         iI+GRF0aaQhpYUiKbSqGfmZhMhdPcEXkP5O+XXjfiO3M59aspLgZ5iyfsIFZDSWEIL1p
         uFyA==
X-Gm-Message-State: AOJu0Yxb9jDyXVGAxHu0Qv151KI8oMETnkrP5XwQY0QAXTwReaRwvrFc
	WJdUQ8ubh5Ix7Ga3MXfh/ASSIAxYfxrlmy++2VJAlBLEy9HEM0J1XYuLWDW7QzhM7s4=
X-Gm-Gg: AY/fxX5lrns4Cl9cOZqz/hvlO/+fgn9BIQe6GjRAGcn5QFWQmPm92xuNZMQKkavZLEi
	9PSYb3CQHuxbI/okooX8jqX1uRADj9htsp9LCfeP+ffdLt3ebvnT3p5JoIWXx0ulcD14OPZLwop
	OLI2Z1WGcz0Cxv/G7qR3S/ddzqu0cHop4s3L8u8JgVtmzl1LhaodVDiq4ZVbZnmIWNVfckl40iA
	mE2+krDfLD5Wn7wbhNA/xXMN7CRC9l4VpysmDRxMNhIoZCGimUaWlGuXIfY6OIQPfLH7R98one0
	SpgQnaVSOqauXO69/nzgi4PnE8TZDkUZiJjwlXinXJwa/BjyJzl98v3ir5S/i5JkEDutz6SZ9lR
	oN2v1UjMykuXn9HrupvOvFgAqexnB/HdcEgCZVO47JE2jxDwr624iV3xueVCrpoBfbOkIb+jCyH
	JIg+zbpOp346kTgFncUjjITA==
X-Received: by 2002:a05:7022:221b:b0:11d:c04a:dc5b with SMTP id a92af1059eb24-1244b35b987mr3230415c88.30.1768606553966;
        Fri, 16 Jan 2026 15:35:53 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af22aaasm3877513c88.17.2026.01.16.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:35:53 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH 2/3] spi: xilinx: make irq optional
Date: Fri, 16 Jan 2026 23:35:34 +0000
Message-ID: <20260116233535.260114-2-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116233535.260114-1-abdurrahman@nexthop.ai>
References: <20260116233535.260114-1-abdurrahman@nexthop.ai>
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


