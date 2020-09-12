Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59E267C81
	for <lists+linux-spi@lfdr.de>; Sat, 12 Sep 2020 23:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgILVIr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgILVIT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 17:08:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD839C061573
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 14:08:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so7630532pgb.0
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkdmHZJNcU+7N2ujCFsZPcv/unm2Wh+tx7Rkz6iTuF0=;
        b=n+aUgG/RdRP686huE3p5uz0c0aoEJ5mJl26a3jq1Q33zTy4H3FB4bwCKZF5u6wdJgO
         zz7he6IVgc5ADax0REzyDDWXGHQF2QSqLHbsS/vPCNZ+dpOV+5WeTNMXJbt0lS0nWWgE
         NCFVo40UENKFCM99tOaWb/pynEAIUh28jH3kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkdmHZJNcU+7N2ujCFsZPcv/unm2Wh+tx7Rkz6iTuF0=;
        b=sW6rOQ3Wr93kHs74wo5is4mg84TccKA4PhXlg282S8av27mTO/9c3x4PV8M2ozzQ04
         7lZmMzQ4eQHx0eoW4SYnwR1LeKpVTfrraZn+z9S14j4zUtUG1D3UFsCtBZgOFreX8ulQ
         jjLe/op1tUW55nI5+WUiRa1iqCqor9pIvzlYemi7zL5RW742ebIn7hw/1nGdZDIFi5LC
         /xCBqCnWxzJtPiv4lsXOhEaLgawMrQMxPD7M+8o25wBFLL98ZOq0kki/Q+8CFL9HU3V0
         Ni+dAbYYNKKr0auYbzaKB1irrfwMfhMa3d6hHgHTFYKYKpdBbyGPz27PK7EKkEvZf8sm
         D2vA==
X-Gm-Message-State: AOAM530jquD1LtFZ/1K4L7+ugSJTc1zSJhfmLvxZrdPhY92nKMluMbW+
        qwVbKK4pR7ELQxIlpapOozJBp9coguT+pQ==
X-Google-Smtp-Source: ABdhPJz22rwSO4QjmaRCwJE0H6ZOVP9TpnHWSmb2igzOtjxEis+mUFk/egFXQj1mz3ang7qDeLgZ7g==
X-Received: by 2002:a63:29c7:: with SMTP id p190mr5938653pgp.292.1599944897297;
        Sat, 12 Sep 2020 14:08:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id e10sm3369020pgb.45.2020.09.12.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 14:08:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Akash Asthana <akashast@codeaurora.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/3] spi: spi-geni-qcom: Use the FIFO even more
Date:   Sat, 12 Sep 2020 14:07:59 -0700
Message-Id: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In commit 902481a78ee4 ("spi: spi-geni-qcom: Actually use our FIFO") I
explained that the maximum size we could program the FIFO was
"mas->tx_fifo_depth - 3" but that I chose "mas->tx_fifo_depth()"
because I was worried about decreased bandwidth.

Since that time:
* All the interconnect patches have landed, making things run at the
  proper speed.
* I've done more measurements.

This lets me confirm that there's really no downside of using the FIFO
more.  Specifically I did "flashrom -p ec -r /tmp/foo.bin" on a
Chromebook and averaged over several runs.

Before: It took 6.66 seconds and 59669 interrupts fired.
After:  It took 6.66 seconds and 47992 interrupts fired.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0dc3f4c55b0b..7f0bf0dec466 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -308,7 +308,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	 * Hardware programming guide suggests to configure
 	 * RX FIFO RFR level to fifo_depth-2.
 	 */
-	geni_se_init(se, mas->tx_fifo_depth / 2, mas->tx_fifo_depth - 2);
+	geni_se_init(se, mas->tx_fifo_depth - 3, mas->tx_fifo_depth - 2);
 	/* Transmit an entire FIFO worth of data per IRQ */
 	mas->tx_wm = 1;
 	ver = geni_se_get_qup_hw_version(se);
-- 
2.28.0.618.gf4bc123cb7-goog

