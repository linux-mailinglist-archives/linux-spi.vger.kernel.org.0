Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E353114CFC
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 08:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLFHzK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 02:55:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33714 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFHzK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 02:55:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so1757011pls.0;
        Thu, 05 Dec 2019 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3AOgO5FZbXTW4qKGcd/lNa53gxwSbCk9qmuXzoNq/0=;
        b=XEyw3nr7x7OH4i7E68PYtLJRHUOmkFtzxK1/Z1X+ix7PaR+Pcy3sTDPC9Wca9K0BXo
         Yk+9z3qdvX4TbIIi452gFZCUDmSJG3gr265UxvJ6Phjk0K6Bf/h3qgO/9EmFQqRqENQ5
         xpD14yWtzzWmOvXjHZR99pJ+IyP1yqoi/clmPEmqocrv/winrKmmOO0lNd2Yw4rurKPU
         h8ENy2oHu+TZq/XXn8tAcZLBxl8fti7hUjzxNNAMMAkPVHqPGsFkTtE/tO1iUG7anj5J
         sEb4sDGEXZJnD4KEvwG2mGb4hcvQ7mPt1MWVmrwTsbG11qqjULnjFWFhoVPYBoEGiZtO
         HP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3AOgO5FZbXTW4qKGcd/lNa53gxwSbCk9qmuXzoNq/0=;
        b=jGRV4T1wtGlC6TpYyq2jnUnLC5yp3MCo/lxcJbK/veVBfgLW9Md84RoBgDRH9dnvyb
         HgaJ1B01hVz/qYtSYdpyGmw1xfBgc6ffnSW4Hd1mmlGzImkj1XEg4SecoIR18vgyemvz
         fo+QNkfW0n8o7Q0pXe00NedLWNIIGwMV/iFCLSTkYPFBTAbyZGJBKBhtwo07RTyg1vAj
         AVzEV+LWZ7I5j8mB2NnUkBJOyvnRpdidnJJpbrY6mHndbH6/9FWI3ZLegtwZXu56u2+U
         mQPCU4Xj3irokcWGyaHnEGH98FJjdKQiu5SJOAoIKPLfWBVbsNHtyWGJ4bzSEZl9A81Y
         m1Jg==
X-Gm-Message-State: APjAAAUjNs5bRzHW5HbHCoDsqXbW02cQbBQEr7Ot61uX+kxN5Zoh65Vx
        8diyn/9h/lBgOW9Sxz7ZsUUgbgiWAXI=
X-Google-Smtp-Source: APXvYqy9MGNiP8Uc3qTb5tfVkwG/Nvlkjd0rWayevjIn7KV2mmkbzTexJ+LkNiwHJ2h/Sg7e6WPLkw==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr7029875pll.39.1575618909785;
        Thu, 05 Dec 2019 23:55:09 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id o12sm2155209pjf.19.2019.12.05.23.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:55:09 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: spi-cavium-thunderx: Add missing pci_release_regions()
Date:   Fri,  6 Dec 2019 15:55:00 +0800
Message-Id: <20191206075500.18525-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver forgets to call pci_release_regions() in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-cavium-thunderx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index d12e149f1a41..fd6b9caffaf0 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -82,6 +82,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 error:
 	clk_disable_unprepare(p->clk);
+	pci_release_regions(pdev);
 	spi_master_put(master);
 	return ret;
 }
@@ -96,6 +97,7 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 		return;
 
 	clk_disable_unprepare(p->clk);
+	pci_release_regions(pdev);
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
 }
-- 
2.24.0

