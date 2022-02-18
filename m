Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D04BBA59
	for <lists+linux-spi@lfdr.de>; Fri, 18 Feb 2022 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiBRN7A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Feb 2022 08:59:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiBRN7A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Feb 2022 08:59:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353752B04B1
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 05:58:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so15760860edn.0
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:cc:content-transfer-encoding;
        bh=UzA7BmRI9hk0xBkLCSbXXeOCfpQjshavBf6kAMg7AzI=;
        b=py+upQw9pkVjefX2TMh48r/uyjfCfVmWwlH7CFjCwR4RJAPJunR3UCaoYSVTjXP+LK
         L65GOhxMPxtaMnn6KPdRWboHcvbRJaSMCR6XJrsXMMOLoKyhTA1pYKPGH74OGW0ebblr
         YAoQfZRBLhftXaiQ+UjQakmSvj+F2ob8m0oQHSjE/exH0+fH6zqCqqUlFSh95MTDl+Af
         TDMFwP82R83f7f5oE7aQfUwQ0YK4CJEKmQ3WArcy+qCg65NQdHDe89wRlFTJDtfbnD0l
         bc0S7HFcLwzcJLCc/khZVil3zUBm1Zb36IwHVduCUOC6dF7KZf8qcyzdr2eo5OvFMpTT
         T4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:cc:content-transfer-encoding;
        bh=UzA7BmRI9hk0xBkLCSbXXeOCfpQjshavBf6kAMg7AzI=;
        b=vkdhn8+bndvcOxGE2GmOuTF/71cM1IuCjhEsEyWEyO22X8DbanZ0+wdIcKZtS1myQk
         s2vuSWP/ynnrHoXJW0zmnrNOKsGNzwZbsTG8txdtG47EyjBGo41wsUetoccGXMStnidQ
         G5VfIn0Jlywwo/8qPlKRM6Pso960OmLZXp7c8XsX5JoG6yWk5pywJGlPSRSCyJAMjzMU
         kZJSy8eXNSwEQ4zGpdaBhNKg7V4gjj+Xm6SOcdZsUVZ7HiT3bZZMHium3DT7It/dlJvN
         b0dR2jI1XpZc9+TuQfTh3JKcfA+3GSn6ATkSTxNJUAHWbVA9BmBcrbPdomVTJcIb4bXp
         XJNg==
X-Gm-Message-State: AOAM533BRjIeSOrji4HerNN0t2kJ0NNlf4VHz/Pne58hq4VX9wwuTm8R
        1InAV2ajmrwDXCmhcJgDGMX5iY6YidY=
X-Google-Smtp-Source: ABdhPJxb7SJ83RtD5yK2qP2YKvFtVNgkfnNNzyQRiybr+GgPm1/jNHg9vCZmekoxs9rRWH9rFIk6RQ==
X-Received: by 2002:a05:6402:27c7:b0:412:80f9:18af with SMTP id c7-20020a05640227c700b0041280f918afmr8290512ede.127.1645192721678;
        Fri, 18 Feb 2022 05:58:41 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:fc38:19f1:71d:d4d0? (p200300ea8f4d2b00fc3819f1071dd4d0.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:fc38:19f1:71d:d4d0])
        by smtp.googlemail.com with ESMTPSA id 29sm2331020ejk.147.2022.02.18.05.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 05:58:41 -0800 (PST)
Message-ID: <56e1588d-d53b-73e9-fdc8-7fe30bf91f11@gmail.com>
Date:   Fri, 18 Feb 2022 14:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESEND] spi: use sysfs_emit() for printing statistics and add
 trailing newline
To:     Mark Brown <broonie@kernel.org>
Content-Language: en-US
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use dedicated function sysfs_emit() that does some extra checking,
e.g. to ensure that no more than PAGESIZE bytes are written.
In addition add a trailing newline to the output, that makes it
better readable from the console.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c98c55f44..fae290a33 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -144,7 +144,7 @@ static ssize_t spi_statistics_##name##_show(struct spi_statistics *stat, \
 	unsigned long flags;						\
 	ssize_t len;							\
 	spin_lock_irqsave(&stat->lock, flags);				\
-	len = sprintf(buf, format_string, stat->field);			\
+	len = sysfs_emit(buf, format_string "\n", stat->field);		\
 	spin_unlock_irqrestore(&stat->lock, flags);			\
 	return len;							\
 }									\
-- 
2.35.1

