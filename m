Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBE175159
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 01:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgCBAUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 19:20:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgCBAUP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 19:20:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id a25so1324442wmm.0;
        Sun, 01 Mar 2020 16:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qs3+I42Vk5LwQW7SFPSt19C3CR0rbqVbzkz6HvtZ2AA=;
        b=Qsocjkv1YYfws5NPcSkn0AMdt40Wz8juRmSP8ckwTVATPcwk/+rHDa9KNLFpM1h49u
         RiItwFYsCtYmOdQbnKLaAniAdqjaPdEn+ZIxVxAQ78JV/rlVbVvJbymQsv7DnnVuDey2
         jigVpy//CkGVXqFXlkFVrBiAt+yRypCSIwZ1pyJFHFvryxI2SGIFm/yAY+c33iI3G7M5
         uEhYhbM0Con6iH7qBFyMAezZivh2Nnp2L5E9MoxnF9sKTZcwzZqOhFg8j+rKcI2h0zMi
         q+0ttNaUTIgAuwtaLUrHzRUdSYCipfJd4nV+8pGP4HFPdfdjWACo4RrRr2AxqZ7vamaN
         hx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qs3+I42Vk5LwQW7SFPSt19C3CR0rbqVbzkz6HvtZ2AA=;
        b=CS1K79zeRqy7P2EI21LNL23FcqCOm3F4fCccn/A7Vfqn6u0bplgT1uAnPd1kch2e1F
         HNXULVLU3/pURwKmb/ugio3O38ajTl+XuFsaQH/nIPkImcjwOj3++1LOBoM4+rvk8XXQ
         nj8pgCYX97qrZBKXeNB0nR2epwQqGrM3gFy2Uc4H03Sj5fCQnmtfZkFKUVdm3ovUnZVa
         Lh44FPWlz0BBxaqXRbE2q/VZLm1pdCahTTqDIijzUIs8z/PwisSkUv7ZTtkCXx+Cyhb0
         1r9QyU1+Oj6UJCEsMf2NMzzdJR78LPwFwfRSidaOl2aMGefgMjQ1wrieTztPYnJRdkkI
         pc8Q==
X-Gm-Message-State: APjAAAUMJ0+9zVC9MGRkdNldduAhfoKmQTFc7NNCGBMdPEZJE7HkolqH
        KBr8bHw/INZobHnz6Au2Sss=
X-Google-Smtp-Source: APXvYqzDrUc27H5BCaiSw34tOIHqQ222O8hFHNmkcqEhz4/EGRYVGyTYN2kBGp7fJKxabIcUO3mOag==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr16788140wmj.100.1583108413643;
        Sun, 01 Mar 2020 16:20:13 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:13 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode
Date:   Mon,  2 Mar 2020 02:19:56 +0200
Message-Id: <20200302001958.11105-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

XSPI allows for 2 extra features:
- Command cycling (use a single TX command with more than 1 word in the
  TX FIFO).
- Increased word size (from 16 bits to 32 bits)

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 55ccb3d0f683..d21cc5cdc8a4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -179,6 +179,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
@@ -191,6 +192,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
-- 
2.17.1

