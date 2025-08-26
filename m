Return-Path: <linux-spi+bounces-9673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3797B37463
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F501BA191A
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 21:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F737288D;
	Tue, 26 Aug 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8sMuH6W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5E34F48A;
	Tue, 26 Aug 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243463; cv=none; b=JlzhMkEO38/FRdeSHlYf++qvqaMfDdxeCIkoMVTzrqml7bQI1yfzZQKT3hMBsgj/OuokriNhVcoYsaJvOce04bs0UY/6cs/+R9pWVRX3dJwACyhOzH0eUwTBKzXrfzlKm+hMI+EHhmLh8JZENhf9hyLedZg0oIviYgd7h2C9GVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243463; c=relaxed/simple;
	bh=aYw6MofnHAvKaEH1PElA/MNTzS+F9tHNM86+sFZV9ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=remsbl1Fz+1jwx2kvyx8wLsM+2zqwIADVRfOEfDGPGWgX47KeLXiRUEefLBXrttqtQdGsI2vCwJj7ExtRyEbwedO4ZuG33cNDnsp94tfPjPisrNxMkKXJ5KrmC9cTyK3ArLb7UAyfcsEhYQcbeIecwQnJO8xrmll6g/gwuBB9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8sMuH6W; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f04816589bso235387685a.3;
        Tue, 26 Aug 2025 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756243461; x=1756848261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgXAMQGqr0Izd0AMNgry0Bz28MBpgtkqZJm6I2t+UrE=;
        b=O8sMuH6W4ReMcj1kVdOAMQg6ePU/tdkRmgABQO6c9ESXa8X16fhMk50DRHOgcdTsmO
         ffWGfKB/ACNZeL8L3A1BDhA2e/Luj+5VRN0wFmUeyrcBImp4d+o41TT+W3p5S/urbNE+
         Bwrz9VdSfPY2/I74olvKVBkEVQJ/muaQY2+iRcAT9zQqnksrJZWqmxYbNe4kbp/qaBzq
         gAndXrdnbYR+rhYSrnhDj61vI0pNBbzMYQnzmBt3t2d7i4M21gOqqb8i0XjwNTbq3zyD
         q5blhW00HNbclc386rL2kj8Tg75XeFjLH/emu/CspXaaPBF+BgLenxe2d6/rm9EsMnEH
         zYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243461; x=1756848261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgXAMQGqr0Izd0AMNgry0Bz28MBpgtkqZJm6I2t+UrE=;
        b=ahe9iHkgvNS/dow2qOHeWvBCUnlxan2IrSFl9+n72i2CgIH/4MVSWYUpS6j9ZNZnWp
         a7UW5gjE24k9F42MVK2h3dJnNsLXFZCEwBghtMoeHv5VfuZM7TW+vAeMee+kYk/+yzUW
         pFxXpYYd4feUXLxJmQKhCHP3QqagbOquaqKCpQESaA50T2GcmppdgW4XTXqdd9AjGfQ7
         uArMVuCnC9hGR7zt9jB9NN/Qg0Yp3XGwHTZM4cfP0AwJJs41v0WQvoxfsEgAfsOjtMYh
         VrWGi3z8uR0fdcY2FzQRbxd2LZjJDxefykYDarBhhwTwr3g48GGgMRXnXEnAbL+/QakT
         hR6g==
X-Forwarded-Encrypted: i=1; AJvYcCVs03gEhgn/Af2e+4H5G8Hb19nbmuJoaPbkiKwuut2q8qgX5mFKTq6ryFHeW4ALROKRSUjFoBOTaFMzfyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRmeW0N+HuMCpCuDA2E4AZV7fDNcULnGOHQSz62qdD0ySpFFa
	0rVkOn5YLgyln5OTLKd7BG9VakxMyjJXnBUrRXpdyDn8NnkfA7zKttKkGEHyLg==
X-Gm-Gg: ASbGncu4SO7hs1fevMlw1CBSPfDOM7rsIsTopp1YbQ5/LLquvb63ZTZc3FwIpi4qTf4
	OBYK1CN5ie4cZkZRpv40acnMaU+kLacMo0/voPp92FKstkToV57szK9xnckf7Kaog5ltlefAoCU
	G2rlE+6vAqzTUZMoK3YFtkBB014DJJyQzvf2UMtHalOcpD5OVOyhJnaIHBih5Rej+f1Taxa31Wy
	INZ9AcX2isDIMpTsgeAPYd7vdG5ocE5EraunA6wYxMTnIGXyDKC4JNBnOAYUroeKvBpkho+iCbU
	Kv390rzSjJBZlie4DSdiJUKo+EOLXiOQyjh2Jwdg/blm20kUPepuHRZqME6qZMMW99pOkWWDwEQ
	uAmQo5dDICASFpVDGRKwF1VLz8Lxt9t65EguiDMweVbzpLFB8vg2Ecf9v4OghqVg2yQ==
X-Google-Smtp-Source: AGHT+IGYBX4kaWboCu+DoR53isVds5bF1CvBSNM+ml56+QxJ48bWshjlkrRl8VG7WMuBPEtzNZGrkg==
X-Received: by 2002:a05:620a:1a10:b0:7e6:3460:5b03 with SMTP id af79cd13be357-7ea10eb4859mr1949079685a.0.1756243460599;
        Tue, 26 Aug 2025 14:24:20 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebe6069a17sm758731685a.0.2025.08.26.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:24:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	j4g8y7@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/3] spi: rb4xx: use devm for clk_prepare_enable
Date: Tue, 26 Aug 2025 14:24:13 -0700
Message-ID: <20250826212413.15065-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826212413.15065-1-rosenp@gmail.com>
References: <20250826212413.15065-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the remove function as it no longer does anything useful.

Also remove platform_set_drvdata as get becomes completely unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-rb4xx.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index bae802e94226..22b86fc89132 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -156,7 +156,7 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
-	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
+	ahb_clk = devm_clk_get_enabled(&pdev->dev, "ahb");
 	if (IS_ERR(ahb_clk))
 		return PTR_ERR(ahb_clk);
 
@@ -172,7 +172,6 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	rbspi = spi_controller_get_devdata(host);
 	rbspi->base = spi_base;
 	rbspi->clk = ahb_clk;
-	platform_set_drvdata(pdev, rbspi);
 
 	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err) {
@@ -180,23 +179,12 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(ahb_clk);
-	if (err)
-		return err;
-
 	/* Enable SPI */
 	rb4xx_write(rbspi, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
 
 	return 0;
 }
 
-static void rb4xx_spi_remove(struct platform_device *pdev)
-{
-	struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(rbspi->clk);
-}
-
 static const struct of_device_id rb4xx_spi_dt_match[] = {
 	{ .compatible = "mikrotik,rb4xx-spi" },
 	{ },
@@ -205,7 +193,6 @@ MODULE_DEVICE_TABLE(of, rb4xx_spi_dt_match);
 
 static struct platform_driver rb4xx_spi_drv = {
 	.probe = rb4xx_spi_probe,
-	.remove = rb4xx_spi_remove,
 	.driver = {
 		.name = "rb4xx-spi",
 		.of_match_table = rb4xx_spi_dt_match,
-- 
2.50.1


