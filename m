Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA32FEC2A2
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2019 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKAMSM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Nov 2019 08:18:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55557 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbfKAMSM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Nov 2019 08:18:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id g24so9151142wmh.5;
        Fri, 01 Nov 2019 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZOoIzpG2z8fi2GZrvyp00RYzBAVVduBNjTY7LDpDnDA=;
        b=WMGeLp/AVcDchEPwD5VJFbDRfoXly9LNsd0siehQ54HLKyIZ8qz9gi8KhSFn/ECKpG
         4taW6nS3xhiwjHUhlKwrUKHiRbPhs2tXHJbH1qNcz50q5vHK3RsSKuYORB7lqzRv+kKs
         hlzTPidpqQOgpmDIDqPQWVRFFc279Bdiwn3Fo+zG7ZmOK3rWuWObm1y60wX26Y0lLe2R
         rxYZZwUwn6q4AWS6avO/Ttxqrm9T9MPIkI6l8saqG21Hm3uzAKNsJTZk8gGvFL4ZXobX
         QQ84THyc3nfF1poe9cx5U0FWZlISf+jXrv+zA2bXISGSyXsVB4eUT5G0vYx3eZZY9NgO
         xZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZOoIzpG2z8fi2GZrvyp00RYzBAVVduBNjTY7LDpDnDA=;
        b=X+szGtX8jeFdstKdfMaH1J95SPYF8sBc5Ghi0kjVSxaHv6QSZwljCCZvGibrY+iFB+
         ijH4TxZM93MCBxdhwx0vZAw24WldRr7QytgKjW6ffZ+TjpSY01cTjCyJPju5kjoYoQ1i
         kNUILBH5zDW8YjWTRy0hxCICO6vSA5B/NmPIwgPJKamY1q4piHDP3K7SOwuJkGKkq43k
         omjvq87/LccgyX96GpBkPSOz/tzlUWbD45n0EvVJd2yLu74ShVuE7g+1TDNBXYz4GMLQ
         QcM1HI1QYX4HqhQsjtnYl8J9NYXlOagOPfcWi/dyhW9gzlv3mzPGpZawKJPrFfaCcVWF
         rXcg==
X-Gm-Message-State: APjAAAUjWUuy50qOWuqb2B4I3XJ/54hzGGENieIdgIW8Wmlusmeh5+wM
        W+lInhw/scll9ArGzVEorhQ=
X-Google-Smtp-Source: APXvYqyYGMPZVOcwrT99SjO70XvqnXNb10RZu4lXx7hjfGuoisqKxZ/u5JHTJkzyPdKNoiU5Az3ORw==
X-Received: by 2002:a1c:1d53:: with SMTP id d80mr6277323wmd.88.1572610690236;
        Fri, 01 Nov 2019 05:18:10 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id p15sm7759400wrs.94.2019.11.01.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:18:09 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: sifive: disable clk when probe fails and remove
Date:   Fri,  1 Nov 2019 20:17:45 +0800
Message-Id: <20191101121745.13413-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver forgets to disable and unprepare clk when probe fails and
remove.
Add the calls to fix the problem.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-sifive.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 35254bdc42c4..f7c1e20432e0 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -357,14 +357,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	if (!cs_bits) {
 		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
 		ret = -EINVAL;
-		goto put_master;
+		goto disable_clk;
 	}
 
 	num_cs = ilog2(cs_bits) + 1;
 	if (num_cs > SIFIVE_SPI_MAX_CS) {
 		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
 		ret = -EINVAL;
-		goto put_master;
+		goto disable_clk;
 	}
 
 	/* Define our master */
@@ -393,7 +393,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), spi);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
-		goto put_master;
+		goto disable_clk;
 	}
 
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
@@ -402,11 +402,13 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
-		goto put_master;
+		goto disable_clk;
 	}
 
 	return 0;
 
+disable_clk:
+	clk_disable_unprepare(spi->clk);
 put_master:
 	spi_master_put(master);
 
@@ -420,6 +422,7 @@ static int sifive_spi_remove(struct platform_device *pdev)
 
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+	clk_disable_unprepare(spi->clk);
 
 	return 0;
 }
-- 
2.23.0

