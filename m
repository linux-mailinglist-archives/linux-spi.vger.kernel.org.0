Return-Path: <linux-spi+bounces-5615-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876E9BC45A
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 05:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2348D2828A1
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 04:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF11B394A;
	Tue,  5 Nov 2024 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="ACni7COb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2618FDAC
	for <linux-spi@vger.kernel.org>; Tue,  5 Nov 2024 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780972; cv=none; b=EGY0YKPlU4yOYaymOp+aBmzbJbYRN7A0tcD/sMoEDREI0b6prH+eJNMN5reycpF/pVqVNhMIZnTe+/h85tdHRXcIMYtckUCTKKmZbNLiE53lhNYNq3WjhFfYGOO9cJyc07BGwpdvLC7zk9LY4Kw4Kh7NiDGozga4jKjSr2ZGuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780972; c=relaxed/simple;
	bh=8SLmDpTRCFDajZT38/rFEX+2ka0yX2igg96h70rcUao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Gca4iPxw60M3gPDSaiPsDvfRApy8Om1EEpvOiCpYYtjOAsHCnjS17Crosex3iOUO21hUZ4eQJmB9w9XsG06os5VNV9Ikn0lp9ML5U4v8bx3VIa3IvOBt8AyTmx7CmES7Hd4uzsLBGobldG0unrPp6beAawG6xsCrj71X5c9LYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=ACni7COb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2110a622d76so38013415ad.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Nov 2024 20:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1730780970; x=1731385770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPgJOaKUw2i2yhBq0UrCbUBNmKfQYHEenFvmnag+ukI=;
        b=ACni7CObMJc6Wy8I7q730yoCc9fiiDWImF4ZPtGKV3gLxvYxLPiMRhkjDLgJi+V7ba
         eHakZFl4ZSfSfQmoAE7RJgtHVFFjnCRqa1eP/mhz0yFzaqY5SMVkthl/F7CBW0X68n4Q
         o6RdbgdP0j3wa0JQoNL7fMSe4ad/9JWvVlyXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780970; x=1731385770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPgJOaKUw2i2yhBq0UrCbUBNmKfQYHEenFvmnag+ukI=;
        b=pLxrYyB3lc+lMFAZJkdG/L8hio0yJBMrI/0e6rD7pbwqkmsxK8zDzBBjMc4bkqNgww
         AbHABALRvnyeeJupGHVmeFQ7o8uZREZfnKmUferxlU4r/hzHL4J6Isgk+Blhg1ZMBJKk
         RQbQObdekozF/yErNxgYVS+j3pjklmR5VjUSR3KQ5lMXstlBk0sM4x7quHJP4G1Sxyhn
         GyoWUL1rYbubv+7hq1M8DFLYjv93z4LBYQf+uyU1POWllwEIMbaswCqip2NiYeZ3EYRm
         S9+n74xUM5PoMFNtHoyseeJKi9EJzdtsXHv+e/0shuDD2mwQFrI40PrdTILV73cdCpYp
         jReg==
X-Gm-Message-State: AOJu0Yy6yhtl7//Bp+FLqyPDMPh+v2ijJd7BlwlGyu0oLKsukqAIXnKH
	1DbQDqkpC7hL/oyZjX83J+ApDx1aUQ7BFPWEWRlfiukCuHaHzohjxMvcPercBQc=
X-Google-Smtp-Source: AGHT+IFY9OIl5skQBRIO2pCUZzVxAmt0oAL+rH5hjwiRx9eykhnbWVyX5fzKpskOf4a4N7E57JH8CQ==
X-Received: by 2002:a17:903:124d:b0:20c:5cb1:ddf0 with SMTP id d9443c01a7336-210c68a9c2bmr489805165ad.10.1730780969827;
        Mon, 04 Nov 2024 20:29:29 -0800 (PST)
Received: from jupiter.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc65sm69234575ad.10.2024.11.04.20.29.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2024 20:29:29 -0800 (PST)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH v5.4.y v5.10.y] spi: Fix deadlock when adding SPI controllers on SPI buses
Date: Tue,  5 Nov 2024 09:59:16 +0530
Message-Id: <1730780956-13313-1-git-send-email-hgohil@mvista.com>
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
This fix was not backported to v5.4 and v5.10

please also apply following fix on top of this

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


