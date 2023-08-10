Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2949A7773EE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjHJJNk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjHJJNO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 05:13:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FEE30E3
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 02:12:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so1010611e87.0
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658774; x=1692263574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFC8UwWW+iR30JPgYo5rYE8kvBFOSJM2pan/x7dG/FQ=;
        b=XOfnHOF8Ge3HS+SYIPZG2zjLSG/3isat/D89FvJn8O1gOqPaa5eIbissd+xIj2L2Lw
         WgztZ6Gyn0RxAvUIJyP9r+vpkz8eUcdurVVgvuXscBkB2iru2B/JgRLHIKcu81g3r1Bt
         EosbxjvmqNMnQIoIhJ+4Q362u2UxA2U97mxiLMcOwYeTgdrxAkxJ+1fbBDhCgRa4yxG5
         ez7jwHywBaZ3U5a26UH8bz0vjqhEBzEqUwNlSJc5SyGwCHZjCLuL56JG+U0HPCQGeTy0
         VmyygMb2w0DmosFubJM/3zPHGYcDKQ+4Dw4Jj4O0lMsVKIgKACHfMpLSlWZxvRfP0ofP
         mTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658774; x=1692263574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFC8UwWW+iR30JPgYo5rYE8kvBFOSJM2pan/x7dG/FQ=;
        b=IAaXeQyEI2qyTpz1gRRqDJZrHdtfrTg6kE1uwWHSqL6mEAx3AUBoiXm3PA+Ejao9Xm
         qSRBveDeW1whRZw23144/4aWOzZFqy9+bPXnjDBZFEaF+CIrCiaCL3Yt2ts7QTGR9iV4
         zL9Utd8AsSVsik0eb7wQb2V477SYn65AyoPb09S61Dxh06ZxSrxO9C5pS4fZYvq7qyqR
         ZZQLrF5KxzJElJLI+TkQaHCOrR6XJq90rON67P0joxXIAc/tK79A6LWDvAZCRVy9YDOZ
         O9Gpp5okQeKrvGVzKXgYerubZ16NOLX+wREKiy8+j/P67FYq/GfwEKwnMayuLue8hDU6
         Fw9w==
X-Gm-Message-State: AOJu0YwZcN0faOFwxjcYVKbU0tfWetLL5KPZHlvhZZn2L6J933q6hVZ9
        QTfw9H8VPjF1xc9IrLUwMKCCDEKf8hHAj5I+gX1Yhg==
X-Google-Smtp-Source: AGHT+IFKBRECSDxdUSRf4SBuIAe9GvX6BSkSredNNZfpc6UoJ0zsZfV58pjE4WqjMdZojS0LAmA//A==
X-Received: by 2002:a05:6512:3b21:b0:4fe:82c:5c8a with SMTP id f33-20020a0565123b2100b004fe082c5c8amr1540576lfv.58.1691658774124;
        Thu, 10 Aug 2023 02:12:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id m8-20020a056402050800b0051ff2b6139esm538889edv.5.2023.08.10.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:12:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 3/3] spi: amd: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:12:47 +0200
Message-Id: <20230810091247.70149-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
References: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'version' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  spi-amd.c:401:21: error: cast to smaller integer type 'enum amd_spi_versions' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index b19766571f28..8b3eabb4cb38 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -398,7 +398,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
-	amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
+	amd_spi->version = (uintptr_t) device_get_match_data(dev);
 
 	/* Initialize the spi_master fields */
 	master->bus_num = 0;
-- 
2.34.1

