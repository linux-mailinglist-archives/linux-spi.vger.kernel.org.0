Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D822E872F
	for <lists+linux-spi@lfdr.de>; Sat,  2 Jan 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhABLzI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Jan 2021 06:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABLzI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Jan 2021 06:55:08 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07BC0613CF;
        Sat,  2 Jan 2021 03:54:27 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 75so20981595ilv.13;
        Sat, 02 Jan 2021 03:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Qq+GLTn4BADYn1vuhlqiW5tj2PiDWm35nCUoUH25Vg=;
        b=RokTxsioHjCpvd2N2nznduslCUtMtMKzx6zh8OdnXL8UP1ojRxdYKlZ0td0/prQNRk
         ZR8f9dcRrEaCRVlJ62Bf+6lToKFhLRJ6JkKqG3w2QT80+r17wgj3s5fKip9C6O5QjuDy
         ZUjvfU9763kaz3pocGpOLU13GUOV/iYHV6Tnssvxb3/4VbGoSvy0kpXjOf2VFDqEDiXP
         qGEwK4G27W2TdjtuetvAwpoudyzpO7EkR1dTcWn2/JB3OsUtRtI9ncAv3wnZKsVzUlT+
         B33tUn5XBYz8RgeKCiZOwV6TBpeHvI/7sFb6OVpVRU4cYJV3Nn5WfqmKGvG0ly9IISMO
         Igqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Qq+GLTn4BADYn1vuhlqiW5tj2PiDWm35nCUoUH25Vg=;
        b=Jbu1nqFISjf8BGQHTNvbMW4MbpN4KJKLaR2LE/KywUBLf0ZFusG1vtnerwf2FYZHaO
         8T0ewQT76YarGgKms7Dfp4VAGakJvoIdK1UJ201EvZfbS52ec2stzdCnO1m2NHP3t7sM
         alwUdJR918cFwdggUsxRh+uybIPlV4lY7DJMYxuM+6V0suVS+rMCmFATOWNgT0FlYWO+
         DpgZfPsBth8UGfbrLCgqgfbW83c9Jl7ZJmi5Irz1meXAHtnQ7N7q5jj61iwps/11E26n
         uM8NibWtvyvxdUapyrmTD+c5TL747rUgOp+2aZb3VFJbN3A9regjbrVT7RzCI8bkCOHh
         5Cew==
X-Gm-Message-State: AOAM532G7Jjeanz4Y9kyrWztvzWqDl4py8N+o49B1qzBwi1UMZrT+Tiw
        R3ln+EDQeeufitZTa/VeJZUoz+WxUiR0aQ==
X-Google-Smtp-Source: ABdhPJwio/X63+t63EA/HmmRmNdLP1VxoAULq3vWicc92A7XWtUytXMXJ0eLW6Hj8OR5Tmw0EyXNLA==
X-Received: by 2002:a92:410b:: with SMTP id o11mr66712863ila.306.1609588466794;
        Sat, 02 Jan 2021 03:54:26 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id l9sm37218245ilg.51.2021.01.02.03.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 03:54:26 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, biju.das.jz@bp.renesas.com,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH V2 3/4] spi: renesas rpc-if: Update Add RZ/G2 to Kconfig description
Date:   Sat,  2 Jan 2021 05:54:11 -0600
Message-Id: <20210102115412.3402059-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210102115412.3402059-1-aford173@gmail.com>
References: <20210102115412.3402059-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI driver for the Renesas RPC-IF is present on the RZ/G2
Series.  Add that to the description.

Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

V2:  New to series

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aadaea052f51..e0eb2093aca6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -650,7 +650,7 @@ config SPI_RPCIF
 	tristate "Renesas RPC-IF SPI driver"
 	depends on RENESAS_RPCIF
 	help
-	  SPI driver for Renesas R-Car Gen3 RPC-IF.
+	  SPI driver for Renesas R-Car Gen3 or RZ/G2 RPC-IF.
 
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
-- 
2.25.1

