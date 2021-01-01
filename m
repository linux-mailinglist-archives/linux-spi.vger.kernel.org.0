Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86D2E84E0
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbhAARAF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 12:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbhAARAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 12:00:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F84C061757;
        Fri,  1 Jan 2021 08:59:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i5so14759655pgo.1;
        Fri, 01 Jan 2021 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cYbuTbPahXxjzBKxhL5q3gV0giw+VU+SyFZg9kX4GMY=;
        b=PcGSIVgZm1QkNmbFXTx6HQATJc0uJhNwjGfiUzGg17YjZStOSQVciFoKHkgmRYd3IK
         g5kkL47cUsAkoxnLSFzDtOVj9vJrCQCw+D4vc4jainD1pt9Y1YsmVihYnVt3nVbOQt0r
         KFNnDkGQkq2qaZ6q+jNYYAspKa0TrVHIQDRQlf7sz1rP/1hprQRWtzaz1A65MhDNBMdN
         uGc8WjB41Pp65sQk29saTeHfdD8fyvnoPhE3RxgbpbaDWFGXXyFfQUhnmsZQxNAIyPcm
         2CdEKT0iZMzkXVrszFNJLBIWD0Z/VC75teo4dAHjc7HaIElt0YC8qqBC7eos0xAjst1n
         MyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cYbuTbPahXxjzBKxhL5q3gV0giw+VU+SyFZg9kX4GMY=;
        b=eydX1oAUTltjbsPy3/V9nU2dMDNLUk2XMYvofQHF+sNek6j0fGe0uyQZd09CSiVMsm
         B0Fab7nWvwhkx1g5QtoWxeF+U9k6kU63qin/zFRBT5ZW98VrMIiMP6bIeCHlMGy0w6oj
         oD7Hedu4xUYeokPhTJJVR56wYrV/8nTaTCsMXXb3f6tkKY3qDrFkcuMm7MXUPCa0gWET
         CQAqSz8Sz24lkPLhzvXuD+mzaPKjPftN6oRz1ONuzJzyeWfHOklESD7Npod5kalJMv1f
         qQAor7couHhQRVh+XGUWY+nQZ0WwheV66QguOukHvJEkIH2ypN9ZNUbSGvSvXwKYzFAg
         aqog==
X-Gm-Message-State: AOAM531CFLqMPBMShvVnK1OWoV/I491eekmniz8kG4iGcPsh4XjEkJeQ
        50VgGMmfN+2xv3KUZPHOzto=
X-Google-Smtp-Source: ABdhPJzBxZnugCfohpOfZRma7u6PqMQpyK3PxPlNGZ20GA0zdzVpl57siWqjfJSY1kSGIemvsTRnQA==
X-Received: by 2002:a62:145:0:b029:19e:a395:bd3d with SMTP id 66-20020a6201450000b029019ea395bd3dmr55173035pfb.13.1609520363720;
        Fri, 01 Jan 2021 08:59:23 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:59:23 -0800 (PST)
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
Subject: [PATCH 18/31] drm/lima: remove unneeded devm_devfreq_remove_device()
Date:   Fri,  1 Jan 2021 16:54:54 +0000
Message-Id: <20210101165507.19486-19-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no need to manually release devm related resources.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index d5937cf86504..7690c5c69f9f 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -94,11 +94,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
 		devfreq_cooling_unregister(devfreq->cooling);
 		devfreq->cooling = NULL;
 	}
-
-	if (devfreq->devfreq) {
-		devm_devfreq_remove_device(ldev->dev, devfreq->devfreq);
-		devfreq->devfreq = NULL;
-	}
 }
 
 int lima_devfreq_init(struct lima_device *ldev)
-- 
2.25.1

