Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1386F46B952
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 11:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhLGKox (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 05:44:53 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:18756 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhLGKox (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Dec 2021 05:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638873683; x=1670409683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l83DnkI4AxWxlVN1uFP/FaAtLVUiifNMjaDw15nALS8=;
  b=BaCGLy3tq9nujXru+gE0SzLed9/8kKq8ET1WKZjuZeT4p4Tjbk1v+wBU
   smeYwQFbjl5vNW/5s6Qd9xQXEC9D7E5QEANuE4vCLJhpAollQBd8Yqlee
   NRTsncVFvmLQXi9dB00meuxCgSYjRu0fqyYQ/vLog20+Ui8dMnPRhrmB8
   qtPI2BRyQy4+msYxBv4XWk1727iqYERZjYBlI4Gha+nJpek3JuMztsTgz
   0UgO32EZZOVnMGNntsWjHZhAO5G797a347aRUEIn5wNL/oz4Me9xSFzP/
   Z/Ist3I7FsHQ6lrA3I79Uy2Kxmi39vDr805dvioSH94wjHaUvp/fhj4lQ
   A==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631570400"; 
   d="scan'208";a="20894684"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Dec 2021 11:41:22 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 07 Dec 2021 11:41:22 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 07 Dec 2021 11:41:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638873682; x=1670409682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l83DnkI4AxWxlVN1uFP/FaAtLVUiifNMjaDw15nALS8=;
  b=mWonKulqmczi1Max/uh7v7DmFnkl8RFCia5Xt3zSt5i1ZhunbfoRUkV2
   RxU2b91hagdDKjp9Exsj6KQqdHYvVjzf/jHKBAmMx3vWbSBDSm//wy0Ky
   8IyGojT0t+Ej9GbuQTZ6y+P47Q729JmTw0JF+PLgm5eUKOD6KRxKS8I4k
   sbHZ3bsVRrjNPENhRcQaleE9e3HHp5HLW7OgAoxvlp0ZE+Au4PUlZ1wwW
   hTlw019rU1dRCjd/T9Fs7LxRlptp3+2kG3rpyCrQJjAEzsJPcQOHT4nBc
   Mvnki+ngk0JtV+27le5n5hAX3ZA2rGojgqlnazVkBb5ByW2gIpbWiAtjb
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631570400"; 
   d="scan'208";a="20894683"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Dec 2021 11:41:22 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 63663280065;
        Tue,  7 Dec 2021 11:41:21 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/1] spi: lpspi: Add support for 'num-cs' property
Date:   Tue,  7 Dec 2021 11:41:14 +0100
Message-Id: <20211207104114.2720764-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds support for multiple hardware chip selects. They are controlled
in register TCR bits 24, and possibly more depending on hardware platform.
The driver already supports multiple chip selects in fsl_lpspi_set_cmd(),
so allow setting more than the default 1 for supported chip selects in DT.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This has been verified using a logic analyzer on a custom board on a
i.MX8XQP with 2 chip selects connected.

 drivers/spi/spi-fsl-lpspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4c601294f8fa..532bdfb523ea 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -819,6 +819,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	struct spi_controller *controller;
 	struct resource *res;
 	int ret, irq;
+	u32 num_cs;
 	u32 temp;
 	bool is_slave;
 
@@ -835,6 +836,11 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, controller);
 
+	if (!device_property_read_u32(&pdev->dev, "num-cs", &num_cs))
+		controller->num_chipselect = num_cs;
+	else
+		controller->num_chipselect = 1;
+
 	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
 	fsl_lpspi->is_slave = is_slave;
-- 
2.25.1

