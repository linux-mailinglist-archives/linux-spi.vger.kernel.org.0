Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FD588169
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 19:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiHBR6d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiHBR6c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 13:58:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384A4BD1D
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 10:58:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so14126261wrq.4
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xON5/1RnjBTHOYTi8U3eC1G9Pht10d2+/+PE/oCDM8=;
        b=kDBdO+hRY7GGEfK3BrZAjRifF/FxSnBpdqBE5RTRkvK2+41NZPoMQ0DSrbX5Vq63HN
         jv2F8RuSflT3kmgJsznZ3Vw+ZM4dzzIlaiARzmp2HMjwZlnF0DvBYwBSJpO9JQqz/2ua
         AkF0nVK+2CZw2K/6HS4JmJJBjFCta96WWyKXdyEuNAvWx/fo5qH0VfCLOrYf8o5k5Vey
         Hzs0Vr/sNMNFqdUZMfRIS8dAE3tgh/r8nRH0luf+CqcDgalKNwOUgYd1XOaewHP3JrfG
         0PLyhMwOlNBy0XdpblT15qNlmuMhaSeqqCvRNMJrI8WnPEw0xtU8BVoDh0wK8u3763rj
         9lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xON5/1RnjBTHOYTi8U3eC1G9Pht10d2+/+PE/oCDM8=;
        b=AMKEdSpQggKC9XRixi/eDMBbxFdcg4wOjqtbR6Sfov8DZyUe6ePyZy/O7kF9wNtpwU
         SFZUu7nTgN0dUnovhMFM8Yc00X1NpDRJEmgy47iN0IuUcIvJexV15sJ9/0CUgEmxkgoj
         EwIPwEBmyuUfHzJHus8jJoQ/09Dq832nY4/2J6rFQyokDN7WtCVQ2oijwXnCdNBFeDNe
         8Kfvwvx61TPCZ2eseJob0D4bggd1sKe+zO4TuXwa6XJeCWX36w3wiGeZWvAIkp55Ytaj
         /Yrbr64jRw/ZIVEqgRM9Jr1idwzMvZ6dk7uAuYN3jvmjwZgpLK5Bg5PSlNdwSX0qv5UQ
         xVkA==
X-Gm-Message-State: ACgBeo0qjqxPpsPVyg+e8USbrv3YJ8v2T9wFW0tI5JA+RsA4uSA6g4JC
        lv3+feakabiKWsr1+mBBZMM5vw==
X-Google-Smtp-Source: AA6agR7f7dwanjYpEbjx2VufVCj+4oz4IFATBDBtRwOoC0bEAehgEene0qb5B2gm0Y13e+MUYyqOLQ==
X-Received: by 2002:adf:e28c:0:b0:21e:660e:26aa with SMTP id v12-20020adfe28c000000b0021e660e26aamr13777281wri.345.1659463110904;
        Tue, 02 Aug 2022 10:58:30 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:30 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 02/11] spi: dw: add check for support of dual/quad/octal
Date:   Tue,  2 Aug 2022 18:57:46 +0100
Message-Id: <20220802175755.6530-3-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Before doing the mem op spi controller will be queried about the
buswidths it supports. Add the dual/quad/octal if the controller
has the DW_SPI_CAP_EXT_SPI capability.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 97e72da7c120..77529e359b6d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -488,8 +488,23 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 static bool dw_spi_supports_mem_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	if (op->data.buswidth > 1 || op->addr.buswidth > 1 ||
-	    op->dummy.buswidth > 1 || op->cmd.buswidth > 1)
+	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
+
+	/*
+	 * Only support TT0 mode in enhanced SPI for now.
+	 * TT0 = Instruction and Address will be sent in
+	 * Standard SPI Mode.
+	 */
+	if (op->addr.buswidth > 1 || op->dummy.buswidth > 1 ||
+	    op->cmd.buswidth > 1)
+		return false;
+
+	/* In enhanced SPI 1, 2, 4, 8 all are valid modes. */
+	if (op->data.buswidth > 1 && (!(dws->caps & DW_SPI_CAP_EXT_SPI)))
+		return false;
+
+	/* Only support upto 32 bit address in enhanced SPI for now. */
+	if (op->data.buswidth > 1 && op->addr.nbytes > 4)
 		return false;
 
 	return spi_mem_default_supports_op(mem, op);
-- 
2.30.2

