Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D274249B
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF2LBI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjF2LAq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 07:00:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9161FE8
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 04:00:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f875b267d9so802249e87.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688036440; x=1690628440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irPzF3OxPDMAQ8WDd9+EDaBFBVkV2UlmBZLfXjXGb5Y=;
        b=xaYRbH1VzjSXi8XjAMzwSkOEKS1Uq261RB89swQ99Y9XExiRhTqDvX98ZPwFhuofH+
         6jImdCDXX0tsyyTUYxxpRKX3JFhApHZOyPFF4GNAcKtVOc+gCvlkPNhoQXWhHOUiepL6
         z6mionKIuZ4onvp1KGAfQxlb0Cpf987k+PIn6sBLd3Lj2BDY9YBX5ReWLsjwl5LAEpiu
         v2eCoAL5QfCeMBcmdZ/ndbNz0I5Ex2Dfbh8bgotFCg3Lb0q6hIcjQGQADQ10TosQLePu
         xNSzICod/sWBqb6XHjssl40iFbOzwggTzpV6ve8WLE3vK3zacdB1XbnCsSNHPQ6EEJZW
         OxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688036440; x=1690628440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irPzF3OxPDMAQ8WDd9+EDaBFBVkV2UlmBZLfXjXGb5Y=;
        b=aY71Y8knAb3Wn3LrSJIu9aQG38nB+fQl9nilnuEqnpzSVZyT14BRblnSrSe/6jSsTD
         AzJ6g/e9Rvp0tB1RYG6Oro9Ihk6nVUCo5SseQ7Cb07j4Ymgwgn3Dme50HQOwbErWRc8L
         3SUbAXlLHsmW27aQsUT9JQLjnAQSROZSGaCPHMeUKsuObZcwlZ+ovV3KE/KKgPJWM30Z
         MjwMHdS7IRGUp2cx87O5WxlGrdJg0mZc/BOREdMVsZdD72GFJfojEn1iE+RIb5jyH/Zg
         B86vxL+rZlp4TuDOWIuij/QEhDO4Txqi7w6CuB0OT2AYTI//PnWIHvSB8TmZmlhWqTlB
         GNUQ==
X-Gm-Message-State: ABy/qLY7z5geKHQ0wsQDG9t0whJdGKjFvHcC6yM3qwYo7uHh1QW107Ry
        DD68Ft3haI8FujzNXd567l+LqF6wHkwvr/FKAoA=
X-Google-Smtp-Source: APBJJlE3j3eMomkqRlpiuO6WzVvSAPlwVdCSTn8RtlE6cTvdVKEABToWOYne/dIaBtoQrvTzy99K2w==
X-Received: by 2002:a05:6512:3b07:b0:4fb:9f24:bba9 with SMTP id f7-20020a0565123b0700b004fb9f24bba9mr578170lfv.5.1688036440608;
        Thu, 29 Jun 2023 04:00:40 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n25-20020a195519000000b004fb6c61e79bsm1833214lfe.117.2023.06.29.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 04:00:40 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode
Date:   Thu, 29 Jun 2023 14:00:39 +0300
Message-Id: <20230629110039.3659309-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The GPI DMA mode requires for TX DMA to be prepared. Force SPI core to
provide TX buffer even if the caller didn't provide one by setting the
SPI_CONTROLLER_MUST_TX flag.

This fixes the following oops:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[....]
Call trace:
 gpi_prep_slave_sg+0x3a4/0x5a8
 spi_geni_transfer_one+0x190/0x558
 spi_transfer_one_message+0x424/0x800
 __spi_pump_transfer_message+0x248/0x670
 __spi_sync+0x2cc/0x3a8
 spi_sync+0x3c/0x68
 spidev_sync_read+0xb0/0x108
 spidev_read+0x54/0x110
 vfs_read+0xc8/0x270
 ksys_read+0xec/0x110
 __arm64_sys_read+0x24/0x38
 invoke_syscall+0x50/0x128
 el0_svc_common.constprop.0+0xd4/0x100
 do_el0_svc+0x40/0xa8
 el0_svc+0x34/0x108
 el0t_64_sync_handler+0xf4/0x120
 el0t_64_sync+0x190/0x198
Code: 94079d2b 17ffff94 a90573fb f940a660 (f9400b06)

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes from v1:
- Trimmed the backtrace to include only the relevant information

---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b293428760bc..631c17e629dd 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1100,6 +1100,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (mas->cur_xfer_mode == GENI_SE_FIFO)
 		spi->set_cs = spi_geni_set_cs;
 
+	/*
+	 * TX is required per GSI spec, see setup_gsi_xfer().
+	 */
+	if (mas->cur_xfer_mode == GENI_GPI_DMA)
+		spi->flags = SPI_CONTROLLER_MUST_TX;
+
 	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
 		goto spi_geni_release_dma;
-- 
2.40.1

