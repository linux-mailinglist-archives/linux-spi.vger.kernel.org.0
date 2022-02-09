Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFB4AF6B7
	for <lists+linux-spi@lfdr.de>; Wed,  9 Feb 2022 17:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiBIQaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Feb 2022 11:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiBIQaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 11:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F39C05CB82
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 08:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644424237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1bQbhgSAF2lPgwQubVMn3pqKT77IeuZyyfYEoagC560=;
        b=OzZZBix1TepSiZNrHF1wGMMRLbk3Wdr1EfdFgs+ZWwppnyfGuA0q0gzMd1QVdLzDemRTPe
        ZyivcnKYRftCcw7u9Xp/NF6Io99pt2A6WDsSCucop4QC57PnwQEbOvYQkCH5WpPNhDxqOo
        xk9aDE0wnS4wuvcQ6N00dq6yhvzIjR8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-q8NaQTfXOwCz-59jY5c9ng-1; Wed, 09 Feb 2022 11:30:36 -0500
X-MC-Unique: q8NaQTfXOwCz-59jY5c9ng-1
Received: by mail-qv1-f71.google.com with SMTP id eo11-20020ad4594b000000b0042151b7180aso1982731qvb.8
        for <linux-spi@vger.kernel.org>; Wed, 09 Feb 2022 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bQbhgSAF2lPgwQubVMn3pqKT77IeuZyyfYEoagC560=;
        b=030j+Oj/JyHuLy+MC5v3yrRtNeR56m+Mwnnt8Cia7OBTXvUxS3ECIydm+G+YUsBt0o
         ffONAScYN6An/AM+go7FdlKthHvBK84byfkxl/Wab4Ra7d7873kA/sT6lv7je7Mzhp03
         RQbNLLXtmMsV52kin0kC1+5KFwzds5eWNiU70xyo9f4CWzeAYvKK0KGH1hWmNl67uglu
         1OMjBoSzxuW2+a8gLhTcmEpOijEgOgiCnD/WtYl2SoVBdaJIm7udKILnywIIrjgWuRAC
         U5jPZT45dIpPgQjxWTCLWe6XGgflipqILoLta818nKNYaJbt0S6VEKadutjTKjzwc+LG
         11iQ==
X-Gm-Message-State: AOAM5313QeQe20wQXUDVMktexIn2l5joFBB3RvUcxmkCtuCRWSvfKyVg
        JZCX30w7vECm7fKY67QTksfhAdYZ1N6SQfIFOJQems6Px4h4iHIYUDlvZobf1os/axYGK5Fu5lX
        MCmXXX3VvlqHbTJ5Wtx/y
X-Received: by 2002:a37:4648:: with SMTP id t69mr1512059qka.702.1644424235750;
        Wed, 09 Feb 2022 08:30:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnwrxGYEFisJG8vsAxtzWQegq11Myco9LBMvHqdQZ4x/6E6Yb1DWf2feI7/8QDUXQ7/ItaQg==
X-Received: by 2002:a37:4648:: with SMTP id t69mr1512046qka.702.1644424235520;
        Wed, 09 Feb 2022 08:30:35 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m4sm8323725qka.111.2022.02.09.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:30:34 -0800 (PST)
From:   trix@redhat.com
To:     lhjeff911@gmail.com, broonie@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] spi: initialize ret variable
Date:   Wed,  9 Feb 2022 08:30:29 -0800
Message-Id: <20220209163029.2299009-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang build fails with
spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
  uninitialized whenever switch default is taken
        default:
        ^~~~~~~

Restore initializing ret.

Fixes: 47e8fe57a66f ("spi: Modify irq request position and modify parameters")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index ba5ed9f7277a3..fc61578ce5c47 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -375,7 +375,7 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 {
 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
-	int mode, ret;
+	int mode, ret = 0;
 
 	mode = SP7021_SPI_IDLE;
 	if (xfer->tx_buf && xfer->rx_buf) {
-- 
2.26.3

