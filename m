Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E602DDB75
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 23:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgLQWbK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 17:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732126AbgLQWa4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 17:30:56 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B1EC0611CA
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 14:29:40 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i7so61447pgc.8
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWkiWzk6Rso22yNG+cnGpuPXvotVryC+O2+4me1Qo6c=;
        b=ElbqSAKABhF+sBG9f/NXWoC5A3GLpmmFLgEKHC/ljsaQ0mqLK+bKaIZb5pKKbzznO+
         uNXIW5SRSl/YV2W0YOt8zDCqT8ZhE0Hy07HV/rWRf5vK68PN5W6jOIUVf4CGY3fSS4fs
         9qx4vynHQFlxaz1Ga7ugGbnHY7SrTvEOMwuRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWkiWzk6Rso22yNG+cnGpuPXvotVryC+O2+4me1Qo6c=;
        b=Soztj6BDh3tOIgYPGsFWMDghURdo7j1dd4RD1fCe2slzynpdNa1eVf0gS5pbWqyK7K
         TQUBSbBuy0bpP+sKGJrl3J+49CcXK8JieFa11e5FBvvtqMw2HxK9oR0W39/2yvQPzmGv
         AQYbmB0oSe07wh5GNP2HITNC2s4k+Fsid2OLvqYdQClXMS5KBLcObrktrxjLiTAXq2qQ
         Qllz3wzBx+Rl1GhJbVE3X7lACcLfosUBusOmL1asLDIBFWSHN0KoU4qKiTiwSd5tmU1d
         rs/x5zajApYROZmobBQlzhN7J4e0/eViON+8u2wzxcLBQLSpj1BrmPW55K/Cvc25Dk4N
         o9VA==
X-Gm-Message-State: AOAM533c/Dm+8FNZf5UX3YxCSgLxegU5NBPfLpNkUwR+D5UkNqNrxWVG
        zTUFw3SiqHgbFI9VH+b7enyevg==
X-Google-Smtp-Source: ABdhPJy4bycT77LtZjm+hgxVOqL/vnjb7rOjBzQ6uEr8599KO9Wl4MBrwV7m7A8mi9p0ChEeI87r5g==
X-Received: by 2002:a62:32c3:0:b029:1a1:c2f2:d771 with SMTP id y186-20020a6232c30000b02901a1c2f2d771mr1364793pfy.29.1608244180129;
        Thu, 17 Dec 2020 14:29:40 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id gm18sm5805850pjb.55.2020.12.17.14.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 14:29:39 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     msavaliy@qti.qualcomm.com, Stephen Boyd <swboyd@chromium.org>,
        akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 4/4] spi: spi-geni-qcom: Print an error when we timeout setting the CS
Date:   Thu, 17 Dec 2020 14:29:14 -0800
Message-Id: <20201217142842.v3.4.I666b37646de9652cef438ac7c2c6c2053367fc6b@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If we're using geni to manage the chip select line (don't do it--use a
GPIO!) and we happen to get a timeout waiting for the chip select
command to be completed, no errors are printed even though things
might not be in the best shape.  Let's add a print.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("spi: spi-geni-qcom: Print an error when we timeout setting the CS") new for v2

 drivers/spi/spi-geni-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b3ba092db489..5472d895a9e0 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -223,8 +223,10 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	spin_unlock_irq(&mas->lock);
 
 	time_left = wait_for_completion_timeout(&mas->cs_done, HZ);
-	if (!time_left)
+	if (!time_left) {
+		dev_warn(mas->dev, "Timeout setting chip select\n");
 		handle_fifo_timeout(spi, NULL);
+	}
 
 exit:
 	pm_runtime_put(mas->dev);
-- 
2.29.2.684.gfbc64c5ab5-goog

