Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A34685EB4
	for <lists+linux-spi@lfdr.de>; Wed,  1 Feb 2023 06:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBAFFd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Feb 2023 00:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjBAFF0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Feb 2023 00:05:26 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2559E74
        for <linux-spi@vger.kernel.org>; Tue, 31 Jan 2023 21:05:22 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s124so14815127oif.1
        for <linux-spi@vger.kernel.org>; Tue, 31 Jan 2023 21:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6q4IwOecTcEOy5VQEjXPXoIpKM8CGc/pqjZdiY7fyw=;
        b=MPawYchqKt9uaJ41XmXgTP1DkHtqFZVt2TGFm5XIzekKwTgBgqjtMQcKwak3L2k1Kd
         H7oso3XmnqxQAiMcstp+okiYqPc0V+nffn2K7hiwDqiu6vCWj7s/RPRdgjgaP/aSRYE5
         Q4cD5IslT1XhLTpoIh8pIOBC57VklFggs/4m2Jn6cdzubrjbpatnx32Pv0gmR6AE9ypw
         jiUSYvQmvUTwXww4jyRLfRxmC+5kJnn1MsUHOyWutsMDyAFIhUHLIWLGZ1MJtJqBfAFy
         IDcP84ZVC9aQj8epIvkSyMsWPxiYmEqrd3cGlHxKVL/amFQBLHtevazxB9Jrk6C8+rCX
         GGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6q4IwOecTcEOy5VQEjXPXoIpKM8CGc/pqjZdiY7fyw=;
        b=yeG0IIxgU8IrhasFM1O3cpraTZ3d78jeccvtEKqRet30l25zwCMxaIXbufH+Ag2bsX
         vm9/E+Txygw4kymd8YnJm3G+ICs3T9jNItmyDGz/eokgnUDb2MeEm8ivB9Ug5ECRbO1t
         xaRgB7FNc3qSUjXKlg2u8RH3tmPn9Uv/AuYMUL4lUhylojNqynoL3faMMsfZdjmLlW1X
         fBLunOQzKUTZOcPaSBTJUCeCwM7QL94vaPBKMV7fZ0ZJIj9FZCYSwXOWaJXA/IR7+1xB
         690wm66BIYWqtqvZc+GuYUnHNNzgSK8VY2Ecqh2duMVwNuznZ+aSBrjNa4Z+MYq1O8uf
         XUxQ==
X-Gm-Message-State: AO0yUKVGO14WA+GhKnY5S59tzgdH6BvJoyIDpY5OWLQZARW+fHUfnkWh
        eSWbcRvvy0ztf1x5cSDPujZXUw==
X-Google-Smtp-Source: AK7set+s2jXxEB4pjtE6MZ/6UtRVKhnTRdbp6ivGExrbYLS0jjbEwaTdJARmqxRTCeS124Ho0eS6Sw==
X-Received: by 2002:aca:b30b:0:b0:37a:3ebc:d3a8 with SMTP id c11-20020acab30b000000b0037a3ebcd3a8mr463112oif.43.1675227921849;
        Tue, 31 Jan 2023 21:05:21 -0800 (PST)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id cd26-20020a056830621a00b0068be61a7ac6sm1123445otb.56.2023.01.31.21.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:05:21 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 2/2] spi: intel: Add support for controllers
Date:   Wed,  1 Feb 2023 02:04:55 -0300
Message-Id: <20230201050455.505135-3-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201050455.505135-1-mauro.lima@eclypsium.com>
References: <20230201050455.505135-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Device IDs to the module table for the following controllers:
	- 9da4  Cannon Lake 300 Series On-Package
	- a2a4  200 Series/Z370 Chipset Family SPI Controller
	- 9d24  Intel® 200 Series Chipset Family (Including Intel® X299),
		Intel® Z370 Intel® H310C,B365,
		also Intel® B460 and H410 Chipset Platform Controller Hub

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/spi-intel-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 10fa3a7fa4f5..ba08f64e56eb 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -80,6 +80,9 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.39.1

