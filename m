Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4025DFDF
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgIDQha (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDQh1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Sep 2020 12:37:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B8C061244;
        Fri,  4 Sep 2020 09:37:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so6610912wme.5;
        Fri, 04 Sep 2020 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsHz0anaSIx736ObUUMRuw/XmIbkGGT4MP6ZPn22gyg=;
        b=WrvT2RylSi8jZtli8/8LLTw8YYEpVRVlyTg2k9iI5UUoKWAqy3QZN4qlvOnmAqFWLt
         qiwvK6qirQyR9FhYKZjU2I8i1Yk8fCkT2NvZL0Fm09RIyWqet80bPiwjo+um2TWeceun
         9cV4iXaYZhdBNg1M9nNceU05KIjGDxGJTXnru5ejZZnM49bH4RNyZ0UAbfKbWa9rpLhY
         rIb7vXwiHmghtmnueUAx4Pvq+7jR9ZqhDVo1eGd2mQqvdtFBhW4RDlKY6ku2KxB+45e3
         N2l6Ko+F71lfYGMhdrezGLKT0iKfZzAQgU72EP5ia07OmIoY/L/SRjdiroieH5i73aU5
         RdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsHz0anaSIx736ObUUMRuw/XmIbkGGT4MP6ZPn22gyg=;
        b=PFOm3mAtTnREK8pUkADuIKbzk/MPSzGxXu03CKGTFuJJ/lwxIcPdmJP6y4+LJczlP3
         B5a63BL19Sg34NM86lZmZAoGR/WThSPJJwVsOSOG53qikPOv7ep1MY87QhRj6Ng0Wnov
         lx6PnkRYBnebqVO/37+5jy2yhvuFdRrrWO7GX4I/ONwG6tCJnjEIRAjFjTUA6k0dANEa
         4fsBjzad81p8iGYXtQ1itZTen4YHnTO2vNnC3iDEMf6HQNVbb2BVW5WyUAmtwd2iXbyi
         0VEDxfWdI7frM7JSmQKiZYz7XbwC//ZlsRP08pwra4ZaySGSRx++56Kp49jx0yYzkq41
         +5zQ==
X-Gm-Message-State: AOAM531PBMHK50Q5/kwPX8HARYC2Cl+teOmoVTYPRioshqZ1c45TkY0K
        8tack2jW65V+3o0Q8tYtBaw=
X-Google-Smtp-Source: ABdhPJzpRKILIo9HKs0tS47pLTsfUQuR58L9eN/1mexDCDJ0jQVJQryezGXFENcnjTn7imOXJ4AORg==
X-Received: by 2002:a1c:dec2:: with SMTP id v185mr8313988wmg.1.1599237444498;
        Fri, 04 Sep 2020 09:37:24 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id c10sm11980109wmk.30.2020.09.04.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:37:23 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] spi: qup: Allow for compile-testing on !ARM
Date:   Fri,  4 Sep 2020 17:37:10 +0100
Message-Id: <20200904163709.110975-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There seems no reason to restrict testing to ARM, so remove this
constraint to improve test coverage.

Build-tested with allyesconfig on x86.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 01b6c80d86c9..6dd7154d175b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -637,7 +637,7 @@ config SPI_QCOM_QSPI
 
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
-	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Qualcomm Universal Peripheral (QUP) core is an AHB slave that
 	  provides a common data path (an output FIFO and an input FIFO)
-- 
2.28.0

