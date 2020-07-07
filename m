Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C011217926
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 22:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgGGURG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGGURF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 16:17:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95254C061755
        for <linux-spi@vger.kernel.org>; Tue,  7 Jul 2020 13:17:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so20517606pgb.6
        for <linux-spi@vger.kernel.org>; Tue, 07 Jul 2020 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tCTrAKWMJVuvZolCuiw6Qi11c7jBp2RNevhFxrSgmw=;
        b=E6u2N0HYkyZVbrcS7ao7VcNmPRODfcTSo5b48Ee/6vAd9W9rpK0paNN4aQa7kt0+Eh
         FQ8CicLr0gT3aNjl55yudIDJhD0s8RFnBOej527WhdNsRZ8oCSVW5+DM09j1WPG1fKjS
         ZWYm0gHt/x//SFsaQLOs3DOaPV3EeL2NDZjEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tCTrAKWMJVuvZolCuiw6Qi11c7jBp2RNevhFxrSgmw=;
        b=AhIF8DSWR5qc4zHIqPEaG5roBA6AuHXmvJdgPvVhvaJ4G75uSOIkS+2w5IjXjOfbpr
         /u3gIjchCA8j/DYa700GKsvbJox1QDjvy6hYWf3T5zT2f7M6ZDmTCk3TbNYcYswD9OQC
         R0FdC433zBvjAeTtA2r0eAx7uM598TBFpKKxvsEluMqypceJPNAhMlkkLnMcFJLcAagq
         YMDB9Wr4oiuAIufyLC+ZJVfKXrKE5hVN3Ngc1x3OecD8duFin028oSp4Fj6YOPB3Lp37
         t8MrVrt/3WHeKVNkgLGwoJtVJ3y2QSMZH0U7W6TkaaZ6VpG2li9CbW5wsngaB0sEPrXL
         AW0Q==
X-Gm-Message-State: AOAM531sdWJEDV+F3b2g2cBFtJaAXzU0Bl+x87rKcZpjHgXz7cA1dLJs
        elXMTvUAvl1R5tNAhaExkJyg/Q==
X-Google-Smtp-Source: ABdhPJwM9b7JDIXP5Gb8t7awJr/QovUJ/0MYE1YMo1UtvqZOuw+GkOunu2GJuNn9V2rWbH1RVw8M8A==
X-Received: by 2002:a62:84d5:: with SMTP id k204mr47316805pfd.66.1594153024963;
        Tue, 07 Jul 2020 13:17:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id i23sm7166097pfq.206.2020.07.07.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:17:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, Akash Asthana <akashast@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/2] spi: spi-qcom-qspi: Avoid some per-transfer overhead
Date:   Tue,  7 Jul 2020 13:16:39 -0700
Message-Id: <20200707201641.2030532-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Not to be confused with the similar series I posed for the _other_
Qualcomm SPI controller (spi-geni-qcom) [1], this one avoids the
overhead on the Quad SPI controller.

It's based atop the current Qualcomm tree including Rajendra's ("spi:
spi-qcom-qspi: Use OPP API to set clk/perf state").  As discussed in
individual patches, these could ideally land through the Qualcomm tree
with Mark's Ack.

Measuring:
* Before OPP / Interconnect patches reading all flash takes: ~3.4 seconds
* After OPP / Interconnect patches reading all flash takes: ~4.7 seconds
* After this patch reading all flash takes: ~3.3 seconds

[1] https://lore.kernel.org/r/20200702004509.2333554-1-dianders@chromium.org
[2] https://lore.kernel.org/r/1593769293-6354-2-git-send-email-rnayak@codeaurora.org


Douglas Anderson (2):
  spi: spi-qcom-qspi: Avoid clock setting if not needed
  spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

 drivers/spi/spi-qcom-qspi.c | 45 ++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

