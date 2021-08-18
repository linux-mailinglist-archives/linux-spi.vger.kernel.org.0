Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309453EFFB6
	for <lists+linux-spi@lfdr.de>; Wed, 18 Aug 2021 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhHRI56 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Aug 2021 04:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHRI5z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Aug 2021 04:57:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4FC061764;
        Wed, 18 Aug 2021 01:57:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a21so1452033pfh.5;
        Wed, 18 Aug 2021 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VZBTPNRqlQESLigV/4KZUq07fd4N5BAX8vFbMG5GM3w=;
        b=gBvpiHtfSWXcLGm+Pb8RBHqwtR0QaQHyp+96/lOlHByJlKeIpL7Bl/TCHflrtWgmuF
         BJsYKnX7uMjCqwp9pheRxX/MusFAx9F0JXqvbGuJgfGHfcGBKaDD6Tk83Xa3wxtLYrr0
         q+aDlLyukKxmA3clZ/wtwv2NU4OyIwanuLxp1rjni8zx1hlwkcvr/25F1JpEwAWaLdwl
         BVNL/UQNEf5Zbv4pLRkO/UEeAf0QHYn9QZBlg5a5zOhBZoKAZSoWYTLZAGuFwMELIUB1
         ggBCyYzDYifTq+BdYOJLBAdfzxPp92g8tbe2ZRlhDBmDPyC1eP5xiVVxav4bQxlS+z7M
         yG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VZBTPNRqlQESLigV/4KZUq07fd4N5BAX8vFbMG5GM3w=;
        b=ulvWVcs3bkiKl0qpP3Ec+sLJgnlkzSIzfBzkVUfohgph+NfmCcZ0ngBEnHQKHQbCNw
         42h7kxdNnxbA/NtRs/MOEGC6mjhpnen7rleG9P35qyc1VNbYInMOqUD2B0eO0nb9Whii
         zatvp2e27/8JiU7pSxzDranfxbza7fD6Hm6AT1qSv3k/kYh817v++6QOSTqvVIKwBEXU
         qTaJ7b1bJJ989WNc96yAET/qKGL+Wfs84i6KkUsgmWHJtWLQ8PTJ6v76XZIwqN3hfpyn
         0f4/lOcmVajNosPDvoo8pcnwRm9a0NtUpCqAedZOyLRJwl04kHo8K8rbjpSZa3kUWwxD
         5kBg==
X-Gm-Message-State: AOAM531Cl8+n43Lvm1vGu9TPt8Bvpe94dEbovIiOeFbLc5aDFUyRMKms
        OaZSXhwhtIxZtF/ZOpLP0g4=
X-Google-Smtp-Source: ABdhPJwreg9GBhaTxZHOtTcpyo4nZ2qN+BxCjfzFucwLE8f/qYCOrfDdnIXCMrU15nkCwnY9XETCbQ==
X-Received: by 2002:a63:5606:: with SMTP id k6mr7853042pgb.21.1629277041096;
        Wed, 18 Aug 2021 01:57:21 -0700 (PDT)
Received: from localhost.localdomain ([123.51.145.88])
        by smtp.gmail.com with ESMTPSA id s46sm5521867pfw.89.2021.08.18.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:57:20 -0700 (PDT)
From:   Zhengxun <zhengxunli.mxic@gmail.com>
To:     sergei.shtylyov@cogentembedded.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        zhengxunli@mxic.com.tw
Cc:     Zhengxun <zhengxunli.mxic@gmail.com>
Subject: [PATCH] memory: renesas-rpc-if: Fix missing setting address
Date:   Wed, 18 Aug 2021 16:56:04 +0000
Message-Id: <20210818165604.22127-1-zhengxunli.mxic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the RPC manual mode, if the data direction is not set
(such as the flash erase command), the address misses the
setting.

Signed-off-by: Zhengxun <zhengxunli.mxic@gmail.com>
---
 drivers/memory/renesas-rpc-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 45eed659b0c6..9dd27c6307f7 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -482,6 +482,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 		}
 		break;
 	default:
+		regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
 		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
 		regmap_write(rpc->regmap, RPCIF_SMCR,
 			     rpc->smcr | RPCIF_SMCR_SPIE);
-- 
2.17.1

