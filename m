Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93533116E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCHO4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCHOzi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B1EC061760
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m9so15136478edd.5
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urYLQtVdnzA+q/DonKHBr+50GGSu7EQTj+TBy7g6Q9o=;
        b=DI2451HfgotQz9pB6iDClae765YmLRgpDL2tCkDipGN54R+t87igdJbgK+kmmreaeA
         8KPw7u3xoIz9kOCfIv08lBVwmzr0JSwKZUBDRyUNWmSK5ATIQfmWqO5Q6xx8uIJLikA5
         X+4sOWpuDw30weSJk+atq9Ow39Uv0ffPDH/Jbwcu8Jdi+JnQaHboHU8msYT9CKq6m4UT
         DBTRx+IZAUsflr0foefztI0cy35cwviB5fimBRCYTDiCtV1JgeVmbCDL+fLj6coXxdhK
         akBiWjsSx/bzPQDIxfRyuf5JLv7mwrqLzRThKIwHEz2B43K7HqN1vXA5pvmO8yhk9Dfy
         8jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urYLQtVdnzA+q/DonKHBr+50GGSu7EQTj+TBy7g6Q9o=;
        b=mcrQvHG2aJhV/yzAUBV2zVRE/PhqT90EwZpvHtB0NXOAsP3PHoKtt6Ip2mfsC88H2E
         63QCUBHqmmsdl8xUosrDGl+Gs37oNE+n7Ydm8w0sPwmYBeE8iReivJnokK39re9niMTc
         c/+BA9q18oT1oqBuq9B6ujbyf6mMOnbrvDTZcOGegJta635zwwmHPH+DlRnHQYut+jHR
         L1nuKdcCZffhn13sEmEQA47aSFC0zc9o2fudQv915Ht2XN4mXv1UUsFqj1WmDvnXFzUr
         zoWX7VAZmZa2VqMs1uZkPmNSbTvT558O/D55e6j5MEYKFntonkzW7Vz4qA2f64L+V2ns
         Ja4A==
X-Gm-Message-State: AOAM533ZUSRSiBjLIzq9HcP6F5Jq14NYXJfLRJWH73Fg5JCB65D+xxCp
        0WogGBnpIWqgKlFOyrYxP0llriLIbPEkkxbW
X-Google-Smtp-Source: ABdhPJxe0zyWH76y8kItEqXgvETT7TZ6JKNT1e22wQhgFUZx5RbGpKr9TzsZbEKqFDYgqLwPaYGILg==
X-Received: by 2002:aa7:c94c:: with SMTP id h12mr22840108edt.40.1615215336605;
        Mon, 08 Mar 2021 06:55:36 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:36 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 08/10] spi: fsl-espi: remove usage of 'delay_usecs' field
Date:   Mon,  8 Mar 2021 16:55:00 +0200
Message-Id: <20210308145502.1075689-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'delay_usecs' field is being removed from the spi_transfer struct.
This change removes it from the SPI FSL ESPI driver.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-fsl-espi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index cf2b947c600e..f7066bef7b06 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -435,8 +435,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
-	unsigned int delay_usecs = 0, rx_nbits = 0;
-	unsigned int delay_nsecs = 0, delay_nsecs1 = 0;
+	unsigned int rx_nbits = 0, delay_nsecs = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -445,16 +444,10 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 		goto out;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->delay_usecs) {
-			if (t->delay_usecs > delay_usecs) {
-				delay_usecs = t->delay_usecs;
-				delay_nsecs = delay_usecs * 1000;
-			}
-		} else {
-			delay_nsecs1 = spi_delay_to_ns(&t->delay, t);
-			if (delay_nsecs1 > delay_nsecs)
-				delay_nsecs = delay_nsecs1;
-		}
+		unsigned int delay = spi_delay_to_ns(&t->delay, t);
+
+		if (delay > delay_nsecs)
+			delay_nsecs = delay;
 		if (t->rx_nbits > rx_nbits)
 			rx_nbits = t->rx_nbits;
 	}
-- 
2.29.2

