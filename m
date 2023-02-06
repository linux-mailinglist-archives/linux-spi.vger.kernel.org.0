Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BA68C06C
	for <lists+linux-spi@lfdr.de>; Mon,  6 Feb 2023 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBFOrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Feb 2023 09:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBFOrr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Feb 2023 09:47:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46A244AE;
        Mon,  6 Feb 2023 06:47:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id z13so1377953wmp.2;
        Mon, 06 Feb 2023 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlUDZuWPTmEW3GESVUk2tU0QMqPqq9v66MS0b2A/TMo=;
        b=TzhojKmqBOVC5I6j53ngbduICfBD0cZj2DIFYaUvQNRlNy2+YOSPn5tERYuoEjLFzC
         0oIAkAd2sqoIzAA/GapZRYosqLlEuEk65pKepw6zWN49U6gIE9f8Cn5GGdYFBnc3YXnb
         QpId3pvCuwL5JZ27bfRvSj8emysfusXgRc3FuBXOlQHlgwLkNArPpvMqdNxqYMCOWUun
         wm1uElVK4XKI/ZN1HVNtP+yu28X0GZB+IdqqPWbhciVX/bTurSwbc+NGQD7rJFfvQtK/
         2mOXba2Dh8WEEY5oRxM37ySLDljh1puwdwLttuPqesi2Mav0AORdgeTabXG3MhUiFcu4
         z4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlUDZuWPTmEW3GESVUk2tU0QMqPqq9v66MS0b2A/TMo=;
        b=dPDUXVqI6/mSlGbKoebgxBs5UrLmoCTfIqoCPNvLNeCv1lCKa7u54m1839EhRIVaL3
         tvLu3bdvPHktVnJrfZYoljpLqB5cE7CuRtG1CZRT2wVh2nnq+WcFioEFvG8iKSs+duMG
         nljffbqB686qqYSnBxHJrvfq/6soaFa4NNK/xOQyAgVkQ5BA9nRbQBi7k7f9tW1kOrgc
         XX6BbNjEIcJW13zv7/RtB+sz+jMhYYq1o99fRyx8iMPZgJqV5AP337iLd7METtR9HopC
         h4+3s4twcv2tYTcsYyvZNhIICj9Ew5t5BA60j1XRILXHXbS+MTxXTV4KYVNa4Z/roS0o
         O+/Q==
X-Gm-Message-State: AO0yUKV2XZly8zEq2UPFG5gUAGVfNzl4dZ/vOmoSAIXW7UDYTc1ugfQQ
        pa6Tqev0aikxjsiXon4qNUmh0NIAtyE=
X-Google-Smtp-Source: AK7set9JcQUJrXJS6sAOExapFGEhkCgtpqGtNmN+jKi0jinK0UpKGUMt+hXgCv/U1bkehJjQ1VenHw==
X-Received: by 2002:a05:600c:3b9d:b0:3df:de27:4191 with SMTP id n29-20020a05600c3b9d00b003dfde274191mr15683294wms.16.1675694862019;
        Mon, 06 Feb 2023 06:47:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003dc433355aasm11740638wmn.18.2023.02.06.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:47:41 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:47:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: spidev: Fix double unlock in spidev_sync()
Message-ID: <Y+ETCk7XKfAy8yWQ@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This unlocks twice due to a merge issue.

Fixes: 35bba23e6732 ("Merge remote-tracking branch 'spi/for-6.2' into spi-6.2")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/spi/spidev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index f836567c631b..5a038c667401 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -115,8 +115,6 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	else
 		status = spidev_sync_unlocked(spi, message);
 
-	mutex_unlock(&spidev->spi_lock);
-
 	mutex_unlock(&spidev->spi_lock);
 	return status;
 }
-- 
2.35.1

