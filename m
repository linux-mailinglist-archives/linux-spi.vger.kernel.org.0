Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A590C223D69
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGQNzD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgGQNyh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89287C0619D4
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so17159209wmi.4
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/mBj9pAMuVLonO6aKhrgrEYwyEsNFutXpDwnyRxo/to=;
        b=cCC6wwWlQpTMveu1qLqD9irne79EY5ETXeh1rAvAAmH+LbiFyUjRk1ScIyrfmwefTv
         mFH+Dn3v/+xPUHoIWVWnpdkrm8IZAwwrC0nGV6nJHAUPKTjea9YuyLEZQwc1IJAswX6+
         tCXEHvtE1nHhDMPzh2+JAiQX+k+oxlOF0rSb1BHirgI+fTnJa1Wag/CmnsEhB2k4FQei
         IuVXnlndn2vb2xncG+l0JMF/aakBraFwN6jUo0NHQUI1LLX0qof6/3e3YtpgKX0gUI4o
         sBKrEHsK4I3F+qIti6r6RGX+i+V2MWy7R7rwXBmQH2TfDvHmoPTS3FPp8isAlmk2K3fI
         VMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/mBj9pAMuVLonO6aKhrgrEYwyEsNFutXpDwnyRxo/to=;
        b=lX8o1XkVlwk6aBvoBt16BWr7WtA5y6PtAzdDY5MdAWVF299GJ+eyr/L9Il9AJNPSf4
         ay5Vv667aOWLx5Q1HBUn0iAZNoq+2AVhr1nsgigOQGTACUWmAh9Pko5rw2cucbpv5fSi
         6XFZ1tpvzHvRgi1Q+eHxqRQrs1wY9V8rjRlOMoDrRtIAzfKko/77uZTW+++MCNCQIxp1
         54m7sWrC/xckB9xrZfgtAvesARiUiha3mU1ZaenN87FefZS98ne6PdDuDe6KTKP1/gC1
         hbWl3V9dhvIW/QJEm3wz9dw1lmNyv6EI5YOuUCL+TBvyRwglwfJaDNNZfKQY5ZUXxgsx
         qFCA==
X-Gm-Message-State: AOAM532zMW9hl/trLdBY0Izfxhk6FVZZFNJldDG3s0uGpB4x1KSwphkG
        Ovxh9lhPM4fX9canszITVmxwabuucxgwew==
X-Google-Smtp-Source: ABdhPJwcTbAJHeWet+0yZMRNf1B5uWVO3GrnOII6C92tRowqv4TTCeJPT7QC54S41JczZLvDokTPCg==
X-Received: by 2002:a1c:2d0c:: with SMTP id t12mr9259723wmt.43.1594994076272;
        Fri, 17 Jul 2020 06:54:36 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sureshkumar Relli <nagasure@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
Date:   Fri, 17 Jul 2020 14:54:19 +0100
Message-Id: <20200717135424.2442271-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-zynq-qspi.c:143: warning: Function parameter or member 'dev' not described in 'zynq_qspi'
 drivers/spi/spi-zynq-qspi.c:334: warning: Function parameter or member 'spi' not described in 'zynq_qspi_config_op'
 drivers/spi/spi-zynq-qspi.c:334: warning: Excess function parameter 'qspi' description in 'zynq_qspi_config_op'

Cc: Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/spi/spi-zynq-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index bbf3d90561f54..5d8a5ee62fa23 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -119,6 +119,7 @@
 
 /**
  * struct zynq_qspi - Defines qspi driver instance
+ * @dev:		Pointer to the this device's information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -316,7 +317,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 /**
  * zynq_qspi_config_op - Configure QSPI controller for specified transfer
  * @xqspi:	Pointer to the zynq_qspi structure
- * @qspi:	Pointer to the spi_device structure
+ * @spi:	Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
-- 
2.25.1

