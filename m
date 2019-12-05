Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB131149CD
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 00:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLEXXw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 18:23:52 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:35074 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEXXw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 18:23:52 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 18:23:51 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47TWkp12dsz9vnqp
        for <linux-spi@vger.kernel.org>; Thu,  5 Dec 2019 23:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lO3p4QIU52Ij for <linux-spi@vger.kernel.org>;
        Thu,  5 Dec 2019 17:14:26 -0600 (CST)
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47TWkp02QWz9vnqw
        for <linux-spi@vger.kernel.org>; Thu,  5 Dec 2019 17:14:25 -0600 (CST)
Received: by mail-yw1-f72.google.com with SMTP id x206so3748754ywa.22
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2019 15:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oSYnes0/l1u+4rIUZLMW/yKpeiqYc5kOnZtn2XTe1+4=;
        b=X9WHG7rgvwbxw7JgkQDFD0KoZjBvbTkWObbXVHZ2899dH/a4k32yNqM14o9vSaifdk
         y0ODLMeZIUC96L+JdSPfLbLcI/yEApv/yVGB3FzktZqL+ZBKQ6NhWKBAmqrmZj1LV/OO
         14gIkdUKkJXjIXt5L/UC2fKDhoQv6TJPhYX4cjlqmxsQyMime7tgHwuQrqXOJjmUraJV
         uIRVeyUfyRyLcsC3fA2UTx3a9MsMK9voa5m9oXcbUyeJolSY7MeFSBzkNuOJxmlRcfP5
         D1tUy8qpYW/YuBUN21HwKjywMavWUB1lT0GyA4mBsMuRwhwm0ULlplKhT4s+s0doRzuz
         tTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oSYnes0/l1u+4rIUZLMW/yKpeiqYc5kOnZtn2XTe1+4=;
        b=fzRb2fcjDPILEe33yklAeUPWhT8Qmclfy9gHgpamOSOVpKMrv6zpeTUZQUN4DcqYqw
         x7chg610WEK2GDBX+SdAJgkE5pQlwXoWaM2341bFtTP3t2pap1M4o7/aHMkNSa8fjeTu
         P5blh5rarW26KGFtw2MDyCf+WBduZjdu2AbIGyMN52dfFFGshru44dkR+79cDpjfuoIR
         woyQg3ZFEMSkH1X1VVjkTvDE9xTeFVq9J+hqc6TQF3nAmfwVMHopdb33mneN1MR/SdUc
         GbmreF/m3ce7SG1Qpl/BVTkon2OLFtWp9uCRnjUObWbmkda+3noEQj71HgMLKEV+qnst
         127w==
X-Gm-Message-State: APjAAAWykKKVjbu8Vs42bEpq0SrspeZ1m/wgT9dU1lwk7rxy9kQroT8i
        Kz2KsWS3ARUeSa60fZzuWjXBBVcUcC9cJg4Bs+sHgroXob6JCzKVT0xtrw99Flexp+5wVOEZQHz
        Xwyg6qGzC5Gqv7Ou4sMyX7Im5
X-Received: by 2002:a25:7c44:: with SMTP id x65mr7863559ybc.382.1575587665408;
        Thu, 05 Dec 2019 15:14:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLAnU6KbwAtj46DpMUNEmC9R9ezFXcb1I4FJWdCTx69wIk0nVCGHH0hGfZCalPe1Upg56GnQ==
X-Received: by 2002:a25:7c44:: with SMTP id x65mr7863541ybc.382.1575587665127;
        Thu, 05 Dec 2019 15:14:25 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id e198sm5681470ywa.51.2019.12.05.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:14:24 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: Avoid BUG_ON() in case of host failure
Date:   Thu,  5 Dec 2019 17:14:21 -0600
Message-Id: <20191205231421.9333-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If dws is NULL in dw_spi_host_add(), we return the error to the
upper callers instead of crashing. The patch replaces BUG_ON by
returning -EINVAL to the caller.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..a160d9a141ea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -460,7 +460,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	struct spi_controller *master;
 	int ret;
 
-	BUG_ON(dws == NULL);
+	if (!dws)
+		return -EINVAL;
 
 	master = spi_alloc_master(dev, 0);
 	if (!master)
-- 
2.17.1

