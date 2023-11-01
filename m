Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08627DE38C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Nov 2023 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjKAPP4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Nov 2023 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjKAPPz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Nov 2023 11:15:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3C129
        for <linux-spi@vger.kernel.org>; Wed,  1 Nov 2023 08:15:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cd9a71d3cso8544771cf.1
        for <linux-spi@vger.kernel.org>; Wed, 01 Nov 2023 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698851751; x=1699456551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2SsA8lNfsfo5blKrfyRF4NmHE0kd2YJvslu6dle/wI=;
        b=1sGFFcCXbB9/gAP3EvpDzqAFLTcPAd2nV84cr9E3kgAVKPA9/5Avvs9MD8g7qvrkei
         F3jkHfO33cvX2mWSmm7kqImrelTV3PBtFFOEPyrUQ83ORRa8hNxEy57tVFwDsE0BfOI6
         Y31fxEfASpqRhxD8xX0qwSxnXanrdZ53Yp1cHdmKpHYq7z6l0s/n+OtgkQNiBZmLiqE8
         DYxVBZKn1nGAOe1kZ4TTkG8EV/w/uCd0HqvFyxmh6v4uh+Dy9jrTONauSaNoMAN2sw1z
         kHBA7BxH05LdUWXHCbLvEe1PVzx8FoOUfquawdUtYHJVc1gkFLRu4ucud5t4CIXxl/iF
         wqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851751; x=1699456551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2SsA8lNfsfo5blKrfyRF4NmHE0kd2YJvslu6dle/wI=;
        b=uwQhXch5ylQHOYYVHb6L2lGE2iplvH0Zb3tFThJz07XBs75P4ygNq2yvBLOCao0nqE
         RG5nu4q/biCGsPAIxY2+M1WYZSyBskZjANUQPt0ilTFY9zKzBAxe8qBBKE2423huJ+Bm
         O6+EeEhIGOIN8eMNc2kegPVLddVN9zaIc5/FJuDIjHutuYWfNNNMrHNmAZyY7m4KydEJ
         Yqf4H+N3UECeqqqL37pzPwetD0IzMUz+Q59lSW2BChLTO9qXNfVHX5QMMWbWtJN+O+bY
         FjK1cbvfvL1YdLg5lTaaWdpWmp9OjIpnJBQzEzS7xq36o6UR21t4nynxt9zwIuBcDSlf
         heIw==
X-Gm-Message-State: AOJu0YyE/GEven6uO2K5Wk+op698pGbkgtbw5S2ivxZVumxAzCamepnH
        Bj23kpeDQKSUQhDa8232k2dbvnubV5yLhTSxses=
X-Google-Smtp-Source: AGHT+IHWjvouG9vf5NVO719ZlWW+XphlMNTuSp/67HW9qXaA2To6e351tMMqwrLG7eC9q42SOgiDZQ==
X-Received: by 2002:a05:622a:110:b0:400:9f2c:1211 with SMTP id u16-20020a05622a011000b004009f2c1211mr8947000qtw.29.1698851750784;
        Wed, 01 Nov 2023 08:15:50 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dn5-20020a05622a470500b004181a8a3e2dsm1477165qtb.41.2023.11.01.08.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:15:50 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 3/5] dt-bindings: spi: add stm32f7-spi compatible
Date:   Wed,  1 Nov 2023 11:08:08 -0400
Message-ID: <20231101150811.2747455-4-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
References: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index ae0f082bd377..5754d603f34f 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - st,stm32f4-spi
+      - st,stm32f7-spi
       - st,stm32h7-spi
 
   reg:
-- 
2.42.0

