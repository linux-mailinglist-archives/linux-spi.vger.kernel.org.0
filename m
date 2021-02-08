Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E360E313169
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhBHLwa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 06:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhBHLuV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Feb 2021 06:50:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903AEC061786;
        Mon,  8 Feb 2021 03:49:41 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s11so6259526qtq.10;
        Mon, 08 Feb 2021 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAzz6WCrRO0WwDk5gFhUxBwBiElBJr4tyLf2C1wPfSo=;
        b=na37QjRHLCIfd/oN9TZWbCUm3ccHHQrUq4egqsjOHdG4/+vrRJJ/YJbnVyxlLcDH5i
         SAr1YY9HBB/ln26deqUe/iWeXykQKxmwbjUBZmfGX7tQxp8aFiyXIR7+puuEgT/43F5A
         YmWr84kWpmtIOXyUyrGUkg/889nQnkafbvbw+av0QEi3rAC9uziP3EvkRwvdS8Ed80je
         uL1+2DApfoEPuHSYwp6AtFWuNR7SbPsUfl+8JUMnSGJr6JvY53t1ovxID0+q616haVVA
         5URcEr9PCuXTxUTR6exJrdiSZey0NFhlunoDaCd35wzG46pglY7cgZYTdx0CeIsG5tGk
         QZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAzz6WCrRO0WwDk5gFhUxBwBiElBJr4tyLf2C1wPfSo=;
        b=tdtb/jIl9eZ0rt1zZeOuLQVxK7PC7HsMGMsFqJ+lCDCS0qcT/JQO5HXR3VMvwPtNQ8
         seeNrL1Rg88MYsbuTSDrr7OCNobv8yh+xQUzAG7cmlPfoC4d/ZqRgBmfI7aNAsNOpvTz
         NnZKXDNTFVuby8p6XBe/pLnxzO8L6iQRWpprT0u/Iy2Sf3MH94qLSO2IPraLTQ4ehPcN
         u2fgtkRfil/Yoiqjj/dsV/+c8hxbESBUgTGsekArSLdBzSbmC1q7Q83gsFBaR1JQJ2lS
         XCggQdbOytM1ad9qd4loMjDDhgByePSQlAcQOZR6kUCUd/IMqfQEKsxQ/nQVluojkpYu
         7UqQ==
X-Gm-Message-State: AOAM531DxiK0Egeaf8zDhmCgq9L8Laxn93i/BkfFHiKptDXMT7Mb9SoJ
        VkJSK6JWQD9hbKq4HVyNogQ=
X-Google-Smtp-Source: ABdhPJzF+nn9wbkJ94K5YQA+Kw9uTY/OwyR4ObXWP9Bvbuj3oPYSqbrOxb2l2eabv0tVzmSLFVVlHw==
X-Received: by 2002:ac8:1c6a:: with SMTP id j39mr15412695qtk.326.1612784980002;
        Mon, 08 Feb 2021 03:49:40 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.175])
        by smtp.gmail.com with ESMTPSA id o12sm4450878qko.117.2021.02.08.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:49:39 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] include: linux: spi: Change provied to provided in the file spi.h
Date:   Mon,  8 Feb 2021 17:19:28 +0530
Message-Id: <20210208114928.32241-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


s/provied/provided/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes from V1:
  As Mark pointed out change provide to provided for the context

 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..79f89fd250de 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -624,7 +624,7 @@ struct spi_controller {

 	/*
 	 * These hooks are for drivers that use a generic implementation
-	 * of transfer_one_message() provied by the core.
+	 * of transfer_one_message() provided by the core.
 	 */
 	void (*set_cs)(struct spi_device *spi, bool enable);
 	int (*transfer_one)(struct spi_controller *ctlr, struct spi_device *spi,
--
2.20.1

