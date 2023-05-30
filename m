Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94741716C12
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjE3SPC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjE3SO7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 14:14:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD77EC
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 11:14:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53487355877so3058888a12.1
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685470496; x=1688062496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wejmfms/MTruDYODALqcJ51ghyqKDRBVlvqid0DKdUU=;
        b=ngR8WUfo12QEnVFptE3frRjlZIIv53yMuBehH6/yqZOlhdWodxtvmMkx4cOCKLFU1J
         Be5nnnNc0oj+fBcVqMR42F8lJMRreGmaZWldywOfCmuKn1xMjguK+JS9revnMtiAt15k
         E9DV64QoXxjJTIK8Z2cJOcAC1sfuuGrLrLVL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685470496; x=1688062496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wejmfms/MTruDYODALqcJ51ghyqKDRBVlvqid0DKdUU=;
        b=WCW5fihtmmI95O6PNGPaHzOmGJ4aWufQR97pBqep1s5u02fgvteup0UAGMYn1Q2b3i
         aB9BhtEbiE8APvygFK6Z1B0FCkvElUfgOl+kdGynwNvSSc32GjefA8KCL8uOF1HhIfij
         PFjbjEx6hkY1yhMYFge0+8+4Zhl2wV8YcUQgPNGq8B5OT0fPB5hNphMU18tFO4cxCy+C
         8cZX8kL9CSdbevEZBHKmrKVRcyVcLDXRl5UaV4T0W6YZoC5wZ2kwZ1aQ1kwWT+pdHREZ
         VPR4EljCokDk3Wu4EqCr7RV1IMZb8DYkxnNYO7csqnabmsKO9PjY8fVjcVgX20H2onpq
         hPlA==
X-Gm-Message-State: AC+VfDyUOpTj7tBntOzS48iUK4w6F1oKo/+gR/DOEeq9u4jPIxB+DNUT
        py3Z7pD+znNd+MkierDlShmKcw==
X-Google-Smtp-Source: ACHHUZ7XQtTdVlY0DHCmMiZA+STEzORTjmprrjia5mLFvW/qUUbtteO21yEtKVNdONuLVxcpl5n8ZA==
X-Received: by 2002:a17:90a:b298:b0:256:2ee5:aebc with SMTP id c24-20020a17090ab29800b002562ee5aebcmr3133136pjr.18.1685470496708;
        Tue, 30 May 2023 11:14:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:49d0:fe41:5206:ac47])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090b068a00b0024df6bbf5d8sm9288614pjz.30.2023.05.30.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:14:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-qcom-qspi: Add newline to PIO fallback warning
Date:   Tue, 30 May 2023 11:13:48 -0700
Message-ID: <20230530111348.1.Ibd1f4827e18a26dc802cd6e5ac300d83dc1bc41c@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A warning added in commit b5762d95607e ("spi: spi-qcom-qspi: Add DMA
mode support") was missing a newline. Add it.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Closes: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/4573857/comment/44331d65_79128099/
Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index a3991e617c90..a8a683d6145c 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -445,7 +445,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 				qcom_qspi_dma_xfer(ctrl);
 			goto exit;
 		}
-		dev_warn_once(ctrl->dev, "DMA failure, falling back to PIO");
+		dev_warn_once(ctrl->dev, "DMA failure, falling back to PIO\n");
 		ret = 0; /* We'll retry w/ PIO */
 	}
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

