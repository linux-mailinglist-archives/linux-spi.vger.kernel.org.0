Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE11FF641
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgFRPK4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbgFRPKw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 11:10:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8AAC06174E
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so2926408pfe.4
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVe6UCUtrVR7cafEV9bt9G1zk5uDkvg9No0xHEHinP8=;
        b=HfoZ5lRONe1F61xrxP9U4L/d9eEWRtxvGR1cJncfL/woxzmvANr4v7yU5w9uV+0w7P
         XcjIgNgXmghUX+eAEQaMHmAjrIUFdQM2LLEcvBGYYsI1BUw4VKM5Q0VLNRn6y7Vq7/9j
         CkxlFgDNBB8iW6/bhIasfNViYUjlV+/a8geOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVe6UCUtrVR7cafEV9bt9G1zk5uDkvg9No0xHEHinP8=;
        b=tOGwgwwXkRdUWGopM3fYu1AcUs1kvd1smMnVLT+74ouFd2J/vcec/RHmdkf6FvGrPI
         /Koqs+vKxHRG45uTTU+CiyjNEh+7XCXUEGvWpI+rnTaudbsCY24xt9W3pN/1ZHVS2cFr
         YHxE5CsucURgVYwlSru5ITLdVVf+pMtmglgq+mdfYPFx5RpnNcwa4G//pUNpOAguXEMU
         eBR84euZtZ0aBTvUXWPuW8Vg08MHx0o+5m3OaEsxoqkknYTaodkheldplZobuCPAs63+
         isSV0JZmYzUnd7HI9FQnrMeJoaWHo9PC0d1y9eTM7AfzQoWxIArMV61S70WGD2U7veBr
         Ooww==
X-Gm-Message-State: AOAM532RcT0ILHseqzvHUdCxo0HWFmFGH//cSImpFp6102nRoNpyjOY/
        K+aKtkXTheS2S3hTfmm22SpTmQ==
X-Google-Smtp-Source: ABdhPJxeb3obYpA8AnWN2pNjegngMD5qnPGIspUqIiUGT3QjemzJUaNiSOGvh5KCaQsVt6QmO1Xtyw==
X-Received: by 2002:a62:3103:: with SMTP id x3mr3897100pfx.130.1592493052313;
        Thu, 18 Jun 2020 08:10:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 4/5] spi: spi-geni-qcom: Actually use our FIFO
Date:   Thu, 18 Jun 2020 08:06:25 -0700
Message-Id: <20200618080459.v4.4.I988281f7c6ee0ed00325559bfce7539f403da69e@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The geni hardware has a FIFO that can hold up to 64 bytes (it has 16
entries that can hold 4 bytes each), at least on the two SoCs I tested
(sdm845 and sc7180).  We configured our RX Watermark to 0, which
basically meant we got an interrupt as soon as the first 4 bytes
showed up in the FIFO.  Tracing the IRQ handler showed that we often
only read 4 or 8 bytes per IRQ handler.

I tried setting the RX Watermark to "fifo size - 2" but that just got
me a bunch of overrun errors reported.  Setting it to "fifo size - 3"
seemed to work great, though.  This made me worried that we'd start
getting overruns if we had long interrupt latency, but that doesn't
appear to be the case and delays inserted in the IRQ handler while
using "fifo size - 3" didn't cause any errors.  Presumably there is
some interaction with the poorly-documented RFR (ready for receive)
level means that "fifo size - 3" is the max.  We are the SPI master,
so it makes sense that there would be no problems with overruns, the
master should just stop clocking.

Despite "fifo size - 3" working, I chose "fifo size / 2" (8 entries =
32 bytes) which gives us a little extra time to get to the interrupt
handler and should reduce dead time on the SPI wires.  With this
setting, I often saw the IRQ handler handle 40 bytes but sometimes up
to 56 if we had bad interrupt latency.

Testing by running "flashrom -p ec -r" on a Chromebook saw interrupts
from the SPI driver cut roughly in half.  Time was roughly the same.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Technically this is an improvement, not a fix.  ...but it should be
such a decrease in interrupts that I've tagged it as a Fix nonetheless
as per suggestion during review.

Changes in v4: None
Changes in v3:
- ("spi: spi-geni-qcom: Actually use our FIFO") new in v3.

Changes in v2: None

 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 11f36d237c77..5b8ca8b93b06 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -285,7 +285,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	 * Hardware programming guide suggests to configure
 	 * RX FIFO RFR level to fifo_depth-2.
 	 */
-	geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
+	geni_se_init(se, mas->tx_fifo_depth / 2, mas->tx_fifo_depth - 2);
 	/* Transmit an entire FIFO worth of data per IRQ */
 	mas->tx_wm = 1;
 	ver = geni_se_get_qup_hw_version(se);
-- 
2.27.0.290.gba653c62da-goog

