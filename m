Return-Path: <linux-spi+bounces-10444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A683CBC0F8A
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 12:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B0684E144E
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53328221DB4;
	Tue,  7 Oct 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caSKUQlN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5852D7DEB
	for <linux-spi@vger.kernel.org>; Tue,  7 Oct 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831911; cv=none; b=JRegyxT5EfdsdyTsCSn/kQLF3ZGBGsh2ioq4L4iqq9QfmgPc1cLetX800uyNgXrfhXIdqKKOCBtpL5Ae/P0awtU6jxys9pBzzMUzNTwjhRiBUbU3mtkNUOqd8X2A2eXVwvCnbuij2g7rAkxjeoZvD297avTpCKncSoMmXcgcu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831911; c=relaxed/simple;
	bh=aUB14bYr62eO+KCUUkphBpyq+IkN35gDqbsIwntERA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fR8KpZNyQARhCHi8MDdPacV4/l4W7OgaJcLIDVsq+8QjctBtQWA25dJ3wI2r8YWjNwcbYcnT3yY9021tQxaG931i4w/lQRVtipaDWOnK11smmZBcUr0HerrgweisAQlnaPQQZS5p8JnIGT78k3cxRBaXzAYMgUY4ufI6TMF7hIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caSKUQlN; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso7226581e87.0
        for <linux-spi@vger.kernel.org>; Tue, 07 Oct 2025 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759831908; x=1760436708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fh57GThCQIn/IKZtDhnvozk8Ln4QEkjmD5REYNdcWXw=;
        b=caSKUQlN8LOhG2VsO48j7x0Vk7TMVcollFUNCI8VOWuTozAslbz04B/aT14jqGpncT
         7LXWchGAfFL20kxAfBYg7yeFFLeUIQ9+P3IjsqGwG9uRwtWXm57at7q3rlQL9Ld4Bxfl
         O0lq3OCrNI/nc6DxPclxykMxufKs6VoViu0+Pm4WUV0qsW4TKmpGcgg1soHwrL1mDKCz
         CkDQ047+E0vzHz/cdifYEc+k9krxu1XOGBe/iYh5bNM9Yfrarxtyc1O/xHDThN9ZzTyE
         aG0jgeFrhZc4twCCx7GbvIht2MvuHeUHqZGnF5Fz9VFzWvg+bSP6d2YG1yL1qzykttJi
         CNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831908; x=1760436708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fh57GThCQIn/IKZtDhnvozk8Ln4QEkjmD5REYNdcWXw=;
        b=RTIuOlztBxhsqp2BfZoyu+yjAgzqaUA4gjP1x4Oq1FUG7+VzLmNGDR7Y1wxxygnnhs
         PdYrhiykNWxxGFBx3W2t7+DUo4s2RyAXOIi2nYCQof387qu5CcOmWwuHHAAgYkIeXOhr
         BJsokY7zZME6SuHeQ6kTEx9955th5PEXtKB0u/pniLhf6AP62bd/iSjE8xpN/GTqFV6D
         WBZmcvar0PcoGiL64wRpE9PhNhRJtrNxSn4H6bsaT6yb85rIpyMJXeOYJADY5tD9C0+z
         /nIhTGVurYFNRUE+mKlCW2kqUWqsqifveq1djQE9MwaVDbuzC3EBgEhPsre2xrt4DSvC
         Ryrg==
X-Forwarded-Encrypted: i=1; AJvYcCUidqeD9KHI19h/bqsmlSJ+Su2mYNulGMdhM9Ze21TuKSYLjr0iVmIuEY285XpYBSAxO8jUyb67pcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1sGK20/1Dz0Q8lRHAGwlG8DF2epHCrB+QFWUseZVN4R9Ho21
	0jHRKepKhRZUMX87jlkxPiCFE/3gO9Jm0l7i9XHzuETqy5NClMmvKa2NGYr0cBFf
X-Gm-Gg: ASbGncvKBMxfH1K/tIZ6R5oOHt98eU/bn8c5E01ytrRH+y0I8UqQTxhudVkn3YrnUEu
	3Kgt1Ca6MVCzOxpXoF3ilDhVH5THb3DGq9eIvwFJqyLr0/JgV8PlYsyOng3KK5LK/7fjvSEKDxb
	bWJ5CTkWjhGMFwTHJYGMBKrbqhGpD3XpZD34rrW6qekTYtAQeZhzfl20GkRh+X+j3iG2EY3TiUs
	I9PCZ6qvoa3qgRS2+BninQj1CR8gmDlWrhSvkkmYftBT8sQda5BsfeTtgh9Vc//zPPlBLZ0Ya0k
	zbZJcdKLDJYG9Ap5AknWkRmEiTar0WF1F4YaGXzFU4VlunS1JnPjulJlX16lK24n4liQ1y/Itu3
	l1qqAdwyRpFXnPrV0gpWG597/dVIuiGlA5QI/5ej8zSRsm0ljFLf7K75iBNmOM3NY
X-Google-Smtp-Source: AGHT+IG8ywaUQNYKe9y5g2Et4+4rpuglgF9x9p0fXHFiYpqyFxiX6s/whUYu29aKmZ2P0BQJMTWsJA==
X-Received: by 2002:a05:6512:3e04:b0:57c:6376:b42d with SMTP id 2adb3069b0e04-58cbbdd8267mr3873957e87.29.1759831907290;
        Tue, 07 Oct 2025 03:11:47 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011b14aesm5952260e87.128.2025.10.07.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:11:47 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: a.shimko.dev@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw-mmio: add error handling for reset_control_deassert()
Date: Tue,  7 Oct 2025 13:11:33 +0300
Message-ID: <20251007101134.1912895-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently reset_control_deassert() is called without checking its
return value. This can lead to silent failures when reset deassertion
fails.

Add proper error handling to:
1. Check the return value of reset_control_deassert()
2. Return the error to the caller
3. Provide meaningful error message using dev_err_probe()

This ensures that reset-related failures are properly reported during
probe and helps with debugging reset issues.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

This patch addresses an issue in the DesignWare SPI MMIO driver
where the return value of reset_control_deassert() was not being checked,
potentially leading to silent failures.

The problem occurs when reset deassertion fails - the driver would
continue probing without the device being properly reset, which could
result in unpredictable behavior or hardware malfunctions.

Patch adds proper error checking and propagation for the
reset_control_deassert() call, ensuring that probe fails gracefully
when reset operations cannot be completed successfully.

This change improves the robustness of the driver and provides better
debugging information when reset-related issues occur.

 drivers/spi/spi-dw-mmio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index f0f576fac77a..7a5197586919 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -358,7 +358,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (IS_ERR(dwsmmio->rstc))
 		return PTR_ERR(dwsmmio->rstc);
 
-	reset_control_deassert(dwsmmio->rstc);
+	ret = reset_control_deassert(dwsmmio->rstc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
 
 	dws->bus_num = pdev->id;
 
-- 
2.43.0

