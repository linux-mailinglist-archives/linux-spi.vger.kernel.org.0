Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D7615E2A
	for <lists+linux-spi@lfdr.de>; Wed,  2 Nov 2022 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKBIqR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Nov 2022 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiKBIqI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Nov 2022 04:46:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449827CD9
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 01:46:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so23488033wrt.0
        for <linux-spi@vger.kernel.org>; Wed, 02 Nov 2022 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ltByLIj0SyokO3we+F7KDthHs4841xVlGPJUzUCdJU=;
        b=IgamBxEBc7YoiCYjghTBlqfPvxbjKkrIcNvUoyHd+9Wb3iQifOIdSoV+omsbL7fHZZ
         iCIrSpt6zpYXU+SV9+jPrhXgwt8T69WroG5DcI+G9wZJqqqO4Dc5kyb0+KpEENT2B5NO
         lT4lns2QCSh5ZRYA1sjrpyhxWdzpjYfQEx8W+m3dc/6OEuocpOAc5jmuFbxrkx8XoF19
         lH0h2/9WZ8grA1KBG1lTTUmHiogVZbMFaD1MxmP3MW+X66CR+6u9GiPNMcrbv5xokseQ
         5jvgMQjxQRRJw9XyJOTxg8bIqX0rwy/Eq3yzK2BNc62FMbA+A0BCFOGB/AzEcmYrH2h1
         FKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ltByLIj0SyokO3we+F7KDthHs4841xVlGPJUzUCdJU=;
        b=d9alxFgulJA1Aon1Khp0S03g7kk6QwgNYrWJ/P+tFgNWFxW7E1btkH3ImZ6PbGcxpi
         e9otD6Pu7f+HKSoFlkOaQnZzRS5F91VghgYiyAQs0Vg4t05JIDHM1ODHcoSsnkMZvnmA
         pHDWI3FTv/YEGEK6TYFMnoYi7ceEoMrVmFZpK+UxNMoJc20kid+pPTX+9pvjd3x8cfvR
         l3xQMJaN1/3z8ckuGf0JHVCSoaVPEfHvkmcKHrHlZ9uzlqqkNN/GgS15g2Lfcf1bvyLR
         pzq30HrtUNIOEaZ7Ctif8CiRvmzygJ6rmwkCswbB26ZXxWp7GxI7NXEMj7MhqoAF48BI
         ZF4A==
X-Gm-Message-State: ACrzQf0OCORZpSv3B5qQphs9ovEtfp34bsF1v5z/liHH9DUDCK4QUPl0
        ihsOOhZuylA9vn2XMJy+BedUAPzOwgAKSO66
X-Google-Smtp-Source: AMsMyM60FDv91EVLcYmjUas48F/vYfVv+qYpLRu4S964Onj+6CUMdQNPnSqXUPiirdAQYcaqNjTjeg==
X-Received: by 2002:a05:6000:1862:b0:236:510c:6d0a with SMTP id d2-20020a056000186200b00236510c6d0amr14604158wri.592.1667378764349;
        Wed, 02 Nov 2022 01:46:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b002367ad808a9sm12066261wrw.30.2022.11.02.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:46:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 02 Nov 2022 09:46:01 +0100
Subject: [PATCH v2] spi: meson-spicc: fix do_div build error on non-arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221027-b4-spicc-burst-delay-fix-v2-0-8cc2bab3417a@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        kernel test robot <lkp@intel.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This fixes :
error: passing argument 1 of '__div64_32' from incompatible pointer type

By passing an uint64_t as first variable to do_div().

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 04694e50020b ("spi: meson-spicc: move wait completion in driver to take bursts delay in account")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Mark Brown <broonie@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Added Martin's Acked-by
- Added Reported-by: kernel test robot
- Added To: Mark Brown
- Link to v1: https://lore.kernel.org/r/20221027-b4-spicc-burst-delay-fix-v1-0-5a6e9a88e54c@linaro.org
---
 drivers/spi/spi-meson-spicc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 52bffab18329..1b4195c54ee2 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -387,7 +387,7 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
-	unsigned long timeout;
+	uint64_t timeout;
 
 	/* Store current transfer */
 	spicc->xfer = xfer;

---
base-commit: 574f97ab96d6b153407161746bc127564e998b4f
change-id: 20221027-b4-spicc-burst-delay-fix-a03004454876

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
