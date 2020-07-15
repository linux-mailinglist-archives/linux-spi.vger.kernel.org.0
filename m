Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E118022103A
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGOPGt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgGOPGs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B8C08C5E1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so6184900wmh.2
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2yOByTJ584zq87efhS3Vkyk+agE9qVyWq/sL4PYeIk=;
        b=UyEhMAjQjWz7s63ZoKbqZd0he72PbgcQoERVqZzfPDdeHfi76qTF2aqAKxzkw+vs8v
         1ccaVDSAO4pCzQ94UQJrxVt/sheMgiPUXVzxym6vO5O3kTo9gbcNiNZVaVD1plMF0J3k
         z3yGisz15rp6uRZwbOTBwSS7WRG2WW4RYhT3UooUQ1/ByKSkNAp8xkJVJkMzDKEaz/uV
         dY1tnRfjmei2kZiknTPr5tnLNurtxkTSnbU4QVjMd/PG1AQFoIo5f4IX91KQdnkdhecL
         G0V3E7kPOXw89FXa9PIId9kyqYzc/kbEl6QHQn+6MHKgA350J1Dw6gHOjtOneOkfuyyM
         4CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2yOByTJ584zq87efhS3Vkyk+agE9qVyWq/sL4PYeIk=;
        b=VHSq4Viiv27nQECVu6PWGZwsggUQZYsVJfawFOaExm0f/rM3cveFAPEPtjJ3dsHj0V
         Vl6V4spv+IVG7/vI861Cp2D/gWxlnuqeOVir1w9oXHO6dzRmXZMuhFrBOKELaH3pFD+L
         H24ev9KpzVoz2UJP2WuLMf4tOjrfS6ry/6v9UVVEtkibnDX7pMu9xGn6GwdGslov2eha
         o1WdNi0dwZpRGF7MMam2LQI9yppmYGL//NPCsz69r+syze5HUkqvVZ64DkpZxSdrSYXx
         JBvnFw6QO98LP0FRwl5mcgzzAu7DCxoZtakoUnvREds5r7Hp+DU6uejhGOrbu8FXJiSP
         iftw==
X-Gm-Message-State: AOAM533X3N8h2PVv1X2DptnK8xrpJmbwEtWasBm3ZgJ6/c0LjR4btj+C
        xQmz16196hN6LIuYmG7+le0ZgA==
X-Google-Smtp-Source: ABdhPJx39xtrPHkcaKWFcDV25x4ysJFEnVveAGzGMS6sEEHSQ9JC+ALsZmBUt/eVdulx8vVh0d6eMQ==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr9114757wmc.150.1594825606599;
        Wed, 15 Jul 2020 08:06:46 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sureshkumar Relli <nagasure@xilinx.com>
Subject: [PATCH 09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
Date:   Wed, 15 Jul 2020 16:06:27 +0100
Message-Id: <20200715150632.409077-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-zynq-qspi.c:143: warning: Function parameter or member 'dev' not described in 'zynq_qspi'
 drivers/spi/spi-zynq-qspi.c:334: warning: Function parameter or member 'spi' not described in 'zynq_qspi_config_op'
 drivers/spi/spi-zynq-qspi.c:334: warning: Excess function parameter 'qspi' description in 'zynq_qspi_config_op'

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-zynq-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index bbf3d90561f54..5d8a5ee62fa23 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -119,6 +119,7 @@
 
 /**
  * struct zynq_qspi - Defines qspi driver instance
+ * @dev:		Pointer to the this device's information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -316,7 +317,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 /**
  * zynq_qspi_config_op - Configure QSPI controller for specified transfer
  * @xqspi:	Pointer to the zynq_qspi structure
- * @qspi:	Pointer to the spi_device structure
+ * @spi:	Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
-- 
2.25.1

