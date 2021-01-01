Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3532E84EE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAARAb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 12:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbhAARA3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 12:00:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8AC061573;
        Fri,  1 Jan 2021 08:59:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iq13so6293577pjb.3;
        Fri, 01 Jan 2021 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z6qbj8dgzROgh85miZBetCRcFsAMjj4rAUBFqdmQKAI=;
        b=tzzmbhnLanGifpkaEEuhMbq9nyVrZwGiezeyUg07DWbmSZBnrgr1HBe8d81xxwHD6i
         knswbUeHIFzwDFLdQ1euU3vIrCOW7O3Lf1Vu9ARrKIBTln9nU3g+tW3tzfBodrhf54Fi
         JmQRUdnEzTVeqeQofJI3pcqe4UkQ9S0EoMl7OcnNuD+yreAIgJF7RZ+Rk1dKrTUWWnle
         B6FPquXJVU2OsZqToQJtG7YVZkyPmGvN8Nvo3+Y2AvketrSmeP/DKIEMj5ZzB8+vXCX1
         EuCR1SM9D0RjyHf3aAvEQM+/orr9w0z4fuphU2WonoZxfLlH0+g67Qrc8oF+jVZI9M4r
         ctMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z6qbj8dgzROgh85miZBetCRcFsAMjj4rAUBFqdmQKAI=;
        b=szutbNbr5Rt8z8HY8JGHSqZBgi/0Sm0GCEkf8fY5pEDGBHsZwsEf05k7rgk4Zg6hVh
         GR8CTibHR5jRSlyQd+EYHgrfCJ/F0ZaTb0L3pqOiVMaULU+lRq5VfwDl58eUeHO7Bz1a
         8hih8nAwjeKJq3DD+fxP6CpaT94iS2APFZmWyEA9yuSIaBqZbl3YBPfpfXEwM2O+9UAg
         hekhflp+md3QaRWr6SPk0ZYB9ZRWVBplUof+VcsuAxaIasqb7KeSGfQKb/eTHI1mRPfa
         cBPO80esWTV1M7u/1m0dBLI1kcbrgzrXIeri5k9iPwFSJ1IrmKC3jLXh4RJjHxjPamKK
         1itQ==
X-Gm-Message-State: AOAM533a06wM5B5y5oOsZ5fPmFePA4p/rs9hZKbaxBrhAv10Ck5RmOdY
        LTjV2JZXUNedXjDu3iuFwlI=
X-Google-Smtp-Source: ABdhPJzvKvhyQq+Adj8RaWYu975XY7J6amI//R0xez2m/CCUIqLkUExovMVLZ9HW3tr1oS8YMg71WQ==
X-Received: by 2002:a17:902:eb0c:b029:db:c0d6:6289 with SMTP id l12-20020a170902eb0cb02900dbc0d66289mr62277763plb.12.1609520388641;
        Fri, 01 Jan 2021 08:59:48 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:59:47 -0800 (PST)
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
Subject: [PATCH 20/31] media: venus: fix error check in core_get_v4()
Date:   Fri,  1 Jan 2021 16:54:56 +0000
Message-Id: <20210101165507.19486-21-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Don't call dev_pm_opp_put_clkname() when got invalid OPP table
in device tree, since we do this in core_put_v4().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index a3850261d697..59cbd6c39450 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -881,8 +881,9 @@ static int core_get_v4(struct device *dev)
 			core->has_opp_table = true;
 		} else if (ret != -ENODEV) {
 			dev_err(dev, "invalid OPP table in device tree\n");
-			dev_pm_opp_put_clkname(core->opp_table);
 			return ret;
+		} else {
+			dev_pm_opp_put_clkname(core->opp_table);
 		}
 	}
 
-- 
2.25.1

