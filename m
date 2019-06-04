Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6EF33D4F
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 04:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFDCvn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 22:51:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46994 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDCvn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 22:51:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so12011224qtz.13
        for <linux-spi@vger.kernel.org>; Mon, 03 Jun 2019 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OVkhgHGZecqg71Nt6b+nRHlxOoYRQehGuMik5VmzaIY=;
        b=cia+qHaa0jRKFrd04Ro5RmYrdyXj9iDMUBKWok5RRkSMbaqlvyqNxsJCSK7+yoe1Th
         K/2sbGU8kZkIWl0Fpih+F56YV9WWKHflULqCbkMUO6HpqLZjuoLmKe6ibATGcmNPgmUQ
         WcpAI7+riEHDgD0bcdhpbjGZvMqDFuanu175B9XiHhQQGOlK1rUUTXrUuwV/qLY20/uV
         15tGa1yIRzhrEXHf01p0zf9hwexmEKQ+P0biP5pdoC1o3sKZZ4rTjvvd42lf8e2uSalo
         ujJ3Ue8VIsLuLitpw5gvqAon+1u12rTUhmrOwwvwdwFrLmbGnuwcvdflH3z8eOMBcvfA
         IwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVkhgHGZecqg71Nt6b+nRHlxOoYRQehGuMik5VmzaIY=;
        b=Sp4wifaAPP4A66zrwA4wOTM8kxkaOS6Caw5Ed8DB3FbRFD644PgePide4qd6n1I3qd
         TsVmag3FTelInQX75L7ZiaOmX0Te+9Xc4lXyPSXCe0udt7g9nZlVf3WnUOwgxBflFSAA
         OvYoux8zjI//G286bcNaGEcn+uOHoI7qsO1/GJJ9ftpfAKxzaGdTv9Axkq4Vi8Ot5TrQ
         MfGqsshlgAtzaIuViag8KAHzQDW4CcO3gtSATjQ8yH6OUEfLKtldDzimYjBB9TvFP1zA
         gThoGu6yhlMRI3JqDhzppmvoF26Jsfuo/SyAoGJ7+1gK2i/rmKOVx3XiqhhoARzbH2dN
         whuw==
X-Gm-Message-State: APjAAAV6TZKqTD3Q1Ekhd8hB7/na7nJj/o7wNion3QUeKz7Yotfj7tzp
        U9ilaIeKtWO+VOZ9bdg4wAQ=
X-Google-Smtp-Source: APXvYqzyrYAM/4UgtrOG2bdMtqkfHOiKG3CIE6H55eHfqerDM6uF1pu/bGx3ECjGsu9NvcF5Uyf5vg==
X-Received: by 2002:a05:6214:cf:: with SMTP id f15mr5852383qvs.154.1559616702025;
        Mon, 03 Jun 2019 19:51:42 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id k5sm8013942qtj.40.2019.06.03.19.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 19:51:41 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spidev: Use dev_dbg() instead of pr_debug()
Date:   Mon,  3 Jun 2019 23:51:29 -0300
Message-Id: <20190604025129.20387-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dev_dbg() is more appropriate for printing debug messages inside
drivers, so switch to dev_dbg().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 255786f2e844..0ea67ef3e65c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -560,7 +560,8 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	}
 
 	if (status) {
-		pr_debug("spidev: nothing for minor %d\n", iminor(inode));
+		dev_dbg(&spidev->spi->dev, "spidev: nothing for minor %d\n",
+			iminor(inode));
 		goto err_find_dev;
 	}
 
-- 
2.17.1

