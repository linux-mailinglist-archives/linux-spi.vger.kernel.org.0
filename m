Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B771463CCB
	for <lists+linux-spi@lfdr.de>; Tue, 30 Nov 2021 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhK3Rbb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Nov 2021 12:31:31 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36222 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244734AbhK3Rba (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Nov 2021 12:31:30 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 12:31:30 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3TZJ2QxPz9xgl2
        for <linux-spi@vger.kernel.org>; Tue, 30 Nov 2021 17:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TaoF-QgZGtBK for <linux-spi@vger.kernel.org>;
        Tue, 30 Nov 2021 11:23:04 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3TZJ0QN5z9xgl0
        for <linux-spi@vger.kernel.org>; Tue, 30 Nov 2021 11:23:04 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3TZJ0QN5z9xgl0
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3TZJ0QN5z9xgl0
Received: by mail-pj1-f71.google.com with SMTP id lt10-20020a17090b354a00b001a649326aedso11858679pjb.5
        for <linux-spi@vger.kernel.org>; Tue, 30 Nov 2021 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svJ3RMCV+p4JHnfOiaFQLsj9cOauK3sHfEDzsRzk6UE=;
        b=MKa5ESf0rJVu4B+Q4oPqAmJ0frxgN60i358zPoUfYCIVztCFvcCWBKDz3pBHBOaYOp
         bRroQpQ1tkEWGvW76MNh7ePyn848CH5ZZIcpYWTai9RiTkbheVuqvrHqt2+5Xcxf35Yq
         7lTBdA7EN6K5NksOc6AePjns7nMpo3YzChW7W66+WdUNxnrTtj+t6ofIyNd8u21NRvAN
         7/bwHfBc8EfXS9bM7Ca2AEW/ZHPVljGo2r6pp7WYuRx+SLRyxC0Mg/iSAaGmbGTwFxgR
         T1hRR5Qr5HTsPHUoUsvisJbuEHiSCNLyObIIaQzYICr/YtsqKLQxzUvpnUA55IqPK947
         G3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svJ3RMCV+p4JHnfOiaFQLsj9cOauK3sHfEDzsRzk6UE=;
        b=PoeM1W8Mwk45oJUCUzaA4L7Ohmcr8j2LYsTy7AX+41MgX+4m4fGs26C6jCYvtl3/+G
         svu3ehFXWULSzVIKh9cA+aOGjwlowocWOfnNOEk+e+2mJJnJeOJfdT/uVmHSCXpsOyLl
         TuNiWVG7lru+wN4j8xB6owvIYpf/0xpFY3WlVH9mRYvbHvfJ26QJADqeR9iExZ2VSl+H
         yLRWaGuF/hglupRO3I/2oem89Rn537/ks8o/tuolZHG06e9gbLUJjFYhoWCYvaXfalkr
         P+BnoE2o3wt5W2LM9+/gUamvNHVYx/jrrMm7dKEQ7oeqbwW3+oybMYSOHbHkEyFxxal5
         hMKg==
X-Gm-Message-State: AOAM533NGgns5TiaT09MVL+uP3nKT0MJY5j6NBYqW0Dp6pin2pNWNco6
        +C6MY9zehklNQp8x1feEkdjZH4M5B8Bb/5YSBYAviEbyV5fHqxsJC5AKZf28eHJEu/rwaT+LAj5
        E18gCMX4ikJCYAU5iANImF1hO
X-Received: by 2002:a63:8248:: with SMTP id w69mr399692pgd.342.1638292978448;
        Tue, 30 Nov 2021 09:22:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4jXepohyRIJTKNCWtUtZ32KtQYupDUiKSwu+l5gDNI+QP5Mos/sA3gKYymmIvch88wAv7cA==
X-Received: by 2002:a63:8248:: with SMTP id w69mr399668pgd.342.1638292978232;
        Tue, 30 Nov 2021 09:22:58 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id t3sm20415817pfj.207.2021.11.30.09.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:22:57 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-zynq-qspi: Fix a NULL pointer dereference in zynq_qspi_exec_mem_op()
Date:   Wed,  1 Dec 2021 01:22:53 +0800
Message-Id: <20211130172253.203700-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In zynq_qspi_exec_mem_op(), kzalloc() is directly used in memset(),
which could lead to a NULL pointer dereference on failure of
kzalloc().

Fix this bug by adding a check of tmpbuf.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_SPI_ZYNQ_QSPI=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/spi/spi-zynq-qspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index cfa222c9bd5e..78f31b61a2aa 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -570,6 +570,9 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 
 	if (op->dummy.nbytes) {
 		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL);
+		if (!tmpbuf)
+			return -ENOMEM;
+
 		memset(tmpbuf, 0xff, op->dummy.nbytes);
 		reinit_completion(&xqspi->data_completion);
 		xqspi->txbuf = tmpbuf;
-- 
2.25.1

