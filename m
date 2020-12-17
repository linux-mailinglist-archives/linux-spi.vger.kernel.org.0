Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004592DDB6C
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 23:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgLQWa4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 17:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbgLQWa4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 17:30:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA414C061248
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 14:29:38 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e2so71476pgi.5
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 14:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vo+nW0dH46P2KHLc68abpdc4ZQATo0Haicb01r3gGc=;
        b=dbCU0DJ2thR9h4Iz7w1YVlFi+HfxzId5hJDFxlm3vZnAzRN4afmLNoXle64azsK4sg
         XbtjvivnBA8YgZchJk+neKH7GPHzVcuu/P02D4TEJFR9kqh+pt+StIQr9H6CfHjIykP6
         DNwkmHOCIbIB/9vTRoIFtHqF22NYbFmtJ7rvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vo+nW0dH46P2KHLc68abpdc4ZQATo0Haicb01r3gGc=;
        b=pmkrjq3CYdLTyVKb5fntrp93ssayoyeZf94s/eDBKd8b9RHwykKgWmXABCD2r8Lgqm
         A2vfhBM+UvcVKrNovO4uxw8BUidNVW/15szAf+fUkGwpsCZ+b4d/ZCLZZTlGpgZNFy0z
         o+T14VcaeepchwRNWdHkkmvlHUQW7NLKhqA9rscLD4mFNd8hJUHeLc3URbJzzcZkMbAo
         fCcB/YpT27g+Ug67KqX70v2zjTojbrcUWEwaOw+wg2x4VytRi/OA6J2XEyxhL+1fQyV5
         raRPnOsFnA2anh+WNBd+EXTK7t4dQleB1Enqb7jbWTugg/m7OLlfR214zFh4R2Jp/Zf6
         VTwA==
X-Gm-Message-State: AOAM533j3BOQlJXHiIDTZAA3g8Mei9iZZX7d1qkyEXVSD/WMexvQ1Dkf
        Efb3poyZrszEOvdFfenMbeOKPA==
X-Google-Smtp-Source: ABdhPJwu2sL7WtP1xSDUnnnfQFJiRPkWMbpq8CPaTFt/Z+ZvMZIuOdvbcWPtbycwcQe24LffmO4WxA==
X-Received: by 2002:a63:5845:: with SMTP id i5mr1291424pgm.355.1608244178430;
        Thu, 17 Dec 2020 14:29:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id gm18sm5805850pjb.55.2020.12.17.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 14:29:37 -0800 (PST)
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
Subject: [PATCH v3 3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
Date:   Thu, 17 Dec 2020 14:29:13 -0800
Message-Id: <20201217142842.v3.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If we get a timeout sending then this happens:

spi_transfer_one_message()
 ->transfer_one() AKA spi_geni_transfer_one()
  setup_fifo_xfer()
   mas->cur_xfer = non-NULL
 spi_transfer_wait() => TIMES OUT
 if (msg->status != -EINPROGRESS)
  goto out
 if (ret != 0 ...)
  spi_set_cs()
   ->set_cs AKA spi_geni_set_cs()
    # mas->cur_xfer is non-NULL

The above happens _before_ the SPI core calls ->handle_err() AKA
handle_fifo_timeout().

Unfortunately that won't work so well on geni.  If we got a timeout
transferring then it's likely that our interrupt handler is blocked,
but we need that same interrupt handler to run and the command channel
to be unblocked in order to adjust the chip select.  Trying to set the
chip select doesn't crash us but ends up confusing our state machine
and leads to messages like: Premature done. rx_rem = 32 bpw8

Let's just drop the chip select request in this case.  We can detect
the case because cur_xfer is non-NULL--it would have been set to NULL
in the interrupt handler if the previous transfer had finished.  Sure,
we might leave the chip select in the wrong state but it's likely it
was going to fail anyway and this avoids getting the driver even more
confused about what it's doing.

The SPI core in general assumes that setting chip select is a simple
operation that doesn't fail.  Yet another reason to just reconfigure
the chip select line as GPIOs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- xfter => xfer in error message.
- More obvious in commit message how this happens

Changes in v2:
- ("spi: spi-geni-qcom: Don't try to set CS if an xfer is pending") new for v2.

 drivers/spi/spi-geni-qcom.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index cf3db40ae5ba..b3ba092db489 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -207,9 +207,14 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 		goto exit;
 	}
 
-	mas->cs_flag = set_flag;
-
 	spin_lock_irq(&mas->lock);
+	if (mas->cur_xfer) {
+		dev_err(mas->dev, "Can't set CS when prev xfer running\n");
+		spin_unlock_irq(&mas->lock);
+		goto exit;
+	}
+
+	mas->cs_flag = set_flag;
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
-- 
2.29.2.684.gfbc64c5ab5-goog

