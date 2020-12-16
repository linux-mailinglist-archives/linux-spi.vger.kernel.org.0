Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C0D2DC91E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 23:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgLPWnZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 17:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgLPWnZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 17:43:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772AAC0611CD
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 14:42:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 11so17555442pfu.4
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Vd1QFcuFWIYhVvfHfG2jARGV8ifNdeNillFXaADRjI=;
        b=XcQWXpjHUgixcOl67GSSIrQM4qzCd7i5k9g1qpnc16X47aSiTa+hJTCeHI7s/In4Hi
         aXb1BbEJvbKJbYDhtvd4VbW+o2vFMQqVx+bVk34tvnWaKM/arWUO4hHP0oQJGIRQEWob
         d7IS56reRQQwX2krJI5yM1JTr/nU47G1njeEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Vd1QFcuFWIYhVvfHfG2jARGV8ifNdeNillFXaADRjI=;
        b=I7LgjRJeVM0RfUiHbuz2DqBnHt8cDZNYxc9c1QxBZjDtxapEk1uWRYDyPg31cz3sRj
         m4RusMTWSPBxM6c961XR1Pd9PwkAXeEaTEfwwSTJGCJTKh4FRdrrbL9COJXy09+FONc4
         bQIvCSeLSLRRcKEYHCs2xhxgP/AirHBH4nn824gsJCWQPheLt8iiaC+dALeQUQavW1hx
         zUN6CZP+iakRJ72PtvrgkUYUzttQw6UFMyLagTrdRXYP72QmrcbWRey1Lmyikz2ty3ME
         US0s5D5tteowIL0/mjZBgUxO9I6pIdUaVuVliBzH8YHCb2aIjlFvzzyoi3+iH04LrqLB
         Ic2A==
X-Gm-Message-State: AOAM5311HIeMxm2Xk2cm7ATU7BS/P0seFlgNlom2r0LJOyb/wBfyI3y7
        PwlWne6E+dSNfU9nv7e/Epzjfg==
X-Google-Smtp-Source: ABdhPJzXT6pePUqTG6AWzM3OjQ/9+uqfCpIe6yZioAT9ioqcgVoAY3922oZ2qpc5QX4Z9csUYEDYqQ==
X-Received: by 2002:a63:f12:: with SMTP id e18mr35442800pgl.101.1608158556030;
        Wed, 16 Dec 2020 14:42:36 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q26sm3561703pfl.219.2020.12.16.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:42:35 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 4/4] spi: spi-geni-qcom: Print an error when we timeout setting the CS
Date:   Wed, 16 Dec 2020 14:41:52 -0800
Message-Id: <20201216144114.v2.4.I666b37646de9652cef438ac7c2c6c2053367fc6b@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
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

Changes in v2:
- ("spi: spi-geni-qcom: Print an error when we timeout setting the CS") new for v2

 drivers/spi/spi-geni-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0e4fa52ac017..744009875762 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -220,8 +220,10 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
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

