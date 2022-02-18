Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643224BB90B
	for <lists+linux-spi@lfdr.de>; Fri, 18 Feb 2022 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiBRMW5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Feb 2022 07:22:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiBRMWy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Feb 2022 07:22:54 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52915299254
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 04:22:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qx21so14559898ejb.13
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=UzA7BmRI9hk0xBkLCSbXXeOCfpQjshavBf6kAMg7AzI=;
        b=iyJOgGeDCnevgCw/NhTsBynJNzDlpmMkQB4sY5keiVs//XBQkW2y3NqT307IojZm10
         eJgI1rRnhdJ2gaPJ1DSs2xOdMS0tTjxX3AxWWU/12LCjKiLjYfKHxKHDcPZFzdu03LPB
         NuuJu53gDwIgPj+0xQjLp0wrqaWIApErUmB7ttM47w6DakKNBRnhXlvcDRe9fDzob26R
         8mwBUxJg2mMMHHISj4nRB6otBzmiUc971Q1/iG0RjRp5ZnIZy0RCgT1Zjgl3awJI6lMD
         Ku/x36wHUaOoaK6GOh50Tf32V0C1VIBMrshToLc4y/pQcM+2P/xrvdVNAyheLYbM3txU
         r1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=UzA7BmRI9hk0xBkLCSbXXeOCfpQjshavBf6kAMg7AzI=;
        b=vNhxxkIuGibcOErdd37HZPsnEadMY9NLqXgNusW8rOC4nltnAJiqGcxbSHb10uOd13
         NCt2JHLd3cG9vVoMSEIbDU1YgC/TNcH6e61Dwsb3a50DAK4/66bQIX3Dv6vzZ1WGXCiz
         M7zBGjktX6W6RkdZXP2qy3BRm63HwMpDATNl9TVcRdmMYDNsdcmZa+mm3voSNz13gczF
         SsQExvSJqFN/t0HVUASiaeud96SbmJemc3utblCg4hsE1fFQgWRSW3zlk6r8Zn8H/UJX
         G6f7kwilrDZ6Zf/KOc7ow+lg10NIyQI8OCZ4og1Y3gR/K91gR7pevMAXl3Z4YESqaHoO
         lv8A==
X-Gm-Message-State: AOAM531vRy+snQjSScHckQ1p2LRMqnuvDP14Rfn2SXCHBpaMHmKqV8vy
        WEY11x6JgXp0lgSuTjtjHdPYBrCIBTc=
X-Google-Smtp-Source: ABdhPJzTuKWCRRvlX0kKB0M6iuXZ5+CLiAPgdjOqwF1iTUT+bhae7wEt0Cq+3AfOK/g7OBzyTyCbYg==
X-Received: by 2002:a17:906:2b58:b0:6d0:938:887e with SMTP id b24-20020a1709062b5800b006d00938887emr6020990ejg.644.1645186946797;
        Fri, 18 Feb 2022 04:22:26 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:bc37:63fb:bca2:6f08? (p200300ea8f4d2b00bc3763fbbca26f08.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:bc37:63fb:bca2:6f08])
        by smtp.googlemail.com with ESMTPSA id p12sm1714313edc.49.2022.02.18.04.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 04:22:26 -0800 (PST)
Message-ID: <9d622df2-be3a-5327-59f7-dbe51fb0be4f@gmail.com>
Date:   Fri, 18 Feb 2022 13:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] spi: use sysfs_emit() for printing statistics and add
 trailing newline
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

