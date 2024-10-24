Return-Path: <linux-spi+bounces-5372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AC9AE975
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428D4285EAA
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C78614E;
	Thu, 24 Oct 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="EsURE6AW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5271547C6
	for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781789; cv=none; b=lbvAXIZK7cZqiTp+xNT4jSg8VnAq7hidpzyuRkFvvjzMxqHawG/EM+nvlTcm3f2BOMxkyYXEvX1vOVq3irnQWkWUC5xx+LBFyjhl/K9BdQZ5XhmgKll+Swn1ZwI+yXStcRlpqa3HnDnQ2w5KAX9h/2Zu/aMKgOx9+n+X20aLL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781789; c=relaxed/simple;
	bh=xe6fJuOFxKZ9Wa/QzwskMTCxSacyQ1znwVDAZjjTK9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rInxa1nJKveaM+PcLlva5cf25PVnaQrl69hyENbbE6Zv9VESBgFZ/ZawsWvQPTVx2pSw+CHpYP17674iy7Ko6NMFVqsP++PZvfL98JJcgFGz/q9TDVpWbunCjObv1X3v8pqtqMx0Uy2/RLq9ej6GYGLS0iaIgu+wAo6XOKR6Nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=EsURE6AW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so803793a91.1
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1729781787; x=1730386587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYXk1kuEikUpEll+uuEl+9utwWcdJCC+qvGvGbrx1Tg=;
        b=EsURE6AWisggLJNgThmN0ojompRNDzcOR6Quo7IQIafseM6jJt8DCpAKXjAktELrnu
         kJWttzfyDLYon2il3ZxmmShlgYI77dEBnqq++jFlhMRBRJi+2cy7MHaAnzS2odhr8QC+
         PmssULqwVk4w3MI2ixZKyHD86pcGyOgBB/VMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729781787; x=1730386587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYXk1kuEikUpEll+uuEl+9utwWcdJCC+qvGvGbrx1Tg=;
        b=v89Nu0eYOZ5847djHQiUBYzUZDoaqVgTGEb9xg0p8oaaZEsTBSjyOveKq0uiuesWYj
         7w32t/SqV0b+V8VUIfWtf2GxxEVeT0hpC4fwiv7MsE9FADFiTeGMWTRo7pJjMNDZ7xnc
         VrAhBnUg8FU6TF8lRniRM27rJLeE2wXUtd6eCw7br4RA382rA6gs3DEpVgE1Fpe8/JeA
         LgfEEwq6ARldJxv2ivOaDxNHMqaO+uSiBREfHdZjtxpLBLQ0tcN0ndx+Et+k0yhu9hqq
         JjHbQrl2kdbQsfAwUpSe2CMRjNsZRZo35FeJN1F/p9er+3N/jl5vFrHy7beVkMxs8nVc
         pWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUyuQX2nm44sOAzDoR5Fq/lNFJcDWSgWZkjXWWyXfAXcrMWPpVJ3OiqgVHuEVqxVjo0ltFWSPoz53Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQOJo6Os1fJAVmHZLycrq8sepfDCIUWh8IdbNYoVKVX/8P0GN
	yUPPuWT04tpq2dh4MTRIZz0vgui+G2XmLxQg9UzG/8zgV10B2i/r2b3ggufRP2c=
X-Google-Smtp-Source: AGHT+IGyrmr2pGpvcgio+yG/5Ty2pp8bce/MB34CIYn/1HII/5Ci59h5wA402DReYRaucCGjKjFlZA==
X-Received: by 2002:a17:90a:e2ca:b0:2dd:6969:2096 with SMTP id 98e67ed59e1d1-2e76b70c545mr6503466a91.38.1729781786854;
        Thu, 24 Oct 2024 07:56:26 -0700 (PDT)
Received: from jupiter.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df41f7f2sm3888729a91.0.2024.10.24.07.56.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:56:26 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH] spi: Fix deadlock when adding SPI controllers on SPI buses
Date: Thu, 24 Oct 2024 20:26:11 +0530
Message-Id: <1729781771-14089-1-git-send-email-hgohil@mvista.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 6098475d4cb48d821bdf453c61118c56e26294f0 ]

Currently we have a global spi_add_lock which we take when adding new
devices so that we can check that we're not trying to reuse a chip
select that's already controlled.  This means that if the SPI device is
itself a SPI controller and triggers the instantiation of further SPI
devices we trigger a deadlock as we try to register and instantiate
those devices while in the process of doing so for the parent controller
and hence already holding the global spi_add_lock.  Since we only care
about concurrency within a single SPI bus move the lock to be per
controller, avoiding the deadlock.

This can be easily triggered in the case of spi-mux.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
This fix was not backported to v5.4 and 5.10

Along with this fix please also apply this fix on top of this

spi: fix use-after-free of the add_lock mutex
commit 6c53b45c71b4920b5e62f0ea8079a1da382b9434 upstream.

Commit 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on
SPI buses") introduced a per-controller mutex. But mutex_unlock() of
said lock is called after the controller is already freed:

 drivers/spi/spi.c       | 15 +++++----------
 include/linux/spi/spi.h |  3 +++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0f9410e..58f1947 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -472,12 +472,6 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
 
-/*
- * Prevents addition of devices with same chip select and
- * addition of devices below an unregistering controller.
- */
-static DEFINE_MUTEX(spi_add_lock);
-
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -580,7 +574,7 @@ int spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.  Lock against concurrent add() calls.
 	 */
-	mutex_lock(&spi_add_lock);
+	mutex_lock(&ctlr->add_lock);
 
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
@@ -624,7 +618,7 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 done:
-	mutex_unlock(&spi_add_lock);
+	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
@@ -2512,6 +2506,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	spin_lock_init(&ctlr->bus_lock_spinlock);
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
+	mutex_init(&ctlr->add_lock);
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
 	if (!ctlr->max_dma_len)
@@ -2657,7 +2652,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_lock(&spi_add_lock);
+		mutex_lock(&ctlr->add_lock);
 
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
@@ -2688,7 +2683,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_unlock(&board_lock);
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&spi_add_lock);
+		mutex_unlock(&ctlr->add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ca39b33..1b9cb90 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -483,6 +483,9 @@ struct spi_controller {
 	/* I/O mutex */
 	struct mutex		io_mutex;
 
+	/* Used to avoid adding the same CS twice */
+	struct mutex		add_lock;
+
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
-- 
2.7.4


