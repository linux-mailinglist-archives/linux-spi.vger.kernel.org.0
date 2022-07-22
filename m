Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8457E723
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jul 2022 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiGVTQA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jul 2022 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGVTQA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jul 2022 15:16:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B57F4BD18
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 12:15:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m12so8050299lfj.4
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDcr6lA6wTvJ7xcFBXD+24WTV1qMn/yJTavRAkd9iGE=;
        b=ilbCTarj/wnEjMbDmJxl2o954q9xKRhNUNea+2SMOboq81M/BCRCKqvsXSGxHPV57V
         SbAc0oUcrCWqqzr9eASqxwsnsmws+q0MsNSLz4sEsNko2MdraFVAiC7gOnj9oVR2SdLK
         5bg24FVpqNRAJA3hfRhtNnTX+9qMd1Swy2jcnXqzePcNeFzkaYH1DkA7yvRoZsysKt7J
         Diwl3mNT9PiIN3FbyxUdr31X10ji5CPz4cOhGH0s1467mMZ2i3b4OOG7sMMKRcMQHUk0
         W3xNGdFxYZwcel5RddsqfleFFqbJaU6ivvv9hkTp0wS7aO2JTVpthlZtqI7FePGWwZbz
         yiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDcr6lA6wTvJ7xcFBXD+24WTV1qMn/yJTavRAkd9iGE=;
        b=2OyhJipQHBEwizLC06Fh02GLsGAhbgy8kU53jg1JMI5NSnF+T20DqKcHyzuUW/71FD
         NGwKK0x4waMh3lijt4lIQClHiA/kOHRr0LBcveCJIIMVIZNaza2rS1OSjPL/xiTgUvIr
         u/jxkACTTP3Z+03s9JW7LtpIaeEmYCWVjlHva7B1MgDGqECUhM8wnUAqns0c0V/VC/ga
         DQ3TInLvGCfUCO8qukTomAcN3MUMAoay6HRU6Zi3if5yo+u1ap/1XSTcYgrc9v9dbY9g
         SMzfW9822hyJ9PCBfWHe2VxSit7Kxo/JMKCJXZvAxiaCMqrDEGfC8/K8gWlR7g8FnwHc
         yxFw==
X-Gm-Message-State: AJIora/wL/ObF2KQ8xrfDRLpNBC2sdz+E0c+O6btiL3c8ha3VyJQgJ/h
        3UbNmcd8TmFgMZnshKCiHCx1Sw==
X-Google-Smtp-Source: AGRyM1uljkuyb3A0AYTb0jGs5xTpnu6p3SPVNgMDaAZRVeBWKSRW0DeDhK1nbzG+uCmXUAw7q4zhxw==
X-Received: by 2002:a19:6745:0:b0:48a:76be:ef7a with SMTP id e5-20020a196745000000b0048a76beef7amr541545lfj.220.1658517356553;
        Fri, 22 Jul 2022 12:15:56 -0700 (PDT)
Received: from krzk-bin.home (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id f7-20020a0565123b0700b0047255d211d7sm287484lfv.262.2022.07.22.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:15:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/1] dt-bindings: spi/display/panel: drop SPI CPHA and CPOL
Date:   Fri, 22 Jul 2022 21:15:38 +0200
Message-Id: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Rebased on Linus' master

Changes since v1
================
1. Rework patchset as Rob suggested, so there is only one patch - changing spi
   and display/panel.
v1: https://lore.kernel.org/all/20220721153155.245336-2-krzysztof.kozlowski@linaro.org/

Merging
=======
I guess via DT or SPI tree. I don't expect conflicts with display/panel tree
(at least nothing visible now in linux-next).

Description
===========
The spi-cpha and spi-cpol properties are device specific and should be
accepted only if device really needs them.  Inspired by [1].

[1] https://lore.kernel.org/all/20220718220012.GA3625497-robh@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (1):
  spi/panel: dt-bindings: drop CPHA and CPOL from common properties

 .../bindings/display/panel/lgphilips,lb035q02.yaml    |  3 +++
 .../bindings/display/panel/samsung,ld9040.yaml        |  3 +++
 .../bindings/display/panel/sitronix,st7789v.yaml      |  3 +++
 .../devicetree/bindings/display/panel/tpo,td.yaml     |  3 +++
 .../devicetree/bindings/spi/spi-controller.yaml       | 11 +++++++++++
 .../devicetree/bindings/spi/spi-peripheral-props.yaml | 10 ----------
 6 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.34.1

