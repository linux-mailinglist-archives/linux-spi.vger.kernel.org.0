Return-Path: <linux-spi+bounces-6196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6EF9FDCC2
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7543A1348
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295419CC05;
	Sat, 28 Dec 2024 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWdWLo8F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD319993B;
	Sat, 28 Dec 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428781; cv=none; b=nzOtACer2kw/SCDRuCQG0VAGLZPfXT23ZK6mipfSbyOHpr6dvtv7q4Rwr2FAuT6+pYyyIkxxidX3vKi2I9tcBj0jsLRmvd9ZMt3Qjp0OqEY7j4bFoadPqwPDk7cKX3umDt3uGf/J2pncjfXUe2OxwK+w5PNH8SxxTQTVD3WFaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428781; c=relaxed/simple;
	bh=3cZeUXTp51nnkA0ehfcJ3kzlhmQfCuKF9N0XQDOcDK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/1hSlqgOiEOWA6vL9HRo7ioZWeDih+Y6i5N+/eKA7N35gQYLkCREN6fZWqQ5zZ/Qg7oKrZeZOjnrjEZzggWzG9LFW7JxYIiqMVPzyCfs5mfNr80hbMn7pCgl0wIEyI9WoO5r52vOn/6R9SD/kGBW4270Pcr5veKTBgErB+0FEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWdWLo8F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so86680075e9.3;
        Sat, 28 Dec 2024 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428777; x=1736033577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxV9VtPwcOjfdreL/ElR6ztmuVaPGRx7ZtA/COvnbHs=;
        b=VWdWLo8FY++ZbSCC3YRs4kBiHQq16hA+/buqK8qy3Z+74XHMY0WSOwbCDmu+tsiX6w
         HxcgQD/r1+idvve0bcjTyMLoEfanlQy66BpanDd7P898HnThMN/O7FtbEszqzB/kacNE
         z5IRl38a4AK4h8KAKFHgn2JeEpqgiGxMz9aVRJmUK/RNhIks9CGgowV5j7MehVJLexz3
         +DB4IpBMzi3qfhFCB+RgIWLH/VnRZBi6v5fHASuKIYs4wseRaYSpA9ldos6EoqV1NAFj
         XLDFT0/WW8RNHVoFWytNNzpDnOCX4WdjyZIyCKse3jGSfOFXkvXg5j69oDIyKFGqZQRe
         H8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428777; x=1736033577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxV9VtPwcOjfdreL/ElR6ztmuVaPGRx7ZtA/COvnbHs=;
        b=uNs2fBYSceVFkAd0nWr/7xO8XqDoFHfANCv29Qji077prBy29s6Nq7vA2rSbMsBTMi
         CpPGtTyEgpi3ZI1kkvbOFB+KlQGmoY397UmbvhpW8BLS2BUdLWMuxFq+f51EQFV0Rx2c
         zZTDLK+Ag1XnH+AFd26SOyt8GkNJIy+OqSAd5ggAJ86mISnONdkYrzvG9JJyKoZSEuR6
         3nIlEgKjBvKNsNUVDZWWRP6JIlRufiVZqXdOj5i8o4iNmXrlVidW9MfhzWRajYYKY7xa
         /XygcCTd98ot1LAS3zIHLP6y/yc0hzn+t6Bips+r3RqwYoA07lyMb5FBnNbojrLQ2Xb3
         SC8A==
X-Forwarded-Encrypted: i=1; AJvYcCUcOl9MfsL+KB1FSV+aGDL0C5OpMjtNSOTEjSmHJe14I4SEOz6iw+aT8C34QoaEDZiQWpbBc7N/jsM=@vger.kernel.org, AJvYcCUizTtoiXfO9IIJ6HVFf+6MjDJAoEvPO8xxgnMW84Kt5UYFWBK6v+k5jRzxzYnzO0G4B0wDty/n@vger.kernel.org, AJvYcCV7/aEgfTJR5G1ybgASWRmJCaM+9VYNX11nSGjb8Sj0QiBKgdPqINMO5WrjKERWAlqMjznOtuGD1hy4@vger.kernel.org, AJvYcCVsu0tQdcSfn3XAhCm8SCf7lF4ptTX5NYHYXAQHx5HcALch17VB/zoZOhuEwKsBJCrEzVkwJraBi0m9@vger.kernel.org, AJvYcCWZ+iVq9Vs0AvYR/za66SRI7fLxmIZuAiptoyd4o+E2H2k7YWfJn2BWpPtDfbicJBmYHaQhSpfgumgr@vger.kernel.org, AJvYcCX1Vj1TSBZTXcVWP2gAiE/axpTZPwRCTNtIju/ynrZDBmz0ZHOoUKfWYzUeEWTG6vG4nPfw52Bo/ZJkpX50@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LgVjWfPVEnxrYwX5D+oNNNT+jIfgedY2AI5mINoBNh/iBsdK
	ZklQPCCzZJ9gvB/9eLH/zUhNHNe8mp4qCn/8okcbZW1aSotrHUk63WJ+Vw==
