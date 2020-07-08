Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9670E21946D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 01:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGHXkA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHXj7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 19:39:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3B2C061A0B
        for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2020 16:39:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so262758pje.0
        for <linux-spi@vger.kernel.org>; Wed, 08 Jul 2020 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOTHh5N/RNtg5WKfhfCtwkiBRU/CH9ki0aZxMLZWNM8=;
        b=kR2nFh1mnQTXnbdqeR27HQUqhgNSLiijZACUnlR2dWdx1wyUWWYZ+4xqJ8mu7aGSF/
         E8hRqUv4tieRzOjR3H8OrsuoWAOVgE6FBGzhbrDkzHKNyR4bTAiUOty50yX0f4mnCR8j
         W3W6KIJ56JwgtX0sri+CqRqhN74y8lSycCVQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOTHh5N/RNtg5WKfhfCtwkiBRU/CH9ki0aZxMLZWNM8=;
        b=F1/USBdDgPBHJcjEJy969fuu1m7IRAMzKHVptAIj4fBxYakph1k81d9XgEK5yQbrRr
         aTUIRd38x8wLUGTwqnRcm86ab9waBSKzM5u/V4z/glaPsxtg/ZWqtsJw5kotKbdPMLck
         x/GiNpDhuTAgmim47pRzIzjugWNvyk7zIbaPSORVsDRM1bCr6Q0Kg8DUO1fkFvofPN/m
         velRBvvpK5I+c+nCtDPBTOIBvapSu/IDeT3PVRJhSY4JGPv2Ayr9HPQXIlkdj+4oExrE
         /NNeOuTKeuSIfI2UGw+tjNPrI+ljrKmwh2tN3K4xmAnFt5hRmVCDUxYu/l5x7GnPzbWN
         Ct9w==
X-Gm-Message-State: AOAM5310tfKfw7vTmXf2B23/7l5XdBDoQ1/KGD6FzskiWe+yf5ngnPl0
        8t848X44hf46E8J9ycZ3E/z4AQ==
X-Google-Smtp-Source: ABdhPJzoia5b4R3aKCY9DeX9VBSHtlvmbIiYbgW9yavDq1ofyRtLzgDYooiLfyGViGwhip19H04ljw==
X-Received: by 2002:a17:90a:b38b:: with SMTP id e11mr12317231pjr.120.1594251599145;
        Wed, 08 Jul 2020 16:39:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id h100sm526405pjb.46.2020.07.08.16.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:39:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, akashast@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        georgi.djakov@linaro.org, swboyd@chromium.org,
        mkshah@codeaurora.org, ctheegal@codeaurora.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime resume
Date:   Wed,  8 Jul 2020 16:39:39 -0700
Message-Id: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the patch ("spi: spi-geni-qcom: Avoid clock setting if not needed")
we avoid a whole pile of clock code.  As part of that, we should have
restored the clock at runtime resume.  Do that.

It turns out that, at least with today's configurations, this doesn't
actually matter.  That's because none of the current device trees have
an OPP table for geni SPI yet.  That makes dev_pm_opp_set_rate(dev, 0)
a no-op.  This is why it wasn't noticed in the testing of the original
patch.  It's still a good idea to fix, though.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Sending this as a separate patch even though I think the patch it's
fixing [1] hasn't landed yet.  I'd be happy if this was squashed into
that patch when landing if that suits everyone, but it could land on
its own too.

Like the patch it's fixing, this needs to target the Qualcomm tree in
order to avoid merge conflicts.

[1] https://lore.kernel.org/r/20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid

 drivers/spi/spi-geni-qcom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 97fac5ea6afd..e5ece1bcc4ad 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -79,6 +79,7 @@ struct spi_geni_master {
 	u32 tx_wm;
 	u32 last_mode;
 	unsigned long cur_speed_hz;
+	unsigned long cur_sclk_hz;
 	unsigned int cur_bits_per_word;
 	unsigned int tx_rem_bytes;
 	unsigned int rx_rem_bytes;
@@ -116,6 +117,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
 	if (ret)
 		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
+	else
+		mas->cur_sclk_hz = sclk_freq;
+
 	return ret;
 }
 
@@ -670,7 +674,13 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return geni_se_resources_on(&mas->se);
+	ret = geni_se_resources_on(&mas->se);
+	if (ret)
+		return ret;
+
+	dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
+
+	return 0;
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
-- 
2.27.0.383.g050319c2ae-goog

