Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E758B7773EA
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjHJJNb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjHJJNE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 05:13:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF042D7B
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 02:12:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523643207dbso796429a12.3
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658771; x=1692263571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tF/UykYBSS5il9uXSjCsz0BSK47V9bZY9dMBZBHwCM=;
        b=Omi3/tkSRgFfWFz5TU3/glLgHe/N/sxie8IkJQRtOfCCzWVEjQR+W6CBt1eRbgOZfA
         nSTEcYf2a9/VRoSVBSrbaxhJQ4ooFAe5nazCqlyCWFz3DXqss/iCO6G1+2n6eLu/4cNa
         MxOV7IQVAnkhWVvyXn5SkY+Wi6C3g3yDPlgLFcDnYofNApG+QBC/GAETWxRGYCF0oIVh
         V9mCG/81U2ziw+8NPtRfpaAgnkXVnQTM72dZFeLXZpUKysceyG5yiDRJ4g0IQXFX91RH
         2/xNq+za9s+oXmSt99zEQthls14X5s5w0SpPRBhv4QVnTepwrfmm59qbjovM+S2gq33G
         bTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658771; x=1692263571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tF/UykYBSS5il9uXSjCsz0BSK47V9bZY9dMBZBHwCM=;
        b=EtUDiBkWNPENxyWKwk49TWmc/uvnkCaAu6//7ZtiJp9orD2CaHG8gFoYke8U37jZnt
         ixzsDUgTRBi1340EZpJ5GfaA6iUqdWmw6OpNcsDww1vwZSqwRWjdRF+0arobVRNlgqe9
         HTNPjW4sE6yauKQQzZxpeMffzGHpTaXGNVcp4Kr1A1PD3RUmP98E9w/PiYdHwqmEsJh6
         7+jK5uKyRSiUb/qUQqmAP9z+x+kHb2AfK187jf5EvaOYfoCJF/ya3x0ztqSMZn+15b3M
         jBmzZYfze/Va7Cc3uIy3oOYlT0ZjmcM/WRJ9QH8pzkCLHxU6ogNkmSmRPMQvdISIx0Zs
         r+Mg==
X-Gm-Message-State: AOJu0YzpbjGrqLnZK4fxOMVb7Qgnbts7iQqg2ef3obtaYUmaYURHBn1W
        3qASPbslkLR69zXA/U5w48jNxw==
X-Google-Smtp-Source: AGHT+IFSpZpedFWoUrxz4TLziYvl5dMKs7HeE6VXyI4MkrnHmPOf5vv/Jeg4jkdwCZhVlShfwLlJEw==
X-Received: by 2002:a05:6402:6c9:b0:51e:3558:5eb6 with SMTP id n9-20020a05640206c900b0051e35585eb6mr1660739edy.3.1691658771138;
        Thu, 10 Aug 2023 02:12:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id m8-20020a056402050800b0051ff2b6139esm538889edv.5.2023.08.10.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:12:50 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] spi: sc18is602: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:12:45 +0200
Message-Id: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  spi-sc18is602.c:269:12: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index c67a24daaaf9..9f98bf350697 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -266,7 +266,7 @@ static int sc18is602_probe(struct i2c_client *client)
 	hw->ctrl = 0xff;
 
 	if (client->dev.of_node)
-		hw->id = (enum chips)of_device_get_match_data(&client->dev);
+		hw->id = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		hw->id = id->driver_data;
 
-- 
2.34.1

