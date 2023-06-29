Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF174239E
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjF2KDa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjF2KBk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 06:01:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB853C10
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 02:58:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f865f0e16cso738097e87.3
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688032728; x=1690624728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dENKQGbnxXeQvjL65pDjN/UekMcZVd8BbW9HeuEWsc=;
        b=XlKSWEn3EGSGsZEegOLmXqQpmw9L3wt3AwLK+aPToXyt6sDS9kI3J0Xmop2zHexoht
         x2+HFfKpUPWyyRP2H7OuAkvQf5hoEA/Q4y9dsNeVwHQ7mNoCEFLXSkrbJCvNXPRhRjNY
         8I0fi2b7tJ6uRD3WZNy2shRDai9BcWrmGDsRgu7TokYERrUoe7s/ZudzQpCbSDSWQqt7
         rq7ZI1taUrM2ucPBhWwiHNU+9WhP5S3HB++TJsr5yECA9V0caOOB14htOYppL3RUvr0b
         7RT0KVx/utAAi5SQ9OHXEbczB5ufA1VibeeT+lJ5VAn5qJQvIyz4R4ywnO+GbpWrVvSa
         BBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032728; x=1690624728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dENKQGbnxXeQvjL65pDjN/UekMcZVd8BbW9HeuEWsc=;
        b=GvVBjDm0fg42VRmpNvoeYXV0WkqBJNmY2PyfRumpkUPMTsVRPLdbVvhVjlfZNZPGZS
         WpmlaGHOMDr6hw433++aSk/fdwXF9LyXx7T/ZRXPZLdm0HArgeYjKaLHJ+Wp4FToHy/p
         v8kFn7Y0BPJHAgUPEd2s3fWoM2egkMVyn+5jjBknwZWkWUfFdRlKwdiU0UpfWScJbMaX
         bG21WMX28lvt/DL6kLJ5v/3o0MrmZfn+dPLgNToGItCkykMfQGTiOtmZSvacHVAt3/Tu
         WJoLSAXQ80fA8K8zeygM04FSal4hk/XUtg95WkL4TMfEEgs1bF5JgfeuN05OnTTjd71N
         /oCA==
X-Gm-Message-State: AC+VfDxQ0LKxlmPR8JLAPPEeQxNKRNz8G7rZb4dhZvTskZs5ggjNxaq3
        jY1FwAkCA7Fps+GNx9e01JP2ew==
X-Google-Smtp-Source: ACHHUZ6uj23D79WTCdOSbLoNaRpSu/oNgl468TItmqhLAzBE25UvGmFQDG2DY6Sntv9LV2bnC+mwKw==
X-Received: by 2002:a05:6512:2824:b0:4fb:7888:7e6d with SMTP id cf36-20020a056512282400b004fb78887e6dmr8733294lfb.46.1688032728410;
        Thu, 29 Jun 2023 02:58:48 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b29-20020ac25e9d000000b004f85cf6416asm2272615lfq.118.2023.06.29.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:58:47 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode
Date:   Thu, 29 Jun 2023 12:58:47 +0300
Message-Id: <20230629095847.3648597-1-dmitry.baryshkov@linaro.org>
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

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000815b82000
[0000000000000010] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : gpi_prep_slave_sg+0x3a4/0x5a8
lr : gpi_prep_slave_sg+0xcc/0x5a8
sp : ffff80000a2c3930
x29: ffff80000a2c3930 x28: ffff80000a2c3c58 x27: ffff4e744d8307f0
x26: 0000000000000001 x25: ffff4e7440f55810 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000003
x20: ffff4e7440c1f800 x19: ffff4e744d1f8618 x18: ffffd8ac41787e68
x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000100
x14: ffff4e744d608000 x13: 0000000800000002 x12: 0000000600000004
x11: 0000000000000000 x10: fffffffffff9f980 x9 : 0000000000000000
x8 : ffff4e7440c1fa00 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 00000000ffffffff x4 : 0000000000000900 x3 : 0000000000000200
x2 : 0000000100000000 x1 : ffff4e7451f73400 x0 : ffff4e744d1f8610
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
---[ end trace 0000000000000000 ]---

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a98b781b103a..15b39008a554 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1098,6 +1098,12 @@ static int spi_geni_probe(struct platform_device *pdev)
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

