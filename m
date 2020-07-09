Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81721A287
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGIOwD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGIOwB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 10:52:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D408C08C5DD
        for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2020 07:52:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id i14so1105025pfu.13
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2020 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCNwMOLhre6TIcq+xE46mgH66EUQUlkzmi0iFanIr+c=;
        b=WkTWta+ygkvsjDeZrol+0SHhzLZKtwtnb673F6gAaZMkqleJ8hiEXTNVtZz0D5wm35
         HIiDkEuL8lED8JHA1IRt2pWRlS0BU4poa+UoVJ9MFyPpuYrBGbwLf3DtpNv0iflVbEyW
         RL/AP0progn0ni332mJbpS8NZX0+9QA5viaQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCNwMOLhre6TIcq+xE46mgH66EUQUlkzmi0iFanIr+c=;
        b=RQCJwyTtH6+0OSltD971Gcxc6xB8+m6OtRCe8GxzmpPnSoS8kEa0pu1eAv8DLOn8iF
         Bd2+WzEO16qYl1MALzwW+uElMUrs2s08ukFQPVAYR8/CUYibtnuWhBnasarfdCotmCWt
         r5rh/08EOU4fU0epOYB/q3E1jPSB6kWq3s8jwZvWJIx2ISZBMFMOmDYXr9MpqySrl4b+
         eNwJYGwp8paKx2v0Xx9eRzz79yK1xyR5xmZPGvw5grBcOwLhBLn/xQMpNYYUoNmJkeIh
         3eC+/xItnF3uUnjzkGj3S/NUiyoxdXFJFTq7g0kwU8/texyQ2IVAYxTCP+IbdxgiBg36
         55Jw==
X-Gm-Message-State: AOAM5336wB1JAZpG0OGpFlVHzC5AnXlc1Bxx3K+WmCoGV1gw+XngUFgv
        KU3nt5/flUCGRl3hy7eOChDukQ==
X-Google-Smtp-Source: ABdhPJxldIWJwLmpIX2peiSkmv54/xjNeufkBsdu52lnXuDQk24y73KFZqffxuh+HiL7VvA/bCniyg==
X-Received: by 2002:aa7:8ac3:: with SMTP id b3mr61856209pfd.45.1594306320783;
        Thu, 09 Jul 2020 07:52:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m1sm2791322pjy.0.2020.07.09.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:52:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, georgi.djakov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms
Date:   Thu,  9 Jul 2020 07:51:45 -0700
Message-Id: <20200709075113.v2.2.I3c56d655737c89bd9b766567a04b0854db1a4152@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709145145.4055619-1-dianders@chromium.org>
References: <20200709145145.4055619-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In commit cff80645d6d3 ("spi: spi-qcom-qspi: Add interconnect support")
the spi_geni_runtime_suspend() and spi_geni_runtime_resume()
became a bit slower.  Measuring on my hardware I see numbers in the
hundreds of microseconds now.

Let's use autosuspend to help avoid some of the overhead.  Now if
we're doing a bunch of transfers we won't need to be constantly
chruning.

The number 250 ms for the autosuspend delay was picked a bit
arbitrarily, so if someone has measurements showing a better value we
could easily change this.

Fixes: cff80645d6d3 ("spi: spi-qcom-qspi: Add interconnect support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
---
This patch could go through the SPI tree or land in the Qualcomm tree.
The patch it Fixes is currently in the Qualcomm tree so if it lands in
the main SPI tree there'd be a bit of a perf regression in the
Qualcomm tree until things merge together in mainline.

Changes in v2: None

 drivers/spi/spi-qcom-qspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 8fedc605ab7f..b8857a97f40a 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -553,6 +553,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		goto exit_probe_master_put;
 	}
 
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 250);
 	pm_runtime_enable(dev);
 
 	ret = spi_register_master(master);
-- 
2.27.0.383.g050319c2ae-goog

