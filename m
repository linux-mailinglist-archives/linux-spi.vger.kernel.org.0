Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7711A553
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2019 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfEJWfQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 18:35:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41882 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfEJWfN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 18:35:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id l132so3925722pfc.8
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2019 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hV5HxwGs7gY03wK3rK8o6uhUFP9lcwaLtj0H4FYh2dk=;
        b=lTuSMAv25fNL9J/QKC0HQ9qmLRckYs3hBlUXs/+YYhydsEvcq+SyATaNCV1rCMDz89
         BSTK5DP0LEnWSGUhOyGTr7I5U8Bw2WIhDsXgnfcmHVBa9ofbOBqOcP7XWDZOJDMDbQga
         4Sw5ibIdQSa7/HY4XS9y5VByC3g0GUYAx2VI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hV5HxwGs7gY03wK3rK8o6uhUFP9lcwaLtj0H4FYh2dk=;
        b=r3ffZMmSDoMkdGpVnaa4MPqWwXJevKCvmvpTcdjFvPcXSFf5RthMXMVFh2ORBXll5w
         2aPBhQMq08gwmljcHbKLvU5B5/taytyxnz/w6Fgo8mR6shIlnAMqETD1GVbEiK/mecii
         gqYtA1NXnR8u2K9JAHnrY5rP40aYbvlcGsOcUPqb11BvSbbvaSWC8rm5wb13zvYVrnsn
         uibZw0y/hZE0rANOZlaFCSicvqENPKH6mfV+jIKd4Msmw50PGb53Z5s/xJuI5pBCqxMp
         ePKPxj1Gz7VQl/VfRK/aoZFASnfy34elwICzntWoYH37vFthtV8C2GF0xcoPqpJkvGKa
         AYpA==
X-Gm-Message-State: APjAAAXfRSWD82n6AsZk92R60s2bS2Fr9pEOByL3A+G0l4Pd55PJCnbz
        V/kd8q0cK6uaruULjanVvr0sfA==
X-Google-Smtp-Source: APXvYqx00UvXi9LVlDxBQ/qgIeKHowFgu4na2sTLOT4tSNXiduy9+oOD4eLycJ+CqSEWgmcp1mI+eQ==
X-Received: by 2002:a65:4c86:: with SMTP id m6mr16401970pgt.75.1557527712392;
        Fri, 10 May 2019 15:35:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j6sm7689393pfe.107.2019.05.10.15.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:35:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 1/4] spi: For controllers that need realtime always use the pump thread
Date:   Fri, 10 May 2019 15:34:34 -0700
Message-Id: <20190510223437.84368-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510223437.84368-1-dianders@chromium.org>
References: <20190510223437.84368-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If a controller specifies that it needs high priority for sending
messages we should always schedule our transfers on the thread.  If we
don't do this we'll do the transfer in the caller's context which
might not be very high priority.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eb7460dd744..0597f7086de3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1230,8 +1230,11 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		return;
 	}
 
-	/* If another context is idling the device then defer */
-	if (ctlr->idling) {
+	/*
+	 * If another context is idling the device then defer.
+	 * If we are high priority then the thread should do the transfer.
+	 */
+	if (ctlr->idling || (ctlr->rt && !in_kthread)) {
 		kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		return;
-- 
2.21.0.1020.gf2820cf01a-goog

