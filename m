Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F285619F949
	for <lists+linux-spi@lfdr.de>; Mon,  6 Apr 2020 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgDFPxi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Apr 2020 11:53:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46002 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgDFPxh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Apr 2020 11:53:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id t4so6058917plq.12;
        Mon, 06 Apr 2020 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rN6eY9Qrqp2MyzcIySN26tQrPMmoMDpY4puhGFyM5mw=;
        b=IKlSzMZCcVNTRiuuJTREdvQ0DQozB3+Tcxbfc0oOwCUd1mnh8GBsQGphFBawZ5p1+e
         s+HTWu1zS0a2esb+KXnN83Qqf4k2nNPuiBnCgxO2jC4T5LwcwkEsLoMs+cS6sP2+oyY8
         Ul6nUy11tEihE31ZV8128jkd3iYQ5Gai3QE7pyGE/A2MWryA7fNFPp2yKounLBFtzBkz
         xzTKXuUGB2jsoz4KGE8fCqAx3mF4wic7bMTQQxV3E0IUF8AogHkG0ckdhb0OV9eVb5dT
         JSUSKF95gMC6Z/juaRIFCQOG0tZCeIpZYVqSFqOhDkhS9fKlj5VNlR5Leh8wCAkIU+1v
         h5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rN6eY9Qrqp2MyzcIySN26tQrPMmoMDpY4puhGFyM5mw=;
        b=ZTVZrLkBUV9j7UXzp+n1rO1F5Cba8re+tiisggBBN7DdXnBPcLyeQnPLUYivzutYDM
         0uQpGqhuSpZodDQUY6JaWh7zgjlWcJUXWVedEjYzp+5t9lRkuPTJijgTM6fbIcEdv0Hh
         baeJk25QhB3j+QHdyzMKXlT55Fxl9bw983NotLyOGCJ+H+qe68qJPp9gzYrmcOnK+asr
         CrZDbVtcOVD+wydJjey1ZyW3M6n29lJNMNDOZEsfCq47iGmzrHk3kQAzouCLyjeDJZQU
         gagzPNzhSiDfnoKRBF8TkpIjWuKzIEQD0tcTvZ0ekRgaKIAQdzQ362oePf+KEEnNoqhX
         g0+Q==
X-Gm-Message-State: AGi0PuZoZ4gJT3BhejTWEDhSEXLfFL3+uIeq4CRPULCzqkAo9cr6hvqM
        WlNVRJfRosNghng+2P+f5Ho=
X-Google-Smtp-Source: APiQypKEwHakGNo5xil/xnae82hio7J68wiouyjW1GRU7CpJavnsLPkfCIeBBEPCBzw8SA9wgDdOUg==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr19607934pls.230.1586188416657;
        Mon, 06 Apr 2020 08:53:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:89a:e705:d50:b01b:c4e4:35ad])
        by smtp.gmail.com with ESMTPSA id q43sm3851pjc.40.2020.04.06.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:53:35 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
X-Google-Original-From: Aishwarya R <raishwar@visteon.com>
Cc:     raishwar@visteon.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-sh-msiof: Fix checkpatch error Complex macros should use ()
Date:   Mon,  6 Apr 2020 21:23:01 +0530
Message-Id: <20200406155301.21768-1-raishwar@visteon.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixed checkpatch error "Macros with complex values should be enclosed
in parentheses"

Signed-off-by: Aishwarya R <raishwar@visteon.com>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1c11a00a2c36..b2579af0e3eb 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1398,7 +1398,7 @@ static int sh_msiof_spi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
 			 sh_msiof_spi_resume);
-#define DEV_PM_OPS	&sh_msiof_spi_pm_ops
+#define DEV_PM_OPS	(&sh_msiof_spi_pm_ops)
 #else
 #define DEV_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
-- 
2.17.1

