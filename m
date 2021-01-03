Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C312E8A51
	for <lists+linux-spi@lfdr.de>; Sun,  3 Jan 2021 04:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhACD5M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Jan 2021 22:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhACD5L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Jan 2021 22:57:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7CBC061573;
        Sat,  2 Jan 2021 19:56:31 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y8so12651928plp.8;
        Sat, 02 Jan 2021 19:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MBqnkb35Yx+XB2qacn+GMSgP3vvOS1DmQn6mAoUxAko=;
        b=psBWJqf/IihlpGW8zhb4mDcJKjwQwL+Nm74dbHhamfsUrv4kpAP9nx7m6wtoHcGIyS
         zgIy24UtjbfcuiB2Mq4FZXNkgeSVJ4YOCeiwYZMJ4w92AXNzd5SxxAPhquqd1v0gzfg1
         HKOxUvEoAAh/RqZLi7RJ+71UzMgXpnf3dGjA8q0fBY/dEsVhDAOER88azzWmRrKET8Au
         tBuEC+ePsePrdQ4WUIDmL+6lq96tHi96QNj+AUyarqZZGd+ntX++9/Xjfb4ZcANVlotm
         +3c0UsB9ziguJ86i5zONeSBsCLuU+6efKECn0W0P1t3marpfQ+gh0BDh2kyVAIBBkYv2
         IifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBqnkb35Yx+XB2qacn+GMSgP3vvOS1DmQn6mAoUxAko=;
        b=qytf6gFji12GeHQVW+hlyBD5JiDo9hozdYM5xmGls/cRlV45TvPHqVnSFL2y+I4ZEc
         QMUp1Gt4CfydDHjnNeG1XobB4f9UWIiT/HEIT5NdnQ8XISbc3hFbiOGQD32VSNhBIxLv
         SzMfNBToQHJVtvkhY5faI94Xd3FyidP32eHXYH8GF9MDZuHgaOUHi+bW53V7xoFalU4O
         +HoZanTSNoefVHsqitwh1Tc9qqCLeKq1dA+h7XWiKnBYpSh9Keiy3j3GuUVNBmI9kZwU
         90+0R7BWkz8lpX8MsER+jTI8btc871GbCW/53tKwAWBE5Nld5dn9JsBmiqZSi4D2Guct
         OLNA==
X-Gm-Message-State: AOAM53123Ba2PmyqdrJC4ZoSSEOow9/hcj9lf5EJVbU3c40e+aIlp1fh
        mdBNMs7nLt2b+WqbY4pfIzw=
X-Google-Smtp-Source: ABdhPJw4rLAK7aVKo+4qowfteGr9aQhB933bY7H4Pkd1XY5luUUGGANfZdnT+MeSUMumccO7HG1M0g==
X-Received: by 2002:a17:902:6ac8:b029:da:d645:ab58 with SMTP id i8-20020a1709026ac8b02900dad645ab58mr45836977plt.25.1609646190921;
        Sat, 02 Jan 2021 19:56:30 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id i25sm56066998pgb.33.2021.01.02.19.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 19:56:30 -0800 (PST)
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
Subject: [PATCH 29/31] PM / devfreq: imx-bus: convert to use devm_pm_opp_* API
Date:   Sun,  3 Jan 2021 03:56:05 +0000
Message-Id: <20210103035605.23973-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_pm_opp_* API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/imx-bus.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 4f38455ad742..ff26ef049b1b 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -61,7 +61,6 @@ static void imx_bus_exit(struct device *dev)
 {
 	struct imx_bus *priv = dev_get_drvdata(dev);
 
-	dev_pm_opp_of_remove_table(dev);
 	platform_device_unregister(priv->icc_pdev);
 }
 
@@ -123,7 +122,7 @@ static int imx_bus_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, priv);
 
-	ret = dev_pm_opp_of_add_table(dev);
+	ret = devm_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
 		return ret;
@@ -141,18 +140,11 @@ static int imx_bus_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->devfreq)) {
 		ret = PTR_ERR(priv->devfreq);
 		dev_err(dev, "failed to add devfreq device: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	ret = imx_bus_init_icc(dev);
-	if (ret)
-		goto err;
-
-	return 0;
+	return imx_bus_init_icc(dev);
 
-err:
-	dev_pm_opp_of_remove_table(dev);
-	return ret;
 }
 
 static const struct of_device_id imx_bus_of_match[] = {
-- 
2.25.1

