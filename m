Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7026F21A283
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGIOv7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgGIOv7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 10:51:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AECEC08C5DD
        for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2020 07:51:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k5so918140plk.13
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2020 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cptIFOy+s35IOrGpxC/c61eH5jsSRhIdmTZLXFVPdjk=;
        b=PC2Pot4KmH1gr1NvXniHoKNf9m4dqGRv0CD328oaViqnSdYsE3pLmZtJ3y47G0suSm
         9qJxZvgzT0MZdQySNQeoiJRU8aPY85XmcaVva/OxIFY5WduhzCi4z7qa25i6TDC9x3IU
         KhUeZtBVvYKawhWzb+nIPPIQg0uPsKiWfmVSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cptIFOy+s35IOrGpxC/c61eH5jsSRhIdmTZLXFVPdjk=;
        b=NdYs/dNfeqPVQbUQHow8kE6MEf++60sjDcvWXgGIaKV09nwXmLqRdvaEwPTJYbt3+O
         J6e7y8wfcp+EmVALILI4S32uS4jBhY/5RekgWtoGJCYkiydvfhhjyOCvoFNdTLFTZHLQ
         hGe1sVuGnihd8AXyVhZNrfB4hSu4tCiS0PrKp8U+ExNvgWZewkG8SeA4rTHLsTP1NRqI
         j4YqQvkTK0WMhmvA0+/x79mLGIwVurXM4iMOlnjKudlVCsTE+Jm2qS4VpK36dDUo/GD5
         PxxdYq0jkWRGZlhve4snDoZDI4rg+XVO9CUwKCobFiUPD+gYyaw0bXqSRDKdLxJbwgfH
         /i5g==
X-Gm-Message-State: AOAM532Iznt1Bq4jtJaQg0BPRYQvkQmQ9b8h/tHtbuediYzTun+MEZSG
        5RzvQ6rVHGAfK6lvvMVYI4j3jw==
X-Google-Smtp-Source: ABdhPJyn8dlt69y0gsG6wR+o/UXnjmbgFtRHWtdY8+d07kDxdHLobDPbTnYAeyYyMTxAPc9jYTsmYw==
X-Received: by 2002:a17:90b:3555:: with SMTP id lt21mr428742pjb.234.1594306318531;
        Thu, 09 Jul 2020 07:51:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m1sm2791322pjy.0.2020.07.09.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:51:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, georgi.djakov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 0/2] spi: spi-qcom-qspi: Avoid some per-transfer overhead
Date:   Thu,  9 Jul 2020 07:51:43 -0700
Message-Id: <20200709145145.4055619-1-dianders@chromium.org>
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

Changes in v2:
- Return error from runtime resume if dev_pm_opp_set_rate() fails.

Douglas Anderson (2):
  spi: spi-qcom-qspi: Avoid clock setting if not needed
  spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

 drivers/spi/spi-qcom-qspi.c | 43 ++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

