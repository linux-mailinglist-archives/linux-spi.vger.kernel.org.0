Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4794F82F9E
	for <lists+linux-spi@lfdr.de>; Tue,  6 Aug 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfHFKSd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Aug 2019 06:18:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39827 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFKSd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Aug 2019 06:18:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so37734286pls.6
        for <linux-spi@vger.kernel.org>; Tue, 06 Aug 2019 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B2Az8FZ7ku0X2inJnd7funCGhhLUuh16TDsRGjU7wPY=;
        b=YLSHDIxEYeh158kEGbiXMI86GIByE6ZBeC0wvOq22XFHllvFtRDEVX/D4B2rCKIkpU
         B95CBSqrEOjKGdoZI6typuPUN1FG/78x+D6pL8LNHFsHe0YSQYZwO+nNZiMOca5i3WsF
         HH1Csge+AVd6PV0yT31mCQliC59Y77ttlGxFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2Az8FZ7ku0X2inJnd7funCGhhLUuh16TDsRGjU7wPY=;
        b=SpC6U5Cq++WRouJ3PQixPW/eLxSJYvlqmmjtg9kuz1w094EenGQ3Go2X00BZl9/eGE
         terPDPckrXZmifW7StDLuwm34wVkZl+f5EKE7sUVyYMas4orBFr7TII1azC7/MHZGVFW
         gB2utDFXOeK/tWrqx7Xb+Z7s98jBDGa7aJYulevG8OG/Y0uVGJ4I2UVOxxLGYLQqdDWl
         NYMdPs1MY5Xg2PBO8k1b/sAkKkodJEugJh15TcRRQx5s5Y16QeC6Q5rKlhln5UfzWHqm
         K+/XKUAXjSAppcX0AolsSDeiZNC0aoerPcLfEkwMI/hyVkagDolYVKeofyE6q+yE39nT
         Vkog==
X-Gm-Message-State: APjAAAWevcelbnuhdZNJl9prjrJkH5IvNFcYHs9hre/povi5JmyWkP9g
        oh6W9SEfo6Xpa1A30p8MjT1Odw==
X-Google-Smtp-Source: APXvYqxyS1wEbeR/Ana/G2s2t8MN3btZM/Gabob2KwSWhuZCr75sQgO/4yYcxz0amLEeqYPRTivpyQ==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr2319319plb.187.1565086712671;
        Tue, 06 Aug 2019 03:18:32 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y23sm90516588pfo.106.2019.08.06.03.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 03:18:31 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
Date:   Tue,  6 Aug 2019 15:44:34 +0530
Message-Id: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch back to BSPI mode after MSPI operations (write and erase)
are completed. This change will keep qpsi in BSPI mode by default.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
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

