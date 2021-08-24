Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED273F58A2
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhHXHDP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhHXHDK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 03:03:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202AC06175F;
        Tue, 24 Aug 2021 00:02:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so11657901plh.7;
        Tue, 24 Aug 2021 00:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAVLriOKMyhaOJWbZj70EKxm3Jc9VNASO2rIE5jIqK0=;
        b=Ovpxm5p1tZOzii+C82+4S/b4ersXONHVVAvszzU0r7KEDcV0xv3wBjXI3aLjODkVIo
         YYpPenN6KD2MdOesfoom+EIoDZMRD4hzLX2qqh0FAZNNbeBRzQ2p8EP1mHFDqMpjCBRL
         qDzcSHnDvlEHFZLhqvBwJ5oSxKWbd+FbLrOugySgwGW4DT+YdmgOBNFHzw37c6Tqhg6M
         uS8+sR1W54yxhHRwu1thgiTP/fGWtipLgNU5B1vWYKvgdeBEiWlqIo4/NGo/CVFpIzpk
         HgWNHZduH15b6719qx6k/9kEzk2H63yTZz6GGLH2oKIpKi6dFZrB/rD0+1KjRJlZezAJ
         iDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAVLriOKMyhaOJWbZj70EKxm3Jc9VNASO2rIE5jIqK0=;
        b=k4nDxhogxErQIkKK3nBcTaDIpdo8j5Y+lKBq3zMa1wZVI/6dDztqM+NjYJPU+Ga8mX
         zctfVzaVUWjHX+PkkJt9muyQ+zEmCh3FmIrEt4l9tW0UJJmDLAD/OmACIR/vm7KxontO
         kSki0kmT8tj5UcU3mRmuKvR1ijc+qibDhiIBwVFwR43wiYXzdTBCfAYO5tksHh0j4MKx
         5cpWRethXU8w9iMu9yvEvakoN0jzanvNqZFB3g/vKpCdSnUTZLR7zkRUD4pNE617xsF+
         cnuK20RknD3vxuv+WooDf12O3zJblgvLeOUYNm5jwroT8pxr5Awg0HqqpKpv//ZkdYjV
         SCNg==
X-Gm-Message-State: AOAM531mO8kkQ4EUOajec7U5E35rZSLbM3sNU3zSPbnPBioz3M9MFn8k
        EAJeHQfIYATA2o12Hm1yqtI=
X-Google-Smtp-Source: ABdhPJwvhYZ9OXJgmIjktoUAeG4hP/upTvabgf9DqDZ6PndwnvE7chDSvWwEF9AcGrC6+jTIS1S2Fw==
X-Received: by 2002:a17:902:bcc6:b0:12d:bd30:bc4d with SMTP id o6-20020a170902bcc600b0012dbd30bc4dmr31891845pls.18.1629788546570;
        Tue, 24 Aug 2021 00:02:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b17sm20365340pgl.61.2021.08.24.00.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:02:26 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] spi: sprd: Make sure offset not equal to slave address size
Date:   Tue, 24 Aug 2021 15:02:11 +0800
Message-Id: <20210824070212.2089255-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824070212.2089255-1-zhang.lyra@gmail.com>
References: <20210824070212.2089255-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The slave register offset shouldn't equal to the max slave address
which ADI can support to access.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index abdad1ea7b38..06af519c0b21 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -119,7 +119,7 @@ struct sprd_adi {
 
 static int sprd_adi_check_addr(struct sprd_adi *sadi, u32 reg)
 {
-	if (reg > ADI_SLAVE_ADDR_SIZE) {
+	if (reg >= ADI_SLAVE_ADDR_SIZE) {
 		dev_err(sadi->dev,
 			"slave address offset is incorrect, reg = 0x%x\n",
 			reg);
-- 
2.25.1

