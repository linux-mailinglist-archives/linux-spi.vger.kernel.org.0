Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A296CA2E74
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2019 06:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfH3EdX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Aug 2019 00:33:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42799 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfH3EdW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Aug 2019 00:33:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id y1so2707029plp.9
        for <linux-spi@vger.kernel.org>; Thu, 29 Aug 2019 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KklhaOrcJjumUOcMoajjDCuKO1cn0WIKBTfo3oVxm7U=;
        b=TV+xdT09IOmtbG2hmZwo+q6JqoJtHVEdeKhgG4HQ4X/3cu6L+wYMCA2IiQmiJETnIP
         kO3JKDv4I8yC50ikVI1dRbHa165dBQLFumdF3OPjd/72iA/CHRrfEEEn6XuIDgi1Ux0q
         SVSVCNK3b03oS1A/2ORZ+E8NQpQUkUS1gELg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KklhaOrcJjumUOcMoajjDCuKO1cn0WIKBTfo3oVxm7U=;
        b=uKxP181xuMSH1anJag2middFmFnDoD91/ngxyDnRcxqNk4dyrSErNSqEoEuzBBCnwh
         8PHCp2PG1qryvqHSxpKSM+BOmzmfbPmnt5HHCZ5wrqkszFgZIo/vOr5Z10IM414uer3t
         agmX2TkHhCxw5URtE8HhFZKq1e3OX6R3F4oRZDZFWJRh24a5j7bO/QBh245KTNWmALeL
         qZKT4lqhAkYrVx1wPQ5gGFMzc3zzfGIAtOuJaUSfhODzapFpP77QyLHcQSYrfX5OuayP
         vFlxssvF2XYQxHjMKb6VVtBEejgyl1sYTt4bkWq9S2/Rawk0t+lAszWXBQ5T7RRfsrMi
         WCtA==
X-Gm-Message-State: APjAAAXCclXYvc0UhQbwWt0CtvDbXjqrvToUgR8bKtsW10zIuA1WmzWE
        +ibzP1lR6I8O8CrzHXdaOphBDg==
X-Google-Smtp-Source: APXvYqymW9vh3nPRzh8A/jrCiyA0Q3efc0k3mPI7rCtKnhANQGoF3EGZTwupRFVwNyETHVslldm7MQ==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr13024583plk.53.1567139601347;
        Thu, 29 Aug 2019 21:33:21 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id ev3sm17753974pjb.3.2019.08.29.21.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 21:33:19 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH V3 1/1] spi: bcm-qspi: Make BSPI default mode
Date:   Fri, 30 Aug 2019 09:58:45 +0530
Message-Id: <1567139325-7912-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-nor controller defaults to BSPI mode, hence switch back
to its default mode after MSPI operations (write or erase)
are completed.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
changes from V2:
 - Address code review comment from Mark Brown about changelog.

Changes from V1:
 - Address code review comment from Mark Brown.

 drivers/spi/spi-bcm-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..46a811a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -897,6 +897,7 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 
 		read_from_hw(qspi, slots);
 	}
+	bcm_qspi_enable_bspi(qspi);
 
 	return 0;
 }
-- 
1.9.1

