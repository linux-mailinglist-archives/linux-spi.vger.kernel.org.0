Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF3463F0E
	for <lists+linux-spi@lfdr.de>; Tue, 30 Nov 2021 21:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhK3URF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Nov 2021 15:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbhK3URF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Nov 2021 15:17:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE7AC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Nov 2021 12:13:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i12so18516199wmq.4
        for <linux-spi@vger.kernel.org>; Tue, 30 Nov 2021 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=zD/t993/NyxzRnTokWaGCkfhn86ThJgcF3B9bfrki4E=;
        b=B0nh1TjaXr264pLI7Sy3fAaey+c2/U/U6VTS0qxQj80lMsAVVrkoUNRrvC8TOHTYXr
         4O2YbyY0JOcyIRtCXSnoqLTA9Kpv4ZuEK8E3Ec8jQyMVS2WEwHn9qNh9+0tZAH5CuI/a
         caynIzj6obe3/eyeBjY0wGp2ZAybboq3RSAW56181dTRgRp9lmw8JAPMBscciO18NxmY
         22lHfXvd9TuwYZJsAv5I50Y8mQuiaOk2y4LsfTTEpfh1LXvCzZLO3gHgpa1zdWvwfF8H
         VR7yk3xwEcF3v7aAmxhh+KzJzDs3LwGRcwb75Q69cmrIxaNekf0TCU+HpBU/TbErK2C2
         YCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=zD/t993/NyxzRnTokWaGCkfhn86ThJgcF3B9bfrki4E=;
        b=SMNiexICA58+zRtX6GwW6YvdOKdy1aMYgOhN/7yrcOyHTF9zm7C/eI+dO9Ga9SD1cc
         NSitCQViWjhXwEf/sDbOVLz5UDxL2Q3qWwCIzBNLBYqC0O/efipY1aX3ygUp8n/HJXJ7
         swmWOPxNjl3r31yzk5ZLixJRoIklScdDIDgANSLfuseB5lZqytxfg2/Ws/ygRHcyinHa
         j3Lb7EnXyYt9uosct14c9JnSrwwPL5mXrJE0K9bFsVWTv6oBQTbFbzRCSV1kDsJdt7zn
         juhgGgn9WA8kNzpY0dq6SbtElG/VHcDsC8I4DLGMVFNBeLQG9IrRkNPl0vCHLYYKrXGG
         MUOw==
X-Gm-Message-State: AOAM530h03HZZ04G1IMOq10pctVGtyL9bKWVxzrS38xOcFvoAq1zmFdH
        mwxLCNyBxSkadvqNjxK38aA=
X-Google-Smtp-Source: ABdhPJykkWJmO/AmD7m8xDxXvT/Dn0fRFwF1cG/BwDGo+bULo9NERvDJkG3nABnB0iZvLAPJJrlhAw==
X-Received: by 2002:a7b:cbd8:: with SMTP id n24mr1108817wmi.150.1638303224265;
        Tue, 30 Nov 2021 12:13:44 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:cdea:1258:1cb4:5e92? (p200300ea8f1a0f00cdea12581cb45e92.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:cdea:1258:1cb4:5e92])
        by smtp.googlemail.com with ESMTPSA id w4sm18078175wrs.88.2021.11.30.12.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:13:43 -0800 (PST)
Message-ID: <44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com>
Date:   Tue, 30 Nov 2021 21:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] spi: fix erroneous logic inversion in spi_match_id() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We want to continue in case of a match. Fix the erroneously inverted
logic.

Fixes: 3f07657506df ("spi: deduplicate spi_match_id() in __spi_register_driver()")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/spi/spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5bf680fcb..4578c2fb5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -471,10 +471,7 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 				of_name = of_id->compatible;
 
 			if (sdrv->id_table) {
-				const struct spi_device_id *spi_id;
-
-				spi_id = spi_match_id(sdrv->id_table, of_name);
-				if (!spi_id)
+				if (spi_match_id(sdrv->id_table, of_name))
 					continue;
 			} else {
 				if (strcmp(sdrv->driver.name, of_name) == 0)
-- 
2.34.1

