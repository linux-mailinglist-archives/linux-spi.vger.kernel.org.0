Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D36EE364
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjDYNpj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjDYNpi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 09:45:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0815A1447E
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 06:45:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-953343581a4so860756666b.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682430334; x=1685022334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRgabKLq7eTacDKoRbI9FK/SG7BfFMCRKhP9HGH7/VI=;
        b=DpdsldsksNbrlYrHx72q3FsmVTygzQ8+ILEy/6Z47oNp9+CIsnm7sxSovUbiQbZgg7
         imHgDTz+AF0pXiJXTeaGHUgYJ3ib0U2en5rmsPCF0yP23sLsX4UntZCS+HMGFgBqxlkA
         Cj5e7wrWZ+8OKjCeMrv7BQItLrjPiqb0hugP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430334; x=1685022334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRgabKLq7eTacDKoRbI9FK/SG7BfFMCRKhP9HGH7/VI=;
        b=F14w9f7NyC3aNNSVASmBw0rtRh83t4F6lYV+yz/9aFhjLwpdOPW5LD47WHyCYQiq65
         AhTjd9WLc9QjSv7SWsOzWTwA2Ydkd/KmauIR+Iwx6uAJeOEFhIfUsv/iQMEEN0vWMIrC
         p7LFZNdCflxfO5ZYapZi7dC9WJUVYnA2/gaJXGNjFcTjOGegKGjOZC0cMTx4Rx31YtoS
         SRhcqyNcfG3A8ZfTClBNm6mp6B67B0l44rodEUduXwUynhxOvugPVSOJtm0J8oVu2D/Z
         iJfQiBKoFlK09wW3B68ZoXru4bWttubIwyL6+8KU9BWF5THtHAbJrla45VjJK3WQQKOo
         C0sg==
X-Gm-Message-State: AAQBX9dmhAUU8fvA+CHyHR3W06NPjbdhURZLuVfqyg5mao7ukIfZrBlS
        4K0jsEjZcTnGw/nw20JcqMpq4XGIOq0Ibagsji+WD0BG
X-Google-Smtp-Source: AKy350Z83jsGizwNJRA+mohLxhjiEvtuoiSejIRimuqtdjKMN2jPVPuP7+Lhh1bC8E1iH8chq3akuw==
X-Received: by 2002:a17:907:7e9c:b0:957:28b2:560a with SMTP id qb28-20020a1709077e9c00b0095728b2560amr13750121ejc.46.1682430334339;
        Tue, 25 Apr 2023 06:45:34 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906048a00b0094eeea5c649sm6806822eja.114.2023.04.25.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:45:34 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: spi-imx: set max_native_cs for imx51/imx53/imx6 variants
Date:   Tue, 25 Apr 2023 15:45:26 +0200
Message-Id: <20230425134527.483607-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ecspi IP block on imx51/imx53/imx6 have four native chip
selects. Tell that to the spi core so that any non-gpio chip selects
get validated against that upper bound.

Also set the SPI_MASTER_GPIO_SS so that the core verifies that, in the
case where both native and gpio chip selects are in use, there is at
least one leftover native chip select (or "channel", in the ecspi
language) for use by the slaves sitting on gpio chip selects.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/spi/spi-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6fa53a82674a..e8f7afbd9847 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1749,6 +1749,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 		 */
 		controller->mode_bits |= SPI_CS_WORD;
 
+	if (is_imx51_ecspi(spi_imx) || is_imx53_ecspi(spi_imx)) {
+		controller->max_native_cs = 4;
+		controller->flags |= SPI_MASTER_GPIO_SS;
+	}
+
 	spi_imx->spi_drctl = spi_drctl;
 
 	init_completion(&spi_imx->xfer_done);
-- 
2.37.2

