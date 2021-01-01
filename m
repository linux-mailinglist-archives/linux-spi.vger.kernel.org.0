Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7672E8495
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbhAAQ60 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbhAAQ6Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:58:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17733C061757;
        Fri,  1 Jan 2021 08:57:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lj6so6298080pjb.0;
        Fri, 01 Jan 2021 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tiWxikxPuWX5qrSsnG3gylr8SLwIWwlDgkk1TM03GZ8=;
        b=MnbYXRNcvlxfSbkvfcPK/n4tGcYIzBuapQ7RmCOI8N22yFh7Q4xtFIHESJQjSBaFY8
         7ckmMWlwLam1mDcDw7+9zBiuMRRhtBGoJDlbQPI/1aMYW2+IvId/CD2hge4uoPtyKnCL
         DTFuHKA/o6mIdFmvtA4/xiSgdj8++GrPaXtFLaICWYgvOJzZmCqeQfiA98iutVtmhA6/
         /7JaAvxRXdo1s0aIpNDSlNw8iHxAI4oDG6AkAEHgXmmVLNR5Q1KqtZXL6ttQVfl0hQz1
         nsDuMCwd9IbchLS308FbcH0V3l4JKXE3idGACIqp1oLXnOPpLsA0ZOHbA1oEg0BVFKGx
         Vc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tiWxikxPuWX5qrSsnG3gylr8SLwIWwlDgkk1TM03GZ8=;
        b=BvFPLEq8a9E6LkaGDY/nhVppAQW1EFmYy9fCuoSbHWahtp7zmCpyRSASMzFp+Qniy3
         iyCkJ8Dog52YN+Or/nTHkOgAqLtD76qm1irQ8pCWw7aWDMpLT8VnWvyJotQr7xg4Dlz7
         00SAgJLHzaqVJsBcmefM33ZGZ7/raFi1R7ifDXlzzmmMMwrGMeeJtX5ZxRYccmAtxcO3
         DiJOSgTz+v7Oe1j0GHZ70Ztn/QAvT227i/vSU9WThAL0Iq5EipYOhkw3cBKOaKQBBFNv
         1kI5kR3MOXchQZ0dznKkVnLKiVdT0Djnu6sgVUOwRJWsNOAmcgt5N4dKW6msSW9YndXY
         gDGw==
X-Gm-Message-State: AOAM530sQ0aBaRmaD8vsnQmK08+IMvt26FLdWkknFEwn199ZMYGt8+rH
        kRxswfZbG6YWxD2Y2PnoIp4=
X-Google-Smtp-Source: ABdhPJxz+nZU443EFCLWHTCQctcygBPdBe6EDrDrvOT6er4vAak3Hfyleyc/B7CaVd9ruLyg4w0AZw==
X-Received: by 2002:a17:902:c195:b029:db:c725:24d1 with SMTP id d21-20020a170902c195b02900dbc72524d1mr62207622pld.28.1609520263684;
        Fri, 01 Jan 2021 08:57:43 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:57:43 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, tiny.windzz@gmail.com,
        ddavenport@chromium.org, jsanka@codeaurora.org,
        rnayak@codeaurora.org, tongtiangen@huawei.com,
        miaoqinglang@huawei.com, khsieh@codeaurora.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        groeck@chromium.org, varar@codeaurora.org, mka@chromium.org,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        natechancellor@gmail.com, georgi.djakov@linaro.org,
        akashast@codeaurora.org, parashar@codeaurora.org,
        dianders@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 10/31] qcom-geni-se: remove opp_table
Date:   Fri,  1 Jan 2021 16:54:46 +0000
Message-Id: <20210101165507.19486-11-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

opp_table isn't used anymore, remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/qcom-geni-se.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index ec2ad4b0fe14..cddef864a760 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -47,7 +47,6 @@ struct geni_icc_path {
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
- * @opp_table:		Pointer to the OPP table
  */
 struct geni_se {
 	void __iomem *base;
@@ -57,7 +56,6 @@ struct geni_se {
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
-	struct opp_table *opp_table;
 };
 
 /* Common SE registers */
-- 
2.25.1

