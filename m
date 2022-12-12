Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A964A6AE
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiLLSJt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiLLSIa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B865D7
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o15so6208409wmr.4
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxcMgepI8oVEM9TqV5Jw/8Ls56KCQWpTpg2XQ851Vyo=;
        b=ihIo87o/eW0m0yNdwDPZYK+DwBvApOUgbohqKB5uvxZomOsA7v/sIVscW3U7MU40Vn
         oZvjCKLwi7XnZlTbhTAM1iefFfkNbcmzhaR1hWInKHbCO53Z6NJ71yKW4uCjdXX1pLmU
         gbSbXVkBRmwf9k4nutNA9DDRLRSrKqyzVdDdGCmiepNlB69wP5ysyD+gWqC8MZHrLY1n
         4FvDcYZA79H8FOQDnSK0i1wZCxfE9qBsG5n/6f8lwx4DQOqWyt2kbjuHOZr+KNYh8Uxa
         4NSYJlsDKN0EKzCbH5oc29wuirYwZMkFKgoHGTbpd83LA+sXtN/jMMb0K6Aj43CL6ZXq
         ygsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxcMgepI8oVEM9TqV5Jw/8Ls56KCQWpTpg2XQ851Vyo=;
        b=KqoaiPj0xEjv/kBpDlpQ61nFfxyUGZQcaVotRoHN4nodjtPK11EKOLaVB7pqtqbNRT
         yt+5Pg6tjU+T5wxQI2z/cWcncu9yH+iAKvsL0qOkSLVZn76emqrGyoSbZnf77/zz9IB8
         NcOB10TW3hO6LvdeEcp4bftGFE6lenxvd/3bo+c9djKvWHdp1Jkxvzj/QWBknSviuDmv
         Mq+9bGSpmteSqpMs8vPp3/2J3HdXNWhvFRByzDExtMtHNuwdUa1SHo8kcCjtf+TSUhh7
         i/AirP+A4MjUq5cqyRV5yPBF6hUUTxxufpGOnF+NTSTibmxPRtpHv+gsolmZymG8Bffc
         jx8Q==
X-Gm-Message-State: ANoB5pmRpTcrVql1iIE5gm2+5L/uW3ZPs161PmlZEPm5lSfFYtcEV4VN
        1SXo9AMqcVQ6SFYbC5TWJh4R5w==
X-Google-Smtp-Source: AA0mqf5WAwhv7CN65oqrRHJ56WnHd0r1iLiZBzcHbxlqTDYQ/i3lCLb42boTqKHrJxh0Z2TfH+O25Q==
X-Received: by 2002:a1c:4c06:0:b0:3cf:88c3:d008 with SMTP id z6-20020a1c4c06000000b003cf88c3d008mr13028681wmf.28.1670868475158;
        Mon, 12 Dec 2022 10:07:55 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:54 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 15/15] spi: dw: initialize dwc-ssi controller
Date:   Mon, 12 Dec 2022 18:07:32 +0000
Message-Id: <20221212180732.79167-16-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the generic snps,dw-ahb-ssi version to initialize the controller.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd129..431ba768ea861 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -352,6 +352,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "snps,dw-ahb-ssi", .data = dw_spi_hssi_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.30.2

