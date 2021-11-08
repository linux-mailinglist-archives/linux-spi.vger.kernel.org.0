Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B49449742
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhKHO6Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 09:58:16 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:3655 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236884AbhKHO6N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Nov 2021 09:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636383329; x=1667919329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l4uhQVrWdxivqDNc2kLDMQcewIewAn6eyYqgva/TcFg=;
  b=b25tKls4Wx92IuWEz+R+CWt5eZHEuU6mmUC3R13aVfYST9r8QWU93IJI
   ah5LJ2QKSJ0SwChxHdATCCGAeLnJUIlTcqeu9bkTIVhrdXGN6iuHEdfZd
   bn5WYu0fF2NxS29RiIR7uoUUodvQG0Ppxo/qhPa3mckbbP4WYtmVM8qBv
   lyF0KvkEFJviTzgrRO6nHHwqgSKXlyW4hwDppXRY5fBlJ69QjRZt4IBkv
   rNLerVe954TabsAPlXT2Rw4dE5F67Q7zSnFv5ERKRMS8M2VKTkwzXTFgD
   1zjk8a6A1raC7TUBQHT/SPAdGgV4/WQe7LwpayKk6My1X7RxUb0cZsV4w
   w==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="20378568"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Nov 2021 15:55:27 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 08 Nov 2021 15:55:27 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 08 Nov 2021 15:55:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636383327; x=1667919327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l4uhQVrWdxivqDNc2kLDMQcewIewAn6eyYqgva/TcFg=;
  b=XNVFBDp+ZtrH2El+k0uJObLkeUlEmm5W8TGd+jthXpEbkua30TrshJ7p
   ShRzmAubFkgwexQ8xZOdHCbX9p6HrylHT2D/liALCJiq92ZW//feej1bn
   ktvqTsdw+GjBLHlEvRJBBEJGTfbzfb3kw1IgS1etkxn+Xzox+SJekX5aj
   oa3nIh8wctT7v9GZdiumGF0XLYQyy/4kHlQITkWyKY4R2D5X+vbU5tzOv
   lK65fj4Ml25svizENsOUNJSRMUjkTYXLk0RG3+SIs7BDNyB+oNFAEzofZ
   8gqOpE5bOp0urNDQ3yCyxy22sOix+9Kvt8MXujS2aPFuZzO2WYNtoX0Y5
   w==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="20378567"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Nov 2021 15:55:27 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B5E88280065;
        Mon,  8 Nov 2021 15:55:27 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/1] spi: lpspi: Silence error message upon deferred probe
Date:   Mon,  8 Nov 2021 15:55:23 +0100
Message-Id: <20211108145523.1797609-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Do not print error messages with error code -517. Silences the following
errors upon on imx8qm:
fsl_lpspi 5a000000.spi: spi_register_controller error: -517
fsl_lpspi 5a010000.spi: spi_register_controller error: -517
fsl_lpspi 5a020000.spi: spi_register_controller error: -517

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5d98611dd999..c72e501c270f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -912,7 +912,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		dev_err_probe(&pdev->dev, ret, "spi_register_controller error: %i\n", ret);
 		goto out_pm_get;
 	}
 
-- 
2.25.1

