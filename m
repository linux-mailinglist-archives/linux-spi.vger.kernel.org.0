Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238BC31310C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 12:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBHLix (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 06:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBHLfQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Feb 2021 06:35:16 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B04C06178A;
        Mon,  8 Feb 2021 03:34:22 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b14so377942qkk.0;
        Mon, 08 Feb 2021 03:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c7/ro2vJNlZ1YPxBzjYpBjlaYBZBnvlVnHyBqp94XA=;
        b=sxFqmqcW1AQlLTPNsfY1Ovcf0Z8TJ184KZ+gQGe10cLczSttIKdWBkbmMG33gcF1Zy
         T6m2xulS5HFazdWSljvg3LrBAnwVAkC3DmxPVCtWzSNubb/j5xjA1N5Bz0jRagDOaByD
         WDAIBuflZKuECMQFaPUzsVLwq3IogLiSZHdtEHu/rWiRKT0wnOUaF0cyJNdZ2OZwjeQ2
         vmhmZl9X/EBcRyBpb4KDlLNjIDrsjWzmJ7EIF1hGrcig0Yi5UJhxWh5/zeld9jmx32hB
         b+DcYaa8uSa0ca8t651ZRmMAlnHRv4/MQhA+mps+aLtfTr6TrDozsMfPLqAfDvcNLrKT
         EZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c7/ro2vJNlZ1YPxBzjYpBjlaYBZBnvlVnHyBqp94XA=;
        b=jIRmcHY4oxxi2T6aKOD7Fji0JPapQRKL515PUhyIQL/rUgxKmxFHFz3UwPipyBmjiT
         sVd/tyiE7zlqiHjqmYSAjKUnoXxdYmizPRmYmk5EZcotwrqd5vl0CFZlzZ7Ek+zrPa2Z
         Q+YBqiWelDtC9hKq31zSTBWOPhYNvTtQ3KRk/RuV8/fuZaZ5yLHI8iwAmym4E9XD226r
         TiDPjONOt7l/UQQreaDt/pwYkktmPBQjqxc88QNMpcpQQrnjJRcrjA78AmUEKiLqZpsj
         j9Rv68I5+LQkG3po5FHh9tJ20kvyCjb1cl+bY5FbMLxuQbu0H5PCyHscWC7eN2SrNLu7
         QULg==
X-Gm-Message-State: AOAM532TtpJad+0beQ2JGKcQfF7j7gc16ZYKWNbZg+EgntD5IomkPRU2
        iwqXoqag7cK5PRKhAbQ0+yM=
X-Google-Smtp-Source: ABdhPJxaWBNV0Q3hng7qIy1PlfOBk1uwF1Lemg+xSAYoj9DWTJVKaFqzfhm+LsQF8VKz3S/5ZEC9WA==
X-Received: by 2002:a37:63d4:: with SMTP id x203mr16066014qkb.105.1612784061917;
        Mon, 08 Feb 2021 03:34:21 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.175])
        by smtp.gmail.com with ESMTPSA id i15sm16862613qka.103.2021.02.08.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:34:21 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: linux: spi: Change provied to provide in the file spi.h
Date:   Mon,  8 Feb 2021 17:03:59 +0530
Message-Id: <20210208113359.31269-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


s/provied/provide/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..2cd4bf488ecd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -624,7 +624,7 @@ struct spi_controller {

 	/*
 	 * These hooks are for drivers that use a generic implementation
-	 * of transfer_one_message() provied by the core.
+	 * of transfer_one_message() provide by the core.
 	 */
 	void (*set_cs)(struct spi_device *spi, bool enable);
 	int (*transfer_one)(struct spi_controller *ctlr, struct spi_device *spi,
--
2.20.1

