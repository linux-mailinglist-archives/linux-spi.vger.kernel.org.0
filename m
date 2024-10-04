Return-Path: <linux-spi+bounces-5104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEFA990354
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33467B21984
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA70155322;
	Fri,  4 Oct 2024 12:54:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33129422;
	Fri,  4 Oct 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046464; cv=none; b=eXj7m43k1aHGwuFbJt/rWy1kTSFESq3z1UcdV8FN/hUzmsfdtfBGiGYv1VWIgwSJKx/w3iP+u/OKQY9akuuR5PTLZWfNOI1x4HwnLeK9qFPf/DElzsEgmGisNLm5L5jB9Glq9jDNpR7R+8XLGU5MI6IC+rsMMpOuJxkTvo/cmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046464; c=relaxed/simple;
	bh=AYYJxzyv/TpHRMqYnZn+yNkjlce/nGXyDC83ozB/2+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cK63GUtw0LIBPmxAsU40jDbFdLs1KUXKOen7ecyxsu1oSTi3s6lAd1QzXx1suDudonIimfrI+9aybUUvVXHnSOL4GXDUwhNvaqfkoZEOsyd8p5Z+CjyScBDxcE+Z+ykN1JoIRTgDGzFZwEY1tm73+NywIFhWElYL+spEUFBgsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93b2070e0cso235285066b.3;
        Fri, 04 Oct 2024 05:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046461; x=1728651261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8WDb0ILMLp3TSVi/xUWRtDcWXKpkXxh5dKuJYT4rVo=;
        b=H6bJXyDPaS+XecotA/7p6d5IhKXDTZu+bOZ/an9OlKIBEhXPwvm4efezVMLPcth7Zv
         p/6eRdFbWKiLbnypmfEzJWUJaV2V7pvvVssRHgCjrMaaq8j+fcc51ApcwpnKvQ15cooe
         P5x6IoNUOwUxYRpUw4cq88L0CY+Hzjh1FVQTLZcnI1nqjZUfIjhkhuZpiBbbeCHee51l
         3kDy7h+n0K/pgy8tfWcv6/z+fAN+UIx/P1lJ8XOFUPWqNHLhC01jwgDmWjSGhCCoQc0O
         vH+1skK8SwmtvNM3ezu/bsnFhRXmpQ8Nd0zaaLG2b+oEUNKGIZrxxp/JQx1TmuVfSVIY
         0BGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7miMyooDgs5XNigFLwR4QczNCCgN+bbJxCGa3QRfqOVY1KF6lE2BtdkV+J+N0RpuBbawVHPuG2Ayz@vger.kernel.org, AJvYcCWFn2eXjA6dUCNbQmYXCG6LzieVZMFI42eH4Zr3rRc7vmXFU8HrsoPFrFXuKx/R2Paoe42VFQC+BEB+65o=@vger.kernel.org, AJvYcCX9r8lL7Hv3hxFZiq/40rTBcf5c68QPMyv+vgcSsbpW3tTB4Ob+G8+NFP2vjMT2oOLfjFUHnCSe4IxqVNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CRoxYAj9PIrfO9WvLujmTFufe1nLku2FHLFMqpkNWNPupOHi
	yzc2uXLq0EKMxJ7JyDsizew1BAxsueENyOb1DJJjbyRTWiH/ABkd
X-Google-Smtp-Source: AGHT+IHPddgOhipGvQNn5hVJUpM0k4CMY0oO4dUHBdaDJkos2CoqPupmnPT1hXBwU/1MYxp7WC6qgw==
X-Received: by 2002:a17:907:86a0:b0:a8d:3f6a:99ce with SMTP id a640c23a62f3a-a991c031444mr285956266b.49.1728046460594;
        Fri, 04 Oct 2024 05:54:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910285a9bsm228197766b.14.2024.10.04.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:54:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Mark Brown <broonie@kernel.org>
Cc: rmikey@meta.com,
	linux-tegra@vger.kernel.org (open list:TEGRA QUAD SPI DRIVER),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: tegra210-quad: Avoid shift-out-of-bounds
Date: Fri,  4 Oct 2024 05:53:59 -0700
Message-ID: <20241004125400.1791089-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A shift-out-of-bounds issue was identified by UBSAN in the
tegra_qspi_fill_tx_fifo_from_client_txbuf() function.

	 UBSAN: shift-out-of-bounds in drivers/spi/spi-tegra210-quad.c:345:27
	 shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
	 Call trace:
	  tegra_qspi_start_cpu_based_transfer

The problem arises when shifting the contents of tx_buf left by 8 times
the value of i, which can exceed 4 and result in an exponent larger than
32 bits.

Resolve this by restrict the value of i to be less than 4, preventing
the shift operation from overflowing.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
---
 drivers/spi/spi-tegra210-quad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index afbd64a217eb..43f11b0e9e76 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -341,7 +341,7 @@ tegra_qspi_fill_tx_fifo_from_client_txbuf(struct tegra_qspi *tqspi, struct spi_t
 		for (count = 0; count < max_n_32bit; count++) {
 			u32 x = 0;
 
-			for (i = 0; len && (i < bytes_per_word); i++, len--)
+			for (i = 0; len && (i < min(4, bytes_per_word)); i++, len--)
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tegra_qspi_writel(tqspi, x, QSPI_TX_FIFO);
 		}
-- 
2.43.5


