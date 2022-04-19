Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA198506AB4
	for <lists+linux-spi@lfdr.de>; Tue, 19 Apr 2022 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351506AbiDSLiC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiDSLht (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 07:37:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6F1EED4
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 04:35:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so32273415ejd.5
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZB4AAiYpghp+j0HlvXqcm6S1oaOh86fqoD06sTrQvg=;
        b=EpULbiMcIyvOq1eTI1FkoG7wHTnnsB+t3uW7Gr9XJVTSv6M+N6+CpqVJ4tX3TkCJmj
         sx+dBtweIzXDc+/elWAvba2OBrbAX04zVGMt+UVOEGyNqFedX1c7G9LuvmQ/ozIthkTq
         Y3/IDX3dscPP1/B9ADdZKVAGu6XTtAEaCHeesCj2xtEjHqF5DWbZVPStC3571/pmn2Bq
         Jc6N0AFyt8OgU0gUmyQ0UxOeUpTVrV+LWpEZXyanIUvvzGU7ES/Sw3k+CIBiihhHS8LF
         G+8pz++8wqbv055aZZ2wCgi1Pz812gH503ntSZGp5dxdbkotFOTkn+daw5aiX/a4Di1V
         uI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZB4AAiYpghp+j0HlvXqcm6S1oaOh86fqoD06sTrQvg=;
        b=1hALXTXw0XhBUafTiL/nCdtOB6Ngjw/zaGaXntB4eKBqPahgsBGvB/kdxEa531UPTm
         1Tb6UghWwhyzSGor0vs04MOW7/8Veeo8PPoPkQdOHLBG1eKWLEulVmk/bMesr2Occ3ZC
         rtqx29iUafQVTgABK52JR58JmGrSCb1ce0HqvveSNXJ1sPV+T1TCWBpPoX4c5apjo5C3
         bbwb6+6eqbkHxXx97RQCXzSUgi9flndsWGo0gj3s6er8BrTE3cUHo8fgn5T3oUkYhGcl
         7NDGFxXFZd1XVMyh6jzMi40lH0uTdF059OL65bqiakzJIg6cDPqPsKegD+0Njo/JpPx4
         taiA==
X-Gm-Message-State: AOAM530niW9EAcVWZcHh2Q0v+knw09kpqnN0/PQlnUx1zHMQLtt3X42t
        88X9SN4FZM41gY6fFjsEKid1oQ==
X-Google-Smtp-Source: ABdhPJz5IEvGiK922/vJClBDi+mKcO5SsMUlVd7BXDUmO4dQvqIub6KWUVkwOaaikp1xnTNTPgx3tw==
X-Received: by 2002:a17:907:7e92:b0:6e8:8df7:cf92 with SMTP id qb18-20020a1709077e9200b006e88df7cf92mr12502150ejc.541.1650368104852;
        Tue, 19 Apr 2022 04:35:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:35:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 11/12] rpmsg: Constify local variable in field store macro
Date:   Tue, 19 Apr 2022 13:34:34 +0200
Message-Id: <20220419113435.246203-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Memory pointed by variable 'old' in field store macro is not modified,
so it can be made a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 79368a957d89..95fc283f6af7 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -400,7 +400,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
-- 
2.32.0

