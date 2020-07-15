Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EE22104F
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGOPH3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgGOPGt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE03C061755
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so3047894wrp.10
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IfYptBKxQvrYFn67V4A+QmgFkUNV62He06/dIZhBEjs=;
        b=KZ/TT1t8CLQwqRlkcCPqM5ZK4eIUzF122chFSiLAFw9aUgHkXoJwedsjFUWNkqBK8w
         xoB4tfqJRd7SZyxqiKTR0kyAIdXPlACO3EGTzoXFXhuypYOk/pAabYnC9cCRagJh7ra6
         ys8mn2pnkIg3p3UpxtX1bwTvZquhEm5FSmtxNhh0OL5NHOsLK1CSoHoAZKQZe3U63AC6
         kWdU4mIEZiRg7ZLXpgfvBAeuZbFLsSu/s8OANq5iu9F/gUzRFCpo8TyvZzhRXipVMsh/
         W/JWNHB7R1SpSzw5769jWnV7f2oaRtgeMcQNpgQUwUsncIOaqTP5xM4uwZc4qtUaYnV4
         /oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfYptBKxQvrYFn67V4A+QmgFkUNV62He06/dIZhBEjs=;
        b=OXKJVXBYMVxUXy/peRhZXgvAZBbgPWaps/NfgGR3QU6wQKPFqi1GaO9ZMbVy9xdVcU
         yM7IkCxuGpo4Y+HDcAuueGBeWx5O7gxGrDl0nw9CG3ZimpNaN4nDi6O38uon2RtHZUuA
         YcuLV7Jlq9E588sY6Qruq8aWzXkk5wAQ0jDDU2XETvOcogEDW8tPhVxWeyd5eHzLkicL
         HevDn4AuoGHKHmHqm+OhN+6WoTA0y1fBRg7WcZUAJZInDtHW2JXbRpZi0yscR9+rUcDI
         D5k4s5Rm9Eh1HCuk2dnzXGfwz/YM3ao+O1szdbAkAqBUV0wGg2VTEf0Ygk28AcJz+VAE
         H6/A==
X-Gm-Message-State: AOAM531MoKXmMlee5zSzr+Tj1qqjyWUAioa0xRy962imrp2SXFJXxsNb
        AFzvQSlME0i8+CiANJjXQSlypA==
X-Google-Smtp-Source: ABdhPJxrrdTj/aQFIMBJUj58shw/EWz9k6o034iUJPO0GSeP71Qz7tMabUEkuVxpSHB3KuZgJnnDiQ==
X-Received: by 2002:a5d:4992:: with SMTP id r18mr11145302wrq.323.1594825608304;
        Wed, 15 Jul 2020 08:06:48 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
Date:   Wed, 15 Jul 2020 16:06:28 +0100
Message-Id: <20200715150632.409077-11-lee.jones@linaro.org>
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

 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavecs' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavebus' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashcs' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashbus' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Function parameter or member 'dev' not described in 'zynqmp_qspi_suspend'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Excess function parameter '_dev' description in 'zynqmp_qspi_suspend'

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 811c97a7c8589..e17a201252557 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -197,8 +197,8 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
 /**
  * zynqmp_gqspi_selectslave:	For selection of slave device
  * @instanceptr:	Pointer to the zynqmp_qspi structure
- * @flashcs:	For chip select
- * @flashbus:	To check which bus is selected- upper or lower
+ * @slavecs:	For chip select
+ * @slavebus:	To check which bus is selected- upper or lower
  */
 static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 				     u8 slavecs, u8 slavebus)
@@ -892,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 
 /**
  * zynqmp_qspi_suspend:	Suspend method for the QSPI driver
- * @_dev:	Address of the platform_device structure
+ * @dev:	Address of the platform_device structure
  *
  * This function stops the QSPI driver queue and disables the QSPI controller
  *
-- 
2.25.1