X-Gm-Gg: ASbGncuG5p9DNRNervjRQslIqV/ZbjeGzVl9v8Z/EI4j977kdzp821qc99tfGCSYGQt
	UtPFYaR5LIPUSGevPNRbaALQ68bWbut6C3FDhNmti6+fxm/uSpqK4nI5+fsrpAF6rbSG/TGRneE
	3gWvzpb03oJ7Y8Ve5Z3Lw2hrp8Qtotu5orkrkqR4JTyPJbK8GYlpKUGpvhRp+7w0scZKNx3laPN
	vhX8j2/TzSlIIQkMLvEyFMc5DV1pxGD59OGBATxfZA80oh8sJ8cq52CWQ==
X-Google-Smtp-Source: AGHT+IFXB6mtbitt1Ty/iT+t/Wxyvt+fr2CPLQ6VRcW7h6pu2iRFzuNW50tyST860x+rxbR3cQJGsw==
X-Received: by 2002:a05:600c:3b20:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-43668643bccmr256788785e9.13.1735428777279;
        Sat, 28 Dec 2024 15:32:57 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e528sm26232100f8f.83.2024.12.28.15.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:32:56 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 29 Dec 2024 00:32:42 +0100
Subject: [PATCH 3/6] mtd: st_spi_fsm: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-update_pm_macro-v1-3-c7d4c4856336@gmail.com>
References: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
In-Reply-To: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-spi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=3cZeUXTp51nnkA0ehfcJ3kzlhmQfCuKF9N0XQDOcDK8=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqkunV0YUrJmo2OxF1WCeGsLT1QpLwOpvdep
 XrGjLg1MXGJAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKpAAKCRDnIYpo1BLC
 tYhUD/9P4jzfqCUfSrApK6lmfba4E7uCY6h7SzplroCGW1ScAmboJ/iYlxhkMHbAYfLQ771Sy5X
 GApAEGp4oyZ3wXnMKt8YIdaZ6hmJTzeBWIsuISUWUx+2NFEqQQ3NuKR9fyjjJOz541V9Sbrbhj5
 dKm2bsvCeg/vFy7uEo6HCGmbFFrdSMUOahladMZaNiFyssMjt5B+Oxo9WuGPd1qecQKGPVIsqS0
 Rnlrb/7nduNaMV6u5peS3QPgq/rW8qodw5k+1u7YDrMbvU3jOpDBbNkZ1S0sNxBnoJ8tnAjwDk/
 eQlg2JFElPRIvOnRWXngSOzLgvZR/nHaFpYZiZnfF32pvu0VFABQoQ1JL159abwroLScvR48/C6
 6i2RMm5ARJf5RdkBoYai3xU93SvI1qxjYucRkE3uj+mMTZ0PUrftZ3JZ23DMZZG8WnPNfh2EOxW
 xWL1/3THYy7Wl7qHQ00LPyMT2NRocPs+0Tp1wzMaRVMj0q6ciGjqJ+QYHMZlHbhSh5sBCuqRwmu
 41acQELy7x7I3k01wrZ1sy4TLYyni32a1fvdO2G/DWSvUSDhFTMkl2dhQUfKpv0VrXcx331yS/z
 p0to76g+3pC4HZPGpFzKof2JGxRm11hvlh2tzpvL3RFL3eaWjrtMGvmM8gXxvtCcmh8Ha9CGnNI
 ovHV8xs1qQgCQKw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gmail.com
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/mtd/devices/st_spi_fsm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index dba584fa2a530b8d32eccc4ebc4d04ce01582ca8..f2266145b82167a4f7a063bcc7815115815483a1 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2104,7 +2104,6 @@ static void stfsm_remove(struct platform_device *pdev)
 	WARN_ON(mtd_device_unregister(&fsm->mtd));
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stfsmfsm_suspend(struct device *dev)
 {
 	struct stfsm *fsm = dev_get_drvdata(dev);
@@ -2120,9 +2119,8 @@ static int stfsmfsm_resume(struct device *dev)
 
 	return clk_prepare_enable(fsm->clk);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(stfsm_pm_ops, stfsmfsm_suspend, stfsmfsm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stfsm_pm_ops, stfsmfsm_suspend, stfsmfsm_resume);
 
 static const struct of_device_id stfsm_match[] = {
 	{ .compatible = "st,spi-fsm", },
@@ -2136,7 +2134,7 @@ static struct platform_driver stfsm_driver = {
 	.driver		= {
 		.name	= "st-spi-fsm",
 		.of_match_table = stfsm_match,
-		.pm     = &stfsm_pm_ops,
+		.pm     = pm_sleep_ptr(&stfsm_pm_ops),
 	},
 };
 module_platform_driver(stfsm_driver);

-- 
2.47.1


